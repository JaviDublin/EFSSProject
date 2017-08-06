-- =============================================
-- Author:		Javier
-- Create date: June 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spCompaniesSelectDetailsById]
		@companyId INT
AS
BEGIN
	
	SET NOCOUNT ON;

    select [Dimension.Companies].CompanyId ,
	[Dimension.Companies].CompanyCode ,
	[Dimension.Companies].CompanyName ,
	[Dimension.Companies].CompanyFiscalCode ,
	[Dimension.Countries].CountryName , 
	convert(varchar,[Dimension.Countries].CountryVat) as "VatRate"  ,
	[Dimension.Currencies].CurrencyName ,
	[Dimension.Currencies].Rate ,
	[Dimension.Regions].RegionName ,
	[Dimension.CompanyTypes].CompanyType ,
	[Dimension.Companies].OracleCode ,
	[Dimension.Companies].GroupName
	from [Dimension.Companies]
	INNER JOIN [Dimension.Countries]	ON [Dimension.Companies].CountryId = [Dimension.Countries].CountryId
	INNER JOIN [Dimension.Currencies]	ON [Dimension.Countries].CurrencyId = [Dimension.Currencies].CurrencyId
	INNER JOIN [Dimension.Regions]		ON [Dimension.Countries].RegionId = [Dimension.Regions].RegionId
	INNER JOIN [Dimension.CompanyTypes] ON [Dimension.Companies].CompanyTypeId = [Dimension.CompanyTypes].CompanyTypeId
	where [Dimension.Companies].CompanyId  = @companyId
END