-- =============================================
-- Author:		Javier
-- Create date: June 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spBuyersSelectDetailsByCode]
	@buyerCode VARCHAR(10),
	@countryId INT
AS
BEGIN
	
	SET NOCOUNT ON;
	
	
	IF LEN(@buyerCode) = 1 BEGIN SET @buyerCode = '0000' + @buyerCode END
	IF LEN(@buyerCode) = 2 BEGIN SET @buyerCode = '000'  + @buyerCode END
	IF LEN(@buyerCode) = 3 BEGIN SET @buyerCode = '00'   + @buyerCode END
	IF LEN(@buyerCode) = 4 BEGIN SET @buyerCode = '0'    + @buyerCode END

    SELECT 
		[Dimension.Buyers].BuyerId , 
		[Dimension.Countries].CountryName ,
		[Dimension.Buyers].BuyerCode,
		[Dimension.Buyers].BuyerName ,
		[Dimension.Buyers].BuyerTaxCode ,
		[Dimension.Buyers].BuyerFiscalCode,
		[Dimension.BuyerTypes].BuyerType,
		[Dimension.BuyerTypes].BuyerTypeId
	FROM [Dimension.Buyers]
	INNER JOIN [Dimension.Countries]  ON [Dimension.Buyers].CountryId   = [Dimension.Countries].CountryId
	INNER JOIN [Dimension.BuyerTypes] ON [Dimension.Buyers].BuyerTypeId = [Dimension.BuyerTypes].BuyerTypeId
	WHERE 
		[Dimension.Buyers].BuyerCode = @buyerCode 
	AND [Dimension.Buyers].CountryId = @countryId
END