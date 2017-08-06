-- =============================================
-- Author:		Javier
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spDBImportSalesParseBuyers]
	
AS
BEGIN
	
	SET NOCOUNT ON;
	
	
	
	UPDATE [Staging.SalesOR] SET 
		ManufacturerName = 'UNK' , 
		ManufacturerCode = 'UNK' 
	WHERE
		ManufacturerCode IS NULL AND 
		ManufacturerName IS NULL
		
	UPDATE [Staging.SalesOR] SET BuyerCode		= '00000'   WHERE BuyerCode IS NULL	
	
	UPDATE [Staging.SalesOR] SET BuyerName = REPLACE(BuyerName,'ESPANA','ESPAÑA') 
		WHERE CompanyCode = 'SP'
	UPDATE [Staging.SalesOR] SET BuyerName = REPLACE(BuyerName,'#','Ñ') 
		WHERE CompanyCode = 'SP'
	UPDATE [Staging.SalesOR] SET BuyerAddress1 = REPLACE(BuyerAddress1,'ESPANA','ESPAÑA') 
		WHERE CompanyCode = 'SP'
	UPDATE [Staging.SalesOR] SET BuyerAddress1 = REPLACE(BuyerAddress1,'#','Ñ') 
		WHERE CompanyCode = 'SP'
	UPDATE [Staging.SalesOR] SET BuyerAddress2 = REPLACE(BuyerAddress2,'ESPANA','ESPAÑA') 
		WHERE CompanyCode = 'SP'
	UPDATE [Staging.SalesOR] SET BuyerAddress2 = REPLACE(BuyerAddress2,'#','Ñ') 
		WHERE CompanyCode = 'SP'
	UPDATE [Staging.SalesOR] SET BuyerAddress3 = REPLACE(BuyerAddress3,'ESPANA','ESPAÑA') 
		WHERE CompanyCode = 'SP'
	UPDATE [Staging.SalesOR] SET BuyerAddress3 = REPLACE(BuyerAddress3,'#','Ñ') 
		WHERE CompanyCode = 'SP'
	UPDATE [Staging.SalesOR] SET BuyerAddress4 = REPLACE(BuyerAddress4,'ESPANA','ESPAÑA') 
		WHERE CompanyCode = 'SP'
	UPDATE [Staging.SalesOR] SET BuyerAddress4 = REPLACE(BuyerAddress4,'#','Ñ') 
		WHERE CompanyCode = 'SP'
		
		
	UPDATE [Staging.SalesOR] SET BuyerName = 'CONVERSION WRITE OFF' 
		WHERE BuyerName like '%conversion%' 
	
	
	
	
	-- FIX ADDRESS ERRORS
	----------------------------------------------------------------------
	UPDATE [Staging.SalesOR] SET
		BuyerAddress1 = NULL 
	WHERE BuyerName = BuyerAddress1

	UPDATE [Staging.SalesOR] SET
		BuyerAddress2 = NULL 
	WHERE BuyerName = BuyerAddress2

	UPDATE [Staging.SalesOR] SET
		BuyerAddress3 = NULL 
	WHERE BuyerName = BuyerAddress3

	UPDATE [Staging.SalesOR] SET
		BuyerAddress4 = NULL 
	WHERE BuyerName = BuyerAddress4

	UPDATE [Staging.SalesOR] SET
		BuyerAddress1 = BuyerAddress2 ,  Notes = 'BuyerAddress1 = BuyerAddress2'
	WHERE BuyerAddress1 IS NULL AND BuyerAddress2 IS NOT NULL

	UPDATE [Staging.SalesOR] SET BuyerAddress2 = NULL WHERE Notes = 'BuyerAddress1 = BuyerAddress2'

	UPDATE [Staging.SalesOR] SET Notes = NULL WHERE Notes = 'BuyerAddress1 = BuyerAddress2'

	UPDATE [Staging.SalesOR] SET
		BuyerAddress2 = BuyerAddress3 ,  Notes = 'BuyerAddress2 = BuyerAddress3'
	WHERE BuyerAddress2 IS NULL AND BuyerAddress3 IS NOT NULL

	UPDATE [Staging.SalesOR] SET BuyerAddress3 = NULL WHERE Notes = 'BuyerAddress2 = BuyerAddress3'

	UPDATE [Staging.SalesOR] SET Notes = NULL WHERE Notes = 'BuyerAddress2 = BuyerAddress3'


	UPDATE [Staging.SalesOR] SET
		BuyerAddress3 = BuyerAddress4 ,  Notes = 'BuyerAddress3 = BuyerAddress4'
	WHERE BuyerAddress3 IS NULL AND BuyerAddress4 IS NOT NULL

	UPDATE [Staging.SalesOR] SET BuyerAddress4 = NULL WHERE Notes = 'BuyerAddress3 = BuyerAddress4'

	UPDATE [Staging.SalesOR] SET Notes = NULL WHERE Notes = 'BuyerAddress3 = BuyerAddress4'
	
	
	
	
	
	UPDATE [Staging.SalesOR] SET BuyerName		= 'DUMMY VENDOR' WHERE BuyerName IS NULL
	UPDATE [Staging.SalesOR] SET BuyerAddress1	= 'UNKNOWN' WHERE BuyerAddress1 IS NULL
	UPDATE [Staging.SalesOR] SET BuyerAddress2	= 'UNKNOWN' WHERE BuyerAddress2 IS NULL
	UPDATE [Staging.SalesOR] SET BuyerAddress3	= 'UNKNOWN' WHERE BuyerAddress3 IS NULL
	UPDATE [Staging.SalesOR] SET BuyerAddress4	= 'UNKNOWN' WHERE BuyerAddress4 IS NULL
	
	
	
	MERGE [Dimension.Buyers] WITH (TABLOCK) AS TARGET
	USING
	(
		SELECT 
			CountryId , CompanyId , CompanyCode , BuyerCode , ManufacturerCode , 
			BuyerName , BuyerFiscalCode 
		FROM 
			[Staging.SalesOR]
		GROUP BY 
			CountryId , CompanyId , CompanyCode , BuyerCode , ManufacturerCode , 
			BuyerName , BuyerFiscalCode 
		
	) AS SOURCE
	ON
	(
			TARGET.CountryId		= SOURCE.CountryId AND
			TARGET.CompanyId		= SOURCE.CompanyId AND
			TARGET.CompanyCode		= SOURCE.CompanyCode AND
			TARGET.BuyerCode		= SOURCE.BuyerCode AND
			TARGET.ManufacturerCode = SOURCE.ManufacturerCode AND
			TARGET.BuyerName		= SOURCE.BuyerName
	)
	WHEN NOT MATCHED THEN
	INSERT 
	(
		CountryId , CompanyId , CompanyCode , BuyerCode , ManufacturerCode ,BuyerName , BuyerFiscalCode ,
		BuyerTypeId 
	)
	VALUES
	(
		SOURCE.CountryId , SOURCE.CompanyId , SOURCE.CompanyCode , SOURCE.BuyerCode , SOURCE.ManufacturerCode , 
		SOURCE.BuyerName , SOURCE.BuyerFiscalCode , 1
	);

	UPDATE [Staging.SalesOR] SET
		[Staging.SalesOR].BuyerId = [Dimension.Buyers].BuyerId
	FROM [Staging.SalesOR]
	INNER JOIN [Dimension.Buyers] ON 
		[Staging.SalesOR].CompanyId			= [Dimension.Buyers].CompanyId AND
		[Staging.SalesOR].CountryId			= [Dimension.Buyers].CountryId AND
		[Staging.SalesOR].CompanyCode		= [Dimension.Buyers].CompanyCode AND
		[Staging.SalesOR].ManufacturerCode	= [Dimension.Buyers].ManufacturerCode AND
		[Staging.SalesOR].BuyerCode			= [Dimension.Buyers].BuyerCode AND
		[Staging.SalesOR].BuyerName			= [Dimension.Buyers].BuyerName
	
	
	MERGE [Fact.BuyersAddress] AS TARGET
	USING
	(
	SELECT 
		[Staging.SalesOR].BuyerId , [Staging.SalesOR].BuyerAddress1 , [Staging.SalesOR].BuyerAddress2 , 
		[Staging.SalesOR].BuyerAddress3 , [Staging.SalesOR].BuyerAddress4, [Dimension.ContactTypes].ContactTypeId ,
		ROW_NUMBER() OVER (PARTITION BY [Staging.SalesOR].BuyerId ORDER BY (SELECT 0)) AS RNS
	FROM [Staging.SalesOR]
	INNER JOIN [Dimension.ContactTypes] ON 
		[Staging.SalesOR].CountryId = [Dimension.ContactTypes].CountryId AND
		[Staging.SalesOR].CompanyId = [Dimension.ContactTypes].CompanyId	
	GROUP BY 
		[Staging.SalesOR].BuyerId , [Staging.SalesOR].BuyerAddress1 , [Staging.SalesOR].BuyerAddress2 , 
		[Staging.SalesOR].BuyerAddress3 , [Staging.SalesOR].BuyerAddress4 , [Dimension.ContactTypes].ContactTypeId
	) AS SOURCE
	ON
	(
		TARGET.BuyerId = SOURCE.BuyerId 
	)
	WHEN NOT MATCHED THEN
	INSERT 
	(ContactTypeId , BuyerId , BuyerAddress1 , BuyerAddress2 ,  BuyerAddress3 , BuyerAddress4 , IsDeleted , Position)
	VALUES
	(SOURCE.ContactTypeId , SOURCE.BuyerId , SOURCE.BuyerAddress1 , SOURCE.BuyerAddress2 ,  SOURCE.BuyerAddress3 , 
		SOURCE.BuyerAddress4 , 0 , SOURCE.RNS);	

	
	
	MERGE [Fact.BuyersContact] AS TARGET
	USING
	(
		SELECT 
			[Staging.SalesOR].BuyerId , [Dimension.ContactTypes].ContactTypeId , [Dimension.Companies].EmailDublin
		FROM 
			[Staging.SalesOR]
		INNER JOIN [Dimension.ContactTypes] ON 
			[Staging.SalesOR].CountryId = [Dimension.ContactTypes].CountryId AND
			[Staging.SalesOR].CompanyId = [Dimension.ContactTypes].CompanyId
		INNER JOIN [Dimension.Companies] ON
			[Staging.SalesOR].CompanyId = [Dimension.Companies].CompanyId
		GROUP BY 
			[Staging.SalesOR].BuyerId , [Dimension.ContactTypes].ContactTypeId , [Dimension.Companies].EmailDublin

	) AS SOURCE
	ON
		(
			TARGET.BuyerId = SOURCE.BuyerId 
			--AND
			--TARGET.ContactTypeId = SOURCE.ContactTypeId AND
			--TARGET.ContactEmail = SOURCE.EmailDublin
		)
	WHEN NOT MATCHED THEN
	INSERT 
		(
			BuyerId , ContactTypeId , ContactEmail
		)
	VALUES
		(
			SOURCE.BuyerId , SOURCE.ContactTypeId , SOURCE.EmailDublin
		);
	
	
	-- UK Rule for BuyBacks
	----------------------------------------------------------------------
	
	UPDATE [Staging.SalesOR] SET
		[Staging.SalesOR].BuyerId = [Dimension.Buyers].BuyerId
	FROM [Staging.SalesOR]
	INNER JOIN [Dimension.Buyers] ON 
		[Staging.SalesOR].ManufacturerCode	= [Dimension.Buyers].ManufacturerCode AND
		[Dimension.Buyers].CompanyCode = 'UK' AND
		[Dimension.Buyers].BuyerTypeId = 3
	WHERE 
		[Staging.SalesOR].CompanyCode = 'UK' AND 
			[Staging.SalesOR].SaleType IN ('P','F','D')
				AND [Staging.SalesOR].ManufacturerCode IN 
				(
				'15',
				--'16',
				'17',
				'9',
				--'F',
				'I',
				--'K',
				--'N',
				'R',
				'U',
				'V',
				'W',
				'Y',
				'Z'				
				)
		
	
	UPDATE [Staging.SalesOR] SET BuyerAddressId = BuyerId WHERE BuyerAddressId IS NULL
	
	
	-- ITALY Rule for Wholesales
	----------------------------------------------------------------------
	
	 DECLARE @BUYER_ID INT
	 
	 SET @BUYER_ID = (SELECT BuyerId FROM [Dimension.Buyers] WHERE CompanyCode = 'IT' AND AreaCode='S' AND BuyerTypeId = 4)
	 UPDATE [Staging.SalesOR] SET
		BuyerId = @BUYER_ID
	 WHERE CompanyCode = 'IT' AND SaleType ='S'
	 
	 
	 SET @BUYER_ID = (SELECT BuyerId FROM [Dimension.Buyers] WHERE CompanyCode = 'I2' AND AreaCode='S' AND BuyerTypeId = 4)
	 UPDATE [Staging.SalesOR] SET
		BuyerId = @BUYER_ID
	 WHERE CompanyCode = 'I2' AND SaleType ='S'
	 
	 
	 
	 SET @BUYER_ID = (SELECT BuyerId FROM [Dimension.Buyers] WHERE CompanyCode = 'IT' AND AreaCode='W' AND BuyerTypeId = 4)
	 UPDATE [Staging.SalesOR] SET
		BuyerId = @BUYER_ID
	 WHERE CompanyCode = 'IT' AND SaleType in ('B','C','DP','R','W')
	 
	 
	 SET @BUYER_ID = (SELECT BuyerId FROM [Dimension.Buyers] WHERE CompanyCode = 'I2' AND AreaCode='W' AND BuyerTypeId = 4)
	 UPDATE [Staging.SalesOR] SET
		BuyerId = @BUYER_ID
	 WHERE CompanyCode = 'I2' AND SaleType in ('B','C','DP','R','W')
	
	
	UPDATE [Staging.SalesOR] SET NoBuyerCode = 1
	WHERE BuyerId in
	(
		SELECT BuyerId
		FROM [Dimension.Buyers]
		WHERE BuyerName LIKE '%DUMMY%'
	)
	
	
	UPDATE [Staging.SalesOR] SET NoBuyerCode = 0 WHERE NoBuyerCode IS NULL
	
	
	-- SPAIN Rule for Wholesales and Savage
	----------------------------------------------------------------------
	
	DECLARE @BUYERS_SPAIN TABLE (BuyerId INT , BuyerCode VARCHAR(10), Position INT)
	
	INSERT INTO @BUYERS_SPAIN (BuyerId , BuyerCode , Position)
	SELECT BuyerId , BuyerCode ,
	ROW_NUMBER() OVER (PARTITION BY BuyerCode ORDER BY (SELECT 0)) AS RNS 
	FROM [Dimension.Buyers]
	WHERE CompanyCode = 'SP'
	GROUP BY BuyerId , BuyerCode
	
	DELETE FROM @BUYERS_SPAIN WHERE Position > 1 
	
	
	UPDATE [Staging.SalesOR] SET
		[Staging.SalesOR].BuyerId			= BSP.BuyerId ,
		[Staging.SalesOR].BuyerAddressId	= BSP.BuyerId
	FROM [Staging.SalesOR]
	INNER JOIN @BUYERS_SPAIN AS BSP ON
		[Staging.SalesOR].BuyerCode			= BSP.BuyerCode 
	WHERE 
		[Staging.SalesOR].CompanyCode = 'SP' AND
		[Staging.SalesOR].SaleType    IN ('B','C','DP','R','W','S')
		
		
		
	UPDATE [Fact.BuyersContact] SET Position = 1 WHERE Position is null
	
	
		
END