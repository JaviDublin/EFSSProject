-- =============================================
-- Author:		Javier
-- Create date: June 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spFleetImportFileActiveFleetReportMonth]
		@sortExpression	VARCHAR(50)=NULL,
		@maximumRows	INT=NULL,
		@startRowIndex	INT=NULL,
		@year			VARCHAR(4),
		@month			VARCHAR(2)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	SELECT
	t.[count] as 'Count' , t.RowId , t.CountryName , t.Total , t.Active , t.Conversion ,
	t.Delivered , t.Inactive , t.[Suspend] , t.Future , t.Other , t.RegionName
	FROM
	(SELECT
		COUNT(u.RowId) OVER() AS 'Count',
		ROW_NUMBER() OVER
			(
				ORDER BY 
				CASE WHEN @sortExpression = 'CountryName' THEN u.CountryName END ASC,
				CASE WHEN @sortExpression = 'CountryName DESC' THEN u.CountryName END DESC,
				CASE WHEN @sortExpression = 'Total' THEN u.Total END ASC,
				CASE WHEN @sortExpression = 'Total DESC' THEN u.Total END DESC,
				CASE WHEN @sortExpression = 'Active' THEN u.Active END ASC,
				CASE WHEN @sortExpression = 'Active DESC' THEN u.Active END DESC,
				CASE WHEN @sortExpression = 'Conversion' THEN u.Conversion END ASC,
				CASE WHEN @sortExpression = 'Conversion DESC' THEN u.Conversion END DESC,
				CASE WHEN @sortExpression = 'Delivered' THEN u.Delivered END ASC,
				CASE WHEN @sortExpression = 'Delivered DESC' THEN u.Delivered END DESC,
				CASE WHEN @sortExpression = 'Inactive' THEN u.Inactive END ASC,
				CASE WHEN @sortExpression = 'Inactive DESC' THEN u.Inactive END DESC,
				CASE WHEN @sortExpression = 'Suspend' THEN u.[Suspend] END ASC,
				CASE WHEN @sortExpression = 'Suspend DESC' THEN u.[Suspend] END DESC,
				CASE WHEN @sortExpression = 'Future' THEN u.Future END ASC,
				CASE WHEN @sortExpression = 'Future DESC' THEN u.Future END DESC,
				CASE WHEN @sortExpression = 'Other' THEN u.Other END ASC,
				CASE WHEN @sortExpression = 'Other DESC' THEN u.Other END DESC,
				CASE WHEN @sortExpression = 'RegionName' THEN r.RegionName END ASC,
				CASE WHEN @sortExpression = 'RegionName DESC' THEN r.RegionName END DESC
			)AS ROW,
			u.RowId , u.CountryName , u.Total, u.Active, u.Conversion, u.Delivered, 
			u.Inactive , u.[Suspend] , u.Future , u.Other , r.RegionName
			FROM fnFleetMonthReport(@year , @month) u
			INNER JOIN [Dimension.Countries] AS c ON u.CountryName = c.CountryName
			INNER JOIN [Dimension.Regions] AS r ON c.RegionId = r.RegionId
			GROUP BY u.RowId , u.CountryName , u.Total, u.Active, u.Conversion, u.Delivered, 
			u.Inactive , u.[Suspend] , u.Future , u.Other , r.RegionName) AS t
			WHERE (t.ROW BETWEEN @startRowIndex AND @maximumRows)
			
	
	

END