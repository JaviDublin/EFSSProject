-- =============================================
-- Author:		Javier
-- Create date: March 2012
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spReportsFleetCashTargetsUpdateDay]
	
AS
BEGIN
	
	SET NOCOUNT ON;

    UPDATE [Fact.FleetCashTargetDay] SET
		Mtd					= y.Mtd, 
		Expected			= y.Expected, 
		Remaining			= y.Remaining, 
		--CollectionTarget	= y.CollectionTarget,
		Note				= y.Note ,
		NoteExpected		= y.NoteExpected
	FROM [Fact.FleetCashTargetDay] t
	INNER JOIN
	(SELECT RowId , Mtd , Expected , Remaining , CollectionTarget , Note , NoteExpected
	FROM [Fact.FleetCashTargetDay]
	WHERE DateUpdated = CAST(FLOOR(CAST(GETDATE() AS float)) AS datetime) - 1) AS y
	ON t.RowId = y.RowId
	WHERE 
		DateUpdated = CAST(FLOOR(CAST(GETDATE() AS float)) AS datetime) 
	AND
		MONTH(CAST(FLOOR(CAST(GETDATE() AS float)) AS datetime)) = 
		MONTH(CAST(FLOOR(CAST(GETDATE() AS float)) AS datetime) - 1)
	AND
		YEAR(CAST(FLOOR(CAST(GETDATE() AS float)) AS datetime)) = 
		YEAR(CAST(FLOOR(CAST(GETDATE() AS float)) AS datetime) - 1)
END