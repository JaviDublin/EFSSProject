-- =============================================
-- Author:		Javier
-- Create date: August 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE spUsersGetRole
		@racfId varchar(20)
AS
BEGIN
	
	SET NOCOUNT ON;

	SELECT 
		[Application.Roles].RoleName 
	FROM [Application.Roles]
	INNER JOIN [Application.UserRoles]	ON [Application.Roles].RoleId = [Application.UserRoles].RoleId
	INNER JOIN [Application.Users]		ON [Application.UserRoles].UserId = [Application.Users].PKID
	WHERE 
		[Application.Users].RacfId = @racfId
   
END