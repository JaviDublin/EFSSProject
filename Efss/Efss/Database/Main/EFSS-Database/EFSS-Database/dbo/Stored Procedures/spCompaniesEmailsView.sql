-- =============================================
-- Author:		Javier
-- Create date: July 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spCompaniesEmailsView]
	
AS
BEGIN
	SET NOCOUNT ON;

	
	SELECT EmailId , EmailDublin 
	FROM [Dimension.Companies]
	GROUP BY EmailId , EmailDublin 

 
END