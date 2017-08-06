-- =============================================
-- Author:		Javier
-- Create date: April 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spFleetOverViewSelectMonthById]
	@VehicleId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT
	[Staging.ActiveFleetMonth].VehicleId,
	[Staging.ActiveFleetMonth].Serial,
	[Staging.ActiveFleetMonth].CompanyCode,
	[Staging.ActiveFleetMonth].AreaCode,
	[Dimension.Areas].AreaName ,
	[Staging.ActiveFleetMonth].Unit,
	[Staging.ActiveFleetMonth].Plate,
	[Staging.ActiveFleetMonth].InvoiceStatus,
	CONVERT(VARCHAR,[Staging.ActiveFleetMonth].SalePrice) AS "SalePrice",
	CONVERT(VARCHAR,[Staging.ActiveFleetMonth].CapitalCost) AS "CapitalCost",
	CONVERT(VARCHAR,[Staging.ActiveFleetMonth].Depreciation) AS "Depreciation",
	CONVERT(VARCHAR,[Staging.ActiveFleetMonth].DepreciationRate) AS "DepreciationRate",
	CONVERT(VARCHAR,[Staging.ActiveFleetMonth].DepreciationPCT) AS "DepreciationPCT",
	CONVERT(VARCHAR,[Staging.ActiveFleetMonth].BuyBackCap) AS "BuyBackCap",
	[Staging.ActiveFleetMonth].LessOr,
	CONVERT(VARCHAR,[Staging.ActiveFleetMonth].BaseAndOptions) AS "BaseAndOptions",
	[Staging.ActiveFleetMonth].SaleType,
	[Staging.ActiveFleetMonth].VehicleClass,
	[Staging.ActiveFleetMonth].VehicleStatus,
	[Staging.ActiveFleetMonth].SpecialprogramIndicator,
	[Staging.ActiveFleetMonth].VisionCode,
	[Staging.ActiveFleetMonth].ModelYear,
	[Staging.ActiveFleetMonth].ModelCode,
	[Staging.ActiveFleetMonth].PaymentMethod,
	[Staging.ActiveFleetMonth].InvoiceNumber,
	CONVERT(VARCHAR(11),[Staging.ActiveFleetMonth].DeliveryDate,103) AS "DeliveryDate",
	CONVERT(VARCHAR(11),[Staging.ActiveFleetMonth].InServiceDate,103) AS "InServiceDate",
	CONVERT(VARCHAR(11),[Staging.ActiveFleetMonth].OutServiceDate,103) AS "OutServiceDate",
	CONVERT(VARCHAR(11),[Staging.ActiveFleetMonth].SaleDate,103) AS "SaleDate",
	CONVERT(VARCHAR(11),[Staging.ActiveFleetMonth].MSODate,103) AS "MSODate",
	[Staging.ActiveFleetMonth].VehicleType,
	CONVERT(VARCHAR,[Staging.ActiveFleetMonth].PL) AS "PL",
	CONVERT(VARCHAR,[Staging.ActiveFleetMonth].Mileage) AS "Mileage",
	CONVERT(VARCHAR,[Staging.ActiveFleetMonth].DaysInService) AS "DaysInService",
	[Staging.ActiveFleetMonth].BuyerCode,
	CONVERT(VARCHAR,[Staging.ActiveFleetMonth].PDepreciationRate) AS "PDepreciationRate",
	CONVERT(VARCHAR,[Staging.ActiveFleetMonth].PDepreciationRatePCT) AS "PDepreciationRatePCT",
	[Staging.ActiveFleetMonth].TasModelCode,
	[Staging.ActiveFleetMonth].SubType,
	[Staging.ActiveFleetMonth].SaleDocumentNumber,
	CONVERT(VARCHAR,[Staging.ActiveFleetMonth].ProgramCap) AS "ProgramCap",
	CONVERT(VARCHAR,[Staging.ActiveFleetMonth].ProgramAcumDepreciation) AS "ProgramAcumDepreciation",
	[Staging.ActiveFleetMonth].Reference,
	CONVERT(VARCHAR,[Staging.ActiveFleetMonth].DocumentId) AS "DocumentId",
	[Dimension.Manufacturer].ManufacturerName ,
	[Dimension.Manufacturer].ManufacturerImage ,
	[Dimension.Buyers].BuyerName ,
	[Dimension.ModelDetails].ModelDescription ,
	[Dimension.ModelDetails].ModelGroup
	FROM [Staging.ActiveFleetMonth]
	LEFT JOIN [Dimension.Areas] ON [Staging.ActiveFleetMonth].AreaCode = [Dimension.Areas].AreaCode
	LEFT JOIN [Dimension.Manufacturer] ON 
	[Staging.ActiveFleetMonth].ManufacturerId =  [Dimension.Manufacturer].ManufacturerId
	LEFT JOIN [Dimension.Buyers] ON
	[Staging.ActiveFleetMonth].BuyerId = [Dimension.Buyers].BuyerId
	LEFT JOIN [Dimension.ModelDetails] ON 
	[Staging.ActiveFleetMonth].ModelDetailid = [Dimension.ModelDetails].ModelDetailId
	WHERE [Staging.ActiveFleetMonth].VehicleId = @VehicleId
    
END