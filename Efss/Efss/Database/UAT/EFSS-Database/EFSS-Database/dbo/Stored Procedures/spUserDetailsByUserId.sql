-- =============================================
-- Author:		Javier
-- Create date: July 2011
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[spUserDetailsByUserId]
	@userId varchar(20)
AS
BEGIN
	
	SET NOCOUNT ON;
	
	SELECT
		[Application.Users].PKID , 
		[Application.Users].RacfId ,
		[Application.Users].FirstName ,
		[Application.Users].SurName ,
		[Application.Users].Phone ,
		[Application.Users].Email ,
		[Application.UserRoles].RoleId
	FROM [Application.Users]
	INNER JOIN [Application.UserRoles] ON
		[Application.Users].PKID = [Application.UserRoles].UserId
	WHERE 
		[Application.Users].PKID = @userId
    
END