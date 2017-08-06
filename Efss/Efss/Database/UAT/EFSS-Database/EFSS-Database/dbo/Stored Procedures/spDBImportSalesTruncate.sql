-- =============================================
-- Author:		Javier
-- Create date: October 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE spDBImportSalesTruncate
	
AS
BEGIN
	
	SET NOCOUNT ON;

	TRUNCATE TABLE [Import.SalesOR]
END