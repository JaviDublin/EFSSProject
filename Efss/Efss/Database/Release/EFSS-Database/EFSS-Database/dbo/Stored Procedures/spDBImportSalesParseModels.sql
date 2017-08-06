-- =============================================
-- Author:		Javier
-- Create date: September 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spDBImportSalesParseModels]
	
AS
BEGIN
	
	SET NOCOUNT ON;
	
	-- 4 MODEL CODES AND ID'S
	--------------------------------------------------------------------------------------------------------
	--------------------------------------------------------------------------------------------------------
	
	-- 4.1 Get the Model Details
	--------------------------------------------------------------------------------------------------------
	
	--UPDATE [Staging.SalesOR] SET
	--	ModelCode = 'CPR90',
	--	ModelDescription = '207 1.4',
	--	ManufacturerName = 'PEUGEOT',
	--	ManufacturerCode = 'Q'
	--WHERE
	--	Serial IN
	--	('LP000000000000052',
	--	'LP000000000000055',
	--	'LP000000000000063',
	--	'LP000000000000064',
	--	'LP000000000000065',
	--	'LP000000000000066')
	
	
	UPDATE [Staging.SalesOR] SET HasModel = 0 WHERE ModelCode IS NULL
	UPDATE [Staging.SalesOR] SET HasModel = 1 WHERE ModelCode IS NOT NULL
	UPDATE [Staging.SalesOR] SET NoModelCode = 1 , IsError = 1 where ModelCode is null
	UPDATE [Staging.SalesOR] SET NoModelCode		= 0 where NoModelCode is null
	
	-- 4.2 Add New Model Codes and Get the Model Code Id
	--------------------------------------------------------------------------------------------------------
	MERGE [Dimension.ModelCodes] AS TARGET
		USING
		(	
			SELECT ModelCode 
			FROM [Staging.SalesOR] 
			WHERE HasModel = 1
			GROUP BY ModelCode
		
		) AS SOURCE
		ON
		(
			TARGET.ModelCode = SOURCE.ModelCode
		)
		WHEN NOT MATCHED BY TARGET THEN
		INSERT (ModelCode)
		VALUES (SOURCE.ModelCode);
	
	UPDATE [Staging.SalesOR] SET
		[Staging.SalesOR].ModelCodeId = [Dimension.ModelCodes].ModelCodeId
	FROM [Staging.SalesOR]
	INNER JOIN [Dimension.ModelCodes] ON 
		[Staging.SalesOR].ModelCode = [Dimension.ModelCodes].ModelCode
	WHERE [Staging.SalesOR].HasModel = 1
			
	--UPDATE [Staging.SalesOR] SET IsError = 1 WHERE ModelCodeId Is Null
		
	-- * Temporary Fix
	--------------------------------------------------------------------------------------------------------
	--DELETE FROM [Staging.SalesOR] WHERE HasModel = 0
	
		
	-- 4.3 Add New Models (Model Code Id , Contry Id , Model Year) and Get the Model Id
	--------------------------------------------------------------------------------------------------------

	--UPDATE [Staging.SalesOR] SET
	--	ModelYear = SUBSTRING(CONVERT(VARCHAR,YEAR(InServiceDate)),3,2)
	--WHERE ModelYear is null


	MERGE dbo.[Dimension.Models] WITH (TABLOCK) AS TARGET
		USING 
		(
			SELECT 
				[Dimension.ModelCodes].ModelCodeId	,
				[Dimension.Companies].CompanyId		, 
				[Staging.SalesOR].ModelYear
			FROM [Staging.SalesOR]
			INNER JOIN [Dimension.ModelCodes] ON 
				[Staging.SalesOR].ModelCode	= [Dimension.ModelCodes].ModelCode
			INNER JOIN [Dimension.Companies]  ON 
				[Staging.SalesOR].CompanyCode = [Dimension.Companies].CompanyCode
			WHERE [Staging.SalesOR].HasModel = 1
			GROUP BY 
				[Dimension.ModelCodes].ModelCodeId	,
				[Dimension.Companies].CompanyId		, 
				[Staging.SalesOR].ModelYear

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
	
	-- * Query to add a Model Year where the Model Year is empty (not needed)	
	--UPDATE [Staging.SalesOR] SET
	--	[Staging.SalesOR].ModelYear = DM.ModelYear
	--	FROM [Staging.SalesOR]
	--	INNER JOIN [Dimension.ModelCodes]	ON	
	--		[Staging.SalesOR].ModelCode = [Dimension.ModelCodes].ModelCode
	--	INNER JOIN [Dimension.Models] AS DM ON	
	--		[Dimension.ModelCodes].ModelCodeId = DM.ModelCodeId 
	--	AND [Staging.SalesOR].CompanyId = DM.CompanyId
	--	WHERE 
	--		[Staging.SalesOR].ModelYear IS NULL 
	--	AND 
	--		DM.ModelYear = 
	--	(SELECT TOP(1) ModelYear FROM [Dimension.Models] AS DM2 WHERE DM2.ModelCodeId = DM.ModelCodeId
	--			ORDER BY ModelYear DESC)
			
	UPDATE [Staging.SalesOR] SET
			[Staging.SalesOR].ModelId = [Dimension.Models].ModelId
	FROM [Staging.SalesOR]
	INNER JOIN [Dimension.Models] ON 
			[Staging.SalesOR].ModelCodeId	= [Dimension.Models].ModelCodeId
		AND [Staging.SalesOR].CompanyId		= [Dimension.Models].CompanyId 
		AND [Staging.SalesOR].ModelYear		= [Dimension.Models].ModelYear	
	WHERE [Staging.SalesOR].ModelCodeId IS NOT NULL
			
	
	-- 4.4 Add New Model Details (Model Description , Engine Type ...) and Get the Model Detail id
	--------------------------------------------------------------------------------------------------------
	
	UPDATE [Staging.SalesOR] SET
		[Staging.SalesOR].ManufacturerName = [Dimension.Manufacturer].ManufacturerName
	FROM [Staging.SalesOR]
	INNER JOIN [Dimension.ManufacturerVision] ON
		[Staging.SalesOR].ManufacturerCode = [Dimension.ManufacturerVision].VisionCode
	INNER JOIN [Dimension.Manufacturer] ON
		[Dimension.ManufacturerVision].ManufacturerId = [Dimension.Manufacturer].ManufacturerId
	WHERE [Staging.SalesOR].ManufacturerName IS NULL
	
	
	
	-- (1) Get the Model Detail id
	UPDATE [Staging.SalesOR] SET
		[Staging.SalesOR].ModelDetailId = [Dimension.ModelDetails].ModelDetailId
	FROM [Staging.SalesOR]
	INNER JOIN  [Dimension.ModelDetails] ON 
		[Staging.SalesOR].ModelId			= [Dimension.ModelDetails].ModelId
	AND [Dimension.ModelDetails].Position	= 1
		
		
	-- (2) Add the New Model Details
	INSERT INTO [Dimension.ModelDetails] 
			(ModelId , ModelDescription , ManufacturerId , ModelGroup , Position)
	SELECT 
		[Staging.SalesOR].ModelId , 
		[Staging.SalesOR].ModelDescription , 
		[Dimension.Manufacturer].ManufacturerId ,
		[Staging.SalesOR].ManufacturerName , 1
	FROM [Staging.SalesOR] 
	INNER JOIN [Dimension.Manufacturer] ON 
			[Staging.SalesOR].ManufacturerName = [Dimension.Manufacturer].ManufacturerName
	WHERE 
			[Staging.SalesOR].ModelDetailId IS NULL 
		AND [Staging.SalesOR].ModelId IS NOT NULL
	GROUP BY 
		[Staging.SalesOR].ModelId , [Staging.SalesOR].ModelDescription , 
		[Dimension.Manufacturer].ManufacturerId ,
		[Staging.SalesOR].ManufacturerName
	
	-- (3) Get the Model Detail id for the new records
	UPDATE [Staging.SalesOR] SET
		[Staging.SalesOR].ModelDetailId = [Dimension.ModelDetails].ModelDetailId
	FROM [Staging.SalesOR]
	INNER JOIN  [Dimension.ModelDetails] ON 
		[Staging.SalesOR].ModelId	= [Dimension.ModelDetails].ModelId
	--AND [Dimension.ModelDetails].Position	= 1
	WHERE [Staging.SalesOR].ModelDetailId IS NULL	
	
	-- (4) Add the New Model Details (Excluded on the step (2))
	INSERT INTO [Dimension.ModelDetails] 
			(ModelId , ModelDescription , ManufacturerId , ModelGroup , Position)
	SELECT 
		[Staging.SalesOR].ModelId			,		 
		[Staging.SalesOR].ModelDescription	, 
		[Dimension.ManufacturerVision].ManufacturerId ,
		[Staging.SalesOR].ManufacturerName	, 1
	FROM [Staging.SalesOR] 
	INNER JOIN [Dimension.ManufacturerVision] ON 
		[Staging.SalesOR].ManufacturerCode = [Dimension.ManufacturerVision].VisionCode	
	WHERE 
		[Staging.SalesOR].ModelCode IS NOT NULL 
	AND [Staging.SalesOR].ModelDetailId IS NULL	
	GROUP BY 
		[Staging.SalesOR].ModelId , [Staging.SalesOR].ModelDescription , 
		[Dimension.ManufacturerVision].ManufacturerId ,
		[Staging.SalesOR].ManufacturerName 
	
	-- (5) Get the Model Detail id for the new records (Excluded on the step (3))	
	UPDATE [Staging.SalesOR] SET
		[Staging.SalesOR].ModelDetailId = [Dimension.ModelDetails].ModelDetailId
	FROM [Staging.SalesOR]
	INNER JOIN  [Dimension.ModelDetails] ON 
		[Staging.SalesOR].ModelId = [Dimension.ModelDetails].ModelId
	AND [Dimension.ModelDetails].Position = 1
	WHERE [Staging.SalesOR].ModelDetailId IS NULL					
				
	UPDATE [Staging.SalesOR] SET ModelCodeId	= 0	WHERE ModelCodeId	IS NULL
	UPDATE [Staging.SalesOR] SET ModelId		= 0	WHERE ModelId		IS NULL
	UPDATE [Staging.SalesOR] SET ModelDetailId	= 0	WHERE ModelDetailId IS NULL;
	
	
	
	UPDATE [Dimension.ModelDetails] SET EstimatedCap = 0 WHERE EstimatedCap is null
	UPDATE [Dimension.ModelDetails] SET EstimatedDeprRate = 0 WHERE EstimatedDeprRate is null
	UPDATE [Dimension.ModelDetails] SET EstimatedVolBonus = 0 WHERE EstimatedVolBonus is null
	UPDATE [Dimension.ModelDetails] SET EstimatedVBAmtPeriod = 0 WHERE EstimatedVBAmtPeriod is null
	UPDATE [Dimension.ModelDetails] SET Position = 1 WHERE Position is null
	UPDATE [Dimension.ModelDetails] SET LogId = 0 WHERE LogId is null
	
	
	-- Fix Manufacturer Errors (Pending)
--select 
--	[Dimension.ModelDetails].ModelDescription , [Dimension.Models].ModelYear , [Dimension.ModelCodes].ModelCode ,
--	[Staging.ActiveFleetMonth].ModelDescription
--from [Dimension.ModelDetails] 
--inner join [Dimension.Models] on [Dimension.ModelDetails].ModelId = [Dimension.Models].ModelId
--inner join [Dimension.ModelCodes] on [Dimension.Models].ModelCodeId = [Dimension.ModelCodes].ModelCodeId
--left join [Staging.ActiveFleetMonth] on [Dimension.ModelCodes].ModelCode = [Staging.ActiveFleetMonth].ModelCode
--where [Dimension.ModelDetails].ManufacturerId = 45
--group by
--[Dimension.ModelDetails].ModelDescription , [Dimension.Models].ModelYear , [Dimension.ModelCodes].ModelCode ,
--	[Staging.ActiveFleetMonth].ModelDescription
		

   
END