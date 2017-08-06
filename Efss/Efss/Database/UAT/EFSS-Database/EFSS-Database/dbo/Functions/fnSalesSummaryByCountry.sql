-- =============================================
-- Author:		Javier
-- Create date: May 2011
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[fnSalesSummaryByCountry]
(	
	@countryId INT = NULL,
	@companyId INT = NULL
)
RETURNS @TABLESUMMARY TABLE
(RowId INT , CountryName VARCHAR(50), CompanyName VARCHAR(200), 
 DocType VARCHAR(50),DocSubType VARCHAR(50), AreaCode VARCHAR(20) ,
 Serial VARCHAR(50),  Unit VARCHAR(80), Plate VARCHAR(50),
 ModelCode VARCHAR(50),ModelDescription VARCHAR(255), ManufacturerName VARCHAR(100),
 BuyerCode VARCHAR(20) , BuyerName VARCHAR(255),
 InvoiceNumber INT , InvoiceDate DATETIME ,  
 DateLog DATETIME)
AS
BEGIN


INSERT INTO @TABLESUMMARY
SELECT 
	[Archive.Sales].RowId,
	[Dimension.Countries].CountryName	,
	[Dimension.Companies].CompanyName	,
	[Dimension.DocumentTypes].DocType	,
	[Dimension.DocumentTypes].DocSubType,
	[Archive.Sales].AreaCode			,
	[Archive.Sales].Serial			,
	[Archive.Sales].Unit				,
	[Archive.Sales].Plate				,
	[Archive.Sales].ModelCode			,
	[Dimension.ModelDetails].ModelDescription ,
	[Dimension.Manufacturer].ManufacturerName ,
	[Archive.Sales].BuyerCode	,
	[Dimension.Buyers].BuyerName	,
	CONVERT(INT,[Archive.Sales].InvoiceNumber) AS "InvoiceNumber",
	[Archive.Sales].InvoiceDate ,
	[Application.FileLog].DateLog 
FROM [Archive.Sales]
INNER JOIN [Dimension.Companies] ON [Archive.Sales].CompanyId = [Dimension.Companies].CompanyId
INNER JOIN [Dimension.Countries] ON [Archive.Sales].CountryId = [Dimension.Countries].CountryId
INNER JOIN [Dimension.ModelDetails] ON [Archive.Sales].ModelDetailId = [Dimension.ModelDetails].ModelDetailId
INNER JOIN [Dimension.Manufacturer] ON [Dimension.ModelDetails].ManufacturerId = [Dimension.Manufacturer].ManufacturerId
INNER JOIN [Application.FileLog] ON [Archive.Sales].LogId = [Application.FileLog].LogId
INNER JOIN [Dimension.DocumentTypes] ON [Archive.Sales].DocumentTypeId = [Dimension.DocumentTypes].DocumentTypeId
INNER JOIN [Dimension.Buyers] ON [Archive.Sales].BuyerId = [Dimension.Buyers].BuyerId
WHERE
	[Archive.Sales].CountryId = @countryId
AND	((@companyId IS NULL) or ([Archive.Sales].CompanyId = @companyId)) 
	
	
	
	RETURN
	
END