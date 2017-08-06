-- =============================================
-- Author:		Javier
-- Create date: July 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spUsersCheck]
	@racfId VARCHAR(20),
	@result INT OUTPUT
AS
BEGIN

	SET NOCOUNT ON;

	SET @result = (SELECT COUNT(*) FROM [Application.Users] WHERE RacfId = @racfId AND IsDeleted = 0)

   
END