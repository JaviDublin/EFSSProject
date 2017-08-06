-- =============================================
-- Author:		Javier
-- Create date: April 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE spSecurityUsersSelectPermissions
	@userId		INT=NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	SELECT 
		[Application.RoleControls].ControlId , MAX([Application.RoleControls].PermissionId) as 'PermissionId'
	FROM 
		[Application.UserRoles]
	INNER JOIN 
		[Application.RoleControls] on [Application.UserRoles].RoleId = [Application.RoleControls].RoleId
	WHERE 
		[Application.UserRoles].UserId = @userId
	GROUP BY 
		[Application.RoleControls].ControlId
END