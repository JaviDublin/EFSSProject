-- =============================================
-- Author:		Javier
-- Create date: June 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spCompaniesUpdate]
	@companyId			INT,
	@vatRate			VARCHAR(5)  = NULL,
	@companyFiscalCode	VARCHAR(50) = NULL
	
AS
BEGIN
	
	SET NOCOUNT ON;

	IF @vatRate IS NOT NULL
	BEGIN
		UPDATE [Dimension.Countries] SET
		[Dimension.Countries].CountryVat = CONVERT(FLOAT,@vatRate)
		WHERE [Dimension.Countries].CountryId IN
			(SELECT CountryId FROM [Dimension.Companies] WHERE CompanyId = @companyId)
	END
	
	IF @companyFiscalCode IS NOT NULL
	BEGIN
		UPDATE [Dimension.Companies] SET
		CompanyFiscalCode = @companyFiscalCode
		WHERE CompanyId = @companyId
	END
END