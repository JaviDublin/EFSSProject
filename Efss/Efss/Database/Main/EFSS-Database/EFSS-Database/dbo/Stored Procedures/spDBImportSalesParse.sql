-- =============================================
-- Author:		Javier
-- Create date: July 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spDBImportSalesParse]
	
AS
BEGIN
	
	SET NOCOUNT ON;
	
	-- 1 BASIC UPLOAD SETTINGS
	--------------------------------------------------------------------------------------------------------
	--------------------------------------------------------------------------------------------------------
	-- 1.1 Get the File Id
	--------------------------------------------------------------------------------------------------------
	DECLARE @FileId	INT	
		SET @FileId	 = (SELECT FileId FROM [Application.Files] WHERE FileCode = 'FSROR')	

	-- 1.2 Add the Log
	--------------------------------------------------------------------------------------------------------
	DECLARE @NEWLOGID INT
		INSERT INTO [Application.FileLog] VALUES (@FileId,GETDATE())
	SET @NEWLOGID = @@IDENTITY
	
	TRUNCATE TABLE [Staging.SalesOR]
	
	UPDATE [Import.SalesOR] SET CompanyCode			= NULL WHERE CompanyCode = ''
	UPDATE [Import.SalesOR] SET AreaCode			= NULL WHERE AreaCode = ''
	UPDATE [Import.SalesOR] SET Serial				= NULL WHERE Serial = ''
	UPDATE [Import.SalesOR] SET Unit				= NULL WHERE Unit = ''
	UPDATE [Import.SalesOR] SET Plate				= NULL WHERE Plate = ''
	UPDATE [Import.SalesOR] SET Mileage				= NULL WHERE Mileage = ''
	UPDATE [Import.SalesOR] SET InServiceDate		= NULL WHERE InServiceDate = ''
	UPDATE [Import.SalesOR] SET OutServiceDate		= NULL WHERE OutServiceDate = ''
	UPDATE [Import.SalesOR] SET MSODate				= NULL WHERE MSODate = ''
	UPDATE [Import.SalesOR] SET ModelCode			= NULL WHERE ModelCode = ''
	UPDATE [Import.SalesOR] SET ModelDescription	= NULL WHERE ModelDescription = ''
	UPDATE [Import.SalesOR] SET CarColor			= NULL WHERE CarColor = ''
	UPDATE [Import.SalesOR] SET ModelYear			= NULL WHERE ModelYear = ''
	UPDATE [Import.SalesOR] SET ManufacturerCode	= NULL WHERE ManufacturerCode = ''
	UPDATE [Import.SalesOR] SET ManufacturerName	= NULL WHERE ManufacturerName = ''
	UPDATE [Import.SalesOR] SET VehicleClass		= NULL WHERE VehicleClass = ''
	UPDATE [Import.SalesOR] SET VehicleType			= NULL WHERE VehicleType = ''
	UPDATE [Import.SalesOR] SET PurchaseOrder		= NULL WHERE PurchaseOrder = ''
	UPDATE [Import.SalesOR] SET PayDate				= NULL WHERE PayDate = ''
	UPDATE [Import.SalesOR] SET InvoiceNumber		= NULL WHERE InvoiceNumber = ''
	UPDATE [Import.SalesOR] SET SaleDate			= NULL WHERE SaleDate = ''
	UPDATE [Import.SalesOR] SET InvoiceDate			= NULL WHERE InvoiceDate = ''
	UPDATE [Import.SalesOR] SET SaleType			= NULL WHERE SaleType = ''
	UPDATE [Import.SalesOR] SET SaleDocumentNumber	= NULL WHERE SaleDocumentNumber = ''
	UPDATE [Import.SalesOR] SET InvoiceNet			= NULL WHERE InvoiceNet = ''
	UPDATE [Import.SalesOR] SET InvoiceVat			= NULL WHERE InvoiceVat = ''
	UPDATE [Import.SalesOR] SET InvoiceTotal		= NULL WHERE InvoiceTotal = ''
	UPDATE [Import.SalesOR] SET BuyerCode			= NULL WHERE BuyerCode = ''
	UPDATE [Import.SalesOR] SET BuyerName			= NULL WHERE BuyerName = ''
	UPDATE [Import.SalesOR] SET BuyerAddress1		= NULL WHERE BuyerAddress1 = ''
	UPDATE [Import.SalesOR] SET BuyerAddress2		= NULL WHERE BuyerAddress2 = ''
	UPDATE [Import.SalesOR] SET BuyerAddress3		= NULL WHERE BuyerAddress3 = ''
	UPDATE [Import.SalesOR] SET BuyerAddress4		= NULL WHERE BuyerAddress4 = ''
	UPDATE [Import.SalesOR] SET BuyerFiscalCode		= NULL WHERE BuyerFiscalCode = ''
	UPDATE [Import.SalesOR] SET CapitalCost			= NULL WHERE CapitalCost = ''
	UPDATE [Import.SalesOR] SET Depreciation		= NULL WHERE Depreciation = ''
	UPDATE [Import.SalesOR] SET BookValue			= NULL WHERE BookValue = ''
	UPDATE [Import.SalesOR] SET BuyBackCap			= NULL WHERE BuyBackCap = ''
	UPDATE [Import.SalesOR] SET MileCharge			= NULL WHERE MileCharge = ''
	UPDATE [Import.SalesOR] SET PlusKM				= NULL WHERE PlusKM = ''
	UPDATE [Import.SalesOR] SET FuelCharge			= NULL WHERE FuelCharge = ''
	UPDATE [Import.SalesOR] SET Damage				= NULL WHERE Damage = ''
	UPDATE [Import.SalesOR] SET TransferFees		= NULL WHERE TransferFees = ''
	UPDATE [Import.SalesOR] SET TransferFeesNoVat	= NULL WHERE TransferFeesNoVat = ''
	UPDATE [Import.SalesOR] SET TaxDescription1		= NULL WHERE TaxDescription1 = ''
	UPDATE [Import.SalesOR] SET TaxDescription2		= NULL WHERE TaxDescription2 = ''
	UPDATE [Import.SalesOR] SET TaxDescription3		= NULL WHERE TaxDescription3 = ''
	UPDATE [Import.SalesOR] SET OriginalBPM			= NULL WHERE OriginalBPM = ''
	UPDATE [Import.SalesOR] SET CalcVatAmortized	= NULL WHERE CalcVatAmortized = ''
	UPDATE [Import.SalesOR] SET Unamortized			= NULL WHERE Unamortized = ''
	UPDATE [Import.SalesOR] SET SuperCharge			= NULL WHERE SuperCharge = ''
	UPDATE [Import.SalesOR] SET HandleFee			= NULL WHERE HandleFee = ''
	UPDATE [Import.SalesOR] SET AddOn				= NULL WHERE AddOn = ''
	UPDATE [Import.SalesOR] SET Other1				= NULL WHERE Other1 = ''
	UPDATE [Import.SalesOR] SET Other2				= NULL WHERE Other2 = ''
	UPDATE [Import.SalesOR] SET Amount5				= NULL WHERE Amount5 = ''
	UPDATE [Import.SalesOR] SET Amount6				= NULL WHERE Amount6 = ''
	UPDATE [Import.SalesOR] SET Amount7				= NULL WHERE Amount7 = ''
	UPDATE [Import.SalesOR] SET ExportTo			= NULL WHERE ExportTo = ''
	UPDATE [Import.SalesOR] SET Tax					= NULL WHERE Tax = ''
	UPDATE [Import.SalesOR] SET RegTaxAmount		= NULL WHERE RegTaxAmount = ''
			
			
		UPDATE [Import.SalesOR] SET BuyerCode = '0000' + BuyerCode WHERE LEN(BuyerCode) = 1
		UPDATE [Import.SalesOR] SET BuyerCode = '000'  + BuyerCode WHERE LEN(BuyerCode) = 2
		UPDATE [Import.SalesOR] SET BuyerCode = '00'   + BuyerCode WHERE LEN(BuyerCode) = 3
		UPDATE [Import.SalesOR] SET BuyerCode = '0'    + BuyerCode WHERE LEN(BuyerCode) = 4
		UPDATE [Import.SalesOR] SET BuyerName = REPLACE(BuyerName,'  ',' ')
		UPDATE [Import.SalesOR] SET BuyerName = REPLACE(BuyerName,'  ',' ')
		UPDATE [Import.SalesOR] SET BuyerName = REPLACE(BuyerName,'  ',' ')
		UPDATE [Import.SalesOR] SET BuyerName = REPLACE(BuyerName,'  ',' ')
		UPDATE [Import.SalesOR] SET BuyerName = LTRIM(RTRIM(BuyerName))
		UPDATE [Import.SalesOR] SET BuyerCode = LTRIM(RTRIM(BuyerCode))
		UPDATE [Import.SalesOR] SET ModelCode = LTRIM(RTRIM(ModelCode))
		UPDATE [Import.SalesOR] SET ModelYear = LTRIM(RTRIM(ModelYear))
		UPDATE [Import.SalesOR] SET ManufacturerName = LTRIM(RTRIM(ManufacturerName))
		UPDATE [Import.SalesOR] SET ManufacturerCode = LTRIM(RTRIM(ManufacturerCode))
		UPDATE [Import.SalesOR] SET Serial = LTRIM(RTRIM(Serial))
		UPDATE [Import.SalesOR] SET Plate = LTRIM(RTRIM(Plate))
		UPDATE [Import.SalesOR] SET Unit = LTRIM(RTRIM(Unit))
		UPDATE [Import.SalesOR] SET BuyerFiscalCode = LTRIM(RTRIM(BuyerFiscalCode))
	
	
	
	INSERT INTO [Staging.SalesOR]
	(
		CompanyCode		,	AreaCode		,	Serial			,	Unit				,	Plate			,	
		Mileage			,	InServiceDate	,	OutServiceDate	,	MSODate				,	ModelCode		,	
		ModelDescription,	CarColor		,	ModelYear		,	ManufacturerCode	,	ManufacturerName,
		VehicleClass	,	VehicleType		,	PurchaseOrder	,	PayDate				,	InvoiceNumber	,
		SaleDate		,	InvoiceDate		,	SaleType		,	SaleDocumentNumber	,	InvoiceNet		,
		InvoiceVat		,	InvoiceTotal	,	BuyerCode		,	BuyerName			,	BuyerAddress1	,
		BuyerAddress2	,	BuyerAddress3	,	BuyerAddress4	,	BuyerFiscalCode		,	CapitalCost		,
		Depreciation	,	BookValue		,	BuyBackCap		,	MileCharge			,	PlusKM			,
		FuelCharge		,	Damage			,	TransferFees	,	TransferFeesNoVat	,	TaxDescription1	,
		TaxDescription2	,	TaxDescription3	,	OriginalBPM		,	CalcVatAmortized	,	Unamortized		,
		SuperCharge		,	HandleFee		,	AddOn			,	Other1				,	Other2			,
		Amount5			,	Amount6			,	Amount7			,	ExportTo			,	Tax,RegTaxAmount
	)
		SELECT
		CompanyCode	,	AreaCode	,	Serial	,	Unit	,	Plate,
		CASE WHEN ISNUMERIC(Mileage)		= 1 THEN CONVERT(FLOAT,Mileage) END ,
		CASE WHEN ISDATE(InServiceDate)		= 1 THEN CONVERT(DATETIME,InServiceDate,103) END,
		CASE WHEN ISDATE(OutServiceDate)	= 1 THEN CONVERT(DATETIME,OutServiceDate,103) END ,
		CASE WHEN ISDATE(MSODate)			= 1 THEN CONVERT(DATETIME,MSODate,103) END ,
		ModelCode	,	ModelDescription	,	CarColor	,	ModelYear	,
		ManufacturerCode	,	ManufacturerName,
		VehicleClass	,	VehicleType	,	PurchaseOrder,
		CASE WHEN ISDATE(PayDate)			= 1 THEN CONVERT(DATETIME,PayDate,103) END,
		InvoiceNumber,
		CASE WHEN ISDATE(SaleDate)			= 1 THEN CONVERT(DATETIME,SaleDate,103) END,
		CASE WHEN ISDATE(InvoiceDate)		= 1 THEN CONVERT(DATETIME,InvoiceDate,103) END,
		SaleType	,	SaleDocumentNumber,
		CASE WHEN ISNUMERIC(InvoiceNet)		= 1 THEN CONVERT(FLOAT,InvoiceNet) END,
		CASE WHEN ISNUMERIC(InvoiceVat)		= 1 THEN CONVERT(FLOAT,InvoiceVat) END,
		CASE WHEN ISNUMERIC(InvoiceTotal)	= 1 THEN CONVERT(FLOAT,InvoiceTotal) END,
		BuyerCode	,	BuyerName	,	BuyerAddress1	,	BuyerAddress2	,	BuyerAddress3	,	
		BuyerAddress4 ,	BuyerFiscalCode,
		CASE WHEN ISNUMERIC(CapitalCost)	= 1 THEN CONVERT(FLOAT,CapitalCost) END,
		CASE WHEN ISNUMERIC(Depreciation)	= 1 THEN CONVERT(FLOAT,Depreciation) END,
		CASE WHEN ISNUMERIC(BookValue)		= 1 THEN CONVERT(FLOAT,BookValue) END,
		CASE WHEN ISNUMERIC(BuyBackCap)		= 1 THEN CONVERT(FLOAT,BuyBackCap) END,
		CASE WHEN ISNUMERIC(MileCharge)		= 1 THEN CONVERT(FLOAT,MileCharge) END,
		CASE WHEN ISNUMERIC(PlusKM)			= 1 THEN CONVERT(FLOAT,PlusKM) END,
		CASE WHEN ISNUMERIC(FuelCharge)		= 1 THEN CONVERT(FLOAT,FuelCharge) END,
		CASE WHEN ISNUMERIC(Damage)			= 1 THEN CONVERT(FLOAT,Damage) END,
		CASE WHEN ISNUMERIC(TransferFees)	= 1 THEN CONVERT(FLOAT,TransferFees) END,
		CASE WHEN ISNUMERIC(TransferFeesNoVat) = 1 THEN CONVERT(FLOAT,TransferFeesNoVat) END,
		TaxDescription1	,	TaxDescription2	,	TaxDescription3,
		CASE WHEN ISNUMERIC(OriginalBPM)	= 1 THEN CONVERT(FLOAT,OriginalBPM) END,
		CASE WHEN ISNUMERIC(CalcVatAmortized) = 1 THEN CONVERT(FLOAT,CalcVatAmortized) END,
		CASE WHEN ISNUMERIC(Unamortized)	= 1 THEN CONVERT(FLOAT,Unamortized) END,
		CASE WHEN ISNUMERIC(SuperCharge)	= 1 THEN CONVERT(FLOAT,SuperCharge) END,
		CASE WHEN ISNUMERIC(HandleFee)		= 1 THEN CONVERT(FLOAT,HandleFee) END,
		CASE WHEN ISNUMERIC(AddOn)			= 1 THEN CONVERT(FLOAT,AddOn) END,
		CASE WHEN ISNUMERIC(Other1)			= 1 THEN CONVERT(FLOAT,Other1) END,
		CASE WHEN ISNUMERIC(Other2)			= 1 THEN CONVERT(FLOAT,Other2) END,
		CASE WHEN ISNUMERIC(Amount5)		= 1 THEN CONVERT(FLOAT,Amount5) END,
		CASE WHEN ISNUMERIC(Amount6)		= 1 THEN CONVERT(FLOAT,Amount6) END,
		Amount7 ,
		--CASE WHEN ISNUMERIC(Amount7)		= 1 THEN CONVERT(FLOAT,Amount7) END,
		ExportTo,Tax,
		CASE WHEN ISNUMERIC(RegTaxAmount)	= 1 THEN CONVERT(FLOAT,RegTaxAmount) END
		FROM [Import.SalesOR]
	
	
	
		DELETE FROM [Staging.SalesOR] WHERE CompanyCode NOT IN
		(SELECT CompanyCode FROM [Dimension.Companies])
	
	-- 2.2 Find Country Id and Company Id
	--------------------------------------------------------------------------------------------------------	
	
	
	
	UPDATE [Staging.SalesOR] SET
		[Staging.SalesOR].CompanyId = [Dimension.Companies].CompanyId,
		[Staging.SalesOR].CountryId = [Dimension.Companies].CountryId
	FROM [Staging.SalesOR]
	INNER JOIN [Dimension.Companies] ON [Staging.SalesOR].CompanyCode = [Dimension.Companies].CompanyCode
		
		
	-- 2.3 Add the Log Id
	--------------------------------------------------------------------------------------------------------	
		
	UPDATE [Staging.SalesOR] SET LogId = @NEWLOGID
		
	-- 2.4 Add the New vehicles and Get the Vehicle Id
	--------------------------------------------------------------------------------------------------------	
	
	MERGE [Fact.Vehicles] WITH (TABLOCK) AS TARGET
		USING 
		(
			SELECT Serial , Unit , CountryId
			FROM [Staging.SalesOR]
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
		
		
	UPDATE [Staging.SalesOR] SET
		[Staging.SalesOR].VehicleId = [Fact.Vehicles].VehicleId
	FROM [Staging.SalesOR]
	INNER JOIN [Fact.Vehicles] ON 
		[Staging.SalesOR].Serial	 = [Fact.Vehicles].Serial 
	AND [Staging.SalesOR].Unit		 = [Fact.Vehicles].Unit
	AND [Staging.SalesOR].CountryId	 = [Fact.Vehicles].CountryId
			
											
	-- 3 BUSINESS RULES AND MAIN DATA
	--------------------------------------------------------------------------------------------------------
	--------------------------------------------------------------------------------------------------------
							
	-- 3.1 Eliminate Null Values in the Extra Charges
	--------------------------------------------------------------------------------------------------------
	
	UPDATE [Staging.SalesOR] SET MileCharge		= 0 WHERE MileCharge	IS NULL
	UPDATE [Staging.SalesOR] SET PlusKM			= 0 WHERE PlusKM		IS NULL
	UPDATE [Staging.SalesOR] SET FuelCharge		= 0 WHERE FuelCharge	IS NULL
	UPDATE [Staging.SalesOR] SET Damage			= 0 WHERE Damage		IS NULL
	UPDATE [Staging.SalesOR] SET SuperCharge	= 0 WHERE SuperCharge	IS NULL
	UPDATE [Staging.SalesOR] SET HandleFee		= 0 WHERE HandleFee		IS NULL
	UPDATE [Staging.SalesOR] SET AddOn			= 0 WHERE AddOn			IS NULL
	UPDATE [Staging.SalesOR] SET Other1			= 0 WHERE Other1		IS NULL
	UPDATE [Staging.SalesOR] SET Other2			= 0 WHERE Other2		IS NULL
	UPDATE [Staging.SalesOR] SET Amount5		= 0 WHERE Amount5		IS NULL
	UPDATE [Staging.SalesOR] SET Amount6		= 0 WHERE Amount6		IS NULL
	UPDATE [Staging.SalesOR] SET Amount7		= '0' WHERE Amount7		IS NULL
	UPDATE [Staging.SalesOR] SET RegTaxAmount	= 0 WHERE RegTaxAmount	IS NULL
	
	
	UPDATE [Staging.SalesOR] SET TransferFees		= 0 WHERE TransferFees	IS NULL
	UPDATE [Staging.SalesOR] SET TransferFeesNoVat	= 0 WHERE TransferFeesNoVat		IS NULL
	UPDATE [Staging.SalesOR] SET OriginalBPM		= 0 WHERE OriginalBPM	IS NULL
	UPDATE [Staging.SalesOR] SET CalcVatAmortized	= 0 WHERE CalcVatAmortized	IS NULL
	UPDATE [Staging.SalesOR] SET Unamortized		= 0 WHERE Unamortized	IS NULL
	
	
	UPDATE [Staging.SalesOR] SET BuyerAddress1 = LTRIM(RTRIM(BuyerAddress1))
	UPDATE [Staging.SalesOR] SET BuyerAddress2 = LTRIM(RTRIM(BuyerAddress2))
	UPDATE [Staging.SalesOR] SET BuyerAddress3 = LTRIM(RTRIM(BuyerAddress3))
	UPDATE [Staging.SalesOR] SET BuyerAddress4 = LTRIM(RTRIM(BuyerAddress4))
	
	
	UPDATE [Staging.SalesOR] set TaxDescription1 = LTRIM(RTRIM(TaxDescription1))
	UPDATE [Staging.SalesOR] set TaxDescription2 = LTRIM(RTRIM(TaxDescription2))
	UPDATE [Staging.SalesOR] set TaxDescription3 = LTRIM(RTRIM(TaxDescription3))
	
	UPDATE [Staging.SalesOR] set Amount7  = LTRIM(RTRIM(Amount7))
	UPDATE [Staging.SalesOR] set ExportTo = LTRIM(RTRIM(ExportTo))
	
	
	UPDATE [Staging.SalesOR] SET ModelCode		  = LTRIM(RTRIM(ModelCode))
	UPDATE [Staging.SalesOR] SET ModelDescription = LTRIM(RTRIM(ModelDescription))
	UPDATE [Staging.SalesOR] SET ManufacturerName = LTRIM(RTRIM(ManufacturerName))
	UPDATE [Staging.SalesOR] SET ManufacturerCode = LTRIM(RTRIM(ManufacturerCode))
	
	UPDATE [Staging.SalesOR] SET SaleType		= LTRIM(RTRIM(SaleType))
	UPDATE [Staging.SalesOR] SET VehicleClass	= LTRIM(RTRIM(VehicleClass))
	UPDATE [Staging.SalesOR] SET VehicleType	= LTRIM(RTRIM(VehicleType))
	UPDATE [Staging.SalesOR] SET AreaCode		= LTRIM(RTRIM(AreaCode))
	
	UPDATE 	[Staging.SalesOR] SET BuyerName = NULL WHERE BuyerName = '-'
	UPDATE 	[Staging.SalesOR] SET BuyerAddress1 = NULL WHERE BuyerAddress1 = '-'
	UPDATE 	[Staging.SalesOR] SET BuyerAddress2 = NULL WHERE BuyerAddress2 = '-'
	UPDATE 	[Staging.SalesOR] SET BuyerAddress3 = NULL WHERE BuyerAddress3 = '-'
	UPDATE 	[Staging.SalesOR] SET BuyerAddress4 = NULL WHERE BuyerAddress4 = '-'
	

	
	-- 3.2 Get the Contact Type Id 
	--------------------------------------------------------------------------------------------------------
	
	UPDATE [Staging.SalesOR] SET
		[Staging.SalesOR].ContactTypeId = [Dimension.ContactTypes].ContactTypeId
	FROM [Staging.SalesOR]
	INNER JOIN [Dimension.ContactTypes] ON 
		[Staging.SalesOR].CountryId = [Dimension.ContactTypes].CountryId
	AND [Staging.SalesOR].CompanyId = [Dimension.ContactTypes].CompanyId
		
		
	-- 3.3 Get the Document Type Id 
	--------------------------------------------------------------------------------------------------------
		
	UPDATE [Staging.SalesOR] SET
		[Staging.SalesOR].DocumentTypeId = [Dimension.DocumentTypes].DocumentTypeId
	FROM [Staging.SalesOR]
	LEFT JOIN [Dimension.SaleType]		ON  
		[Staging.SalesOR].SaleType		= [Dimension.SaleType].SaleType
	LEFT JOIN [Dimension.DocumentTypes] ON 
		[Dimension.SaleType].DocSubType = [Dimension.DocumentTypes].DocSubType
	WHERE 
		[Dimension.DocumentTypes].DocType = 'INVOICE' 
	AND [Dimension.DocumentTypes].IsManual = 0
			
	UPDATE [Staging.SalesOR] SET IsError = 1 , Notes = 'NO CONTACT TYPE' WHERE ContactTypeId IS NULL
	UPDATE [Staging.SalesOR] SET IsError = 1 , Notes = 'WRONG SALE TYPE' WHERE DocumentTypeId IS NULL
	

	EXEC spDBImportSalesParseBusinessRules
	
	
	UPDATE [Staging.SalesOR] SET NoInvoiceNumber = 1 , IsError = 1 where InvoiceNumber is null
	UPDATE [Staging.SalesOR] SET NoInvoiceNumber	= 0 where NoInvoiceNumber is null
	
	
	EXEC spDBImportSalesParseModels
	


	-- 5 EXTRAS
	--------------------------------------------------------------------------------------------------------
	--------------------------------------------------------------------------------------------------------
	
	-- 5.1 Add new Extras
	--------------------------------------------------------------------------------------------------------

	MERGE [Fact.VehiclesExtraCharges] WITH (TABLOCK) AS TARGET
		USING 
		(
			SELECT 
			MileCharge	,	PlusKM	,	FuelCharge	,	Damage	,	SuperCharge	,
			HandleFee	,	AddOn	,	Other1	,	Other2,
			Amount5	,	Amount6	, RegTaxAmount
			FROM [Staging.SalesOR]
			GROUP BY 
			MileCharge	,	PlusKM	,	FuelCharge	,	Damage	,	SuperCharge	,
			HandleFee	,	AddOn	,	Other1	,	Other2,
			Amount5	,	Amount6	,	RegTaxAmount
		
			
		) AS SOURCE
		ON
		(
			TARGET.MileCharge	= SOURCE.MileCharge AND
			TARGET.PlusKM		= SOURCE.PlusKM AND
			TARGET.FuelCharge	= SOURCE.FuelCharge AND
			TARGET.Damage		= SOURCE.Damage AND
			TARGET.SuperCharge	= SOURCE.SuperCharge AND
			TARGET.HandleFee	= SOURCE.HandleFee AND
			TARGET.AddOn		= SOURCE.AddOn AND
			TARGET.Other1		= SOURCE.Other1 AND
			TARGET.Other2		= SOURCE.Other2 AND
			TARGET.Amount5		= SOURCE.Amount5 AND
			TARGET.Amount6		= SOURCE.Amount6 AND
			TARGET.RegTaxAmount = SOURCE.RegTaxAmount 
		)
		WHEN NOT MATCHED BY TARGET THEN
		INSERT 
		(MileCharge,PlusKM,FuelCharge,Damage,SuperCharge,HandleFee,AddOn,Other1,Other2,
		Amount5,Amount6,RegTaxAmount)
		VALUES 
		(SOURCE.MileCharge,SOURCE.PlusKM,SOURCE.FuelCharge,SOURCE.Damage,
		SOURCE.SuperCharge,SOURCE.HandleFee,SOURCE.AddOn,SOURCE.Other1,SOURCE.Other2,
		SOURCE.Amount5,SOURCE.Amount6,SOURCE.RegTaxAmount);
		
	--5.2 Find Extras Id
	--------------------------------------------------------------------------------------------------------
	UPDATE [Staging.SalesOR] SET
		[Staging.SalesOR].ExtrasId = [Fact.VehiclesExtraCharges].ExtrasId
	FROM [Staging.SalesOR]
	INNER JOIN [Fact.VehiclesExtraCharges] ON 
		[Staging.SalesOR].MileCharge	= [Fact.VehiclesExtraCharges].MileCharge 
	AND [Staging.SalesOR].PlusKM		= [Fact.VehiclesExtraCharges].PlusKM
	AND [Staging.SalesOR].FuelCharge	= [Fact.VehiclesExtraCharges].FuelCharge
	AND [Staging.SalesOR].Damage		= [Fact.VehiclesExtraCharges].Damage
	AND [Staging.SalesOR].SuperCharge	= [Fact.VehiclesExtraCharges].SuperCharge
	AND [Staging.SalesOR].HandleFee		= [Fact.VehiclesExtraCharges].HandleFee
	AND [Staging.SalesOR].AddOn			= [Fact.VehiclesExtraCharges].AddOn
	AND [Staging.SalesOR].Other1		= [Fact.VehiclesExtraCharges].Other1
	AND [Staging.SalesOR].Other2		= [Fact.VehiclesExtraCharges].Other2
	AND [Staging.SalesOR].Amount5		= [Fact.VehiclesExtraCharges].Amount5
	AND [Staging.SalesOR].Amount6		= [Fact.VehiclesExtraCharges].Amount6
	AND [Staging.SalesOR].RegTaxAmount	= [Fact.VehiclesExtraCharges].RegTaxAmount
		
	UPDATE [Staging.SalesOR] SET ExtrasId = 0 WHERE ExtrasId IS NULL
	
	-- 6 REPORTS
	--------------------------------------------------------------------------------------------------------
	--------------------------------------------------------------------------------------------------------	
	
	EXEC spDBImportSalesIsReport
		
		
	-- 7 BUYERS
	--------------------------------------------------------------------------------------------------------
	--------------------------------------------------------------------------------------------------------					
	
	EXEC spDBImportSalesParseBuyers;
	
	
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
			FROM [Staging.SalesOR]
			GROUP BY 
			CompanyId , Serial , Plate , Unit , InServiceDate , OutServiceDate  , MSODate , PurchaseOrder , 
			PayDate , ModelId , BuyerId
		)
		UPDATE [Staging.SalesOR] SET
		IsRepeated = 1 WHERE Serial in
		(SELECT Serial FROM dup WHERE RNS > 1)
		
	UPDATE [Staging.SalesOR] SET IsRepeated = 0 WHERE IsRepeated IS NULL
	
	-- 7.2 Check duplicate Invoices in the Archive.Sales table
	--------------------------------------------------------------------------------------------------------
	MERGE [Staging.SalesOR] AS TARGET
		USING [Archive.Sales] AS SOURCE
		ON 
		(
			TARGET.CompanyId		= SOURCE.CompanyId		AND
			TARGET.Serial			= SOURCE.Serial			AND
			TARGET.Plate			= SOURCE.Plate			AND
			TARGET.InvoiceNumber	= SOURCE.invoiceNumber	
			
			
		)
		WHEN MATCHED THEN
		UPDATE SET
		TARGET.IsDuplicate = 1;
		
	UPDATE [Staging.SalesOR] SET IsDuplicate = 0 WHERE IsDuplicate IS NULL
		
		
	
	UPDATE [Staging.SalesOR] SET NoInvoiceDate = 1 where InvoiceDate is null
	
	UPDATE [Staging.SalesOR] SET NoInvoiceDate = 1 , Notes = 'Wrong Invoice Date' where InvoiceDate > GETDATE()
	
	
	
	UPDATE [Staging.SalesOR] SET NoInvoiceDate = 0 where NoInvoiceDate is null
	
	
	UPDATE [Staging.SalesOR] set IsError = 1 where 
	IsDuplicate = 1 or NoInvoiceNumber = 1 or NoBuyerCode = 1 or 
	NoInvoiceDate = 1 or NoModelCode = 1
	
	
	
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
		FROM [Staging.SalesOR]
		WHERE IsError = 1
		
	
	DELETE FROM [Staging.SalesOR] WHERE 
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
			FROM [Staging.SalesOR]
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
		
	UPDATE [Staging.SalesOR] SET
		[Staging.SalesOR].ItemId = [Fact.Items].ItemId
	FROM [Staging.SalesOR]
	INNER JOIN [Fact.Items] ON 
		[Staging.SalesOR].VehicleId		= [Fact.Items].DescriptionId
	AND [Staging.SalesOR].ExtrasId		= [Fact.Items].ExtrasId 
	AND [Staging.SalesOR].InvoiceNet	= [Fact.Items].Value
	AND [Staging.SalesOR].InvoiceVat	= [Fact.Items].Vat
	AND [Staging.SalesOR].InvoiceTotal  = [Fact.Items].Total
					
				
	--DELETE FROM [Staging.SalesOR] WHERE IsDuplicate = 1
			
	
	-- 8 DOCUMENTS
	--------------------------------------------------------------------------------------------------------
	--------------------------------------------------------------------------------------------------------
		
	-- 8.1 Add New Documents
	--------------------------------------------------------------------------------------------
	MERGE [Fact.Documents] WITH (TABLOCK) AS TARGET
		USING
		(
			SELECT 
				DocumentTypeId , CompanyId , BuyerId , InvoiceNumber , LogId
			FROM [Staging.SalesOR]
			--WHERE DocItemId is null
			GROUP BY 
				DocumentTypeId , CompanyId , BuyerId , InvoiceNumber , LogId
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
	
	UPDATE [Staging.SalesOR] SET
		[Staging.SalesOR].DocumentId = [Fact.Documents].DocumentId 
	FROM [Staging.SalesOR]
	INNER JOIN [Fact.Documents] ON 
		[Staging.SalesOR].InvoiceNumber	 = [Fact.Documents].DocumentNumber
	AND [Staging.SalesOR].BuyerId		 = [Fact.Documents].BuyerId 
	AND [Staging.SalesOR].LogId			 = [Fact.Documents].LogId
	AND [Staging.SalesOR].CompanyId		 = [Fact.Documents].CompanyId
	AND [Staging.SalesOR].DocumentTypeId = [Fact.Documents].DocumentTypeId
	WHERE 
		[Staging.SalesOR].DocumentId IS NULL
		
		
	UPDATE [Staging.SalesOR] SET
		[Staging.SalesOR].DocumentId = [Fact.Documents].DocumentId 
	FROM [Staging.SalesOR]
	INNER JOIN [Fact.Documents] ON 
		[Staging.SalesOR].InvoiceNumber	 = [Fact.Documents].DocumentNumber
	AND [Staging.SalesOR].BuyerId		 = [Fact.Documents].BuyerId 
	--AND [Staging.SalesOR].LogId			 = [Fact.Documents].LogId
	AND [Staging.SalesOR].CompanyId		 = [Fact.Documents].CompanyId
	AND [Staging.SalesOR].DocumentTypeId = [Fact.Documents].DocumentTypeId
	WHERE 
		[Staging.SalesOR].DocumentId IS NULL
		
		
		
	
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
			FROM [Staging.SalesOR]
			--WHERE DocItemId IS NULL
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
			
	UPDATE [Staging.SalesOR] SET
		[Staging.SalesOR].DocItemId = [Fact.DocumentItems].DocItemId
	FROM [Staging.SalesOR] 
	INNER JOIN [Fact.DocumentItems] ON 
		[Staging.SalesOR].DocumentId = [Fact.DocumentItems].DocumentId 
	AND [Staging.SalesOR].ItemId	 = [Fact.DocumentItems].ItemId 
	AND [Staging.SalesOR].CompanyId  = [Fact.DocumentItems].CompanyId 
	WHERE [Staging.SalesOR].DocItemId IS NULL;	
	
	UPDATE 	[Staging.SalesOR] SET
		IsError = 0
	WHERE
		IsError IS NULL
	
	UPDATE [Staging.SalesOR] SET
		HasDocument = 1
	WHERE
		DocItemId IS NOT NULL
	
	UPDATE [Staging.SalesOR] SET
		HasDocument = 0
	WHERE
		DocItemId IS NULL
		
	UPDATE [Staging.SalesOR] SET NoBuyerCode	 = 0 WHERE NoBuyerCode IS NULL
	UPDATE [Staging.SalesOR] SET NoInvoiceDate	 = 0 WHERE NoInvoiceDate IS NULL
	UPDATE [Staging.SalesOR] SET NoModelCode	 = 0 WHERE NoModelCode IS NULL
	UPDATE [Staging.SalesOR] SET NoInvoiceNumber = 0 WHERE NoInvoiceNumber IS NULL
		
	
		

END