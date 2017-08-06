-- =============================================
-- Author:		Javier
-- Create date: June 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spFleetGetMaxDateFleetDayReport]
	
AS
BEGIN
	
	SET NOCOUNT ON;

    SELECT 
		CONVERT(VARCHAR(11),MAX(DateCreated),103) AS "RequestDate" 
    FROM [Import.ActiveFleetDayReport]
END