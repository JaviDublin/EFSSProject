-- =============================================
-- Author:		Javier
-- Create date: October 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE spDBImportDashboardTruncate

AS
BEGIN
	
	SET NOCOUNT ON;

   TRUNCATE TABLE [Import.Dashboard]
END