-- =============================================
-- Author:		Javier
-- Create date: September 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spDBImportSalesParseBusinessRules]
	
AS
BEGIN
	
	SET NOCOUNT ON;
	
	-- 3.4 [Business Rule 1] Use the Sale Document Number as Invoice for some Countries
	--------------------------------------------------------------------------------------------------------
	UPDATE [Staging.SalesOR] SET InvoiceNumber = SaleDocumentNumber WHERE CompanyId IN
	(SELECT CompanyId FROM [Dimension.Companies] WHERE CompanyCode IN ('SP','BE','LU','SZ','NE','NF'))
	
	
	UPDATE [Staging.SalesOR] SET InvoiceNumber = SaleDocumentNumber 
	WHERE CompanyCode  = 'FR' AND SaleType = 'T'
	
	
	
	--UPDATE [Staging.SalesOR] SET
	--InvoiceNumber = STUFF(SUBSTRING(InvoiceNumber , 1 , LEN(InvoiceNumber) - 1) , 1 , 0 , 
	--	REPLICATE('0',7 - LEN(SUBSTRING(InvoiceNumber , 1 , LEN(InvoiceNumber) - 1)))) 
	--where CompanyCode = 'SP'
	
	UPDATE [Staging.SalesOR] set
		InvoiceNumber = SUBSTRING(InvoiceNumber,2,LEN(InvoiceNumber))
	WHERE 
		CompanyCode = 'SP' AND 
		SUBSTRING(InvoiceNumber,1,1) = 0 and LEN(InvoiceNumber) = 7


	UPDATE [Staging.SalesOR] set
		InvoiceNumber = SUBSTRING(InvoiceNumber,1,LEN(InvoiceNumber)-1)
	WHERE 
		CompanyCode = 'SP' AND 
		LEN(InvoiceNumber) = 7
	
	
	
	UPDATE [Staging.SalesOR] SET IsError = 1 , NoInvoiceNumber = 1 WHERE CONVERT(INT , InvoiceNumber) = 0
	
	-- FARNCE SALEDOCNUMBER (8 DIGITS)
	
	UPDATE [Staging.SalesOR] SET 
		SaleDocumentNumber = '0' + SaleDocumentNumber
	WHERE LEN(SaleDocumentNumber) = 7 AND CountryId = 6
	
	UPDATE [Staging.SalesOR] SET 
		SaleDocumentNumber = '00' + SaleDocumentNumber
	WHERE LEN(SaleDocumentNumber) = 6 AND CountryId = 6
	
	
		
		
	-- 3.5 [Business Rule 2] Tax Code for Italy
	--------------------------------------------------------------------------------------------------------
	
	UPDATE [Staging.SalesOR] SET 
		[Staging.SalesOR].TaxCodeId = [Dimension.TaxCodes].TaxCodeId
	FROM 
		[Staging.SalesOR]
	INNER JOIN [Dimension.TaxCodes] ON
		[Staging.SalesOR].TaxDescription3 = [Dimension.TaxCodes].TaxCode
	WHERE 
		[Staging.SalesOR].CompanyCode IN ('IT','I2')
		
		
	UPDATE [Staging.SalesOR] SET 
		[Staging.SalesOR].TaxCodeId = [Dimension.TaxCodes].TaxCodeId
	FROM 
		[Staging.SalesOR]
	INNER JOIN [Dimension.TaxCodes] ON
		[Staging.SalesOR].TaxDescription2 = [Dimension.TaxCodes].TaxCode
	WHERE 
		[Staging.SalesOR].CompanyCode IN ('IT','I2') AND
		[Staging.SalesOR].TaxCodeId IS NULL
		
	
	UPDATE [Staging.SalesOR]  SET 
		[Staging.SalesOR].TaxCodeId = 0
	WHERE [Staging.SalesOR].TaxCodeId IS NULL
	

   
END