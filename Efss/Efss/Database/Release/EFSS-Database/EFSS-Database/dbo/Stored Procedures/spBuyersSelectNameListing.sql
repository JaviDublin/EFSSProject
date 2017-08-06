-- =============================================
-- Author:		Javier
-- Create date: September 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spBuyersSelectNameListing]
		@companyId		INT = null	,
		@countryId		INT = null	,
		@manufacturerId INT = NULL 
AS
BEGIN
	
	SET NOCOUNT ON;
	

	IF @companyId		= 0	BEGIN SET @companyId		=  NULL END
	IF @manufacturerId	= 0 BEGIN SET @manufacturerId	=  NULL END

	SELECT 
		[Dimension.Buyers].BuyerId , 
		[Dimension.Buyers].BuyerName
	FROM [Staging.Dashboard]
	LEFT JOIN [Archive.Sales] ON 
		[Staging.Dashboard].VehicleId = [Archive.Sales].VehicleId
	LEFT JOIN [Dimension.Buyers] ON
		[Archive.Sales].BuyerId = [Dimension.Buyers].BuyerId
	WHERE 
		[Staging.Dashboard].CountryId = @countryId 
	AND
		[Dimension.Buyers].BuyerId IS NOT NULL
	AND
		((@companyId IS NULL) OR ([Staging.Dashboard].CompanyId = @companyId))
	AND 
		((@manufacturerId IS NULL) OR ([Staging.Dashboard].ManufacturerId = @manufacturerId))
	GROUP BY
		[Dimension.Buyers].BuyerId , 
		[Dimension.Buyers].BuyerName
	ORDER BY
		[Dimension.Buyers].BuyerId , 
		[Dimension.Buyers].BuyerName
   
END