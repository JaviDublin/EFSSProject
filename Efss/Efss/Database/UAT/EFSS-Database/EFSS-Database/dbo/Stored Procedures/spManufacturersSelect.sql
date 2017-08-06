-- =============================================
-- Author:		Javier
-- Create date: May 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spManufacturersSelect] 
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT 
		CONVERT(VARCHAR,ManufacturerId) AS "ManufacturerId" , 
		ManufacturerName 
	FROM [Dimension.Manufacturer]
END