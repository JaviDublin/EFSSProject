-- =============================================
-- Author:		Javier
-- Create date: June 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spBuyersSelectDetailsById]
		@buyerId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    select [Dimension.Buyers].BuyerId , 
	[Dimension.Countries].CountryName ,
	[Dimension.Buyers].BuyerCode,
	[Dimension.Buyers].BuyerName ,
	[Dimension.Buyers].BuyerTaxCode ,
	[Dimension.Buyers].BuyerFiscalCode,
	[Dimension.BuyerTypes].BuyerType,
	[Dimension.BuyerTypes].BuyerTypeId
	from [Dimension.Buyers]
	inner join [Dimension.Countries] on [Dimension.Buyers].CountryId = [Dimension.Countries].CountryId
	inner join [Dimension.BuyerTypes] on [Dimension.Buyers].BuyerTypeId = [Dimension.BuyerTypes].BuyerTypeId
	where [Dimension.Buyers].BuyerId = @buyerId
END