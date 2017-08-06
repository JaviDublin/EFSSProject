-- =============================================
-- Author:		Javier
-- Create date: October 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE spDBImportSalesCNTruncate
	
AS
BEGIN
	
	SET NOCOUNT ON;

    TRUNCATE TABLE [Import.SalesCN]
END