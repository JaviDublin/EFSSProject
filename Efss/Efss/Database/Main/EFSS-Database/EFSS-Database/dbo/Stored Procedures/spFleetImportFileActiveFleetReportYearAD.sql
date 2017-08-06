-- =============================================
-- Author:		Javier
-- Create date: June 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spFleetImportFileActiveFleetReportYearAD]
		@sortExpression	VARCHAR(50)=NULL,
		@maximumRows	INT=NULL,
		@startRowIndex	INT=NULL,
		@year	VARCHAR(4),
		@fileId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT t.[count] as 'Count' , t.CountryId , t.CountryName , t.Total ,
	t.Month1 as "January", t.Month2 as "February", t.Month3 as "March", 
	t.Month4 as "April", t.Month5 as "May", t.Month6 as "June", t.Month7 as "July",
	t.Month8 as "August", t.Month9 as "September", t.Month10 as "October", 
	t.Month11 as "November", t.Month12 as "December"
	FROM
	(
    SELECT 
    COUNT(fy.CountryId) OVER() AS 'Count',
    ROW_NUMBER() OVER
			(
				ORDER BY 
				CASE WHEN @sortExpression = 'CountryName' THEN cn.CountryName END ASC,
				CASE WHEN @sortExpression = 'CountryName DESC' THEN cn.CountryName END DESC,
				CASE WHEN @sortExpression = 'Total' THEN SUM(fy.Total) END ASC,
				CASE WHEN @sortExpression = 'Total DESC' THEN SUM(fy.Total) END DESC,
				CASE WHEN @sortExpression = 'January' THEN SUM(fy.Month1) END ASC,
				CASE WHEN @sortExpression = 'January DESC' THEN SUM(fy.Month1) END DESC,
				CASE WHEN @sortExpression = 'February' THEN SUM(fy.Month2) END ASC,
				CASE WHEN @sortExpression = 'February DESC' THEN SUM(fy.Month2) END DESC,
				CASE WHEN @sortExpression = 'March' THEN SUM(fy.Month3) END ASC,
				CASE WHEN @sortExpression = 'March DESC' THEN SUM(fy.Month3) END DESC,
				CASE WHEN @sortExpression = 'April' THEN SUM(fy.Month4) END ASC,
				CASE WHEN @sortExpression = 'April DESC' THEN SUM(fy.Month4) END DESC,
				CASE WHEN @sortExpression = 'May' THEN SUM(fy.Month5) END ASC,
				CASE WHEN @sortExpression = 'May DESC' THEN SUM(fy.Month5) END DESC,
				CASE WHEN @sortExpression = 'June' THEN SUM(fy.Month6) END ASC,
				CASE WHEN @sortExpression = 'June DESC' THEN SUM(fy.Month6) END DESC,
				CASE WHEN @sortExpression = 'July' THEN SUM(fy.Month7) END ASC,
				CASE WHEN @sortExpression = 'July DESC' THEN SUM(fy.Month7) END DESC,
				CASE WHEN @sortExpression = 'August' THEN SUM(fy.Month8) END ASC,
				CASE WHEN @sortExpression = 'August DESC' THEN SUM(fy.Month8) END DESC,
				CASE WHEN @sortExpression = 'September' THEN SUM(fy.Month9) END ASC,
				CASE WHEN @sortExpression = 'September DESC' THEN SUM(fy.Month9) END DESC,
				CASE WHEN @sortExpression = 'October' THEN SUM(fy.Month10) END ASC,
				CASE WHEN @sortExpression = 'October DESC' THEN SUM(fy.Month10) END DESC,
				CASE WHEN @sortExpression = 'November' THEN SUM(fy.Month11) END ASC,
				CASE WHEN @sortExpression = 'November DESC' THEN SUM(fy.Month11) END DESC,
				CASE WHEN @sortExpression = 'December' THEN SUM(fy.Month12) END ASC,
				CASE WHEN @sortExpression = 'December DESC' THEN SUM(fy.Month12) END DESC
			)AS ROW,
   
    fy.CountryId  ,cn.CountryName , SUM(fy.Total) as "Total" ,
	SUM(fy.Month1) as "Month1" , SUM(fy.Month2) as "Month2" , SUM(fy.Month3) as "Month3",
	SUM(fy.Month4) as "Month4" , SUM(fy.Month5) as "Month5" , SUM(fy.Month6) as "Month6",
	SUM(fy.Month7) as "Month7" , SUM(fy.Month8) as "Month8" , SUM(fy.Month9) as "Month9",
	SUM(fy.Month10) as "Month10" , SUM(fy.Month11) as "Month11" , SUM(fy.Month12) as "Month12"
	from [Import.ActiveFleetYearADReport] fy
	INNER JOIN [Dimension.Countries] AS cn ON  
			fy.CountryId = cn.CountryId
	where fy.FileId = @fileId and fy.DateYear = @year
	group by fy.CountryId , cn.CountryName
    
 
	) AS t
	WHERE (t.ROW BETWEEN @startRowIndex AND @maximumRows)
	
END