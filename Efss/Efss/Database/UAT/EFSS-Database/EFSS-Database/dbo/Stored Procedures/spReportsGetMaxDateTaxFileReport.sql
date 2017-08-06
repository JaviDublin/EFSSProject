-- =============================================
-- Author:		Javier
-- Create date: July 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE spReportsGetMaxDateTaxFileReport
AS
BEGIN
	
	SET NOCOUNT ON;

   SELECT 
		CONVERT(VARCHAR(11),MAX(FileDate),103) AS "RequestDate" 
    FROM [Fact.FleetTaxReport]
END