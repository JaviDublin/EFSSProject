-- =============================================
-- Author:		Javier
-- Create date: June 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spBuyersSelectManufacturersById]
			@buyerId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT 
		[Fact.BuyersManufacturer].ManufacturerId,
		[Dimension.Manufacturer].ManufacturerName
	FROM 
		[Fact.BuyersManufacturer]
	INNER JOIN [Dimension.Manufacturer] ON 
		[Fact.BuyersManufacturer].ManufacturerId = [Dimension.Manufacturer].ManufacturerId
	WHERE 
		[Fact.BuyersManufacturer].BuyerId = @buyerId
END