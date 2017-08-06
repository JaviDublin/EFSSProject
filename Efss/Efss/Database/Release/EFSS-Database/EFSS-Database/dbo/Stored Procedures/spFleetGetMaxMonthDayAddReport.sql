-- =============================================
-- Author:		Javier
-- Create date: July 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spFleetGetMaxMonthDayAddReport]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @maxyear INT
	SET @maxyear = (SELECT  MAX(DateYear) from [Import.ActiveFleetMonthADReport])
	
	SELECT 
		MAX(MonthNumber) as "RequestDate" 
	FROM 
		[Import.ActiveFleetMonthADReport]
	WHERE 
		DateYear = @maxyear
END