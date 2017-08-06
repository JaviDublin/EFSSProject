-- =============================================
-- Author:		Javier
-- Create date: July 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spDBImportActiveFleetDayParse]
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @FileId	INT	
	SET @FileId	= (SELECT FileId FROM [Application.Files] WHERE FileCode = 'FAFRD')
	
	TRUNCATE TABLE [Staging.ActiveFleetDay]
	
	UPDATE [Import.ActiveFleetDay] SET CompanyCode			= NULL WHERE CompanyCode = ''
	
		DELETE FROM [Import.ActiveFleetDay] WHERE CompanyCode not in 
			(SELECT CompanyCode FROM [Dimension.Companies])
			
	UPDATE [Import.ActiveFleetDay] SET AreaCode				= NULL WHERE AreaCode = ''
	UPDATE [Import.ActiveFleetDay] SET Serial				= NULL WHERE Serial = ''
	UPDATE [Import.ActiveFleetDay] SET Unit					= NULL WHERE Unit = ''
	UPDATE [Import.ActiveFleetDay] SET TasModel				= NULL WHERE TasModel = ''
	UPDATE [Import.ActiveFleetDay] SET ModelCode			= NULL WHERE ModelCode = ''
	UPDATE [Import.ActiveFleetDay] SET ManufacturerName		= NULL WHERE ManufacturerName = ''
	UPDATE [Import.ActiveFleetDay] SET ModelGroup			= NULL WHERE ModelGroup = ''
	UPDATE [Import.ActiveFleetDay] SET ModelDescription		= NULL WHERE ModelDescription = ''
	UPDATE [Import.ActiveFleetDay] SET RateClass			= NULL WHERE RateClass = ''
	UPDATE [Import.ActiveFleetDay] SET VehicleType			= NULL WHERE VehicleType = ''
	UPDATE [Import.ActiveFleetDay] SET CapitalCost			= NULL WHERE CapitalCost = ''
	UPDATE [Import.ActiveFleetDay] SET Depreciation			= NULL WHERE Depreciation = ''
	UPDATE [Import.ActiveFleetDay] SET DepreciationRate		= NULL WHERE DepreciationRate = ''
	UPDATE [Import.ActiveFleetDay] SET DepreciationPCT		= NULL WHERE DepreciationPCT = ''
	UPDATE [Import.ActiveFleetDay] SET BookValue			= NULL WHERE BookValue = ''
	UPDATE [Import.ActiveFleetDay] SET DeliveryDate			= NULL WHERE DeliveryDate = ''
	UPDATE [Import.ActiveFleetDay] SET MSODate				= NULL WHERE MSODate = ''
	UPDATE [Import.ActiveFleetDay] SET InServiceDate		= NULL WHERE InServiceDate = ''
	UPDATE [Import.ActiveFleetDay] SET OutServiceDate		= NULL WHERE OutServiceDate = ''
	UPDATE [Import.ActiveFleetDay] SET DaysInService		= NULL WHERE DaysInService = ''
	UPDATE [Import.ActiveFleetDay] SET SalePrice			= NULL WHERE SalePrice = ''
	UPDATE [Import.ActiveFleetDay] SET Mileage				= NULL WHERE Mileage = ''
	UPDATE [Import.ActiveFleetDay] SET AdjReceivable		= NULL WHERE AdjReceivable = ''
	UPDATE [Import.ActiveFleetDay] SET ReceivableType		= NULL WHERE ReceivableType = ''
	UPDATE [Import.ActiveFleetDay] SET AmortizedID			= NULL WHERE AmortizedID = ''
	UPDATE [Import.ActiveFleetDay] SET FirstRA				= NULL WHERE FirstRA = ''
	UPDATE [Import.ActiveFleetDay] SET RADate				= NULL WHERE RADate = ''
	UPDATE [Import.ActiveFleetDay] SET SaleType				= NULL WHERE SaleType = ''
	UPDATE [Import.ActiveFleetDay] SET VehicleStatus		= NULL WHERE VehicleStatus = ''
	UPDATE [Import.ActiveFleetDay] SET Plate				= NULL WHERE Plate = ''
	UPDATE [Import.ActiveFleetDay] SET SaleDate				= NULL WHERE SaleDate = ''
	UPDATE [Import.ActiveFleetDay] SET VehicleClass			= NULL WHERE VehicleClass = ''
	UPDATE [Import.ActiveFleetDay] SET DeliveryDate_2		= NULL WHERE DeliveryDate_2 = ''
	UPDATE [Import.ActiveFleetDay] SET OutServiceDate_2		= NULL WHERE OutServiceDate_2 = ''
	UPDATE [Import.ActiveFleetDay] SET ModelYear			= NULL WHERE ModelYear = ''
	
	
	INSERT INTO [Staging.ActiveFleetDay]
	(
		CompanyCode,AreaCode,Serial,Unit,Plate,TasModelCode,ModelCode,
		ManufacturerName,ModelGroup,ModelDescription,RateClass,VehicleType,
		CapitalCost,Depreciation,DepreciationRate,DepreciationPCT,BookValue,
		DeliveryDate,MSODate,InServiceDate,
		OutServiceDate,
		DaysInService,SalePrice,Mileage,AdjReceivable,ReceivableType,AmortizedID,FirstRA,RADate,SaleType,
		VehicleStatus,SaleDate,VehicleClass,DeliveryDate_2,OutServiceDate_2,ModelYear,FileId
	)

		SELECT 
		CompanyCode , AreaCode , Serial , Unit , Plate , TasModel ,
		ModelCode  , ManufacturerName   , ModelGroup  ,  ModelDescription , RateClass,
		VehicleType ,
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
		AdjReceivable , ReceivableType , AmortizedID , FirstRA,
		CASE WHEN ISDATE(RADate)				= 1 THEN CONVERT(DATETIME,RADate,103) END,
		SaleType , VehicleStatus,
		CASE WHEN ISDATE(SaleDate)				= 1 THEN CONVERT(DATETIME,SaleDate,103) END,
		CONVERT(NCHAR(3),VehicleClass),
		CASE WHEN ISDATE(DeliveryDate_2)		= 1 THEN CONVERT(DATETIME,DeliveryDate_2,103) END,
		CASE WHEN ISDATE(OutServiceDate_2)		= 1 THEN CONVERT(DATETIME,OutServiceDate_2,103) END,
		SUBSTRING(ModelYear,1,2) , 1
		FROM [Import.ActiveFleetDay]
		WHERE ISNUMERIC(CapitalCost) = 1
		
	
	--2.1 Find Country Id and Company Id
	--------------------------------------------------------------------------------------------
	UPDATE [Staging.ActiveFleetDay] SET
		[Staging.ActiveFleetDay].CompanyId = [Dimension.Companies].CompanyId ,
		[Staging.ActiveFleetDay].CountryId = [Dimension.Companies].CountryId
		FROM [Staging.ActiveFleetDay]
		INNER JOIN [Dimension.Companies] ON 
				[Staging.ActiveFleetDay].CompanyCode = [Dimension.Companies].CompanyCode	
				
	--2.2 Add Log id
	--------------------------------------------------------------------------------------------		
	DECLARE @NEWLOGID INT	
	INSERT INTO [Application.FileLog] 
	VALUES (@FileId , GETDATE())
	SET @NEWLOGID = @@IDENTITY
	
	UPDATE [Staging.ActiveFleetDay] SET LogId = @NEWLOGID
	
	UPDATE [Staging.ActiveFleetDay] SET FileId = @FileId
	
	
	
	-- 2.3 Add the New vehicles
	---------------------------------------------------------------------	
		MERGE [Fact.Vehicles] WITH (TABLOCK) AS TARGET
		USING 
		(
			SELECT Serial , Unit , CountryId
			FROM [Staging.ActiveFleetDay]
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
		
		UPDATE [Staging.ActiveFleetDay] SET
			[Staging.ActiveFleetDay].AppVehicleId = [Fact.Vehicles].VehicleId
		FROM [Staging.ActiveFleetDay]
		INNER JOIN [Fact.Vehicles]		ON 
			 [Staging.ActiveFleetDay].Serial	= [Fact.Vehicles].Serial 
		AND	 [Staging.ActiveFleetDay].Unit		= [Fact.Vehicles].Unit 
		AND	 [Staging.ActiveFleetDay].CountryId = [Fact.Vehicles].CountryId
		

	
	-- 5 - MODELS
	--------------------------------------------------------------------------------------------
	--------------------------------------------------------------------------------------------
	--------------------------------------------------------------------------------------------
	
	-- 5.1 Get the Model Details
	--------------------------------------------------------------------------------------------
		
		UPDATE [Staging.ActiveFleetDay] SET
			[Staging.ActiveFleetDay].ModelCodeId = [Dimension.ModelCodes].ModelCodeId
		FROM [Staging.ActiveFleetDay]
		INNER JOIN [Dimension.ModelCodes] ON 
			[Staging.ActiveFleetDay].ModelCode	 = [Dimension.ModelCodes].ModelCode
		
		--select * from [Staging.ActiveFleetDay] where ModelCodeId is null
			
			
		INSERT INTO [Dimension.ModelCodes]
		SELECT ModelCode 
		FROM [Staging.ActiveFleetDay] 
		WHERE ModelCodeId IS NULL AND ModelCode IS NOT NULL
		GROUP BY ModelCode
		
		UPDATE [Staging.ActiveFleetDay] SET
			[Staging.ActiveFleetDay].ModelCodeId = [Dimension.ModelCodes].ModelCodeId
		FROM [Staging.ActiveFleetDay]
		INNER JOIN [Dimension.ModelCodes] ON 
			[Staging.ActiveFleetDay].ModelCode = [Dimension.ModelCodes].ModelCode
		WHERE [Staging.ActiveFleetDay].ModelCodeId IS NULL
		
		
		
		MERGE dbo.[Dimension.Models] AS TARGET
		USING 
		(
			SELECT 
				[Dimension.ModelCodes].ModelCodeId	,
				[Dimension.Companies].CompanyId		, 
				[Staging.ActiveFleetDay].ModelYear
			FROM [Staging.ActiveFleetDay]
			INNER JOIN [Dimension.ModelCodes] ON 
				[Staging.ActiveFleetDay].ModelCode	= [Dimension.ModelCodes].ModelCode
			INNER JOIN [Dimension.Companies]  ON 
				[Staging.ActiveFleetDay].CompanyCode = [Dimension.Companies].CompanyCode
			GROUP BY 
				[Dimension.ModelCodes].ModelCodeId	,
				[Dimension.Companies].CompanyId		, 
				[Staging.ActiveFleetDay].ModelYear

		) AS SOURCE
		ON 
		(
				TARGET.ModelCodeId	= SOURCE.ModelCodeId 
			AND TARGET.CompanyId	= SOURCE.CompanyId 
			AND TARGET.ModelYear	= SOURCE.ModelYear
		)
		WHEN NOT MATCHED BY TARGET THEN
		INSERT 
			(ModelCodeId , CompanyId , ModelYear)
		VALUES 
			(SOURCE.ModelCodeId , SOURCE.CompanyId , SOURCE.ModelYear);	
		
		
		UPDATE [Staging.ActiveFleetDay] SET
			[Staging.ActiveFleetDay].ModelId = [Dimension.Models].ModelId
		FROM [Staging.ActiveFleetDay]
		INNER JOIN [Dimension.Models] ON 
						[Staging.ActiveFleetDay].ModelCodeId	= [Dimension.Models].ModelCodeId
					AND [Staging.ActiveFleetDay].CompanyId		= [Dimension.Models].CompanyId 
					AND [Staging.ActiveFleetDay].ModelYear		= [Dimension.Models].ModelYear	
		WHERE [Staging.ActiveFleetDay].ModelCodeId IS NOT NULL
		
		
		
		UPDATE [Staging.ActiveFleetDay] SET
			[Staging.ActiveFleetDay].ModelDetailId = [Dimension.ModelDetails].ModelDetailId
		FROM [Staging.ActiveFleetDay]
		INNER JOIN  [Dimension.ModelDetails] ON 
			[Staging.ActiveFleetDay].ModelId	= [Dimension.ModelDetails].ModelId
		AND [Dimension.ModelDetails].Position	= 1		
		
		
		UPDATE [Staging.ActiveFleetDay] SET
			[Staging.ActiveFleetDay].ManufacturerName = [Dimension.Manufacturer].ManufacturerName
		FROM [Staging.ActiveFleetDay]
		INNER JOIN [Dimension.ModelDetails] ON 
			[Staging.ActiveFleetDay].ModelId = [Dimension.ModelDetails].ModelId AND
			[Dimension.ModelDetails].Position = 1
		INNER JOIN [Dimension.Manufacturer] ON 
			[Dimension.ModelDetails].ManufacturerId = [Dimension.Manufacturer].ManufacturerId
		WHERE 
			[Staging.ActiveFleetDay].ManufacturerName IS NULL
		
		
		INSERT INTO [Dimension.ModelDetails] 
				(ModelId , ModelDescription , ManufacturerId , ModelGroup , Position)
		SELECT 
			[Staging.ActiveFleetDay].ModelId , 
			[Staging.ActiveFleetDay].ModelDescription , 
			[Dimension.Manufacturer].ManufacturerId ,
			[Staging.ActiveFleetDay].ManufacturerName , 1
		FROM [Staging.ActiveFleetDay] 
		INNER JOIN [Dimension.Manufacturer] ON 
				[Staging.ActiveFleetDay].ManufacturerName = [Dimension.Manufacturer].ManufacturerName
		WHERE 
				[Staging.ActiveFleetDay].ModelDetailId IS NULL 
			AND [Staging.ActiveFleetDay].ModelId IS NOT NULL
		GROUP BY 
			[Staging.ActiveFleetDay].ModelId , [Staging.ActiveFleetDay].ModelDescription , 
			[Dimension.Manufacturer].ManufacturerId ,
			[Staging.ActiveFleetDay].ManufacturerName
		
		
		
		
		UPDATE [Staging.ActiveFleetDay] SET
				[Staging.ActiveFleetDay].ModelDetailId = [Dimension.ModelDetails].ModelDetailId
		FROM [Staging.ActiveFleetDay]
		INNER JOIN  [Dimension.ModelDetails] ON 
			[Staging.ActiveFleetDay].ModelId	= [Dimension.ModelDetails].ModelId
		AND [Dimension.ModelDetails].Position	= 1
		WHERE [Staging.ActiveFleetDay].ModelDetailId IS NULL	
		
		UPDATE [Staging.ActiveFleetDay] SET ModelCodeId	= 0	WHERE ModelCodeId IS NULL
		UPDATE [Staging.ActiveFleetDay] SET ModelId		= 0	WHERE ModelId IS NULL
		UPDATE [Staging.ActiveFleetDay] SET ModelDetailId	= 0	WHERE ModelDetailId IS NULL	
		
		
		
		UPDATE [Staging.ActiveFleetDay] SET
			[Staging.ActiveFleetDay].ManufacturerId = [Dimension.ModelDetails].ManufacturerId
		FROM [Staging.ActiveFleetDay]
		INNER JOIN [Dimension.ModelDetails] ON 
				[Staging.ActiveFleetDay].ModelDetailId = [Dimension.ModelDetails].ModelDetailId
				
		UPDATE [Staging.ActiveFleetDay] SET ManufacturerId = 0 WHERE ManufacturerId IS NULL
		
		UPDATE [Staging.ActiveFleetDay] SET 
			[Staging.ActiveFleetDay].ManufacturerId = [Dimension.Manufacturer].ManufacturerId
		FROM [Staging.ActiveFleetDay]
		INNER JOIN [Dimension.Manufacturer] ON
			[Staging.ActiveFleetDay].ManufacturerName = [Dimension.Manufacturer].ManufacturerName
		WHERE
			[Staging.ActiveFleetDay].ManufacturerId = 0
		
		
		
		UPDATE [Staging.ActiveFleetDay] SET 
			ManufacturerId = 31 
		WHERE ManufacturerName = 'VAUXHALL' AND ManufacturerId = 0
		
		DECLARE @UNKMANUFACTURER INT
		SET @UNKMANUFACTURER = (SELECT ManufacturerId 
								FROM [Dimension.Manufacturer] 
								WHERE ManufacturerName = 'UNKNOWN')
		
		UPDATE [Staging.ActiveFleetDay] SET 
			ManufacturerId = @UNKMANUFACTURER 
		WHERE ManufacturerId = 0
											
	
	  
END