-- =============================================
-- Author:		Javier
-- Create date: April 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spApplicationControlsSelect]
	@userId	INT = NULL
AS
BEGIN
	
		
		SELECT c.Id, c.parentid, CONVERT(VARCHAR(10),c.ControlId) AS 'url', c.ControlName As 'title', 
		CASE WHEN (c.ParentId IS NULL OR c.ParentId =1 AND c.[ControlDesc] IS NOT NULL) 
		THEN c.[ControlDesc] + '|' + c.ControlImage ELSE c.[ControlDesc] END AS 'description'
		FROM
			[Application.Controls] c
		WHERE 
			c.IsActive =1 AND c.MenuEnabled=1
		ORDER BY c.Position
END