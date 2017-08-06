-- =============================================
-- Author:		Javier
-- Create date: September
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE spDBManualInvoiceJournal
	
AS
BEGIN

	SET NOCOUNT ON;

	
	SELECT [Staging.ManualInvoice].Serial ,
		[Dimension.DocumentTypes].PrimeAccount ,
		[Dimension.DocumentTypes].SubAccount ,
		[Dimension.DocumentTypes].CostCenter ,
		[Dimension.DocumentTypes].Activity ,
		[Dimension.DocumentTypes].Division
	FROM [Staging.ManualInvoice]
	inner join [Dimension.DocumentTypes] on  
		[Staging.ManualInvoice].DocumentTypeId = [Dimension.DocumentTypes].DocumentTypeId
  
END