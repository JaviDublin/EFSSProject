-- =============================================
-- Author:		Javier
-- Create date: April 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spUsersOverViewSelectById]
	@userid int
AS
BEGIN
	
	select 
	1 as "count" ,
	PKID as "userId" , racfid , firstname , surname , email , approved , lockedOut , lastLoggedIn, 
	lastActivity , isDeleted
	from [Application.Users]
	where PKID = @userid
	
END