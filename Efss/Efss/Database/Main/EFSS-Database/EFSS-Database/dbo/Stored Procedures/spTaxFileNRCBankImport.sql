-- =============================================
-- Author:		Javier
-- Create date: September 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spTaxFileNRCBankImport]
	@rowValue VARCHAR(2000)
AS
BEGIN
	
	SET NOCOUNT ON;

	INSERT INTO [Import.TaxFileSP] VALUES (@rowValue)
END