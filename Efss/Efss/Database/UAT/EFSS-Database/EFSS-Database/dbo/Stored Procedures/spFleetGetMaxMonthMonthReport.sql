-- =============================================
-- Author:		Javier
-- Create date: July 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spFleetGetMaxMonthMonthReport]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @maxyear INT
	SET @maxyear = (SELECT  MAX(DateYear) from [Import.ActiveFleetMonthReport])
	
	SELECT 
		MAX(DateMonth) as "RequestDate" 
	FROM 
		[Import.ActiveFleetMonthReport]
	WHERE 
		DateYear = @maxyear
END