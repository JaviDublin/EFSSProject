-- =============================================
-- Author:		Javier
-- Create date: May 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spSalesSearchEngineToExcelByBuyer]
	@fileDate	 VARCHAR(50) = NULL,
	@invoiceDate VARCHAR(50) = NULL,
	@countryId	 INT,
	@buyerId	 INT
AS
BEGIN

	SET NOCOUNT ON;
		
	IF @fileDate	= 'ALL' BEGIN SET @fileDate		= NULL END
	IF @invoiceDate	= 'ALL' BEGIN SET @invoiceDate	= NULL END
	
	
	SELECT 
		u.RowId , u.CompanyCode , u.AreaCode , u.Serial ,u.Unit , u.Plate , u.Mileage ,
		CONVERT(VARCHAR(11),u.InServiceDate,103)	AS "InServiceDate",
		CONVERT(VARCHAR(11),u.OutServiceDate,103)	AS "OutServiceDate",
		CONVERT(VARCHAR(11),u.MSODate,103)			AS "MSODate",
		u.ModelCode , u.ModelDescription , u.CarColor , u.ModelYear , u.ManufacturerCode ,
		u.ManufacturerName , u.VehicleClass , u.VehicleType ,u.PurchaseOrder ,
		CONVERT(VARCHAR(11),u.PayDate,103)	AS "PayDate",
		u.InvoiceNumber,
		d.DocType AS "INV_CN",
		CONVERT(VARCHAR(11),u.SaleDate,103)	AS "SaleDate",
		CONVERT(VARCHAR(11),u.InvoiceDate,103)	AS "InvoiceDate",
		u.SaleType,
		u.SaleDocumentNumber,
		u.InvoiceNet	 ,u.InvoiceVat		,u.InvoiceTotal,
		u.BuyerCode		 ,u.BuyerName		,u.BuyerAddress1	,u.BuyerAddress2	,u.BuyerAddress3,
		u.BuyerAddress4	 ,u.BuyerFiscalCode ,
		u.CapitalCost	 ,u.Depreciation	,u.BookValue		,u.BuyBackCap		,u.MileCharge , u.PlusKM,
		u.FuelCharge	 ,u.Damage			,u.TransferFees		,u.TransferFeesNoVat,
		u.TaxDescription1,u.TaxDescription2 ,u.TaxDescription3	,
		u.OriginalBPM	 ,u.CalcVatAmortized,u.Unamortized		,u.SuperCharge		,u.HandleFee , u.AddOn,
		u.Other1		 ,u.Other2			,u.Amount5			,u.Amount6 ,
		u.Amount7		,u.ExportTo			,u.Tax				,u.RegTaxAmount
	FROM 
	[Archive.Sales] u
	INNER JOIN [Application.FileLog] AS f ON
		u.LogId = f.LogId
	INNER JOIN [Dimension.DocumentTypes] as d ON u.DocumentTypeId = d.DocumentTypeId
	WHERE 	((@fileDate		IS NULL) OR (CONVERT(VARCHAR(11),f.DateLog,103) = @fileDate))
		AND ((@invoiceDate	IS NULL) OR (CONVERT(VARCHAR(11),u.InvoiceDate,103) = @invoiceDate))
		AND u.CountryId = @countryid
		AND u.BuyerId   = @buyerid
	GROUP BY
		u.RowId , u.CompanyCode , u.AreaCode , u.Serial ,u.Unit , u.Plate , u.Mileage ,
		u.InServiceDate,u.OutServiceDate,u.MSODate,
		u.ModelCode , u.ModelDescription , u.CarColor , u.ModelYear , u.ManufacturerCode ,
		u.ManufacturerName , u.VehicleClass , u.VehicleType ,u.PurchaseOrder ,
		u.PayDate,u.InvoiceNumber,u.SaleDate,u.InvoiceDate,u.SaleType,u.SaleDocumentNumber,
		u.InvoiceNet	 ,u.InvoiceVat		,u.InvoiceTotal,
		u.BuyerCode		 ,u.BuyerName		,u.BuyerAddress1	,u.BuyerAddress2	,u.BuyerAddress3,
		u.BuyerAddress4	 ,u.BuyerFiscalCode ,
		u.CapitalCost	 ,u.Depreciation	,u.BookValue		,u.BuyBackCap		,u.MileCharge , u.PlusKM,
		u.FuelCharge	 ,u.Damage			,u.TransferFees		,u.TransferFeesNoVat,
		u.TaxDescription1,u.TaxDescription2 ,u.TaxDescription3	,
		u.OriginalBPM	 ,u.CalcVatAmortized,u.Unamortized		,u.SuperCharge		,u.HandleFee , u.AddOn,
		u.Other1		 ,u.Other2			,u.Amount5			,u.Amount6 ,
		u.Amount7		,u.ExportTo			,u.Tax				,u.RegTaxAmount , d.DocType
	

END