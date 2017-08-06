-- =============================================
-- Author:		Javier
-- Create date: June 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spFleetChartActiveFleetDay]
	@dateCreated	VARCHAR(20)
AS
BEGIN
	
	SET NOCOUNT ON;
	
	DECLARE @DATE DATETIME
	SET @DATE = CONVERT(DATETIME,@dateCreated,103)
	
	SELECT
	u.RowId , c.CountryCode , u.Total
	FROM [Import.ActiveFleetDayReport] u
	INNER JOIN [Dimension.Countries] AS c ON u.CountryId = c.CountryId
	WHERE 
		YEAR(u.DateCreated)  = YEAR(@DATE)
	AND	MONTH(u.DateCreated) = MONTH(@DATE)
	AND DAY(u.DateCreated)   = DAY(@DATE)
	GROUP BY u.RowId , c.CountryCode , u.Total
	

 
END