-- =============================================
-- Author:		Javier
-- Create date: September 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spManufacturerCodeByCountryId]
	@countryId  int
AS
BEGIN
	
	SET NOCOUNT ON;
	
	SELECT 
		[Dimension.Buyers].ManufacturerCode as "ManufacturerId", 
		
		case when LEN([Dimension.Buyers].ManufacturerCode) = 1 then
			[Dimension.Buyers].ManufacturerCode + SPACE(1) + '  - ' +
			[Dimension.Manufacturer].ManufacturerName
		else
			[Dimension.Buyers].ManufacturerCode + ' - ' +
			[Dimension.Manufacturer].ManufacturerName
		end as "ManufacturerName"
		
	FROM 
		[Dimension.Buyers]
	INNER JOIN [Dimension.ManufacturerVision]	ON
		[Dimension.Buyers].ManufacturerCode = [Dimension.ManufacturerVision].VisionCode
	INNER JOIN [Dimension.Manufacturer]			ON 
		[Dimension.ManufacturerVision].ManufacturerId = [Dimension.Manufacturer].ManufacturerId
	WHERE 
		[Dimension.Buyers].CountryId = @countryId
	GROUP BY 
		[Dimension.Buyers].ManufacturerCode , [Dimension.Manufacturer].ManufacturerName
	ORDER BY
		[Dimension.Manufacturer].ManufacturerName

  

END