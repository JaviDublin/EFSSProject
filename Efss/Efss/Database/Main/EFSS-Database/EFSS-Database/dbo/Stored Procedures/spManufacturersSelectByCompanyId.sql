-- =============================================
-- Author:		Javier
-- Create date: August 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spManufacturersSelectByCompanyId]
	@companyId int,
	@countryId int
AS
BEGIN
	
	SET NOCOUNT ON;

	IF @companyId IS NULL
	BEGIN
		SELECT 
			convert(varchar,[Dimension.Manufacturer].ManufacturerId) as "ManufacturerId",
			[Dimension.Manufacturer].ManufacturerName 
		FROM 
			[Dimension.Manufacturer]
		INNER JOIN [Archive.Sales] ON 
			[Dimension.Manufacturer].[ManufacturerName] = [Archive.Sales].[ManufacturerName]
			or
			[Dimension.Manufacturer].ManufacturerGroup  = [Archive.Sales].[ManufacturerName] 
		WHERE 
			[Archive.Sales].CountryId = @countryId
		GROUP BY 
			[Dimension.Manufacturer].ManufacturerId,
			[Dimension.Manufacturer].ManufacturerName 
		ORDER BY 
			[Dimension.Manufacturer].ManufacturerName 
	
	END
	ELSE
	BEGIN
		SELECT 
			convert(varchar,[Dimension.Manufacturer].ManufacturerId) as "ManufacturerId",
			[Dimension.Manufacturer].ManufacturerName 
		FROM 
			[Dimension.Manufacturer]
		INNER JOIN [Archive.Sales] ON 
			[Dimension.Manufacturer].[ManufacturerName] = [Archive.Sales].[ManufacturerName]
			or
			[Dimension.Manufacturer].ManufacturerGroup  = [Archive.Sales].[ManufacturerName] 
		WHERE 
			[Archive.Sales].CompanyId = @companyId
		GROUP BY 
			[Dimension.Manufacturer].ManufacturerId,
			[Dimension.Manufacturer].ManufacturerName 
		ORDER BY 
			[Dimension.Manufacturer].ManufacturerName 
	
	END

	
   
END