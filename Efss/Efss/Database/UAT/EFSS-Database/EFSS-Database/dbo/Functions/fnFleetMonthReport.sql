-- =============================================
-- Author:		Javier
-- Create date: June 2011
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION fnFleetMonthReport 
(	
		@year			VARCHAR(4),
		@month			VARCHAR(2)
)
RETURNS @TABLEMONTHREPORT TABLE 
(RowId INT PRIMARY KEY IDENTITY ,CountryName VARCHAR(50), 
Total INT,Active INT,Conversion INT, Delivered INT, Inactive INT,
Suspend INT,Future INT , Other INT)
AS
BEGIN

	
	INSERT INTO @TABLEMONTHREPORT
	SELECT [Dimension.Countries].CountryName ,
	SUM([Import.ActiveFleetMonthReport].Total),
	SUM([Import.ActiveFleetMonthReport].Active),
	SUM([Import.ActiveFleetMonthReport].Conversion),
	SUM([Import.ActiveFleetMonthReport].Delivered),
	SUM([Import.ActiveFleetMonthReport].Inactive),
	SUM([Import.ActiveFleetMonthReport].[Suspend]),
	SUM([Import.ActiveFleetMonthReport].Future_ISD),
	SUM([Import.ActiveFleetMonthReport].Other)
	FROM [Import.ActiveFleetMonthReport]
	INNER JOIN [Dimension.Countries] ON 
		[Import.ActiveFleetMonthReport].CountryId = [Dimension.Countries].CountryId
	WHERE [Import.ActiveFleetMonthReport].DateYear = @year
	and	  [Import.ActiveFleetMonthReport].DateMonth = @month
	GROUP BY [Dimension.Countries].CountryName
	
	

	RETURN
END