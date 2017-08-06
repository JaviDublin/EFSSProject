-- =============================================
-- Author:		Javier
-- Create date: September 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE spDBManualInvoiceTruncate
	
AS
BEGIN
	
	SET NOCOUNT ON;
	
	TRUNCATE TABLE [Import.ManualInvoice]
  
END