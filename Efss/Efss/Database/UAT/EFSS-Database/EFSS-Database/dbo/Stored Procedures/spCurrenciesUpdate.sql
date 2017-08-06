-- =============================================
-- Author:		Javier
-- Create date: July 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE spCurrenciesUpdate
	@currencyId		INT,
	@currencyRate	VARCHAR(20)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


	UPDATE [Dimension.Currencies] 
	SET Rate = @currencyRate 
	WHERE CurrencyId = @currencyId
  
END