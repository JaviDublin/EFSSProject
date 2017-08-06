-- =============================================
-- Author:		Javier
-- Create date: Julu 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spCurrenciesSelectDetails]
	@currencyCode VARCHAR(20)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT CurrencyId , CurrencyName , convert(varchar,Rate) as "Rate" 
	FROM [Dimension.Currencies]
	WHERE CurrencyCode = @currencyCode
   
END