-- =============================================
-- Author:		Javier
-- Create date: October 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spDBImportSalesCNTransfer]

AS
BEGIN
	
	SET NOCOUNT ON;
	
	INSERT INTO [Archive.Sales] WITH (TABLOCK)
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
		NoInvoiceNumber ,	NoBuyerCode     ,	NoInvoiceDate   ,	NoModelCode		  ,
		OldInvoiceNumber,   OldInvoiceDate  ,  OldRowId
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
		NoInvoiceNumber ,	NoBuyerCode     ,	NoInvoiceDate   ,	NoModelCode		  ,
		OldInvoiceNumber,   OldInvoiceDate  ,  OldRowId
		FROM [Staging.SalesCN]

  
END