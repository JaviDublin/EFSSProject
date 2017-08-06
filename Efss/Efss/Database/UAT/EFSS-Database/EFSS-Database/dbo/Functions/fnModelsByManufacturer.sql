-- =============================================
-- Author:		Javier
-- Create date: May 2011
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[fnModelsByManufacturer]
(	
	@manufacturerId INT
)
RETURNS @TABLEMANUFACTURER TABLE
(ModelDetailId INT , CompanyCode VARCHAR(50), ModelCode VARCHAR(50), 
 ModelYear VARCHAR(10),
 TasModelCode VARCHAR(50),  ModelGroup VARCHAR(50), ManufacturerName VARCHAR(50),
 ModelDescription VARCHAR(500), RateClass VARCHAR(50) ,
 EngineSize VARCHAR(50),  FuelType VARCHAR(80), EstimatedCap VARCHAR(50),
 EstimatedDeprRate VARCHAR(50) , EstimatedVBAmtPeriod VARCHAR(50),
 EstimatedVolBonus VARCHAR(50) , FastSpec VARCHAR(50), ReceivableStoreDate DATETIME,CompanyId INT)
AS
BEGIN

	INSERT INTO @TABLEMANUFACTURER
	select 
	[Dimension.ModelDetails].ModelDetailId ,
	[Dimension.Companies].CompanyCode ,
	[Dimension.ModelCodes].ModelCode ,
	[Dimension.Models].ModelYear ,
	[Dimension.ModelDetails].TasModelCode ,
	[Dimension.ModelDetails].ModelGroup,
	[Dimension.Manufacturer].ManufacturerName ,
	[Dimension.ModelDetails].ModelDescription ,
	[Dimension.ModelDetails].RateClass ,
	[Dimension.ModelDetails].EngineSize ,
	[Dimension.ModelDetails].FuelType ,
	[Dimension.ModelDetails].EstimatedCap ,
	[Dimension.ModelDetails].EstimatedDeprRate ,
	[Dimension.ModelDetails].EstimatedVBAmtPeriod ,
	[Dimension.ModelDetails].EstimatedVolBonus,
	[Dimension.ModelDetails].FastSpec,
	[Dimension.ModelDetails].ReceivableStoreDate,
	[Dimension.Companies].CompanyId
	from [Dimension.ModelCodes]
	inner join [Dimension.Models] on [Dimension.ModelCodes].ModelCodeId = [Dimension.Models].ModelCodeId
	inner join [Dimension.Companies] on [Dimension.Models].CompanyId = [Dimension.Companies].CompanyId
	inner join [Dimension.ModelDetails] on [Dimension.Models].ModelId  = [Dimension.ModelDetails].ModelId
	inner join [Dimension.Manufacturer] on [Dimension.ModelDetails].ManufacturerId = [Dimension.Manufacturer].ManufacturerId
	where [Dimension.ModelDetails].ManufacturerId = @manufacturerId
	
	
	RETURN
	
END