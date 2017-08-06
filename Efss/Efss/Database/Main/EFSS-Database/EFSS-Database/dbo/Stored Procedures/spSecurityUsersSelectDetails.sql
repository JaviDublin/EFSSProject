-- =============================================
-- Author:		Javier
-- Create date: April 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spSecurityUsersSelectDetails]
	@racfId varchar(50)
AS
BEGIN
	SELECT PKID as "UserId" , RacfId , FullName , Email , Phone FROM [Application.Users]
	WHERE RacfId = @racfId
END