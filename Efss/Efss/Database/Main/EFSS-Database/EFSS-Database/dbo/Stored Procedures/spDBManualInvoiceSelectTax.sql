-- =============================================
-- Author:		Javier
-- Create date: September 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE spDBManualInvoiceSelectTax
	@countryId int
AS
BEGIN

	SET NOCOUNT ON;

	SELECT 
		TaxCodeId , TaxCode 
	FROM [Dimension.TaxCodes]
	WHERE 
		CountryId = @countryId
   
END