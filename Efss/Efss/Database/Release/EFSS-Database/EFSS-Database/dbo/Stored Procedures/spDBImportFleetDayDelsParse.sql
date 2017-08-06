-- =============================================
-- Author:		Javier
-- Create date: July 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spDBImportFleetDayDelsParse]
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @FileId	 INT	
	SET @FileId = (SELECT FileId FROM [Application.Files] WHERE FileCode = 'FCMDR')
	
	-- QUERY TO TEST
	------------------------------
	--TRUNCATE TABLE [Import.ActiveFleetMonthDelsTest24012012]
	--INSERT INTO [Import.ActiveFleetMonthDelsTest24012012]
	--SELECT * FROM [Import.ActiveFleetMonthDels]
	
	--DELETE FROM [Import.ActiveFleetMonthDels] WHERE Serial IN 
	--(SELECT Serial FROM [Staging.ActiveFleetMonthDeletes])
	
	
	TRUNCATE TABLE [Staging.ActiveFleetMonthDeletes]
	
	UPDATE [Import.ActiveFleetMonthDels] SET CompanyCode   = NULL WHERE CompanyCode = ''
	
	DELETE FROM [Import.ActiveFleetMonthDels] WHERE CompanyCode not in 
		(SELECT CompanyCode FROM [Dimension.Companies])
	
	UPDATE [Import.ActiveFleetMonthDels] SET AreaCode    = NULL WHERE AreaCode = ''
	UPDATE [Import.ActiveFleetMonthDels] SET Serial     = NULL WHERE Serial = ''
	UPDATE [Import.ActiveFleetMonthDels] SET Unit     = NULL WHERE Unit = ''
	UPDATE [Import.ActiveFleetMonthDels] SET TasModel    = NULL WHERE TasModel = ''
	UPDATE [Import.ActiveFleetMonthDels] SET ModelCode    = NULL WHERE ModelCode = ''
	UPDATE [Import.ActiveFleetMonthDels] SET ManufacturerName  = NULL WHERE ManufacturerName = ''
	UPDATE [Import.ActiveFleetMonthDels] SET ModelGroup    = NULL WHERE ModelGroup = ''
	UPDATE [Import.ActiveFleetMonthDels] SET ModelDescription  = NULL WHERE ModelDescription = ''
	UPDATE [Import.ActiveFleetMonthDels] SET RateClass    = NULL WHERE RateClass = ''
	UPDATE [Import.ActiveFleetMonthDels] SET VehicleType   = NULL WHERE VehicleType = ''
	UPDATE [Import.ActiveFleetMonthDels] SET CapitalCost   = NULL WHERE CapitalCost = ''
	UPDATE [Import.ActiveFleetMonthDels] SET Depreciation   = NULL WHERE Depreciation = ''
	UPDATE [Import.ActiveFleetMonthDels] SET DepreciationRate  = NULL WHERE DepreciationRate = ''
	UPDATE [Import.ActiveFleetMonthDels] SET DepreciationPCT  = NULL WHERE DepreciationPCT = ''
	UPDATE [Import.ActiveFleetMonthDels] SET BookValue    = NULL WHERE BookValue = ''
	UPDATE [Import.ActiveFleetMonthDels] SET DeliveryDate   = NULL WHERE DeliveryDate = ''
	UPDATE [Import.ActiveFleetMonthDels] SET MSODate    = NULL WHERE MSODate = ''
	UPDATE [Import.ActiveFleetMonthDels] SET InServiceDate   = NULL WHERE InServiceDate = ''
	UPDATE [Import.ActiveFleetMonthDels] SET OutServiceDate   = NULL WHERE OutServiceDate = ''
	UPDATE [Import.ActiveFleetMonthDels] SET DaysInService   = NULL WHERE DaysInService = ''
	UPDATE [Import.ActiveFleetMonthDels] SET SalePrice    = NULL WHERE SalePrice = ''
	UPDATE [Import.ActiveFleetMonthDels] SET Mileage    = NULL WHERE Mileage = ''
	UPDATE [Import.ActiveFleetMonthDels] SET AdjReceivable   = NULL WHERE AdjReceivable = ''
	UPDATE [Import.ActiveFleetMonthDels] SET ReceivableType   = NULL WHERE ReceivableType = ''
	UPDATE [Import.ActiveFleetMonthDels] SET AmortizedID   = NULL WHERE AmortizedID = ''
	UPDATE [Import.ActiveFleetMonthDels] SET FirstRA    = NULL WHERE FirstRA = ''
	UPDATE [Import.ActiveFleetMonthDels] SET RADate     = NULL WHERE RADate = ''
	UPDATE [Import.ActiveFleetMonthDels] SET SaleType    = NULL WHERE SaleType = ''
	UPDATE [Import.ActiveFleetMonthDels] SET VehicleStatus   = NULL WHERE VehicleStatus = ''
	UPDATE [Import.ActiveFleetMonthDels] SET Plate     = NULL WHERE Plate = ''
	UPDATE [Import.ActiveFleetMonthDels] SET SaleDate    = NULL WHERE SaleDate = ''
	UPDATE [Import.ActiveFleetMonthDels] SET VehicleClass   = NULL WHERE VehicleClass = ''
	UPDATE [Import.ActiveFleetMonthDels] SET DeliveryDate_2   = NULL WHERE DeliveryDate_2 = ''
	UPDATE [Import.ActiveFleetMonthDels] SET OutServiceDate_2  = NULL WHERE OutServiceDate_2 = ''
	UPDATE [Import.ActiveFleetMonthDels] SET ModelYear    = NULL WHERE ModelYear = ''
	UPDATE [Import.ActiveFleetMonthDels] SET CapitalCostFleetco  = NULL WHERE CapitalCostFleetco = ''
	
	INSERT INTO [Staging.ActiveFleetMonthDeletes]
 (
  CompanyCode,AreaCode,Serial,Unit,Plate,
  TasModelCode,ModelCode,ManufacturerName,ModelGroup,ModelDescription,RateClass,VehicleType,CapitalCost,
  Depreciation,DepreciationRate,DepreciationPCT,BookValue,DeliveryDate,MSODate,InServiceDate,OutServiceDate,
  DaysInService,SalePrice,Mileage,AdjReceivable,ReceivableType,AmortizedID,FirstRA,RADate,SaleType,
  VehicleStatus,SaleDate,VehicleClass,DeliveryDate_2,OutServiceDate_2,ModelYear,CapitalCostFleetco,
  FileId
 )

  SELECT
  CompanyCode,AreaCode,Serial,Unit,Plate,TasModel,ModelCode,ManufacturerName,
  ModelGroup,ModelDescription , RateClass,
  CONVERT(NCHAR(3),VehicleType),
  CASE WHEN ISNUMERIC(CapitalCost)  = 1 THEN CONVERT(FLOAT,CapitalCost) END,
  CASE WHEN ISNUMERIC(Depreciation)  = 1 THEN CONVERT(FLOAT,Depreciation) END,
  CASE WHEN ISNUMERIC(DepreciationRate) = 1 THEN CONVERT(FLOAT,DepreciationRate) END,
  CASE WHEN ISNUMERIC(DepreciationPCT) = 1 THEN CONVERT(FLOAT,DepreciationPCT) END,
  CASE WHEN ISNUMERIC(BookValue)   = 1 THEN CONVERT(FLOAT,BookValue) END,
  CASE WHEN ISDATE(DeliveryDate)  = 1 THEN CONVERT(DATETIME,DeliveryDate,103) END,
  CASE WHEN ISDATE(MSODate)   = 1 THEN CONVERT(DATETIME,MSODate,103) END,
  CASE WHEN ISDATE(InServiceDate)  = 1 THEN CONVERT(DATETIME,InServiceDate,103) END,
  CASE WHEN ISDATE(OutServiceDate) = 1 THEN CONVERT(DATETIME,OutServiceDate,103) END,
  CASE WHEN ISNUMERIC(DaysInService) = 1 THEN CONVERT(INT,DaysInService) END,
  CASE WHEN ISNUMERIC(SalePrice)   = 1 THEN CONVERT(FLOAT,SalePrice) END,
  CASE WHEN ISNUMERIC(Mileage)  = 1 THEN CONVERT(FLOAT,Mileage) END,
  CASE WHEN ISNUMERIC(AdjReceivable) = 1 THEN CONVERT(FLOAT,AdjReceivable) END,
  ReceivableType,AmortizedID,
  CASE WHEN ISDATE(FirstRA)   = 1 THEN CONVERT(DATETIME,FirstRA,103) END,
  CASE WHEN ISDATE(RADate)   = 1 THEN CONVERT(DATETIME,RADate,103) END,
  SaleType,
  VehicleStatus,
  CASE WHEN ISDATE(SaleDate)   = 1 THEN CONVERT(DATETIME,SaleDate,103) END,
  VehicleClass,
  CASE WHEN ISDATE(DeliveryDate_2)  = 1 THEN CONVERT(DATETIME,DeliveryDate_2,103) END,
  CASE WHEN ISDATE(OutServiceDate_2) = 1 THEN CONVERT(DATETIME,OutServiceDate_2,103) END,
  ModelYear,
  CASE WHEN ISNUMERIC(CapitalCostFleetco)  = 1 THEN CONVERT(FLOAT,CapitalCostFleetco) END,
  4

  FROM [Import.ActiveFleetMonthDels]
  WHERE ISNUMERIC(CapitalCost) = 1
		
		
	--2.1 Find Country Id and Company Id
	--------------------------------------------------------------------------------------------
		UPDATE [Staging.ActiveFleetMonthDeletes] SET
			[Staging.ActiveFleetMonthDeletes].CompanyId = [Dimension.Companies].CompanyId ,
			[Staging.ActiveFleetMonthDeletes].CountryId = [Dimension.Companies].CountryId
		FROM [Staging.ActiveFleetMonthDeletes]
		INNER JOIN [Dimension.Companies] ON 
			[Staging.ActiveFleetMonthDeletes].CompanyCode = [Dimension.Companies].CompanyCode
			
	
	--2.2 Add Log id
	--------------------------------------------------------------------------------------------	
	
	DECLARE @NEWLOGID INT
	INSERT INTO [Application.FileLog]
	--VALUES (4,GETDATE())
	VALUES (@FileId,GETDATE())
	SET @NEWLOGID = @@IDENTITY
	
	UPDATE [Staging.ActiveFleetMonthDeletes] SET LogId =  @NEWLOGID
	
	
	
		-- 2.3 Add the New vehicles
	---------------------------------------------------------------------	
		MERGE [Fact.Vehicles] WITH (TABLOCK) AS TARGET
		USING 
		(
			SELECT Serial , Unit , CountryId
			FROM [Staging.ActiveFleetMonthDeletes]
			GROUP BY Serial , Unit , CountryId
		)
		AS SOURCE
		ON 
		(TARGET.Unit = SOURCE.Unit AND TARGET.Serial = SOURCE.Serial AND 
		 TARGET.CountryId = SOURCE.CountryId)
		
		WHEN NOT MATCHED THEN
			INSERT 
			(Serial , Unit , CountryId)
			VALUES
			(SOURCE.Serial ,  SOURCE.Unit , SOURCE.CountryId);
		
		
			
		UPDATE [Staging.ActiveFleetMonthDeletes] SET
			[Staging.ActiveFleetMonthDeletes].AppVehicleId = [Fact.Vehicles].VehicleId
		FROM [Staging.ActiveFleetMonthDeletes]
		INNER JOIN [Fact.Vehicles]		ON 
			 [Staging.ActiveFleetMonthDeletes].Serial	= [Fact.Vehicles].Serial 
		AND	 [Staging.ActiveFleetMonthDeletes].Unit		= [Fact.Vehicles].Unit 
		AND	 [Staging.ActiveFleetMonthDeletes].CountryId = [Fact.Vehicles].CountryId
		
	-- 3 - MANUFACTURERS
	--------------------------------------------------------------------------------------------
	--------------------------------------------------------------------------------------------
	--------------------------------------------------------------------------------------------

		UPDATE [Staging.ActiveFleetMonthDeletes] SET
			[Staging.ActiveFleetMonthDeletes].ManufacturerId = [Dimension.Manufacturer].ManufacturerId
		FROM 
			[Staging.ActiveFleetMonthDeletes]
		INNER JOIN [Dimension.Manufacturer] ON
			[Staging.ActiveFleetMonthDeletes].ManufacturerName = [Dimension.Manufacturer].ManufacturerName
  
	

		UPDATE [Staging.ActiveFleetMonthDeletes] SET ManufacturerId = 0 WHERE ManufacturerId IS NULL
		
		
		UPDATE [Staging.ActiveFleetMonthDeletes] SET
			[Staging.ActiveFleetMonthDeletes].ManufacturerId	= [Dimension.ModelDetails].ManufacturerId,
			[Staging.ActiveFleetMonthDeletes].ManufacturerName = [Dimension.Manufacturer].ManufacturerName
		FROM [Staging.ActiveFleetMonthDeletes]
		INNER JOIN [Dimension.ModelCodes] ON
			[Staging.ActiveFleetMonthDeletes].ModelCode = [Dimension.ModelCodes].ModelCode
		INNER JOIN [Dimension.Models] ON
			[Dimension.ModelCodes].ModelCodeId = [Dimension.Models].ModelCodeId AND
			[Staging.ActiveFleetMonthDeletes].CompanyId = [Dimension.Models].CompanyId AND
			[Staging.ActiveFleetMonthDeletes].ModelYear = [Dimension.Models].ModelYear
		INNER JOIN [Dimension.ModelDetails] ON
			[Dimension.Models].ModelId = [Dimension.ModelDetails].ModelId 
		INNER JOIN [Dimension.Manufacturer] ON 
			[Dimension.ModelDetails].ManufacturerId = [Dimension.Manufacturer].ManufacturerId
		WHERE 
			[Staging.ActiveFleetMonthDeletes].ManufacturerId = 0
			
			
		UPDATE [Staging.ActiveFleetMonthDeletes] SET 
			ManufacturerId = 31 
		WHERE ManufacturerName = 'VAUXHALL' AND ManufacturerId = 0
		
		DECLARE @UNKMANUFACTURER INT
		SET @UNKMANUFACTURER = (SELECT ManufacturerId 
								FROM [Dimension.Manufacturer] 
								WHERE ManufacturerName = 'UNKNOWN')
		
		UPDATE [Staging.ActiveFleetMonthDeletes] SET 
			ManufacturerId = @UNKMANUFACTURER 
		WHERE ManufacturerId = 0
		
	
  
END