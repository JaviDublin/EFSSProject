-- =============================================
-- Author:		Javier
-- Create date: September 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spDBManualInvoiceSelectBuyerManufacturer]
		@companyId INT,
		@countryId INT,
		@buyerName VARCHAR(255)	
AS
BEGIN

	SET NOCOUNT ON;
	
	SELECT
		ManufacturerCode
	FROM [Dimension.Buyers]
	WHERE
		CountryId = @countryId AND
		CompanyId = @companyId AND
		BuyerName = @buyerName
	GROUP BY
		ManufacturerCode
	ORDER BY 
		ManufacturerCode
   
END