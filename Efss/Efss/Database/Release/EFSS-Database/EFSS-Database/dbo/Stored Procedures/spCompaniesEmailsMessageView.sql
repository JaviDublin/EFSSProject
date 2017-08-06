-- =============================================
-- Author:		Javier
-- Create date: July 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spCompaniesEmailsMessageView]
		@emailId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	
	SELECT MessageId , Title , Header , Body , Footer
	FROM [Dimension.CompanyMessages] 
	WHERE EmailId = @emailId
  
END