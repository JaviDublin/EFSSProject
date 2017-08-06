-- =============================================
-- Author:		Javier
-- Create date: June 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spFleetImportFileActiveFleetReportDay]
		@sortExpression	VARCHAR(50)=NULL,
		@maximumRows	INT=NULL,
		@startRowIndex	INT=NULL,
		@dateCreated	VARCHAR(20)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


	DECLARE @DATE DATETIME
	SET @DATE = CONVERT(DATETIME,@dateCreated,103)
	
	
	DECLARE @total INT
	SET @total = (SELECT SUM(u.Total) FROM [Import.ActiveFleetDayReport] u WHERE 
						YEAR(u.DateCreated)  = YEAR(@DATE)
					AND	MONTH(u.DateCreated) = MONTH(@DATE)
					AND DAY(u.DateCreated)   = DAY(@DATE))
	
	
	
	SELECT
	t.[count] as 'Count' , t.RowId , t.CountryName , t.Total , t.RegionName , t.TotalPCT ,
	t.BuyBack , t.BuyBackPCT , t.WholeSale , t.WholeSalePCT , t.Lease , t.LeasePCT
	FROM
	(SELECT
		COUNT(u.RowId) OVER() AS 'Count',
		ROW_NUMBER() OVER
			(
				ORDER BY 
				CASE WHEN @sortExpression = 'CountryName' THEN c.CountryName END ASC,
				CASE WHEN @sortExpression = 'CountryName DESC' THEN c.CountryName END DESC,
				CASE WHEN @sortExpression = 'Total' THEN u.Total END ASC,
				CASE WHEN @sortExpression = 'Total DESC' THEN u.Total END DESC,
				CASE WHEN @sortExpression = 'RegionName' THEN r.RegionName END ASC,
				CASE WHEN @sortExpression = 'RegionName DESC' THEN r.RegionName END DESC,
				CASE WHEN @sortExpression = 'TotalPCT' THEN u.Total END ASC,
				CASE WHEN @sortExpression = 'TotalPCT DESC' THEN u.Total END DESC,
				CASE WHEN @sortExpression = 'BuyBack' THEN u.BuyBack END ASC,
				CASE WHEN @sortExpression = 'BuyBack DESC' THEN u.BuyBack END DESC,
				CASE WHEN @sortExpression = 'BuyBackPCT' THEN u.BuyBackPCT END ASC,
				CASE WHEN @sortExpression = 'BuyBackPCT DESC' THEN u.BuyBackPCT END DESC,
				CASE WHEN @sortExpression = 'WholeSale' THEN u.WholeSale END ASC,
				CASE WHEN @sortExpression = 'WholeSale DESC' THEN u.WholeSale END DESC,
				CASE WHEN @sortExpression = 'WholeSalePCT' THEN u.WholeSalePCT END ASC,
				CASE WHEN @sortExpression = 'WholeSalePCT DESC' THEN u.WholeSalePCT END DESC,
				CASE WHEN @sortExpression = 'Lease' THEN u.Lease END ASC,
				CASE WHEN @sortExpression = 'Lease DESC' THEN u.Lease END DESC,
				CASE WHEN @sortExpression = 'LeasePCT' THEN u.LeasePCT END ASC,
				CASE WHEN @sortExpression = 'LeasePCT DESC' THEN u.LeasePCT END DESC
			)AS ROW,
			u.RowId , c.CountryName , u.Total , r.RegionName   ,
			
			 CONVERT(NUMERIC(5,2),ROUND(u.Total * 100.00 / @total,2)) as "TotalPCT" , 
			u.BuyBack , u.BuyBackPCT , u.WholeSale , u.WholeSalePCT , u.Lease , u.LeasePCT
			FROM [Import.ActiveFleetDayReport] u
			INNER JOIN [Dimension.Countries] AS c ON u.CountryId = c.CountryId
			INNER JOIN [Dimension.Regions] AS r ON c.RegionId = r.RegionId
			WHERE 
				YEAR(u.DateCreated)  = YEAR(@DATE)
			AND	MONTH(u.DateCreated) = MONTH(@DATE)
			AND DAY(u.DateCreated)   = DAY(@DATE)
			GROUP BY u.RowId , c.CountryName , u.Total , r.RegionName ,
			u.BuyBack , u.BuyBackPCT , u.WholeSale , u.WholeSalePCT , u.Lease , u.LeasePCT
			) AS t
			WHERE (t.ROW BETWEEN @startRowIndex AND @maximumRows)
  	
	
END