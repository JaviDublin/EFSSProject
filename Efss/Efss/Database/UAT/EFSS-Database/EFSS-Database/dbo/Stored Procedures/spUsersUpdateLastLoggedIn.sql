-- =============================================
-- Author:		Javier 
-- Create date: April 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE spUsersUpdateLastLoggedIn
	@racfid			VARCHAR(10)=NULL,
	@lastLoggedIn	DATETIME=NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	UPDATE [Application.Users] SET
	LastLoggedIn = @lastLoggedIn,
	isLoggedIn=1
	WHERE 
	racfid = @racfid
END