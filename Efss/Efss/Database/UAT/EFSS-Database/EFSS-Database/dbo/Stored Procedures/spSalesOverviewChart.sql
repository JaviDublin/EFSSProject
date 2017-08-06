-- =============================================
-- Author:		Javier
-- Create date: August 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spSalesOverviewChart]

AS
BEGIN
	
	SET NOCOUNT ON;
	
	DECLARE @year INT
	SET @year = YEAR(GETDATE())
	
	DECLARE @total INT
	SET @total = (SELECT COUNT([Archive.Sales].RowId) FROM [Archive.Sales] WHERE 
		[Archive.Sales].SaleType NOT IN ('T','L') 
	AND YEAR([Archive.Sales].SaleDate) = @year)
	
		
	SELECT 
		[Dimension.Countries].CountryCode , COUNT([Archive.Sales].RowId) * 100 / @total AS "Total"
	FROM [Archive.Sales]
	INNER JOIN [Dimension.Countries] on [Archive.Sales].CountryId = [Dimension.Countries].CountryId
	WHERE 
		[Archive.Sales].SaleType NOT IN ('T','L') 
	AND YEAR([Archive.Sales].SaleDate) = @year
	GROUP BY 
		[Dimension.Countries].CountryCode
  
END