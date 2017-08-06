-- =============================================
-- Author:		Javier
-- Create date: April 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spBuyersImportFile]
	
AS
BEGIN
	
		SET NOCOUNT ON;
	
		DECLARE @FileId			INT			,
				@FileName		VARCHAR(255),
				@FilePath		VARCHAR(4000),
				@FileFormat		VARCHAR(255),
				@FileFormatPath VARCHAR(4000)
			
		SET @FileId			= (SELECT FileId			FROM [Application.Files]	WHERE FileCode = 'FBVND')
		SET @FileName		= (SELECT [FileName]		FROM [Application.Files]	WHERE FileCode = 'FBVND')
		SET @FilePath		= (SELECT FilePath			FROM [Application.Files]	WHERE FileCode = 'FBVND')
		SET @FileFormat		= (SELECT FileFormat		FROM [Application.Files]	WHERE FileCode = 'FBVND')
		SET @FileFormatPath = (SELECT FileFormatPath	FROM [Application.Files]	WHERE FileCode = 'FBVND')
		
		SET @FilePath		= @FilePath + @FileName
		SET @FileFormatPath = @FileFormatPath + @FileFormat
		
		
		IF dbo.FileExists(@FileFormatPath) = 0
		BEGIN
			INSERT INTO [Application.FileLogError] (FileId,DateError,ErrorMessage,ErrorProcedure)
			SELECT @FileId,GETDATE(),'Format File doesnt exists' , 'spBuyersImportFileVNDLBulk'
		END
		ELSE
		BEGIN

		
		
		BEGIN TRY
			


		
		-- ADD / UPDATE VENDORS
		-----------------------------------------------------------------------------------------------------
		-- 1.1 CREATE TABLE TO STORE THE VENDOR CODES AND NAMES 
		---------------------------------------------------------------------------------
		CREATE TABLE #BUYERSNAME (RowId int primary key identity ,
		CompanyCode varchar(10),BuyerCode varchar(20), BuyerName varchar(255),
		BuyerTaxCode varchar(50) , BuyerFiscalCode varchar(50),CountryId int , BuyerId int, BCounter int)
		-- 1.2 TRANSFER DATA
		---------------------------------------------------------------------------------
		INSERT INTO #BUYERSNAME (CompanyCode , BuyerCode , BuyerName , BuyerTaxCode ,BuyerFiscalCode )
		SELECT CompanyCode , BuyerCode , BuyerName , BuyerTaxCode ,BuyerFiscalCode
		FROM [Staging.Buyers]
		GROUP BY CompanyCode , BuyerCode , BuyerName , BuyerTaxCode ,BuyerFiscalCode
		
		-- 1.3 GET COUNTRY ID
		---------------------------------------------------------------------------------
		UPDATE #BUYERSNAME set 
		#BUYERSNAME.CountryId	= [Dimension.Companies].CountryId
		FROM #BUYERSNAME
		INNER JOIN [Dimension.Companies] ON #BUYERSNAME.CompanyCode = [Dimension.Companies].CompanyCode;
		
		-- 1.4 FIND DUPLICATES
		---------------------------------------------------------------------------------
		WITH DUP_BUYER AS
		(
			SELECT 
			RowId ,CountryId , BuyerCode ,
			ROW_NUMBER() OVER(PARTITION BY BuyerCode , CountryId ORDER BY (SELECT 0)) AS RN
			FROM #BUYERSNAME
		)
		UPDATE #BUYERSNAME SET #BUYERSNAME.BCounter = DUP_BUYER.RN
		FROM #BUYERSNAME
		INNER JOIN DUP_BUYER ON #BUYERSNAME.RowId = DUP_BUYER.RowId
		
		-- 1.5 DELETE DUPLICATES
		---------------------------------------------------------------------------------
		DELETE FROM #BUYERSNAME WHERE BCounter > 1
		-- 1.6 GET BUYER ID
		---------------------------------------------------------------------------------
		UPDATE #BUYERSNAME set 
		#BUYERSNAME.BuyerId = [Dimension.Buyers].BuyerId
		FROM #BUYERSNAME
		INNER JOIN [Dimension.Buyers] ON #BUYERSNAME.CountryId	= [Dimension.Buyers].CountryId AND 
										 #BUYERSNAME.BuyerCode	= [Dimension.Buyers].BuyerCode							 
		-- 1.7 ADD NEW RECORDS
		---------------------------------------------------------------------------------
		INSERT INTO [Dimension.Buyers] (CountryId , BuyerCode)
		SELECT 	CountryId ,	BuyerCode 
		FROM 	#BUYERSNAME
		WHERE BuyerId IS NULL
		GROUP BY  CountryId ,	BuyerCode 
		ORDER BY CountryId ,	BuyerCode 
		-- 1.8 GET NAMES AND FISCAL CODES
		---------------------------------------------------------------------------------
		UPDATE  [Dimension.Buyers] SET
		[Dimension.Buyers].BuyerName = #BUYERSNAME.BuyerName ,
		[Dimension.Buyers].BuyerTaxCode = #BUYERSNAME.BuyerTaxCode ,
		[Dimension.Buyers].BuyerFiscalCode = #BUYERSNAME.BuyerFiscalCode ,
		[Dimension.Buyers].LogId	= 2
		FROM [Dimension.Buyers]
		INNER JOIN #BUYERSNAME ON [Dimension.Buyers].CountryId = #BUYERSNAME.CountryId AND
								[Dimension.Buyers].BuyerCode = #BUYERSNAME.BuyerCode
		-- 1.9 GET NEW BUYER ID'S
		---------------------------------------------------------------------------------
		UPDATE #BUYERSNAME set 
		#BUYERSNAME.BuyerId = [Dimension.Buyers].BuyerId
		FROM #BUYERSNAME
		INNER JOIN [Dimension.Buyers] ON #BUYERSNAME.CountryId	= [Dimension.Buyers].CountryId AND 
										 #BUYERSNAME.BuyerCode	= [Dimension.Buyers].BuyerCode
		WHERE #BUYERSNAME.BuyerId IS NULL
		-- 1.10 MERGE DATA
		---------------------------------------------------------------------------------
		MERGE [Dimension.Buyers] AS TARGET
		USING #BUYERSNAME AS SOURCE
				ON (TARGET.BuyerId	= SOURCE.BuyerId)
				WHEN MATCHED AND
				(
					(TARGET.BuyerName <> SOURCE.BuyerName OR 
						(TARGET.BuyerName IS NULL AND SOURCE.BuyerName IS NOT NULL))
					OR (TARGET.BuyerTaxCode <> SOURCE.BuyerTaxCode OR 
						(TARGET.BuyerTaxCode IS NULL AND SOURCE.BuyerTaxCode IS NOT NULL))
					OR (TARGET.BuyerFiscalCode <> SOURCE.BuyerFiscalCode OR 
						(TARGET.BuyerFiscalCode IS NULL AND SOURCE.BuyerFiscalCode IS NOT NULL))
				) 
				
				THEN
				
					UPDATE SET
						TARGET.BuyerName		= CASE WHEN SOURCE.BuyerName IS NOT NULL THEN SOURCE.BuyerName END	,
						TARGET.BuyerTaxCode		= CASE WHEN SOURCE.BuyerTaxCode	IS NOT NULL THEN SOURCE.BuyerTaxCode END,
						TARGET.BuyerFiscalCode	= CASE WHEN SOURCE.BuyerFiscalCode IS NOT NULL THEN SOURCE.BuyerFiscalCode END;
		-- 1.11 DROP TABLE
		---------------------------------------------------------------------------------
		DROP TABLE #BUYERSNAME
		
		
		UPDATE [Dimension.Buyers] SET BuyerTypeId = 1 WHERE BuyerTypeId IS NULL
		
		
		UPDATE [Staging.Buyers] SET
		[Staging.Buyers].CompanyId = [Dimension.Companies].CompanyId ,
		[Staging.Buyers].CountryId = [Dimension.Companies].CountryId
		FROM [Staging.Buyers] 
		INNER JOIN [Dimension.Companies] ON [Staging.Buyers].CompanyCode = [Dimension.Companies].CompanyCode
		
		
				
		UPDATE [Staging.Buyers] SET
		[Staging.Buyers].BuyerId = [Dimension.Buyers].BuyerId
		FROM [Staging.Buyers]
		INNER JOIN [Dimension.Buyers] ON [Staging.Buyers].CountryId = [Dimension.Buyers].CountryId AND
											[Staging.Buyers].BuyerCode = [Dimension.Buyers].BuyerCode
											
		
		UPDATE [Staging.Buyers] SET
		[Staging.Buyers].ContactTypeId =  [Dimension.ContactTypes].ContactTypeId
		FROM [Staging.Buyers]
		INNER JOIN [Dimension.ContactTypes] ON [Staging.Buyers].CountryId = [Dimension.ContactTypes].CountryId
											AND [Staging.Buyers].CompanyId = [Dimension.ContactTypes].CompanyId
			
		-- ADD / UPDATE ADDRESSES
		-----------------------------------------------------------------------------------------------------
		-- 2.1 CREATE TABLE TO STORE THE ADDRESSES
		---------------------------------------------------------------------------------
		CREATE TABLE #BUYERADDRESS (RowId int primary key identity,CompanyCode varchar(10),BuyerCode varchar(20),
		BuyerAddress1 varchar(255),BuyerAddress2 varchar(255),BuyerAddress3 varchar(255),BuyerAddress4 varchar(255),
		BuyerAddress5 varchar(255),BuyerAddress6 varchar(255),CountryId int , CompanyId int ,
		BuyerId int,ContactTypeId int,BuyerAddressId int, BCounter int)
		-- 2.2 TRANSFER DATA
		---------------------------------------------------------------------------------
		INSERT INTO #BUYERADDRESS (CompanyCode,BuyerCode,BuyerAddress1,BuyerAddress2,BuyerAddress3,BuyerAddress4,
		BuyerAddress5,BuyerAddress6 , CountryId , CompanyId , ContactTypeId , BuyerId)
		SELECT CompanyCode,BuyerCode,BuyerAddress1,BuyerAddress2,BuyerAddress3,BuyerAddress4,
		BuyerAddress5,BuyerAddress6 , CountryId , CompanyId , ContactTypeId , BuyerId
		FROM [Staging.Buyers]
		GROUP BY CompanyCode,BuyerCode,BuyerAddress1,BuyerAddress2,BuyerAddress3,BuyerAddress4,
		BuyerAddress5,BuyerAddress6 , CountryId , CompanyId , ContactTypeId , BuyerId;

		
		-- 2.6 FIND POSITIONS
		---------------------------------------------------------------------------------
		WITH DUP_ADDRESS AS
		(
			SELECT 
			RowId ,BuyerId , ContactTypeId ,
			ROW_NUMBER() OVER(PARTITION BY BuyerId , ContactTypeId ORDER BY (SELECT 0)) AS RN
			FROM #BUYERADDRESS
		)
		UPDATE #BUYERADDRESS SET #BUYERADDRESS.BCounter = DUP_ADDRESS.RN
		FROM #BUYERADDRESS
		INNER JOIN DUP_ADDRESS ON #BUYERADDRESS.RowId = DUP_ADDRESS.RowId
		
		-- 2.7 GET BUYER ADDRESS ID
		---------------------------------------------------------------------------------
		UPDATE #BUYERADDRESS SET
		#BUYERADDRESS.BuyerAddressId = [Fact.BuyersAddress].BuyerAddressId
		from #BUYERADDRESS
		inner join [Fact.BuyersAddress] on #BUYERADDRESS.BuyerId = [Fact.BuyersAddress].BuyerId
											AND #BUYERADDRESS.ContactTypeId = [Fact.BuyersAddress].ContactTypeId
											AND #BUYERADDRESS.BCounter = [Fact.BuyersAddress].Position
		-- 2.8 ADD NEW RECORDS	
		---------------------------------------------------------------------------------						
		INSERT INTO [Fact.BuyersAddress](ContactTypeId,BuyerId,BuyerAddress1,BuyerAddress2,BuyerAddress3,
		BuyerAddress4,BuyerAddress5,BuyerAddress6,IsDeleted,Position)							
		SELECT ContactTypeId ,BuyerId ,BuyerAddress1, BuyerAddress2 , BuyerAddress3, BuyerAddress4, BuyerAddress5 ,
		BuyerAddress6 ,0 ,BCounter
		FROM #BUYERADDRESS
		WHERE BuyerAddressId IS NULL
		
		-- 2.9 GET NEW BUYER ADDRESS ID'S
		---------------------------------------------------------------------------------
		UPDATE #BUYERADDRESS SET
		#BUYERADDRESS.BuyerAddressId = [Fact.BuyersAddress].BuyerAddressId
		from #BUYERADDRESS
		inner join [Fact.BuyersAddress] on #BUYERADDRESS.BuyerId = [Fact.BuyersAddress].BuyerId
											AND #BUYERADDRESS.ContactTypeId = [Fact.BuyersAddress].ContactTypeId
											AND #BUYERADDRESS.BCounter = [Fact.BuyersAddress].Position
		WHERE #BUYERADDRESS.BuyerAddressId IS NULL
		-- 2.10 MERGE
		---------------------------------------------------------------------------------
		MERGE [Fact.BuyersAddress] AS TARGET
				USING #BUYERADDRESS AS SOURCE
				ON 
				(
					TARGET.BuyerAddressId = SOURCE.BuyerAddressId 
				) 
				WHEN MATCHED AND
				(
					(TARGET.BuyerAddress1 <> SOURCE.BuyerAddress1 OR 
						(TARGET.BuyerAddress1 IS NULL AND SOURCE.BuyerAddress1 IS NOT NULL))
					OR (TARGET.BuyerAddress2 <> SOURCE.BuyerAddress2 OR 
						(TARGET.BuyerAddress2 IS NULL AND SOURCE.BuyerAddress2 IS NOT NULL))
					OR (TARGET.BuyerAddress3 <> SOURCE.BuyerAddress3 OR 
						(TARGET.BuyerAddress3 IS NULL AND SOURCE.BuyerAddress3 IS NOT NULL))
					OR (TARGET.BuyerAddress4 <> SOURCE.BuyerAddress4 OR 
						(TARGET.BuyerAddress4 IS NULL AND SOURCE.BuyerAddress4 IS NOT NULL))
					OR (TARGET.BuyerAddress5 <> SOURCE.BuyerAddress5 OR 
						(TARGET.BuyerAddress5 IS NULL AND SOURCE.BuyerAddress5 IS NOT NULL))
					OR (TARGET.BuyerAddress6 <> SOURCE.BuyerAddress6 OR 
						(TARGET.BuyerAddress6 IS NULL AND SOURCE.BuyerAddress6 IS NOT NULL))
				) THEN
				UPDATE SET
						TARGET.BuyerAddress1	= SOURCE.BuyerAddress1,
						TARGET.BuyerAddress2	= SOURCE.BuyerAddress2,
						TARGET.BuyerAddress3	= SOURCE.BuyerAddress3,
						TARGET.BuyerAddress4	= SOURCE.BuyerAddress4,
						TARGET.BuyerAddress5	= SOURCE.BuyerAddress5,
						TARGET.BuyerAddress6	= SOURCE.BuyerAddress6;
		-- 2.11 DROP TABLE
		---------------------------------------------------------------------------------
		DROP TABLE #BUYERADDRESS
		
		-- ADD / UPDATE CONTACTS
		-----------------------------------------------------------------------------------------------------
		-- 3.1 CREATE TABLE TO STORE THE CONTACTS
		---------------------------------------------------------------------------------
		CREATE TABLE #BUYERCONTACTS (RowId int primary key identity,CompanyCode varchar(10),BuyerCode varchar(20),
		ContactName varchar(255),ContactEmail varchar(255) , ContactPhone varchar(255), ContactFax varchar(255),
		CountryId int , CompanyId int , BuyerId int , ContactTypeId int , ContactId int , BCounter int)
		
		
		-- 3.2 TRANSFER DATA
		---------------------------------------------------------------------------------
		INSERT INTO #BUYERCONTACTS 
		(CompanyCode,BuyerCode,ContactEmail,ContactName,CompanyId , CountryId , ContactTypeId , BuyerId)
		SELECT CompanyCode,BuyerCode ,ContactEmail , ContactName , CompanyId , CountryId , ContactTypeId , BuyerId
		FROM [Staging.Buyers]
		GROUP BY CompanyCode ,BuyerCode ,ContactEmail , ContactName , CompanyId , CountryId , ContactTypeId , BuyerId;
		
	
	
		-- 3.6 FIND POSITIONS
		---------------------------------------------------------------------------------
		WITH DUP_ADDRESS AS
		(
			SELECT 
			RowId ,BuyerId , ContactTypeId ,
			ROW_NUMBER() OVER(PARTITION BY BuyerId , ContactTypeId ORDER BY (SELECT 0)) AS RN
			FROM #BUYERCONTACTS
		)
			UPDATE #BUYERCONTACTS SET #BUYERCONTACTS.BCounter = DUP_ADDRESS.RN
			FROM #BUYERCONTACTS
			INNER JOIN DUP_ADDRESS ON #BUYERCONTACTS.RowId = DUP_ADDRESS.RowId						
		
		-- 3.7 GET CONTACT ID
		---------------------------------------------------------------------------------
		UPDATE #BUYERCONTACTS SET
		#BUYERCONTACTS.ContactId = [Fact.BuyersContact].ContactId
		from #BUYERCONTACTS
		INNER JOIN [Fact.BuyersContact] on #BUYERCONTACTS.BuyerId = [Fact.BuyersContact].BuyerId
										AND #BUYERCONTACTS.ContactTypeId = [Fact.BuyersContact].ContactTypeId
										AND #BUYERCONTACTS.BCounter = [Fact.BuyersContact].Position	
										
		
		-- 3.8 ADD NEW RECORDS	
		---------------------------------------------------------------------------------
		INSERT INTO [Fact.BuyersContact](ContactTypeId,BuyerId,ContactName,ContactEmail,IsDeleted,Position)
		SELECT ContactTypeId ,BuyerId ,ContactName, ContactEmail ,0 ,BCounter
		FROM #BUYERCONTACTS
		WHERE ContactId IS NULL	
		-- 3.9 GET NEW CONTACT ID
		---------------------------------------------------------------------------------
		UPDATE #BUYERCONTACTS SET
		#BUYERCONTACTS.ContactId = [Fact.BuyersContact].ContactId
		from #BUYERCONTACTS
		INNER JOIN [Fact.BuyersContact] on #BUYERCONTACTS.BuyerId = [Fact.BuyersContact].BuyerId
											AND #BUYERCONTACTS.ContactTypeId = [Fact.BuyersContact].ContactTypeId
											AND #BUYERCONTACTS.BCounter = [Fact.BuyersContact].Position	
		WHERE #BUYERCONTACTS.ContactId IS NULL	
		-- 3.10 MERGE
		---------------------------------------------------------------------------------
		MERGE [Fact.BuyersContact] AS TARGET
		USING #BUYERCONTACTS AS SOURCE
				ON 
				(
					TARGET.ContactId = SOURCE.ContactId 
				) 
				WHEN MATCHED AND
				(
					(TARGET.ContactName <> SOURCE.ContactName OR 
						(TARGET.ContactName IS NULL AND SOURCE.ContactName IS NOT NULL))
					OR (TARGET.ContactEmail <> SOURCE.ContactEmail OR 
						(TARGET.ContactEmail IS NULL AND SOURCE.ContactEmail IS NOT NULL))
					
				) THEN
				UPDATE SET
						TARGET.ContactName	= SOURCE.ContactName,
						
						TARGET.ContactEmail	= SOURCE.ContactEmail;
		-- 3.11 DROP TABLE
		---------------------------------------------------------------------------------
		DROP TABLE #BUYERCONTACTS			
	
	
		EXEC spImportFileFixTool
		@fixtype = 3
		
		EXEC spImportFileFixTool
		@fixtype = 4
		
		-- ADD / UPDATE MANUFACTURERS
		-----------------------------------------------------------------------------------------------------
		
	
		UPDATE [Staging.Buyers] SET
		[Staging.Buyers].ManufacturerId =[Dimension.ManufacturerVision].ManufacturerId
		FROM [Staging.Buyers]
		INNER JOIN [Dimension.ManufacturerVision] ON 
				[Staging.Buyers].ManufacturerCode = [Dimension.ManufacturerVision].VisionCode

		MERGE dbo.[Fact.BuyersManufacturer] AS TARGET
		USING
		(
			SELECT BuyerId , ManufacturerId
			FROM [Staging.Buyers]
			WHERE ManufacturerId IS NOT NULL
			GROUP BY BuyerId , ManufacturerId
		)
		AS SOURCE
		ON 
		(
			TARGET.BuyerId = SOURCE.BuyerId and TARGET.ManufacturerId = SOURCE.ManufacturerId
		)
		WHEN NOT MATCHED BY TARGET THEN
		INSERT (BuyerId ,ManufacturerId)
		VALUES (SOURCE.BuyerId , SOURCE.ManufacturerId);
		
				
		INSERT INTO [Fact.BuyersContact] (ContactTypeId , BuyerId , ContactName , IsDeleted , Position)
		SELECT 
		[Dimension.ContactTypes].ContactTypeId ,
		[Dimension.Buyers].BuyerId , 
		'No Contact Details' , 
		0 , 1
		FROM [Dimension.Buyers]
		INNER JOIN [Dimension.ContactTypes] ON [Dimension.Buyers].CountryId = [Dimension.ContactTypes].CountryId
		WHERE [Dimension.Buyers].BuyerId NOT IN
		(SELECT BuyerId FROM [Fact.BuyersContact])
		group by [Dimension.ContactTypes].ContactTypeId ,
		[Dimension.Buyers].BuyerId 
		order by [Dimension.Buyers].BuyerId 
		
		
		truncate table [Staging.Buyers]
		
		
		
		END TRY
		BEGIN CATCH
			INSERT INTO [Application.FileLogError] 
						(FileiD,DateError,ErrorNumber,ErrorMessage,ErrorSeverity,
						ErrorState,ErrorLine,ErrorProcedure)
			SELECT  @FileId,GETDATE(),CAST(ERROR_NUMBER() AS VARCHAR(255)),ERROR_MESSAGE() ,
					CAST(ERROR_SEVERITY() AS VARCHAR(255)),CAST(ERROR_STATE() AS VARCHAR(255)),
					CAST(ERROR_LINE()  AS VARCHAR(255)),'spBuyersImportFileVNDLBulk'
		
		END CATCH
		
		
		END

  
END