-- =============================================
-- Author:		Javier
-- Create date: June 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spManufacturersSelectById]
		@manufacturerId  INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT convert(varchar,ManufacturerId) as "ManufacturerId" , ManufacturerName 
    FROM [Dimension.Manufacturer]
    WHERE ManufacturerId = @manufacturerId
END