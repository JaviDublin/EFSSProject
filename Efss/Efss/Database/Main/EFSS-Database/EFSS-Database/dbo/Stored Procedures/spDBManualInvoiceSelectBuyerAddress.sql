-- =============================================
-- Author:		Javier
-- Create date: September 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spDBManualInvoiceSelectBuyerAddress] 
		@companyId INT,
		@countryId INT,
		@buyerName VARCHAR(255),
		@manufactuerCode VARCHAR(10)
AS
BEGIN
	
	SET NOCOUNT ON;
	
	
	SELECT BuyerAddress1 as "BuyerAddress"
	FROM [Fact.BuyersAddress]
	WHERE BuyerId IN
	(
	
	SELECT BuyerId
	FROM [Dimension.Buyers]
	WHERE
		CountryId = @countryId AND
		CompanyId = @companyId AND
		BuyerName = @buyerName AND
		ManufacturerCode = 	@manufactuerCode
	)
 
END