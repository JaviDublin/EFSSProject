-- =============================================
-- Author:		Javier
-- Create date: June 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spModelsOverViewSelectFiltered]
		@sortExpression		VARCHAR(50)=NULL,
		@maximumRows		INT=NULL,
		@startRowIndex		INT=NULL,
		@manufacturerId		INT=NULL,
		@companyId			INT=NULL,
		@modelYear			VARCHAR(5) = NULL 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	IF @companyId = 0 BEGIN SET @companyId = null END
	IF @modelYear = 0 BEGIN SET @modelYear = null END


	SELECT 
	t.[count] as 'Count', t.ModelDetailId, t.CompanyCode,t.ModelCode,t.ModelYear, 
	t.TasModelCode,t.ModelGroup,t.ManufacturerName,t.ModelDescription,t.RateClass,t.EngineSize,
	t.FuelType,t.EstimatedCap,t.EstimatedDeprRate,t.EstimatedVBAmtPeriod,t.EstimatedVolBonus,
	t.FastSpec,t.ReceivableStoreDate
	FROM
	(
	SELECT 
	COUNT(u.ModelDetailId) OVER() AS 'Count',
	ROW_NUMBER() OVER
	(ORDER BY
		CASE WHEN @sortExpression = 'CompanyCode' THEN u.CompanyCode END ASC,
		CASE WHEN @sortExpression = 'CompanyCode DESC' THEN u.CompanyCode END DESC,
		CASE WHEN @sortExpression = 'ModelCode' THEN u.ModelCode END ASC,
		CASE WHEN @sortExpression = 'ModelCode DESC' THEN u.ModelCode END DESC,
		CASE WHEN @sortExpression = 'ModelYear' THEN u.ModelYear END ASC,
		CASE WHEN @sortExpression = 'ModelYear DESC' THEN u.ModelYear END DESC,
		CASE WHEN @sortExpression = 'TasModelCode' THEN u.TasModelCode END ASC,
		CASE WHEN @sortExpression = 'TasModelCode DESC' THEN u.TasModelCode END DESC,
		CASE WHEN @sortExpression = 'ModelGroup' THEN u.ModelGroup END ASC,
		CASE WHEN @sortExpression = 'ModelGroup DESC' THEN u.ModelGroup END DESC,
		CASE WHEN @sortExpression = 'ManufacturerName' THEN u.ManufacturerName END ASC,
		CASE WHEN @sortExpression = 'ManufacturerName' THEN u.ManufacturerName END DESC,
		CASE WHEN @sortExpression = 'ModelDescription' THEN u.ModelDescription END ASC,
		CASE WHEN @sortExpression = 'ModelDescription DESC' THEN u.ModelDescription END DESC,
		CASE WHEN @sortExpression = 'RateClass' THEN u.RateClass END ASC,
		CASE WHEN @sortExpression = 'RateClass DESC' THEN u.RateClass END DESC,
		CASE WHEN @sortExpression = 'EngineSize' THEN u.EngineSize END ASC,
		CASE WHEN @sortExpression = 'EngineSize DESC' THEN u.EngineSize END DESC,
		CASE WHEN @sortExpression = 'FuelType' THEN u.FuelType END ASC,
		CASE WHEN @sortExpression = 'FuelType DESC' THEN u.FuelType END DESC,
		CASE WHEN @sortExpression = 'EstimatedCap' THEN u.EstimatedCap END ASC,
		CASE WHEN @sortExpression = 'EstimatedCap DESC' THEN u.EstimatedCap END DESC,
		CASE WHEN @sortExpression = 'EstimatedDeprRate' THEN u.EstimatedDeprRate END ASC,
		CASE WHEN @sortExpression = 'EstimatedDeprRate DESC' THEN u.EstimatedDeprRate END DESC,
		CASE WHEN @sortExpression = 'EstimatedVBAmtPeriod' THEN u.EstimatedVBAmtPeriod END ASC,
		CASE WHEN @sortExpression = 'EstimatedVBAmtPeriod DESC' THEN u.EstimatedVBAmtPeriod END DESC,
		CASE WHEN @sortExpression = 'EstimatedVolBonus' THEN u.EstimatedVolBonus END ASC,
		CASE WHEN @sortExpression = 'EstimatedVolBonus DESC' THEN u.EstimatedVolBonus END DESC,
		CASE WHEN @sortExpression = 'FastSpec' THEN u.FastSpec END ASC,
		CASE WHEN @sortExpression = 'FastSpec DESC' THEN u.FastSpec END DESC,
		CASE WHEN @sortExpression = 'ReceivableStoreDate' THEN u.ReceivableStoreDate END ASC,
		CASE WHEN @sortExpression = 'ReceivableStoreDate DESC' THEN u.ReceivableStoreDate END DESC
	) AS ROW,
	u.ModelDetailId , u.CompanyCode , u.ModelCode , u.ModelYear , u.TasModelCode , u.ModelGroup,
	u.ManufacturerName , u.ModelDescription , u.RateClass, u.EngineSize , u.FuelType , u.EstimatedCap ,
	u.EstimatedDeprRate , u.EstimatedVBAmtPeriod , u.EstimatedVolBonus, u.FastSpec , u.ReceivableStoreDate 
	FROM fnModelsByManufacturer(@manufacturerId) u
	WHERE
		((@companyId IS NULL) OR (u.CompanyId = @companyId)) 
	AND ((@modelYear IS NULL) OR (u.ModelYear = @modelYear))
	GROUP BY u.ModelDetailId , u.CompanyCode , u.ModelCode , u.ModelYear , u.TasModelCode , u.ModelGroup,
	u.ManufacturerName , u.ModelDescription , u.RateClass, u.EngineSize , u.FuelType , u.EstimatedCap ,
	u.EstimatedDeprRate , u.EstimatedVBAmtPeriod , u.EstimatedVolBonus, u.FastSpec , u.ReceivableStoreDate
	) AS t
	WHERE (t.ROW BETWEEN @startRowIndex AND @maximumRows)
    
END