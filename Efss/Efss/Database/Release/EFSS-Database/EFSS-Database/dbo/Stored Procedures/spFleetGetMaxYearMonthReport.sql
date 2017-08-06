-- =============================================
-- Author:		Javier
-- Create date: July 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spFleetGetMaxYearMonthReport]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	
	SELECT MAX(DateYear) as "RequestDate" 
	FROM [Import.ActiveFleetMonthReport]
END