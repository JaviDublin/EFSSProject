-- =============================================
-- Author:		Javier
-- Create date: July 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE spCompaniesSelectType
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT CompanyTypeId , CompanyType 
	FROM [Dimension.CompanyTypes]
END