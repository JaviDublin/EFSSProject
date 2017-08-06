-- =============================================
-- Author:		Javier
-- Create date: May 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spBuyersSelectName] 
	@buyerCode INT = NULL,
	@countryId INT = NULL
AS
BEGIN
	SELECT BuyerId , BuyerName
	FROM [Dimension.Buyers]
	WHERE CountryId = @countryId and CONVERT(INT,BuyerCode) = @buyerCode
END