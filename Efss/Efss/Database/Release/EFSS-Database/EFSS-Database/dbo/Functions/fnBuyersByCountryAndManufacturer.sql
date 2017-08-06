-- =============================================
-- Author:		Javier
-- Create date: May 2011
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[fnBuyersByCountryAndManufacturer]
(	
	@countryName		VARCHAR(50)=NULL,
	@manufacturerName	VARCHAR(50)=NULL
)
RETURNS @TABLEBUYERS TABLE 
	(BuyerId INT,CountryName VARCHAR(50),BuyerCode VARCHAR(20),BuyerName VARCHAR(255), 
	BuyerTaxCode VARCHAR(50), BuyerFiscalCode VARCHAR(50) , ManufacturerName VARCHAR(50),
	ContactName VARCHAR(255), ContactEmail VARCHAR(255), ContactTypeName VARCHAR(50),
	Position INT)
AS
BEGIN
	
	IF @countryName			= 'ALL' BEGIN SET @countryName		= NULL END
	IF @manufacturerName	= 'ALL' BEGIN SET @manufacturerName = NULL END
	
	INSERT INTO @TABLEBUYERS
	SELECT BuyerId , CountryName , BuyerCode , BuyerName , BuyerTaxCode , BuyerFiscalcode ,
	ManufacturerName , ContactName , ContactEmail , CompanyType ,
	ROW_NUMBER() OVER(PARTITION BY BuyerId ORDER BY (SELECT 0)) AS RN
	FROM dbo.ViewBuyers
	WHERE 
		((@countryName		IS NULL) OR (CountryName		= @countryName))
	AND ((@manufacturerName IS NULL) OR (ManufacturerName	= @manufacturerName))
	


	RETURN
END