-- =============================================
-- Author:		Javier
-- Create date: July 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spDBImportFleetDayAddsParse]
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @FileId	INT	
	SET @FileId	= (SELECT FileId FROM [Application.Files] WHERE FileCode = 'FCMAR')
	
	
	-- QUERY TO TEST
	------------------------------
	
	--TRUNCATE TABLE [Import.ActiveFleetMonthAddsTest24012012]
	--INSERT INTO [Import.ActiveFleetMonthAddsTest24012012]
	--SELECT * FROM [Import.ActiveFleetMonthAdds]
	
	--DELETE FROM [Import.ActiveFleetMonthAdds] WHERE Serial IN 
	--(SELECT Serial FROM [Staging.ActiveFleetMonthAdds])
	
	
	
	TRUNCATE TABLE [Staging.ActiveFleetMonthAdds]
	
	UPDATE [Import.ActiveFleetMonthAdds] SET CompanyCode			= NULL WHERE CompanyCode = ''
	
	DELETE FROM [Import.ActiveFleetMonthAdds] WHERE CompanyCode not in 
			(SELECT CompanyCode FROM [Dimension.Companies])
			
	UPDATE [Import.ActiveFleetMonthAdds] SET AreaCode			= NULL WHERE AreaCode = ''
	UPDATE [Import.ActiveFleetMonthAdds] SET Serial				= NULL WHERE Serial = ''
	UPDATE [Import.ActiveFleetMonthAdds] SET Unit				= NULL WHERE Unit = ''
	UPDATE [Import.ActiveFleetMonthAdds] SET TasModel			= NULL WHERE TasModel = ''
	UPDATE [Import.ActiveFleetMonthAdds] SET ModelCode			= NULL WHERE ModelCode = ''
	UPDATE [Import.ActiveFleetMonthAdds] SET ManufacturerName	= NULL WHERE ManufacturerName = ''
	UPDATE [Import.ActiveFleetMonthAdds] SET ModelGroup			= NULL WHERE ModelGroup = ''
	UPDATE [Import.ActiveFleetMonthAdds] SET ModelDescription	= NULL WHERE ModelDescription = ''
	UPDATE [Import.ActiveFleetMonthAdds] SET RateClass			= NULL WHERE RateClass = ''
	UPDATE [Import.ActiveFleetMonthAdds] SET VehicleType			= NULL WHERE VehicleType = ''
	UPDATE [Import.ActiveFleetMonthAdds] SET CapitalCost			= NULL WHERE CapitalCost = ''
	UPDATE [Import.ActiveFleetMonthAdds] SET Depreciation		= NULL WHERE Depreciation = ''
	UPDATE [Import.ActiveFleetMonthAdds] SET DepreciationRate	= NULL WHERE DepreciationRate = ''
	UPDATE [Import.ActiveFleetMonthAdds] SET DepreciationPCT		= NULL WHERE DepreciationPCT = ''
	UPDATE [Import.ActiveFleetMonthAdds] SET BookValue			= NULL WHERE BookValue = ''
	UPDATE [Import.ActiveFleetMonthAdds] SET DeliveryDate		= NULL WHERE DeliveryDate = ''
	UPDATE [Import.ActiveFleetMonthAdds] SET MSODate				= NULL WHERE MSODate = ''
	UPDATE [Import.ActiveFleetMonthAdds] SET InServiceDate		= NULL WHERE InServiceDate = ''
	UPDATE [Import.ActiveFleetMonthAdds] SET OutServiceDate		= NULL WHERE OutServiceDate = ''
	UPDATE [Import.ActiveFleetMonthAdds] SET DaysInService		= NULL WHERE DaysInService = ''
	UPDATE [Import.ActiveFleetMonthAdds] SET SalePrice			= NULL WHERE SalePrice = ''
	UPDATE [Import.ActiveFleetMonthAdds] SET Mileage				= NULL WHERE Mileage = ''
	UPDATE [Import.ActiveFleetMonthAdds] SET AdjReceivable		= NULL WHERE AdjReceivable = ''
	UPDATE [Import.ActiveFleetMonthAdds] SET ReceivableType		= NULL WHERE ReceivableType = ''
	UPDATE [Import.ActiveFleetMonthAdds] SET AmortizedID			= NULL WHERE AmortizedID = ''
	UPDATE [Import.ActiveFleetMonthAdds] SET FirstRA				= NULL WHERE FirstRA = ''
	UPDATE [Import.ActiveFleetMonthAdds] SET RADate				= NULL WHERE RADate = ''
	UPDATE [Import.ActiveFleetMonthAdds] SET SaleType			= NULL WHERE SaleType = ''
	UPDATE [Import.ActiveFleetMonthAdds] SET VehicleStatus		= NULL WHERE VehicleStatus = ''
	UPDATE [Import.ActiveFleetMonthAdds] SET Plate				= NULL WHERE Plate = ''
	UPDATE [Import.ActiveFleetMonthAdds] SET SaleDate			= NULL WHERE SaleDate = ''
	UPDATE [Import.ActiveFleetMonthAdds] SET VehicleClass		= NULL WHERE VehicleClass = ''
	UPDATE [Import.ActiveFleetMonthAdds] SET DeliveryDate_2		= NULL WHERE DeliveryDate_2 = ''
	UPDATE [Import.ActiveFleetMonthAdds] SET OutServiceDate_2	= NULL WHERE OutServiceDate_2 = ''
	UPDATE [Import.ActiveFleetMonthAdds] SET ModelYear			= NULL WHERE ModelYear = ''
	UPDATE [Import.ActiveFleetMonthAdds] SET CapitalCostFleetco	= NULL WHERE CapitalCostFleetco = ''
	
	
	INSERT INTO [Staging.ActiveFleetMonthAdds]
	(
		CompanyCode		,	AreaCode		,	Serial			,	Unit			,	Plate			,
		TasModelCode	,	ModelCode		,	ManufacturerName,	ModelGroup		,	ModelDescription,
		RateClass		,	VehicleType		,	CapitalCost		,
		Depreciation	,	DepreciationRate,	DepreciationPCT	,	BookValue		,	DeliveryDate	,
		MSODate			,	InServiceDate	,	OutServiceDate	,
		DaysInService	,	SalePrice		,	Mileage			,	AdjReceivable	,	ReceivableType	,
		AmortizedID		,	FirstRA			,	RADate			,	SaleType		,
		VehicleStatus	,	SaleDate		,	VehicleClass	,	DeliveryDate_2	,	OutServiceDate_2,
		ModelYear		,   CapitalCostFleetco	, FileId
	)

		SELECT
			CompanyCode	,	AreaCode		,	Serial		,	Unit				,	Plate		,	TasModel	,
			ModelCode	,	ManufacturerName,	ModelGroup	,	ModelDescription	,	RateClass	,
			CONVERT(NCHAR(3),VehicleType),
			CASE WHEN ISNUMERIC(CapitalCost)		= 1 THEN CONVERT(FLOAT,CapitalCost) END,
			CASE WHEN ISNUMERIC(Depreciation)		= 1 THEN CONVERT(FLOAT,Depreciation) END,
			CASE WHEN ISNUMERIC(DepreciationRate)	= 1 THEN CONVERT(FLOAT,DepreciationRate) END,
			CASE WHEN ISNUMERIC(DepreciationPCT)	= 1 THEN CONVERT(FLOAT,DepreciationPCT) END,
			CASE WHEN ISNUMERIC(BookValue)			= 1 THEN CONVERT(FLOAT,BookValue) END,
			CASE WHEN ISDATE(DeliveryDate)			= 1 THEN CONVERT(DATETIME,DeliveryDate,103) END,
			CASE WHEN ISDATE(MSODate)				= 1 THEN CONVERT(DATETIME,MSODate,103) END,
			CASE WHEN ISDATE(InServiceDate)			= 1 THEN CONVERT(DATETIME,InServiceDate,103) END,
			CASE WHEN ISDATE(OutServiceDate)		= 1 THEN CONVERT(DATETIME,OutServiceDate,103) END,
			CASE WHEN ISNUMERIC(DaysInService)		= 1 THEN CONVERT(INT,DaysInService) END,
			CASE WHEN ISNUMERIC(SalePrice)			= 1 THEN CONVERT(FLOAT,SalePrice) END,
			CASE WHEN ISNUMERIC(Mileage)			= 1 THEN CONVERT(FLOAT,Mileage) END,
			CASE WHEN ISNUMERIC(AdjReceivable)		= 1 THEN CONVERT(FLOAT,AdjReceivable) END,
			ReceivableType	,	AmortizedID,
			CASE WHEN ISDATE(FirstRA)				= 1 THEN CONVERT(DATETIME,FirstRA,103) END,
			CASE WHEN ISDATE(RADate)				= 1 THEN CONVERT(DATETIME,RADate,103) END,
			SaleType	,	VehicleStatus,
			CASE WHEN ISDATE(SaleDate)				= 1 THEN CONVERT(DATETIME,SaleDate,103) END,
			VehicleClass,
			CASE WHEN ISDATE(DeliveryDate_2)		= 1 THEN CONVERT(DATETIME,DeliveryDate_2,103) END,
			CASE WHEN ISDATE(OutServiceDate_2)		= 1 THEN CONVERT(DATETIME,OutServiceDate_2,103) END,
			ModelYear,
			CASE WHEN ISNUMERIC(CapitalCostFleetco)	= 1 THEN CONVERT(FLOAT,CapitalCostFleetco) END,
			3
			
		FROM 
			[Import.ActiveFleetMonthAdds]
		WHERE 
			ISNUMERIC(CapitalCost) = 1
			
	
	--2.1 Find Country Id and Company Id
	--------------------------------------------------------------------------------------------
	
	UPDATE [Staging.ActiveFleetMonthAdds] SET
		[Staging.ActiveFleetMonthAdds].CompanyId = [Dimension.Companies].CompanyId ,
		[Staging.ActiveFleetMonthAdds].CountryId = [Dimension.Companies].CountryId
	FROM [Staging.ActiveFleetMonthAdds]
	INNER JOIN [Dimension.Companies] ON 
		[Staging.ActiveFleetMonthAdds].CompanyCode = [Dimension.Companies].CompanyCode	
		
	--2.2 Add Log id
	--------------------------------------------------------------------------------------------	
	
	DECLARE @NEWLOGID INT
	INSERT INTO [Application.FileLog]
	--VALUES (3,GETDATE())
	VALUES (@FileId,GETDATE())
	SET @NEWLOGID = @@IDENTITY
	
	UPDATE [Staging.ActiveFleetMonthAdds] SET LogId =  @NEWLOGID
	UPDATE [Staging.ActiveFleetMonthAdds] SET FileId =  @FileId
	
	
	-- 2.3 Add the New vehicles
	---------------------------------------------------------------------	
		MERGE [Fact.Vehicles] WITH (TABLOCK) AS TARGET
		USING 
		(
			SELECT Serial , Unit , CountryId
			FROM [Staging.ActiveFleetMonthAdds]
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
		
		
			
		UPDATE [Staging.ActiveFleetMonthAdds] SET
			[Staging.ActiveFleetMonthAdds].AppVehicleId = [Fact.Vehicles].VehicleId
		FROM [Staging.ActiveFleetMonthAdds]
		INNER JOIN [Fact.Vehicles]		ON 
			 [Staging.ActiveFleetMonthAdds].Serial	= [Fact.Vehicles].Serial 
		AND	 [Staging.ActiveFleetMonthAdds].Unit		= [Fact.Vehicles].Unit 
		AND	 [Staging.ActiveFleetMonthAdds].CountryId = [Fact.Vehicles].CountryId
		
	-- 3 - MANUFACTURERS
	--------------------------------------------------------------------------------------------
	--------------------------------------------------------------------------------------------
	--------------------------------------------------------------------------------------------

		UPDATE [Staging.ActiveFleetMonthAdds] SET
			[Staging.ActiveFleetMonthAdds].ManufacturerId = [Dimension.Manufacturer].ManufacturerId
		FROM 
			[Staging.ActiveFleetMonthAdds]
		INNER JOIN [Dimension.Manufacturer] ON
			[Staging.ActiveFleetMonthAdds].ManufacturerName = [Dimension.Manufacturer].ManufacturerName
				
		
		UPDATE [Staging.ActiveFleetMonthAdds] SET ManufacturerId = 0 WHERE ManufacturerId IS NULL
		
		
  
		UPDATE [Staging.ActiveFleetMonthAdds] SET
			[Staging.ActiveFleetMonthAdds].ManufacturerId	= [Dimension.ModelDetails].ManufacturerId,
			[Staging.ActiveFleetMonthAdds].ManufacturerName = [Dimension.Manufacturer].ManufacturerName
		FROM [Staging.ActiveFleetMonthAdds]
		INNER JOIN [Dimension.ModelCodes] ON
			[Staging.ActiveFleetMonthAdds].ModelCode = [Dimension.ModelCodes].ModelCode
		INNER JOIN [Dimension.Models] ON
			[Dimension.ModelCodes].ModelCodeId = [Dimension.Models].ModelCodeId AND
			[Staging.ActiveFleetMonthAdds].CompanyId = [Dimension.Models].CompanyId AND
			[Staging.ActiveFleetMonthAdds].ModelYear = [Dimension.Models].ModelYear
		INNER JOIN [Dimension.ModelDetails] ON
			[Dimension.Models].ModelId = [Dimension.ModelDetails].ModelId 
		INNER JOIN [Dimension.Manufacturer] ON 
			[Dimension.ModelDetails].ManufacturerId = [Dimension.Manufacturer].ManufacturerId
		WHERE 
			[Staging.ActiveFleetMonthAdds].ManufacturerId = 0
			
			
			
		UPDATE [Staging.ActiveFleetMonthAdds] SET 
			ManufacturerId = 31 
		WHERE ManufacturerName = 'VAUXHALL' AND ManufacturerId = 0
			
		DECLARE @UNKMANUFACTURER INT
		SET @UNKMANUFACTURER = (SELECT ManufacturerId 
								FROM [Dimension.Manufacturer] 
								WHERE ManufacturerName = 'UNKNOWN')
	
		
		UPDATE [Staging.ActiveFleetMonthAdds] SET 
			ManufacturerId = @UNKMANUFACTURER 
		WHERE ManufacturerId = 0
		
		
  
END