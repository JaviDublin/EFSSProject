-- =============================================
-- Author:		Javier
-- Create date: August 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spManufacturersBuyersByCountryId]
	@countryId INT
AS
BEGIN
	
	SET NOCOUNT ON;

   SELECT 
		[Dimension.Manufacturer].ManufacturerId ,  [Dimension.Manufacturer].ManufacturerName 
	FROM [Fact.BuyersManufacturer]
	INNER JOIN [Dimension.Manufacturer] ON 
		[Fact.BuyersManufacturer].ManufacturerId  = [Dimension.Manufacturer].ManufacturerId
	INNER JOIN [Dimension.Buyers]		ON 
		[Fact.BuyersManufacturer].BuyerId  = [Dimension.Buyers].BuyerId
	WHERE 
		[Dimension.Buyers].CountryId = @countryId
	GROUP BY 
		[Dimension.Manufacturer].ManufacturerId ,  [Dimension.Manufacturer].ManufacturerName 
	ORDER BY 
		[Dimension.Manufacturer].ManufacturerName 
END