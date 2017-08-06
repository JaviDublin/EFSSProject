-- =============================================
-- Author:		Javier
-- Create date: October 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spDBImportSalesCNParse]

AS
BEGIN
	
	SET NOCOUNT ON;
	
	-- 1 BASIC UPLOAD SETTINGS
	--------------------------------------------------------------------------------------------------------
	--------------------------------------------------------------------------------------------------------
	-- 1.1 Get the File Id
	--------------------------------------------------------------------------------------------------------
	DECLARE @FileId	INT	
		SET @FileId	 = (SELECT FileId FROM [Application.Files] WHERE FileCode = 'FSRCN')	
	
	-- 1.2 Add the Log
	--------------------------------------------------------------------------------------------------------
	DECLARE @NEWLOGID INT
		INSERT INTO [Application.FileLog] VALUES (@FileId,GETDATE())
	SET @NEWLOGID = @@IDENTITY
	
	-- 1.3 Delete the table [Staging.SalesCN]
	--------------------------------------------------------------------------------------------------------
	TRUNCATE TABLE [Staging.SalesCN]
	
	
	UPDATE [Import.SalesCN] SET CompanyCode			= LTRIM(RTRIM(CompanyCode))
	UPDATE [Import.SalesCN] SET Serial				= LTRIM(RTRIM(Serial))
	UPDATE [Import.SalesCN] SET AreaCode			= LTRIM(RTRIM(AreaCode))
	UPDATE [Import.SalesCN] SET ModelCode			= LTRIM(RTRIM(ModelCode))
	UPDATE [Import.SalesCN] SET TaxDescription1		= LTRIM(RTRIM(TaxDescription1))
	UPDATE [Import.SalesCN] SET Plate				= LTRIM(RTRIM(Plate))
	UPDATE [Import.SalesCN] SET BuyerCode			= LTRIM(RTRIM(BuyerCode))
	UPDATE [Import.SalesCN] SET CreditNoteNumber	= LTRIM(RTRIM(CreditNoteNumber))
	UPDATE [Import.SalesCN] SET Mileage				= LTRIM(RTRIM(Mileage))
	UPDATE [Import.SalesCN] SET MSODate				= LTRIM(RTRIM(MSODate))
	UPDATE [Import.SalesCN] SET Unit				= LTRIM(RTRIM(Unit))
	UPDATE [Import.SalesCN] SET SaleDocumentNumber	= LTRIM(RTRIM(SaleDocumentNumber))
	UPDATE [Import.SalesCN] SET OldInvoiceNumber	= LTRIM(RTRIM(OldInvoiceNumber))
	UPDATE [Import.SalesCN] SET CrediNoteDate		= LTRIM(RTRIM(CrediNoteDate))
	UPDATE [Import.SalesCN] SET BuyerCode			= LTRIM(RTRIM(BuyerCode))
	
	

	
	
	-- 1.5 Fix Vendor Codes
	--------------------------------------------------------------------------------------------------------
	
	
	UPDATE [Import.SalesCN] SET CompanyCode			= NULL WHERE CompanyCode = ''
	UPDATE [Import.SalesCN] SET Serial				= NULL WHERE Serial = ''
	UPDATE [Import.SalesCN] SET InvoiceTotal		= NULL WHERE InvoiceTotal = ''
	UPDATE [Import.SalesCN] SET ManufacturerName	= NULL WHERE ManufacturerName = ''
	UPDATE [Import.SalesCN] SET ModelDescription	= NULL WHERE ModelDescription = ''
	UPDATE [Import.SalesCN] SET Plate				= NULL WHERE Plate = ''
	UPDATE [Import.SalesCN] SET BuyerCode			= NULL WHERE BuyerCode = ''
	UPDATE [Import.SalesCN] SET CreditNoteNumber	= NULL WHERE CreditNoteNumber = ''
	UPDATE [Import.SalesCN] SET Mileage				= NULL WHERE Mileage = ''
	UPDATE [Import.SalesCN] SET MSODate				= NULL WHERE MSODate = ''
	UPDATE [Import.SalesCN] SET Unit				= NULL WHERE Unit = ''
	UPDATE [Import.SalesCN] SET SaleDocumentNumber	= NULL WHERE SaleDocumentNumber = ''
	UPDATE [Import.SalesCN] SET OldInvoiceNumber	= NULL WHERE OldInvoiceNumber = ''
	UPDATE [Import.SalesCN] SET CrediNoteDate		= NULL WHERE CrediNoteDate = ''
	
	
	-- 2 TRANSFER DATA FROM [Import.SalesOR] TO [Staging.SalesOR]
	--------------------------------------------------------------------------------------------------------
	--------------------------------------------------------------------------------------------------------
		
	-- 2.1 Transfer Data to the table [Staging.SalesOR]
	--------------------------------------------------------------------------------------------------------


	INSERT INTO [Staging.SalesCN]
	(	
		CompanyCode,
		Serial,
		AreaCode,
		Unit,
		TaxDescription1,
		SaleDocumentNumber,
		ModelCode,
		Plate,
		BuyerCode,
		CrediNoteDate,
		CreditNoteNumber,
		Mileage,
		MSODate,
		OldInvoiceNumber,
		SaleDate
	)
	SELECT 
		CompanyCode , Serial , AreaCode , Unit, TaxDescription1 ,  SaleDocumentNumber , ModelCode , Plate ,
		BuyerCode ,
		CASE WHEN ISDATE(CrediNoteDate)	= 1 THEN CONVERT(DATETIME,CrediNoteDate,103) ELSE NULL END ,
		CreditNoteNumber ,
		CASE WHEN ISNUMERIC(Mileage)	= 1 THEN CONVERT(FLOAT,Mileage) END , 
		CASE WHEN ISDATE(MSODate)		= 1 THEN CONVERT(DATETIME,MSODate,103) ELSE NULL END ,
		OldInvoiceNumber , 
		CASE WHEN ISDATE(SaleDate)		= 1 THEN CONVERT(DATETIME,SaleDate,103) ELSE NULL END 

	FROM [Import.SalesCN]
	
	-- 2.2 Find Country Id and Company Id
	--------------------------------------------------------------------------------------------------------	
	
	DELETE FROM [Staging.SalesCN] WHERE CompanyCode NOT IN
		(SELECT CompanyCode FROM [Dimension.Companies])
	
	UPDATE [Staging.SalesCN] SET
		[Staging.SalesCN].CompanyId = [Dimension.Companies].CompanyId,
		[Staging.SalesCN].CountryId = [Dimension.Companies].CountryId
	FROM [Staging.SalesCN]
	INNER JOIN [Dimension.Companies] ON [Staging.SalesCN].CompanyCode = [Dimension.Companies].CompanyCode
	
	
	
	UPDATE [Staging.SalesCN] SET 
		SaleDocumentNumber = '0' + SaleDocumentNumber
	WHERE LEN(SaleDocumentNumber) = 7 AND CountryId = 6
	
	UPDATE [Staging.SalesCN] SET 
		SaleDocumentNumber = '00' + SaleDocumentNumber
	WHERE LEN(SaleDocumentNumber) = 6 AND CountryId = 6
	
	
	
	
	-- 2.3 Add the Log Id
	--------------------------------------------------------------------------------------------------------	
		
	UPDATE [Staging.SalesCN] SET LogId = @NEWLOGID
	
	
	-- 3.1 Get the Invoice Data
	--------------------------------------------------------------------------------------------
	
	UPDATE [Staging.SalesCN] SET
		[Staging.SalesCN].OldRowId = [Archive.Sales].RowId
	FROM  [Staging.SalesCN]
	INNER JOIN [Archive.Sales] ON 
		[Staging.SalesCN].CompanyCode		= [Archive.Sales].CompanyCode and
		--[Staging.SalesCN].CountryId			= [Archive.Sales].CountryId and
		[Staging.SalesCN].Serial			= [Archive.Sales].Serial and
		[Staging.SalesCN].Plate				= [Archive.Sales].Plate and
		[Staging.SalesCN].Unit				= [Archive.Sales].Unit and
		[Staging.SalesCN].OldInvoiceNumber	= [Archive.Sales].InvoiceNumber 
	WHERE 
		[Staging.SalesCN].CompanyCode NOT IN ('SP')

	UPDATE [Staging.SalesCN] SET
		[Staging.SalesCN].OldRowId = [Archive.Sales].RowId
	FROM  [Staging.SalesCN]
	INNER JOIN [Archive.Sales] ON 
		[Staging.SalesCN].CompanyCode			= [Archive.Sales].CompanyCode and
		[Staging.SalesCN].Serial			    = [Archive.Sales].Serial and
		[Staging.SalesCN].Plate				    = [Archive.Sales].Plate and
		[Staging.SalesCN].Unit				    = [Archive.Sales].Unit and
		[Staging.SalesCN].SaleDocumentNumber	= [Archive.Sales].InvoiceNumber 
	WHERE 
		[Staging.SalesCN].CompanyCode IN ('SP') 	

	
	UPDATE 
		[Staging.SalesCN] SET
		[Staging.SalesCN].SaleType			= [Archive.Sales].SaleType , 
		[Staging.SalesCN].InServiceDate		= [Archive.Sales].InServiceDate , 
		[Staging.SalesCN].OutServiceDate	= [Archive.Sales].OutServiceDate , 
		[Staging.SalesCN].ModelDescription	= [Archive.Sales].ModelDescription , 
		[Staging.SalesCN].CarColor			= [Archive.Sales].CarColor , 
		[Staging.SalesCN].ModelYear			= [Archive.Sales].ModelYear , 
		[Staging.SalesCN].ManufacturerCode	= [Archive.Sales].ManufacturerCode , 
		[Staging.SalesCN].ManufacturerName	= [Archive.Sales].ManufacturerName , 
		[Staging.SalesCN].VehicleClass		= [Archive.Sales].VehicleClass , 
		[Staging.SalesCN].VehicleType		= [Archive.Sales].VehicleType , 
		[Staging.SalesCN].PurchaseOrder		= [Archive.Sales].PurchaseOrder , 
		[Staging.SalesCN].PayDate			= [Archive.Sales].PayDate , 
		[Staging.SalesCN].SaleDate			= [Archive.Sales].SaleDate,
		[Staging.SalesCN].VehicleId			= [Archive.Sales].VehicleId,
		[Staging.SalesCN].ModelCodeId		= [Archive.Sales].ModelCodeId,
		[Staging.SalesCN].ModelDetailId		= [Archive.Sales].ModelDetailId,
		[Staging.SalesCN].ModelId			= [Archive.Sales].ModelId,
		[Staging.SalesCN].BuyerId			= [Archive.Sales].BuyerId,
		[Staging.SalesCN].BuyerAddressId	= [Archive.Sales].BuyerAddressId,
		[Staging.SalesCN].BuyerName			= [Archive.Sales].BuyerName,
		[Staging.SalesCN].BuyerAddress1		= [Archive.Sales].BuyerAddress1,
		[Staging.SalesCN].BuyerAddress2		= [Archive.Sales].BuyerAddress2,
		[Staging.SalesCN].BuyerAddress3		= [Archive.Sales].BuyerAddress3,
		[Staging.SalesCN].BuyerAddress4		= [Archive.Sales].BuyerAddress4,
		[Staging.SalesCN].ExtrasId			= [Archive.Sales].ExtrasId,
		[Staging.SalesCN].TaxCodeId			= [Archive.Sales].TaxCodeId,
		[Staging.SalesCN].HasBuyer			= [Archive.Sales].HasBuyer,
		[Staging.SalesCN].HasModel			= [Archive.Sales].HasModel,
		[Staging.SalesCN].OldInvoiceDate	= [Archive.Sales].InvoiceDate,
		[Staging.SalesCN].OldInvoiceNumber	= [Archive.Sales].InvoiceNumber,
		[Staging.SalesCN].OldRowId			= [Archive.Sales].RowId,
		[Staging.SalesCN].ContactTypeId		= [Archive.Sales].ContactTypeId,
		[Staging.SalesCN].IsReport			= [Archive.Sales].IsReport,
		[Staging.SalesCN].IsError			= [Archive.Sales].IsError,
		[Staging.SalesCN].InvoiceNet		= [Archive.Sales].InvoiceNet,
		[Staging.SalesCN].InvoiceVat		= [Archive.Sales].InvoiceVat,
		[Staging.SalesCN].InvoiceTotal		= [Archive.Sales].InvoiceTotal,		
		[Staging.SalesCN].CapitalCost		= [Archive.Sales].CapitalCost,
		[Staging.SalesCN].Depreciation		= [Archive.Sales].Depreciation,
		[Staging.SalesCN].BookValue			= [Archive.Sales].BookValue ,
		[Staging.SalesCN].BuyBackCap		= [Archive.Sales].BuyBackCap,
		[Staging.SalesCN].MileCharge		= [Archive.Sales].MileCharge,
		[Staging.SalesCN].PlusKM			= [Archive.Sales].PlusKM,
		[Staging.SalesCN].FuelCharge		= [Archive.Sales].FuelCharge,
		[Staging.SalesCN].Damage			= [Archive.Sales].Damage,
		[Staging.SalesCN].TransferFees		= [Archive.Sales].TransferFees,
		[Staging.SalesCN].TransferFeesNoVat = [Archive.Sales].TransferFeesNoVat,
		--[Staging.SalesCN].TaxDescription1	= [Archive.Sales].TaxDescription1,
		[Staging.SalesCN].TaxDescription2	= [Archive.Sales].TaxDescription2,
		[Staging.SalesCN].TaxDescription3	= [Archive.Sales].TaxDescription3,
		[Staging.SalesCN].OriginalBPM		= [Archive.Sales].OriginalBPM ,
		[Staging.SalesCN].CalcVatAmortized	= [Archive.Sales].CalcVatAmortized,
		[Staging.SalesCN].Unamortized		= [Archive.Sales].Unamortized,
		[Staging.SalesCN].SuperCharge		= [Archive.Sales].SuperCharge,
		[Staging.SalesCN].HandleFee			= [Archive.Sales].HandleFee,
		[Staging.SalesCN].AddOn				= [Archive.Sales].AddOn,
		[Staging.SalesCN].Other1			= [Archive.Sales].Other1,
		[Staging.SalesCN].Other2			= [Archive.Sales].Other2,
		[Staging.SalesCN].Amount5			= [Archive.Sales].Amount5,
		[Staging.SalesCN].Amount6			= [Archive.Sales].Amount6,
		[Staging.SalesCN].Amount7			= [Archive.Sales].Amount7,
		[Staging.SalesCN].ExportTo			= [Archive.Sales].ExportTo,
		[Staging.SalesCN].Tax				= [Archive.Sales].Tax,
		[Staging.SalesCN].RegTaxAmount		= [Archive.Sales].RegTaxAmount,
		[Staging.SalesCN].HasDocument		= [Archive.Sales].HasDocument,
		[Staging.SalesCN].NoInvoiceNumber	= [Archive.Sales].NoInvoiceNumber,
		[Staging.SalesCN].NoBuyerCode		= [Archive.Sales].NoBuyerCode,
		[Staging.SalesCN].NoInvoiceDate		= [Archive.Sales].NoInvoiceDate,
		[Staging.SalesCN].NoModelCode		= [Archive.Sales].NoModelCode
	FROM [Staging.SalesCN]
	INNER JOIN [Archive.Sales] ON 
		[Staging.SalesCN].OldRowId			= [Archive.Sales].RowId 
	
	
	
	
	UPDATE [Staging.SalesCN] SET
		[Staging.SalesCN].DocumentTypeId = [Dimension.DocumentTypes].DocumentTypeId
	FROM [Staging.SalesCN]
	LEFT JOIN [Dimension.SaleType]		ON  
		[Staging.SalesCN].SaleType		= [Dimension.SaleType].SaleType
	LEFT JOIN [Dimension.DocumentTypes] ON 
		[Dimension.SaleType].DocSubType = [Dimension.DocumentTypes].DocSubType
	WHERE 
		[Dimension.DocumentTypes].DocType = 'CREDIT NOTE' 
	AND [Dimension.DocumentTypes].IsManual = 0
	
	
	UPDATE [Staging.SalesCN] SET InvoiceNumber = CreditNoteNumber , InvoiceDate = CrediNoteDate;
	
	
	
	
	-- 7 DUPLICATES
	--------------------------------------------------------------------------------------------------------
	--------------------------------------------------------------------------------------------------------
	-- 7.1 Check duplicate Serials in the sales File
	--------------------------------------------------------------------------------------------------------
	WITH dup AS
		(
			SELECT 
			CompanyId , Serial , Plate , Unit , InServiceDate , OutServiceDate  , MSODate , PurchaseOrder , 
			PayDate , ModelId , BuyerId,
			ROW_NUMBER() OVER (PARTITION BY Serial ORDER BY (SELECT 0)) AS RNS
			FROM [Staging.SalesCN]
			WHERE OldRowId IS NOT NULL
			GROUP BY 
			CompanyId , Serial , Plate , Unit , InServiceDate , OutServiceDate  , MSODate , PurchaseOrder , 
			PayDate , ModelId , BuyerId
		)
		UPDATE [Staging.SalesCN] SET
		IsRepeated = 1 WHERE Serial in
		(SELECT Serial FROM dup WHERE RNS > 1)
		
	UPDATE [Staging.SalesCN] SET IsRepeated = 0 WHERE IsRepeated IS NULL AND  OldRowId IS NOT NULL
	
	-- 7.2 Check duplicate Invoices in the Archive.Sales table
	--------------------------------------------------------------------------------------------------------
	MERGE [Staging.SalesCN] AS TARGET
		USING [Archive.Sales] AS SOURCE
		ON 
		(
			TARGET.CompanyId		= SOURCE.CompanyId		AND
			TARGET.Serial			= SOURCE.Serial			AND
			TARGET.Plate			= SOURCE.Plate			AND
			TARGET.InvoiceNumber	= SOURCE.invoiceNumber	AND
			TARGET.DocumentTypeId   = SOURCE.DocumentTypeId
		
		)
		WHEN MATCHED THEN
		UPDATE SET
		TARGET.IsDuplicate = 1;
		
		
	UPDATE [Staging.SalesCN] SET IsDuplicate = 0 WHERE IsDuplicate IS NULL AND  OldRowId IS NOT NULL
	
	
	UPDATE [Staging.SalesCN] SET IsError = 1 WHERE IsDuplicate = 1
	UPDATE [Staging.SalesCN] SET IsError = 0 WHERE IsDuplicate = 0 AND IsError IS NULL
	
	
	UPDATE [Staging.SalesCN] SET IsError = 1 WHERE OldRowId IS NULL
	
	UPDATE [Staging.SalesCN] set IsError = 1 where 
	IsDuplicate = 1 or NoInvoiceNumber = 1 or NoBuyerCode = 1 or NoInvoiceDate = 1 or NoModelCode = 1
	
	
	
	INSERT INTO [Archive.SalesErrors] WITH (TABLOCK)
		(
		CompanyCode		,	AreaCode		,	Serial			,	Unit			  ,	Plate			,
		Mileage			,	InServiceDate	,	OutServiceDate	,	MSODate			  ,	ModelCode		,
		ModelDescription,	CarColor		,	ModelYear		,	ManufacturerCode  ,	ManufacturerName,
		VehicleClass	,	VehicleType		,	PurchaseOrder	,	PayDate			  ,	InvoiceNumber	,
		SaleDate		,	InvoiceDate		,	SaleType		,	SaleDocumentNumber,	InvoiceNet		,
		InvoiceVat		,	InvoiceTotal	,	BuyerCode		,	BuyerName		  , BuyerAddress1	,
		BuyerAddress2	,	BuyerAddress3	,	BuyerAddress4	,	BuyerFiscalCode	  , CapitalCost		,
		Depreciation	,	BookValue		,	BuyBackCap		,	MileCharge		  , PlusKM			,	
		FuelCharge		,	Damage			,	TransferFees	,	TransferFeesNoVat ,	TaxDescription1	,
		TaxDescription2	,	TaxDescription3	,	OriginalBPM		,	CalcVatAmortized  ,	Unamortized		,
		SuperCharge		,	HandleFee		,	AddOn			,	Other1			  ,	Other2			,
		Amount5			,	Amount6			,	Amount7			,	ExportTo		  ,	Tax				,
		RegTaxAmount	,	VehicleId		,	ItemId			,	DocumentId		  ,	LogId			,
		IsRepeated		,	IsDuplicate		,	Notes			,	BuyerId			  ,	ModelId			,
		CountryId		,	HasBuyer		,	HasModel		,	CompanyId		  ,	ExtrasId		,
		ModelDetailId	,	ModelCodeId		,	DocumentTypeId	,	ContactTypeId	  , HasDocument		, 
		DocItemId       ,	IsError			,   IsReport		,	TaxCodeId		  , BuyerAddressId  ,
		NoInvoiceNumber ,	NoBuyerCode     ,	NoInvoiceDate   ,	NoModelCode
		)
		
		SELECT 
		CompanyCode		,	AreaCode		,	Serial			,	Unit			  ,	Plate			,
		Mileage			,	InServiceDate	,	OutServiceDate	,	MSODate			  ,	ModelCode		,
		ModelDescription,	CarColor		,	ModelYear		,	ManufacturerCode  ,	ManufacturerName,
		VehicleClass	,	VehicleType		,	PurchaseOrder	,	PayDate			  ,	InvoiceNumber	,
		SaleDate		,	InvoiceDate		,	SaleType		,	SaleDocumentNumber,	InvoiceNet		,
		InvoiceVat		,	InvoiceTotal	,	BuyerCode		,	BuyerName		  , BuyerAddress1	,
		BuyerAddress2	,	BuyerAddress3	,	BuyerAddress4	,	BuyerFiscalCode	  , CapitalCost		,
		Depreciation	,	BookValue		,	BuyBackCap		,	MileCharge		  , PlusKM			,	
		FuelCharge		,	Damage			,	TransferFees	,	TransferFeesNoVat ,	TaxDescription1	,
		TaxDescription2	,	TaxDescription3	,	OriginalBPM		,	CalcVatAmortized  ,	Unamortized		,
		SuperCharge		,	HandleFee		,	AddOn			,	Other1			  ,	Other2			,
		Amount5			,	Amount6			,	Amount7			,	ExportTo		  ,	Tax				,
		RegTaxAmount	,	VehicleId		,	ItemId			,	DocumentId		  ,	LogId			,
		IsRepeated		,	IsDuplicate		,	Notes			,	BuyerId			  ,	ModelId			,
		CountryId		,	HasBuyer		,	HasModel		,	CompanyId		  ,	ExtrasId		,
		ModelDetailId	,	ModelCodeId		,	DocumentTypeId	,	ContactTypeId	  , HasDocument		, 
		DocItemId       ,	IsError			,   IsReport		,	TaxCodeId		  , BuyerAddressId  ,
		NoInvoiceNumber ,	NoBuyerCode     ,	NoInvoiceDate   ,	NoModelCode
		FROM [Staging.SalesCN]
		WHERE IsError = 1
		
	
	DELETE FROM [Staging.SalesCN] WHERE 
		IsError = 1
	
	
	
	-- 8 ITEMS
	--------------------------------------------------------------------------------------------------------
	--------------------------------------------------------------------------------------------------------
	-- 7.1 Add New Items
	--------------------------------------------------------------------------------------------

	MERGE [Fact.Items] WITH (TABLOCK) AS TARGET
		USING 
		(
			SELECT VehicleId  , 1 as "DescriptionTypeId" , InvoiceNet , 
			InvoiceVat , InvoiceTotal , ExtrasId
			FROM [Staging.SalesCN]
			GROUP BY VehicleId  , InvoiceNet , InvoiceVat , 
			InvoiceTotal , ExtrasId
		) AS SOURCE
		ON
		(
			TARGET.DescriptionId	 = SOURCE.VehicleId			AND
			TARGET.DescriptionTypeId = SOURCE.DescriptionTypeId AND
			TARGET.Value			 = SOURCE.InvoiceNet		AND
			TARGET.Vat				 = SOURCE.InvoiceVat		AND
			TARGET.Total			 = SOURCE.InvoiceTotal		AND
			TARGET.ExtrasId			 = SOURCE.ExtrasId
			
		)
		WHEN NOT MATCHED BY TARGET THEN
		INSERT 
		(DescriptionId , DescriptionTypeId , ExtrasId , Value , Vat , Total)
		VALUES
		(SOURCE.VehicleId ,  1 , 
		SOURCE.ExtrasId , SOURCE.InvoiceNet , SOURCE.InvoiceVat , SOURCE.InvoiceTotal);
		
	UPDATE [Staging.SalesCN] SET
		[Staging.SalesCN].ItemId = [Fact.Items].ItemId
	FROM [Staging.SalesCN]
	INNER JOIN [Fact.Items] ON 
		[Staging.SalesCN].VehicleId		= [Fact.Items].DescriptionId
	AND [Staging.SalesCN].ExtrasId		= [Fact.Items].ExtrasId 
	AND [Staging.SalesCN].InvoiceNet	= [Fact.Items].Value
	AND [Staging.SalesCN].InvoiceVat	= [Fact.Items].Vat
	AND [Staging.SalesCN].InvoiceTotal  = [Fact.Items].Total
				
				
	-- 8 DOCUMENTS
	--------------------------------------------------------------------------------------------------------
	--------------------------------------------------------------------------------------------------------
		
	-- 8.1 Add New Documents
	--------------------------------------------------------------------------------------------
	MERGE [Fact.Documents] WITH (TABLOCK) AS TARGET
		USING
		(
			SELECT DocumentTypeId , CompanyId , BuyerId , InvoiceNumber , LogId
			FROM [Staging.SalesCN]
			GROUP BY DocumentTypeId , CompanyId , BuyerId , InvoiceNumber , LogId
		) AS SOURCE
		ON 
		(
			TARGET.DocumentTypeId	= SOURCE.DocumentTypeId    AND
			TARGET.CompanyId		= SOURCE.CompanyId   AND
			TARGET.BuyerId			= SOURCE.BuyerId   AND
			TARGET.DocumentNumber	= SOURCE.InvoiceNumber 
		)
		WHEN NOT MATCHED BY TARGET THEN
		INSERT 
		 (
			DocumentTypeId , CompanyId , BuyerId , DocumentNumber , LogId 
		 )
		 VALUES 
		 (
			SOURCE.DocumentTypeId , SOURCE.CompanyId , SOURCE.BuyerId , SOURCE.InvoiceNumber ,
			SOURCE.LogId 
		  );
	
	UPDATE [Staging.SalesCN] SET
		[Staging.SalesCN].DocumentId = [Fact.Documents].DocumentId 
	FROM [Staging.SalesCN]
	INNER JOIN [Fact.Documents] ON 
		[Staging.SalesCN].InvoiceNumber	 = [Fact.Documents].DocumentNumber
	AND [Staging.SalesCN].BuyerId		 = [Fact.Documents].BuyerId 
	AND [Staging.SalesCN].CompanyId		 = [Fact.Documents].CompanyId
	AND [Staging.SalesCN].DocumentTypeId = [Fact.Documents].DocumentTypeId
	WHERE 
		[Staging.SalesCN].DocumentId IS NULL
		
	UPDATE [Fact.Documents] SET 
		[Fact.Documents].DateCreated = [Application.FileLog].DateLog
	FROM [Fact.Documents]
	INNER  JOIN [Application.FileLog] ON 
		[Fact.Documents].LogId = [Application.FileLog].LogId
	WHERE
		[Fact.Documents].DateCreated IS NULL
		
	
	
	-- 9 DOCUMENTS - ITEMS
	--------------------------------------------------------------------------------------------------------
	--------------------------------------------------------------------------------------------------------
	
	-- 9.1 Add New Documents and Items
	--------------------------------------------------------------------------------------------
	MERGE  [Fact.DocumentItems] WITH (TABLOCK) AS TARGET
		USING
		(
			SELECT DocumentId , ItemId , CompanyId
			FROM [Staging.SalesCN]
			GROUP BY DocumentId , ItemId , CompanyId
		) AS SOURCE
		ON 
		(
			TARGET.DocumentId	= SOURCE.DocumentId AND
			TARGET.ItemId		= SOURCE.ItemId AND
			TARGET.CompanyId	= SOURCE.CompanyId 
		)
		WHEN NOT MATCHED BY TARGET THEN
		INSERT 
			(
				DocumentId , ItemId , CompanyId
			)
		VALUES 
			(
				SOURCE.DocumentId , SOURCE.ItemId , SOURCE.CompanyId
			);
			
	UPDATE [Staging.SalesCN] SET
		[Staging.SalesCN].DocItemId = [Fact.DocumentItems].DocItemId
	FROM [Staging.SalesCN] 
	INNER JOIN [Fact.DocumentItems] ON 
		[Staging.SalesCN].DocumentId = [Fact.DocumentItems].DocumentId 
	AND [Staging.SalesCN].ItemId	 = [Fact.DocumentItems].ItemId 
	AND [Staging.SalesCN].CompanyId  = [Fact.DocumentItems].CompanyId 
	WHERE [Staging.SalesCN].DocItemId IS NULL;	

  
END