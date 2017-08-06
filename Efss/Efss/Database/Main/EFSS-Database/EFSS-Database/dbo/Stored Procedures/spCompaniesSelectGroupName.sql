-- =============================================
-- Author:		Javier
-- Create date: March 2012
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE spCompaniesSelectGroupName

AS
BEGIN
	
	SET NOCOUNT ON;

	SELECT 
		GroupId , UPPER ( GroupName ) AS "GroupName"
	FROM [Dimension.Companies]
	GROUP BY 
		GroupId , GroupName
	ORDER BY
		GroupName
END