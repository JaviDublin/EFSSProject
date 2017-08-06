-- =============================================
-- Author:		Javier
-- Create date: June 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spBuyersSelectCompanyType]
		@buyerId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT CompanyTypeId  as "ContactTypeId", CompanyType as "ContactTypeName"
	FROM [Dimension.CompanyTypes]
	WHERE CompanyTypeId in 
	(SELECT CompanyTypeId FROM [Dimension.Companies] WHERE CountryId in
	(SELECT CountryId FROM [Dimension.Buyers] WHERE BuyerId = @buyerId))
END