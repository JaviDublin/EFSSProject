-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[proc_Controls_MenuSelect]
	@UserId UNIQUEIDENTIFIER=NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	--Select the menu
	SELECT c.ControlID AS 'id', c.parentid, CONVERT(VARCHAR(10),c.ControlUrl) AS 'url', c.Name As 'title', 
		CASE 
			WHEN (c.ImageUrl IS NOT NULL) THEN c.[description] + '|' + c.ImageUrl
			ELSE c.[description] END AS 'description'
	FROM
		Controls c
	WHERE 
		c.isActive =1 
	ORDER BY c.position
END