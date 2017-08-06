-- =============================================
-- Author:		Javier
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spUsersInsert]
	@racfId		VARCHAR(20),
	@name		VARCHAR(100),
	@surname	VARCHAR(200),
	@phone		VARCHAR(100),
	@email		VARCHAR(255),
	@roleid		INT
AS
BEGIN
	
	SET NOCOUNT ON;
	
	DECLARE @ID INT
	
	INSERT INTO [Application.Users] (FirstName , SurName , RacfId , Phone , Email , FullName , Approved)
	VALUES (@name , @surname , @racfId , @phone , @email ,  @name + ' ' + @surname , 1 )	
	SET @ID = @@IDENTITY
	
	INSERT INTO [Application.UserRoles] (UserId , RoleId)
	VALUES (@ID , @roleid)

    
END