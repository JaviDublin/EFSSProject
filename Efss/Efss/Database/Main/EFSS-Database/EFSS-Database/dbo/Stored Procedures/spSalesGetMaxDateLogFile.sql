-- =============================================
-- Author:		Javier
-- Create date:Juner 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spSalesGetMaxDateLogFile]
	
AS
BEGIN
	SET NOCOUNT ON;
	
	SELECT CONVERT(varchar(11),MAX(DateLog),103) as "RequestDate" 
	FROM [Application.FileLog] 
	WHERE LogId IN (SELECT MAX(LogId) FROM [Archive.Sales])

END