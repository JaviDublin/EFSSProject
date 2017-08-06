-- =============================================
-- Author:		Javier
-- Create date: October 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE spDBImportModelsTruncate
	
AS
BEGIN

	SET NOCOUNT ON;

	TRUNCATE TABLE [Import.Models]
END