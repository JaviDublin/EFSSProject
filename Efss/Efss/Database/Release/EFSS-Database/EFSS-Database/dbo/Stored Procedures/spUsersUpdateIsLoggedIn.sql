-- =============================================
-- Author:		Javier
-- Create date: April 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE spUsersUpdateIsLoggedIn
		@userId	INT=NULL,
		@isLoggedIn	BIT=NULL
AS
BEGIN
	SET NOCOUNT ON;
	UPDATE [Application.Users] SET
	IsLoggedIn=@isLoggedIn
	WHERE 
	PKID =@userId
END