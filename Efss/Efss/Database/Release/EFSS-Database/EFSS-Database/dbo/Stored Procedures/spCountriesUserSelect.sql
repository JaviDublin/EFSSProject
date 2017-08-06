-- =============================================
-- Author:		Javier
-- Create date: April 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE  spCountriesUserSelect
	@racfId varchar(50) = null
AS
BEGIN
	SELECT CountryId , CountryName FROM ViewUsers WHERE RacfId = @racfId
END