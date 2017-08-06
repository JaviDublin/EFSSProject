-- =============================================
-- Author:		Javier
-- Create date: July 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spDBImportDashboardParse]
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @FileId	INT	
	SET @FileId	= (SELECT FileId FROM [Application.Files] WHERE FileCode = 'FDASH')
	
	
	
	-- 1.1 Delete Vendors of the Counries that are not in the system
	--------------------------------------------------------------------------------------------
	
	
	DECLARE @NEWLOGID INT	
	INSERT INTO [Application.FileLog] 
	--VALUES (12 , GETDATE())
	VALUES (@FileId , GETDATE())
	SET @NEWLOGID = @@IDENTITY
	
	
	TRUNCATE TABLE [Staging.Dashboard]
	
	DELETE FROM [Import.Dashboard] WHERE CompanyCode not in 
		(SELECT CompanyCode FROM [Dimension.Companies])
		
	DELETE FROM [Import.Dashboard] WHERE RecvType IN
	(SELECT RecvType FROM [Dimension.ReceivableTypes] WHERE DocSubType = 'Exclude')
	
	
	INSERT INTO [Staging.Dashboard]
	(
		SaleDocumentNumber,InvoiceDate,Serial,AreaCode,CompanyCode,RecvType,
		ManufacturerName,VehicleStatus,OMU,RMSAge,RecvAmt,OutServiceDate,Plate,
		InServiceDate,PurchaseOrder,PurchInvoiceNumber,CapitalCost,
		Depreciation,NetRecv,RecvDueInd,RecvDueDate,InvoiceNbr,VehicleType,
		SPI,ModelCodeVision,DueDtAge,ClaimDate,Unit,InvoiceNumber
	)

	SELECT 
		SaleDocumentNumber,
		CASE WHEN ISDATE(InvoiceDate) = 1 THEN CONVERT(DATETIME,InvoiceDate,103) END,
		Serial,AreaCode,CompanyCode,RecvType,
		ManufacturerName,VehicleStatus,OMU,RMSAge,
		CASE WHEN ISNUMERIC(RecvAmt)	 = 1 THEN CONVERT(MONEY,RecvAmt) END,
		CASE WHEN ISDATE(OutServiceDate) = 1 THEN CONVERT(DATETIME,OutServiceDate,103) END,
		Plate,
		CASE WHEN ISDATE(InServiceDate)  = 1 THEN CONVERT(DATETIME,InServiceDate,103) END,
		PurchaseOrder,PurchInvoiceNumber,
		CASE WHEN ISNUMERIC(CapitalCost)	= 1 THEN CONVERT(FLOAT,CapitalCost) END,
		CASE WHEN ISNUMERIC(Depreciation)	= 1 THEN CONVERT(FLOAT,Depreciation) END,
		CASE WHEN ISNUMERIC(NetRecv)		= 1 THEN CONVERT(FLOAT,NetRecv) END,
		RecvDueInd,
		CASE WHEN ISDATE(RecvDueDate)  = 1 THEN CONVERT(DATETIME,RecvDueDate,103) END,
		InvoiceNbr,VehicleType,
		SPI,ModelCodeVision,DueDtAge,
		CASE WHEN ISDATE(ClaimDate)  = 1 THEN CONVERT(DATETIME,ClaimDate,103) END,
		Unit,InvoiceNumber
	FROM [Import.Dashboard]
	
	
	
	UPDATE [Staging.Dashboard] SET FileId = @FileId , LogId = @NEWLOGID
	--UPDATE [Staging.Dashboard] SET FileId = 12 , LogId = 889
	
	--2.1 Find Country Id and Company Id
	--------------------------------------------------------------------------------------------
	UPDATE [Staging.Dashboard] SET
		[Staging.Dashboard].CompanyId = [Dimension.Companies].CompanyId ,
		[Staging.Dashboard].CountryId = [Dimension.Companies].CountryId
	FROM [Staging.Dashboard]
	INNER JOIN [Dimension.Companies] ON 
		[Staging.Dashboard].CompanyCode = [Dimension.Companies].CompanyCode
		
	UPDATE [Staging.Dashboard] SET
		GroupId = [Dimension.Companies].GroupId
	FROM [Staging.Dashboard]
	JOIN [Dimension.Companies] ON [Staging.Dashboard].CompanyId = [Dimension.Companies].CompanyId
		
	UPDATE [Staging.Dashboard] SET
		[Staging.Dashboard].RecvTypeId = [Dimension.ReceivableTypes].RecvTypeId
	FROM [Staging.Dashboard]
	INNER JOIN [Dimension.ReceivableTypes] ON 
		[Staging.Dashboard].RecvType = [Dimension.ReceivableTypes].RecvType
		
		
	-- 2.3 Add the New vehicles
	---------------------------------------------------------------------	
		MERGE [Fact.Vehicles] WITH (TABLOCK) AS TARGET
		USING 
		(
			SELECT Serial , Unit , CountryId
			FROM [Staging.Dashboard]
			GROUP BY Serial , Unit , CountryId
		)
		AS SOURCE
		ON 
		(TARGET.Unit = SOURCE.Unit AND TARGET.Serial = SOURCE.Serial AND 
		 TARGET.CountryId = SOURCE.CountryId)
		
		WHEN NOT MATCHED THEN
			INSERT 
			(Serial , Unit , CountryId)
			VALUES
			(SOURCE.Serial ,  SOURCE.Unit , SOURCE.CountryId);
		
		UPDATE [Staging.Dashboard] SET
			[Staging.Dashboard].VehicleId = [Fact.Vehicles].VehicleId
		FROM [Staging.Dashboard]
		INNER JOIN [Fact.Vehicles]	ON 
			 [Staging.Dashboard].Serial	   = [Fact.Vehicles].Serial 
		AND	 [Staging.Dashboard].Unit	   = [Fact.Vehicles].Unit 
		AND	 [Staging.Dashboard].CountryId = [Fact.Vehicles].CountryId
		
		
		
		UPDATE [Staging.Dashboard] SET ManufacturerName = LTRIM(RTRIM(ManufacturerName))
		
		
		
		UPDATE [Staging.Dashboard] SET
			[Staging.Dashboard].ModelCodeId		= [Archive.Sales].ModelCodeId ,
			[Staging.Dashboard].ModelId			= [Archive.Sales].ModelId ,
			[Staging.Dashboard].ModelDetailId	= [Archive.Sales].ModelDetailId ,
			[Staging.Dashboard].ManufacturerId	= [Dimension.ModelDetails].ManufacturerId ,
			[Staging.Dashboard].BuyerId			= [Archive.Sales].BuyerId,
			[Staging.Dashboard].ItemId			= [Archive.Sales].ItemId,
			[Staging.Dashboard].DocItemId		= [Archive.Sales].DocItemId,
			[Staging.Dashboard].DocumentId		= [Archive.Sales].DocumentId,
			[Staging.Dashboard].Notes			= 'ARCHIVE SALES'
		FROM [Staging.Dashboard]
		INNER JOIN [Archive.Sales] ON 
			[Staging.Dashboard].CompanyId = [Archive.Sales].CompanyId AND
			[Staging.Dashboard].VehicleId = [Archive.Sales].VehicleId
		INNER JOIN [Dimension.ModelDetails] ON
			[Archive.Sales].ModelDetailId = [Dimension.ModelDetails].ModelDetailId
			
		UPDATE [Staging.Dashboard] SET
			[Staging.Dashboard].ManufacturerName = [Dimension.Manufacturer].ManufacturerName
		FROM [Staging.Dashboard]
		INNER JOIN [Dimension.Manufacturer] ON
			[Staging.Dashboard].ManufacturerId = [Dimension.Manufacturer].ManufacturerId
		WHERE 
			[Staging.Dashboard].Notes = 'ARCHIVE SALES'
			
		
		--UPDATE [Staging.Dashboard] SET
		--	[Staging.Dashboard].InvoiceDate = [Archive.Sales].InvoiceDate
		--FROM [Staging.Dashboard]
		--INNER JOIN [Archive.Sales] ON 
		--	[Staging.Dashboard].CompanyId = [Archive.Sales].CompanyId AND
		--	[Staging.Dashboard].VehicleId = [Archive.Sales].VehicleId AND
		--	[Staging.Dashboard].DocItemId = [Archive.Sales].DocItemId
		--WHERE 
		--	[Staging.Dashboard].Notes IS NOT NULL AND 
		--	[Staging.Dashboard].InvoiceDate IS NULL		
			
		UPDATE [Staging.Dashboard] SET
			[Staging.Dashboard].OutServiceDate = [Archive.Sales].OutServiceDate
		FROM [Staging.Dashboard]
		INNER JOIN [Archive.Sales] ON 
			[Staging.Dashboard].CompanyId = [Archive.Sales].CompanyId AND
			[Staging.Dashboard].VehicleId = [Archive.Sales].VehicleId AND
			[Staging.Dashboard].DocItemId = [Archive.Sales].DocItemId
		WHERE 
			[Staging.Dashboard].Notes IS NOT NULL AND 
			[Staging.Dashboard].OutServiceDate IS NULL	
			
		UPDATE [Staging.Dashboard] SET
			[Staging.Dashboard].InvoiceNumber = [Archive.Sales].InvoiceNumber
		FROM [Staging.Dashboard]
		INNER JOIN [Archive.Sales] ON 
			[Staging.Dashboard].CompanyId = [Archive.Sales].CompanyId AND
			[Staging.Dashboard].VehicleId = [Archive.Sales].VehicleId AND
			[Staging.Dashboard].DocItemId = [Archive.Sales].DocItemId
		WHERE 
			[Staging.Dashboard].Notes IS NOT NULL AND 
			[Staging.Dashboard].InvoiceNumber = '0000000' 
			
	
		UPDATE [Staging.Dashboard] SET ManufacturerName = 'PEUGEOT' WHERE ManufacturerName = 'PEUGOT'
		UPDATE [Staging.Dashboard] SET ManufacturerName = 'ALFA ROMEO' WHERE ManufacturerName = 'ALPHA'
		UPDATE [Staging.Dashboard] SET ManufacturerName = 'PORSCHE' WHERE ManufacturerName = '18'
		UPDATE [Staging.Dashboard] SET ManufacturerName = 'VOLKSWAGEN' WHERE ManufacturerName = 'VOLKSG'
		UPDATE [Staging.Dashboard] SET ManufacturerName = 'INFINITI' WHERE ManufacturerName = 'HI'
		
		UPDATE [Staging.Dashboard] SET 
			[Staging.Dashboard].ManufacturerId = [Dimension.Manufacturer].ManufacturerId
		FROM [Staging.Dashboard]
		INNER JOIN  [Dimension.Manufacturer] ON
			[Staging.Dashboard].ManufacturerName = [Dimension.Manufacturer].ManufacturerName
		WHERE
			[Staging.Dashboard].ManufacturerId IS NULL
			
	
  
END