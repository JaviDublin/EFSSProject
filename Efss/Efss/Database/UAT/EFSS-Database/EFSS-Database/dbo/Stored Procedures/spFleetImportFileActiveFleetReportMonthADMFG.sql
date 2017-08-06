-- =============================================
-- Author:		Javier
-- Create date: July 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spFleetImportFileActiveFleetReportMonthADMFG] 
		@sortExpression	VARCHAR(50)=NULL,
		@maximumRows	INT=NULL,
		@startRowIndex	INT=NULL,
		@year	VARCHAR(4),
		@month	VARCHAR(2),
		@fileId INT,
		@countryId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

   SELECT
	t.[count] as 'Count' , t.ManufacturerId , t.CountryCode, t.ManufacturerName , t.Total ,
	t.Day1 as "1",t.Day2 as "2",t.Day3 as "3",t.Day4 as "4",t.Day5 as "5",
	t.Day6 as "6",t.Day7 as "7",
	t.Day8 as "8",t.Day9 as "9",t.Day10 as "10",t.Day11 as "11",
	t.Day12 as "12",t.Day13 as "13",t.Day14 as "14",
	t.Day15 as "15",t.Day16 as "16",t.Day17 as "17",
	t.Day18 as "18",t.Day19 as "19",t.Day20 as "20",
	t.Day21 as "21",t.Day22 as "22",
	t.Day23 as "23",t.Day24 as "24",t.Day25 as "25",
	t.Day26 as "26",t.Day27 as "27",t.Day28 as "28",t.Day29 as "29",
	t.Day30 as "30",t.Day31 as "31" 
	FROM
	(
	SELECT 
	COUNT(m.ManufacturerId) OVER() AS 'Count',
	ROW_NUMBER() OVER
			(
				ORDER BY 
				CASE WHEN @sortExpression = 'CountryCode' THEN c.CountryCode END ASC,
				CASE WHEN @sortExpression = 'CountryCode DESC' THEN c.CountryCode END DESC,
				CASE WHEN @sortExpression = 'ManufacturerName' THEN m.ManufacturerName END ASC,
				CASE WHEN @sortExpression = 'ManufacturerName DESC' THEN m.ManufacturerName END DESC,
				CASE WHEN @sortExpression = 'D1' THEN SUM(u.Day1) END ASC,
				CASE WHEN @sortExpression = 'D1 DESC' THEN SUM(u.Day1) END DESC,
				CASE WHEN @sortExpression = 'D2' THEN SUM(u.Day2) END ASC,
				CASE WHEN @sortExpression = 'D2 DESC' THEN SUM(u.Day2) END DESC,
				CASE WHEN @sortExpression = 'D3' THEN SUM(u.Day3) END ASC,
				CASE WHEN @sortExpression = 'D3 DESC' THEN SUM(u.Day3) END DESC,
				CASE WHEN @sortExpression = 'D4' THEN SUM(u.Day4) END ASC,
				CASE WHEN @sortExpression = 'D4 DESC' THEN SUM(u.Day4) END DESC,
				CASE WHEN @sortExpression = 'D5' THEN SUM(u.Day5) END ASC,
				CASE WHEN @sortExpression = 'D5 DESC' THEN SUM(u.Day5) END DESC,
				CASE WHEN @sortExpression = 'D6' THEN SUM(u.Day6) END ASC,
				CASE WHEN @sortExpression = 'D6 DESC' THEN SUM(u.Day6) END DESC,
				CASE WHEN @sortExpression = 'D7' THEN SUM(u.Day7) END ASC,
				CASE WHEN @sortExpression = 'D7 DESC' THEN SUM(u.Day7) END DESC,
				CASE WHEN @sortExpression = 'D8' THEN SUM(u.Day8) END ASC,
				CASE WHEN @sortExpression = 'D8 DESC' THEN SUM(u.Day8) END DESC,
				CASE WHEN @sortExpression = 'D9' THEN SUM(u.Day9) END ASC,
				CASE WHEN @sortExpression = 'D9 DESC' THEN SUM(u.Day9) END DESC,
				CASE WHEN @sortExpression = 'D10' THEN SUM(u.Day10) END ASC,
				CASE WHEN @sortExpression = 'D10 DESC' THEN SUM(u.Day10) END DESC,
				CASE WHEN @sortExpression = 'D11' THEN SUM(u.Day11) END ASC,
				CASE WHEN @sortExpression = 'D11 DESC' THEN SUM(u.Day11) END DESC,
				CASE WHEN @sortExpression = 'D12' THEN SUM(u.Day12) END ASC,
				CASE WHEN @sortExpression = 'D12 DESC' THEN SUM(u.Day12) END DESC,
				CASE WHEN @sortExpression = 'D13' THEN SUM(u.Day13) END ASC,
				CASE WHEN @sortExpression = 'D13 DESC' THEN SUM(u.Day13) END DESC,
				CASE WHEN @sortExpression = 'D14' THEN SUM(u.Day14) END ASC,
				CASE WHEN @sortExpression = 'D14 DESC' THEN SUM(u.Day14) END DESC,
				CASE WHEN @sortExpression = 'D15' THEN SUM(u.Day15) END ASC,
				CASE WHEN @sortExpression = 'D15 DESC' THEN SUM(u.Day15) END DESC,
				CASE WHEN @sortExpression = 'D16' THEN SUM(u.Day16) END ASC,
				CASE WHEN @sortExpression = 'D16 DESC' THEN SUM(u.Day16) END DESC,
				CASE WHEN @sortExpression = 'D17' THEN SUM(u.Day17) END ASC,
				CASE WHEN @sortExpression = 'D17 DESC' THEN SUM(u.Day17) END DESC,
				CASE WHEN @sortExpression = 'D18' THEN SUM(u.Day18) END ASC,
				CASE WHEN @sortExpression = 'D18 DESC' THEN SUM(u.Day18) END DESC,
				CASE WHEN @sortExpression = 'D19' THEN SUM(u.Day19) END ASC,
				CASE WHEN @sortExpression = 'D19 DESC' THEN SUM(u.Day19) END DESC,
				CASE WHEN @sortExpression = 'D20' THEN SUM(u.Day20) END ASC,
				CASE WHEN @sortExpression = 'D20 DESC' THEN SUM(u.Day20) END DESC,
				CASE WHEN @sortExpression = 'D21' THEN SUM(u.Day21) END ASC,
				CASE WHEN @sortExpression = 'D21 DESC' THEN SUM(u.Day21) END DESC,
				CASE WHEN @sortExpression = 'D22' THEN SUM(u.Day22) END ASC,
				CASE WHEN @sortExpression = 'D22 DESC' THEN SUM(u.Day22) END DESC,
				CASE WHEN @sortExpression = 'D23' THEN SUM(u.Day23) END ASC,
				CASE WHEN @sortExpression = 'D23 DESC' THEN SUM(u.Day23) END DESC,
				CASE WHEN @sortExpression = 'D24' THEN SUM(u.Day24) END ASC,
				CASE WHEN @sortExpression = 'D24 DESC' THEN SUM(u.Day24) END DESC,
				CASE WHEN @sortExpression = 'D25' THEN SUM(u.Day25) END ASC,
				CASE WHEN @sortExpression = 'D25 DESC' THEN SUM(u.Day25) END DESC,
				CASE WHEN @sortExpression = 'D26' THEN SUM(u.Day26) END ASC,
				CASE WHEN @sortExpression = 'D26 DESC' THEN SUM(u.Day26) END DESC,
				CASE WHEN @sortExpression = 'D27' THEN SUM(u.Day27) END ASC,
				CASE WHEN @sortExpression = 'D27 DESC' THEN SUM(u.Day27) END DESC,
				CASE WHEN @sortExpression = 'D28' THEN SUM(u.Day28) END ASC,
				CASE WHEN @sortExpression = 'D28 DESC' THEN SUM(u.Day28) END DESC,
				CASE WHEN @sortExpression = 'D29' THEN SUM(u.Day29) END ASC,
				CASE WHEN @sortExpression = 'D29 DESC' THEN SUM(u.Day29) END DESC,
				CASE WHEN @sortExpression = 'D30' THEN SUM(u.Day30) END ASC,
				CASE WHEN @sortExpression = 'D30 DESC' THEN SUM(u.Day30) END DESC,
				CASE WHEN @sortExpression = 'D31' THEN SUM(u.Day31) END ASC,
				CASE WHEN @sortExpression = 'D31 DESC' THEN SUM(u.Day31) END DESC
			)AS ROW,
	m.ManufacturerId , 
	c.CountryCode ,
	m.ManufacturerName,
	SUM(u.Total) as "Total" , SUM(u.Day1)  as "Day1", SUM(u.Day2)  as "Day2",
	SUM(u.Day3)  as "Day3", SUM(u.Day4)  as "Day4" ,SUM(u.Day5) as "Day5" , 
	SUM(u.Day6) as "Day6" , SUM(u.Day7) as "Day7" ,SUM(u.Day8) as "Day8" , 
	SUM(u.Day9) as "Day9" , SUM(u.Day10) as "Day10", 
	SUM(u.Day11) as "Day11", SUM(u.Day12) as "Day12", SUM(u.Day13)as "Day13" ,
	SUM(u.Day14) as "Day14",
	SUM(u.Day15) as "Day15", SUM(u.Day16) as "Day16", SUM(u.Day17) as "Day17",
	SUM(u.Day18) as "Day18", SUM(u.Day19) as "Day19", SUM(u.Day20)as "Day20" ,
	SUM(u.Day21) as "Day21",SUM(u.Day22) as "Day22",
	SUM(u.Day23) as "Day23", SUM(u.Day24) as "Day24", SUM(u.Day25) as "Day25",
	SUM(u.Day26) as "Day26", SUM(u.Day27)as "Day27" , SUM(u.Day28)as "Day28" ,
	SUM(u.Day29) as "Day29",SUM(u.Day30) as "Day30",SUM(u.Day31) as "Day31"
	FROM [Import.ActiveFleetMonthADReport] u
	INNER JOIN [Dimension.Countries] AS c ON   u.CountryId = c.CountryId
	INNER JOIN [Dimension.Manufacturer] AS m ON u.ManufacturerId = m.ManufacturerId
	WHERE 
			u.DateYear = @year 
		AND u.MonthNumber = @month 
		AND u.FileId = @fileid 
		AND u.CountryId = @countryId
	GROUP BY m.ManufacturerId , c.CountryCode , m.ManufacturerName
	) AS t
	WHERE (t.ROW BETWEEN @startRowIndex AND @maximumRows)
END