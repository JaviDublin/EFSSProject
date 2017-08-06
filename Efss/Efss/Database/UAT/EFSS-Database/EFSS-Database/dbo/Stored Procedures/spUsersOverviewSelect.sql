-- =============================================
-- Author:		Javier
-- Create date: April 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spUsersOverviewSelect] 
		@sortExpression		VARCHAR(50)=NULL,
		@maximumRows		INT=NULL,
		@startRowIndex		INT=NULL,
		@racfId             VARCHAR(20) = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	IF @racfId = 'ALL' BEGIN SET @racfId = NULL END
		
	SELECT 
	t.[count] as 'Count', t.userId, t.racfid, t.firstname, t.surname, 
		t.email, t.approved, t.lockedOut, t.lastLoggedIn, t.lastActivity, t.isDeleted
		
	FROM
	(
		SELECT COUNT(u.PKID) OVER() as 'Count' , 
		ROW_NUMBER() OVER 
			(ORDER BY
		CASE WHEN @sortExpression = 'racfid' THEN u.racfid END ASC,
				CASE WHEN @sortExpression = 'racfid DESC' THEN u.racfid END DESC,
				CASE WHEN @sortExpression = 'firstname' THEN u.firstname END ASC,
				CASE WHEN @sortExpression = 'firstname DESC' THEN u.firstname END DESC,
				CASE WHEN @sortExpression = 'surname' THEN u.surname END ASC,
				CASE WHEN @sortExpression = 'surname DESC' THEN u.surname END DESC,
				CASE WHEN @sortExpression = 'email' THEN u.email END ASC,
				CASE WHEN @sortExpression = 'email DESC' THEN u.email END DESC,
				CASE WHEN @sortExpression = 'approved' THEN u.approved END ASC,
				CASE WHEN @sortExpression = 'approved DESC' THEN u.approved END DESC,
				CASE WHEN @sortExpression = 'lockedOut' THEN u.lockedOut END ASC,
				CASE WHEN @sortExpression = 'lockedOut DESC' THEN u.lockedOut END DESC,
				CASE WHEN @sortExpression = 'lastLoggedIn' THEN u.lastLoggedIn END ASC,
				CASE WHEN @sortExpression = 'lastLoggedIn DESC' THEN u.lastLoggedIn END DESC,
				CASE WHEN @sortExpression = 'lastActivity' THEN u.lastActivity END ASC,
				CASE WHEN @sortExpression = 'lastActivity DESC' THEN u.lastActivity END DESC,
				CASE WHEN @sortExpression = 'isDeleted' THEN u.isDeleted END ASC,
				CASE WHEN @sortExpression = 'isDeleted DESC' THEN u.isDeleted END DESC
			) as ROW,
	u.PKID AS 'userId', u.racfid, u.firstname, u.surname, u.email, u.approved, u.lockedOut,
					u.lastLoggedIn, u.lastActivity, u.isDeleted
	FROM [Application.Users] u
	WHERE
		((@racfId IS NULL) OR (u.racfid = @racfId))
	GROUP BY 
	u.PKID , u.racfid, u.firstname, u.surname, u.email, u.approved, u.lockedOut,
					u.lastLoggedIn, u.lastActivity, u.isDeleted
	) AS t
	WHERE (t.ROW BETWEEN @startRowIndex AND @maximumRows)
	
END