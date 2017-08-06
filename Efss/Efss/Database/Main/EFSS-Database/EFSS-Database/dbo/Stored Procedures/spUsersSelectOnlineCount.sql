-- =============================================
-- Author:		Javier
-- Create date: April 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE spUsersSelectOnlineCount
	@userId		INT=NULL,
	@timeWindow DATETIME=NULL
AS
BEGIN
	SELECT COUNT(DISTINCT u.PKID) AS 'Count'
	FROM
		[Application.Users] U
	WHERE
		U.LastActivity >=@timeWindow and U.IsLoggedIn = 1
END