-- =============================================
-- Author:		Javier
-- Create date: April 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spSecurityUsersAuthenticate]
	@racfId			VARCHAR(10)=NULL
AS
BEGIN
	
	SET NOCOUNT ON;
	
	SELECT 
		PKID AS 'userId', RacfId, FirstName, SurName, Email, LastLoggedIn
	FROM [Application.Users]
	WHERE 
		(RacfId = @racfid) 
	AND (Approved = 1) 
	AND (LockedOut=0) 
	AND (isDeleted = 0)
END