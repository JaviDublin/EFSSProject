-- =============================================
-- Author:		Javier
-- Create date: September 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spDBManualInvoiceSelectBuyer]
	@countryId int,
	@companyId int
AS
BEGIN

	SET NOCOUNT ON;

	SELECT 
		BuyerName AS "BuyerCode" , BuyerName
	FROM [Dimension.Buyers]
	WHERE 
		CountryId = @countryId and CompanyId = @companyId and BuyerTypeId <> 5
	GROUP BY 
		BuyerName
	ORDER BY
		BuyerName
   
END