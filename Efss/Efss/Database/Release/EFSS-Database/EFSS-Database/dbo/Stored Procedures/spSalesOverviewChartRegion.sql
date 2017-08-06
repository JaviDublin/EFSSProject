-- =============================================
-- Author:		Javier
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spSalesOverviewChartRegion] 

AS
BEGIN
	
	SET NOCOUNT ON;

	DECLARE @year INT
	SET @year = YEAR(GETDATE())
	
	
	DECLARE @total INT
	SET @total = (SELECT COUNT(*) FROM [Archive.Sales] WHERE 
		[Archive.Sales].SaleType NOT IN ('T','L') 
	AND YEAR([Archive.Sales].SaleDate) = @year)
		
	SELECT 
		[Dimension.Regions].RegionName , COUNT([Archive.Sales].RowId) * 100 / @total AS "Total"
	FROM [Archive.Sales]
	INNER JOIN [Dimension.Countries] ON [Archive.Sales].CountryId = [Dimension.Countries].CountryId
	INNER JOIN [Dimension.Regions]   ON [Dimension.Countries].RegionId  = [Dimension.Regions].RegionId
	WHERE 
		[Archive.Sales].SaleType NOT IN ('T','L') 
	AND YEAR([Archive.Sales].SaleDate) = @year
	GROUP BY 
		[Dimension.Regions].RegionName
END