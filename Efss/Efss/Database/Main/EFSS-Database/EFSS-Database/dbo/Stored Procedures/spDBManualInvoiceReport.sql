-- =============================================
-- Author:		Javier
-- Create date: September 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spDBManualInvoiceReport]
	
AS
BEGIN
	
	SET NOCOUNT ON;

    SELECT
		[Staging.ManualInvoice].CountryName,
		[Staging.ManualInvoice].CompanyName,
		[Staging.ManualInvoice].DocumentType,
		[Staging.ManualInvoice].InvoiceType,
		CONVERT(VARCHAR(11),[Staging.ManualInvoice].InvoiceDate,104) AS "InvoiceDate",
		[Staging.ManualInvoice].BuyerName,
		[Staging.ManualInvoice].BuyerCode,
		[Staging.ManualInvoice].Serial,
		[Staging.ManualInvoice].TaxCode,
		[Staging.ManualInvoice].DescriptionName,
		--[Staging.ManualInvoice].CompanyId,
		--[Staging.ManualInvoice].CountryId,
		--[Staging.ManualInvoice].TaxCodeId,
		[Staging.ManualInvoice].DocumentTypeId,
		[Staging.ManualInvoice].ContactTypeId,
		[Staging.ManualInvoice].VehicleId,
		--[Staging.ManualInvoice].ModelCodeId,
		--[Staging.ManualInvoice].ModelId,
		--[Staging.ManualInvoice].ModelDetailId,
		--[Staging.ManualInvoice].BuyerId,
		[Staging.ManualInvoice].ManufacturerName,
		[Staging.ManualInvoice].ManufacturerId,
		--[Staging.ManualInvoice].DocumentId,
		--[Staging.ManualInvoice].ItemId,
		--[Staging.ManualInvoice].DocItemId,
		[Staging.ManualInvoice].BuyerAddressId,
		[Staging.ManualInvoice].BuyerAddress1,
		[Staging.ManualInvoice].BuyerAddress2,
		[Staging.ManualInvoice].BuyerAddress3,
		[Staging.ManualInvoice].BuyerAddress4,
		[Staging.ManualInvoice].BuyerFiscalCode,
		[Staging.ManualInvoice].ManufacturerCode,
		[Staging.ManualInvoice].InvoiceNumber,
		CONVERT(VARCHAR,CONVERT(MONEY,[Staging.ManualInvoice].InvoiceNet),1)   AS "InvoiceNet",
		CONVERT(VARCHAR,CONVERT(MONEY,[Staging.ManualInvoice].InvoiceVat),1)   AS "InvoiceVat",
		CONVERT(VARCHAR,CONVERT(MONEY,[Staging.ManualInvoice].InvoiceTotal),1) AS "InvoiceTotal",
		[Staging.ManualInvoice].VatPCT,
		[Dimension.CompanyAddress].Address1 ,
		[Dimension.CompanyAddress].Address2 ,
		[Dimension.CompanyAddress].Address3 ,
		[Dimension.CompanyAddress].Address4 ,
		[Dimension.CompanyAddress].Address5 ,
		[Dimension.CompanyAddress].Address6 ,
		[Dimension.CompanyAddress].Address7 ,
		[Dimension.CompanyAddress].Address8 ,
		[Dimension.CompanyAddress].Address9 ,
		[Dimension.CompanyAddress].Address10 ,
		[Dimension.CompanyAddress].Address11 ,
		[Dimension.CompanyAddress].Address12 ,
		[Dimension.CompanyAddress].TextFooter
	FROM  [Staging.ManualInvoice]
	INNER JOIN [Dimension.CompanyAddress] ON 
		[Staging.ManualInvoice].CompanyId = [Dimension.CompanyAddress].CompanyId
END