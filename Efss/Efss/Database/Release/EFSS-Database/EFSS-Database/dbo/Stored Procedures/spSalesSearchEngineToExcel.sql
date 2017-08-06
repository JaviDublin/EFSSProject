-- =============================================
-- Author:		Javier
-- Create date: May 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spSalesSearchEngineToExcel] 
		@countryId			INT			= NULL,
		@companyId			INT			= NULL,
		@plate				VARCHAR(50) = NULL,
		@unit				VARCHAR(50) = NULL,
		@serial				VARCHAR(50) = NULL,
		@dateFrom			VARCHAR(25) = NULL,
		@dateTo				VARCHAR(25) = NULL,
		@invoiceFrom		INT			= NULL,
		@invoiceTo			INT			= NULL,
		@buyerCode			VARCHAR(25)	= NULL,
		@buyerName			VARCHAR(255)= NULL,
		@invoiceType		VARCHAR(50) = NULL,
		@invoiceSubType		VARCHAR(50) = NULL,
		@manufacturer		VARCHAR(50) = NULL,
		@vehicleType		VARCHAR(5)	= NULL,
		@saleType			VARCHAR(5)	= NULL,
		@fileDate			VARCHAR(50) = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	IF @companyId = 0 BEGIN SET @companyId = NULL END
	
	DECLARE @df DATETIME ,
			@dt DATETIME
			
	SET @df = CONVERT(DATETIME , @dateFrom , 103)
	SET @dt = CONVERT(DATETIME , @dateTo	+ ' 23:59',103)
	
	
	
	IF @InvoiceFrom = NULL
	BEGIN
		IF @invoiceTo IS NULL
		BEGIN
			SET @InvoiceFrom = (SELECT MIN(CONVERT(INT,InvoiceNumber)) 
									FROM [Archive.Sales] WHERE CompanyId = @companyId)
			SET @invoiceTo	 = (SELECT MAX(CONVERT(INT,InvoiceNumber)) 
									FROM [Archive.Sales] WHERE CompanyId = @companyId)
		END
		ELSE
		BEGIN
			SET @InvoiceFrom = (SELECT MIN(CONVERT(INT,InvoiceNumber)) 
									FROM [Archive.Sales] WHERE CompanyId = @companyId)
		END
		
	END
	ELSE
	BEGIN
		IF @invoiceTo IS NULL
		BEGIN
			SET @invoiceTo = @InvoiceFrom
		END
	END
	
	
	SELECT
		u.RowId , a.CompanyCode,a.AreaCode, 
		a.Serial,a.Unit,a.Plate,a.Mileage,
		CONVERT(VARCHAR(11),a.InServiceDate,103)	AS "InServiceDate",
		CONVERT(VARCHAR(11),a.OutServiceDate,103)	AS "OutServiceDate",
		CONVERT(VARCHAR(11),a.MSODate,103)			AS "MSODate",
		a.ModelCode,a.ModelDescription,a.CarColor,a.ModelYear,a.ManufacturerCode,a.ManufacturerName,
		a.VehicleClass, a.VehicleType,a.PurchaseOrder,
		CONVERT(VARCHAR(11),a.PayDate,103)	AS "PayDate",
		a.InvoiceNumber,
		d.DocType AS "INV_CN",
		CONVERT(VARCHAR(11),a.SaleDate,103)	AS "SaleDate",
		CONVERT(VARCHAR(11),a.InvoiceDate,103)	AS "InvoiceDate",
		a.SaleType,
		a.SaleDocumentNumber,
		a.InvoiceNet,a.InvoiceVat,a.InvoiceTotal,
		a.BuyerCode,a.BuyerName,a.BuyerAddress1,a.BuyerAddress2,a.BuyerAddress3,
		a.BuyerAddress4,a.BuyerFiscalCode,
		a.CapitalCost,a.Depreciation,a.BookValue,a.BuyBackCap,a.MileCharge,a.PlusKM,
		a.FuelCharge,a.Damage,a.TransferFees,a.TransferFeesNoVat,
		a.TaxDescription1,a.TaxDescription2,a.TaxDescription3,
		a.OriginalBPM,a.CalcVatAmortized,a.Unamortized,a.SuperCharge,a.HandleFee,a.AddOn,
		a.Other1,a.Other2,a.Amount5,a.Amount6,a.Amount7,a.ExportTo,a.Tax,a.RegTaxAmount
	
	FROM fnSalesSummaryByCountry(@countryId,@companyId) u
	INNER JOIN [Archive.Sales] AS a ON u.RowId = a.RowId
	INNER JOIN [Dimension.DocumentTypes] as d ON a.DocumentTypeId = d.DocumentTypeId
	WHERE 
		((@plate			IS NULL) OR (u.Plate	LIKE '%' + @plate + '%'))
	AND	((@unit				IS NULL) OR (u.Unit	LIKE '%' + @unit + '%'))
	AND	((@serial			IS NULL) OR (u.Serial	LIKE '%' + @serial + '%'))
	AND	((@manufacturer		IS NULL) OR (u.ManufacturerName	LIKE '%' + @manufacturer + '%'))
	AND	((@buyerName		IS NULL) OR (u.Buyername	LIKE '%' + @buyerName + '%'))
	AND	((@buyerCode		IS NULL) OR (u.BuyerCode LIKE '%' + @buyerCode))
	AND	((@invoiceType		IS NULL) OR (u.DocType = @invoiceType))
	AND	((@invoiceSubType	IS NULL) OR (u.DocSubType = @invoiceSubType))
	AND ((@invoiceFrom		IS NULL) OR (u.InvoiceNumber BETWEEN @invoiceFrom AND @invoiceTo))
	AND ((@dateFrom			IS NULL) OR (u.InvoiceDate   BETWEEN @df AND @dt))
	AND	((@vehicleType		IS NULL) OR (a.VehicleType	 = @vehicleType))
	AND ((@saleType			IS NULL) OR(a.SaleType = @saleType))
	AND ((@fileDate			IS NULL) OR (CONVERT(VARCHAR(11),u.DateLog,103) = @fileDate))
	GROUP BY 
		u.RowId , a.CompanyCode,a.AreaCode,
		a.Serial,a.Unit,a.Plate,a.Mileage,a.InServiceDate,a.OutServiceDate,a.MSODate,
		a.ModelCode,a.ModelDescription,a.CarColor,a.ModelYear,a.ManufacturerCode,a.ManufacturerName,
		a.VehicleClass,
		a.VehicleType,a.PurchaseOrder,a.PayDate,a.InvoiceNumber,a.SaleDate,a.InvoiceDate,a.SaleType,
		a.SaleDocumentNumber,
		a.InvoiceNet,a.InvoiceVat,a.InvoiceTotal,a.BuyerCode,a.BuyerName,a.BuyerAddress1,a.BuyerAddress2,
		a.BuyerAddress3,
		a.BuyerAddress4,a.BuyerFiscalCode,a.CapitalCost,a.Depreciation,a.BookValue,a.BuyBackCap,a.MileCharge,
		a.PlusKM,
		a.FuelCharge,a.Damage,a.TransferFees,a.TransferFeesNoVat,a.TaxDescription1,a.TaxDescription2,
		a.TaxDescription3,a.OriginalBPM,a.CalcVatAmortized,a.Unamortized,a.SuperCharge,a.HandleFee,a.AddOn,
		a.Other1,a.Other2,a.Amount5,a.Amount6,a.Amount7,a.ExportTo,a.Tax,a.RegTaxAmount,d.DocType
	
   
  
END