-- =============================================
-- Author:		Javier
-- Create date: April 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spCompaniesOverViewSelect]
		@sortExpression		VARCHAR(50)=NULL,
		@maximumRows		INT=NULL,
		@startRowIndex		INT=NULL,
		@companyId			INT=NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	SELECT 
	t.[count] as 'Count', t.CompanyId, t.CompanyName,t.CompanyCode, t.CompanyType, t.CountryName, 
	t.RegionName, t.CurrencyCode, convert(varchar,t.CountryVat) as 'CountryVat', t.CompanyFiscalCode ,
	t.OracleCode , t.GroupName , convert(varchar,t.Rate) as "Rate"
		
	FROM
	(
		SELECT COUNT(u.CompanyId) OVER() as 'Count' , 
		ROW_NUMBER() OVER 
			(ORDER BY
				CASE WHEN @sortExpression = 'CompanyName' THEN u.CompanyName END ASC,
				CASE WHEN @sortExpression = 'CompanyName DESC' THEN u.CompanyName END DESC,
				CASE WHEN @sortExpression = 'CompanCode' THEN u.CompanyCode END ASC,
				CASE WHEN @sortExpression = 'CompanyCode DESC' THEN u.CompanyCode END DESC,
				CASE WHEN @sortExpression = 'CompanyType' THEN u.CompanyType END ASC,
				CASE WHEN @sortExpression = 'CompanyType DESC' THEN u.CompanyType END DESC,
				CASE WHEN @sortExpression = 'CountryName' THEN u.CountryName END ASC,
				CASE WHEN @sortExpression = 'CountryName DESC' THEN u.CountryName END DESC,
				CASE WHEN @sortExpression = 'RegionName' THEN u.RegionName END ASC,
				CASE WHEN @sortExpression = 'RegionName DESC' THEN u.RegionName END DESC,
				CASE WHEN @sortExpression = 'CurrencyCode' THEN u.CurrencyCode END ASC,
				CASE WHEN @sortExpression = 'CurrencyCode DESC' THEN u.CurrencyCode END DESC,
				CASE WHEN @sortExpression = 'CountryVat' THEN u.CountryVat END ASC,
				CASE WHEN @sortExpression = 'CountryVat DESC' THEN u.CountryVat END DESC,
				CASE WHEN @sortExpression = 'CompanyFiscalCode' THEN u.CompanyFiscalCode END ASC,
				CASE WHEN @sortExpression = 'CompanyFiscalCode DESC' THEN u.CompanyFiscalCode END DESC,
				CASE WHEN @sortExpression = 'OracleCode' THEN u.OracleCode END ASC,
				CASE WHEN @sortExpression = 'OracleCode DESC' THEN u.OracleCode END DESC,
				CASE WHEN @sortExpression = 'GroupName' THEN u.GroupName END ASC,
				CASE WHEN @sortExpression = 'GroupName DESC' THEN u.GroupName END DESC,
				CASE WHEN @sortExpression = 'Rate' THEN u.Rate END ASC,
				CASE WHEN @sortExpression = 'Rate DESC' THEN u.Rate END DESC
			) as ROW,
	u.CompanyId AS 'CompanyId', u.CompanyName,u.CompanyCode, u.CompanyType, u.CountryName, u.RegionName, u.CurrencyCode, 
	u.CountryVat,u.CompanyFiscalCode , u.OracleCode , u.GroupName , u.Rate
	FROM ViewCompanies u
	GROUP BY 
	u.CompanyId , u.CompanyName,u.CompanyCode, u.CompanyType, u.CountryName, u.RegionName, u.CurrencyCode, 
	u.CountryVat,u.CompanyFiscalCode , u.OracleCode , u.GroupName , u.Rate
	) AS t
	WHERE (t.ROW BETWEEN @startRowIndex AND @maximumRows)
	
END