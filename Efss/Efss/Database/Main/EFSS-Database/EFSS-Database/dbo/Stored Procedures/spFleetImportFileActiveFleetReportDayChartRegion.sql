-- =============================================
-- Author:		Javier
-- Create date: August 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spFleetImportFileActiveFleetReportDayChartRegion]
	
AS
BEGIN
	
	SET NOCOUNT ON;

   	DECLARE @DATE DATETIME
	SET @DATE = (SELECT MAX(DateCreated) FROM [Import.ActiveFleetDayReport])
	
	DECLARE @total INT
	SET @total = (SELECT SUM(u.Total) FROM [Import.ActiveFleetDayReport] u WHERE 
						YEAR(u.DateCreated)  = YEAR(@DATE)
					AND	MONTH(u.DateCreated) = MONTH(@DATE)
					AND DAY(u.DateCreated)   = DAY(@DATE))
	
	
	
	SELECT
		r.RegionName , SUM(u.Total) * 100 / @total as "Total"
	FROM [Import.ActiveFleetDayReport] u
	INNER JOIN [Dimension.Countries] AS c ON u.CountryId = c.CountryId
	INNER JOIN [Dimension.Regions]   AS r ON c.RegionId  = r.RegionId
	WHERE 
		YEAR(u.DateCreated)  = YEAR(@DATE)
	AND	MONTH(u.DateCreated) = MONTH(@DATE)
	AND DAY(u.DateCreated)   = DAY(@DATE)
	GROUP BY r.RegionName 
END