-- =============================================
-- Author:		Javier
-- Create date: June 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spModelsOverViewExportToExcel]
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
	t.ModelDetailId, t.CompanyCode,t.ModelCode,t.ModelYear, 
	t.TasModelCode,t.ModelGroup,t.ManufacturerName,t.ModelDescription,t.RateClass,t.EngineSize,
	t.FuelType,t.EstimatedCap,t.EstimatedDeprRate,t.EstimatedVBAmtPeriod,t.EstimatedVolBonus,
	t.FastSpec,t.ReceivableStoreDate
	FROM fnModelsByManufacturer(@manufacturerId) t
	WHERE
		((@companyId IS NULL) OR (t.CompanyId = @companyId)) 
	AND ((@modelYear IS NULL) OR (t.ModelYear = @modelYear))
	GROUP BY t.ModelDetailId , t.CompanyCode , t.ModelCode , t.ModelYear , t.TasModelCode , t.ModelGroup,
	t.ManufacturerName , t.ModelDescription , t.RateClass, t.EngineSize , t.FuelType , t.EstimatedCap ,
	t.EstimatedDeprRate , t.EstimatedVBAmtPeriod , t.EstimatedVolBonus, t.FastSpec , t.ReceivableStoreDate

   
END