-- =============================================
-- Author:		Javier
-- Create date: July 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE spUsersUpdate
	@userId		INT,
	@racfId		VARCHAR(20),
	@name		VARCHAR(100),
	@surname	VARCHAR(200),
	@phone		VARCHAR(100),
	@email		VARCHAR(255),
	@roleid		INT
AS
BEGIN
	
	SET NOCOUNT ON;

	UPDATE [Application.Users] SET 
		FirstName = @name ,
		SurName   = @surname ,
		RacfId    = @racfId ,
		Phone     = @phone ,
		Email     = @email
	WHERE
		PKID = @userId
		
	UPDATE [Application.UserRoles] SET
		RoleId = @roleid
	WHERE
		UserId = @userId
   
END