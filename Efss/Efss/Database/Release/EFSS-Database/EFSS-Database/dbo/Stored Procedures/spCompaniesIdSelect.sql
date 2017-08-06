-- =============================================
-- Author:		Javier
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE spCompaniesIdSelect
	@companyName varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

   select [Dimension.Companies].CompanyId ,  [Dimension.Companies].CompanyName , [Dimension.CompanyTypes].CompanyType
   from [Dimension.Companies]
   inner join [Dimension.CompanyTypes] on 
		[Dimension.Companies].CompanyTypeId = [Dimension.CompanyTypes].CompanyTypeId
	where [Dimension.Companies].CompanyName = @companyName
END