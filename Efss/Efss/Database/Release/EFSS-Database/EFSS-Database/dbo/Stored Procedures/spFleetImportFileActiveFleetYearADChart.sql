-- =============================================
-- Author:		Javier
-- Create date: September 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spFleetImportFileActiveFleetYearADChart]
	
AS
BEGIN
	
	SET NOCOUNT ON;
	
	DECLARE @FileIdAdds INT , @FileIdDels INT , @Year INT
	SET @FileIdAdds = 5
	SET @FileIdDels = 6
	SET @Year = YEAR(GETDATE())
	
	
	SELECT T.CompanyCode , T.YearAdds , M.YearDels
	FROM
	(
		SELECT 
			[Dimension.Countries].CountryCode				AS "CompanyCode" , 
				sum([Import.ActiveFleetYearADReport].Total) AS "YearAdds"
		FROM [Import.ActiveFleetYearADReport]
		INNER JOIN [Dimension.Countries] ON 
				[Import.ActiveFleetYearADReport].CountryId = [Dimension.Countries].CountryId
		WHERE [Import.ActiveFleetYearADReport].FileId = @FileIdAdds AND DateYear = @Year
		GROUP BY [Dimension.Countries].CountryCode
	) T
	INNER JOIN
	(
		SELECT 
			[Dimension.Countries].CountryCode				AS "CompanyCode" , 
				sum([Import.ActiveFleetYearADReport].Total) AS "YearDels"
		FROM [Import.ActiveFleetYearADReport]
		INNER JOIN [Dimension.Countries] ON 
				[Import.ActiveFleetYearADReport].CountryId = [Dimension.Countries].CountryId
		WHERE [Import.ActiveFleetYearADReport].FileId = @FileIdDels AND DateYear = @Year
		GROUP BY [Dimension.Countries].CountryCode
		
	) 
	AS M ON T.CompanyCode = M.CompanyCode
   
END