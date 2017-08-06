-- =============================================
-- Author:		Javier
-- Create date: July 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE spCompaniesSelectGroupId
		@countryId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT GroupId 
	FROM [Dimension.Companies] 
	WHERE CountryId = @countryId
	GROUP BY GroupId
 
END