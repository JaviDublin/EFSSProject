-- =============================================
-- Author:		Javier
-- Create date: 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spFleetImportFileActiveFleetReportDayChart]
	
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
		u.RowId , c.CountryCode , u.Total * 100 / @total as "Total"
	FROM [Import.ActiveFleetDayReport] u
	INNER JOIN [Dimension.Countries] AS c ON u.CountryId = c.CountryId
	WHERE 
		YEAR(u.DateCreated)  = YEAR(@DATE)
	AND	MONTH(u.DateCreated) = MONTH(@DATE)
	AND DAY(u.DateCreated)   = DAY(@DATE)
	GROUP BY u.RowId , c.CountryCode , u.Total
 
END