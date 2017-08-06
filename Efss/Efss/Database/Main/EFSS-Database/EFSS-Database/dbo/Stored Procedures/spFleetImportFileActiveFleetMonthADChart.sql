-- =============================================
-- Author:		Javier
-- Create date: September 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE spFleetImportFileActiveFleetMonthADChart
	
AS
BEGIN
	
	SET NOCOUNT ON;

	SELECT T.CompanyCode , T.MonthAdds , M.MonthDels
	FROM
	(
		select CompanyCode , Count(*) AS "MonthAdds"
		from [Staging.ActiveFleetMonthAdds] 
		group by CompanyCode 
	) T
	INNER JOIN
	(
		select CompanyCode , Count(*) AS "MonthDels"
		from [Staging.ActiveFleetMonthDeletes] 
		group by CompanyCode
	) 
	AS M ON T.CompanyCode = M.CompanyCode
   
END