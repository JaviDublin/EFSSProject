-- =============================================
-- Author:		Javier
-- Create date: April 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spCompaniesCountrySelect]
	@countryName varchar(100)
AS
BEGIN
	
	SELECT 
		DISTINCT CompanyId , CompanyName , CompanyType 
	FROM 
		ViewCompanies 
	WHERE 
		GroupName = @countryName
	
END