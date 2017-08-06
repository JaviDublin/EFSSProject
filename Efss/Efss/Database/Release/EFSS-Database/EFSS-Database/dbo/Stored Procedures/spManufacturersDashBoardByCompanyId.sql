-- =============================================
-- Author:		Javier
-- Create date: August 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spManufacturersDashBoardByCompanyId]
	@companyId INT,
	@countryId INT
AS
BEGIN
	
	SET NOCOUNT ON;

	IF @companyId IS NULL
	BEGIN
		SELECT 
			CONVERT(VARCHAR,ManufacturerId) as "ManufacturerId" , ManufacturerName
		FROM 
			[Staging.Dashboard]
		WHERE 
			CountryId = @countryId
		GROUP BY 
			ManufacturerId , ManufacturerName
		ORDER BY 
			ManufacturerId , ManufacturerName
	END
	ELSE
	BEGIN
		SELECT 
			CONVERT(VARCHAR,ManufacturerId) as "ManufacturerId" , ManufacturerName
		FROM 
			[Staging.Dashboard]
		WHERE 
			CompanyId = @companyId
		GROUP BY 
			ManufacturerId , ManufacturerName
		ORDER BY 
			ManufacturerId , ManufacturerName
	END
    
END