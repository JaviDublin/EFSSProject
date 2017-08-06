-- =============================================
-- Author:		Javier
-- Create date: July 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spDBImportModelsParse]
	
AS
BEGIN
	
		SET NOCOUNT ON;
	
		DECLARE @FileId INT
		SET @FileId	= (SELECT FileId FROM [Application.Files] WHERE FileCode = 'FMDRP')
		
		DELETE FROM [Import.Models] WHERE CompanyCode not in 
				(SELECT CompanyCode FROM [Dimension.Companies])
			
		
		DECLARE @NEWLOGID INT	
		INSERT INTO [Application.FileLog] 
		VALUES (@FileId , GETDATE())
		SET @NEWLOGID = @@IDENTITY
		
		UPDATE [Import.Models] SET CompanyCode		= NULL WHERE LTRIM(RTRIM(CompanyCode)) = ''
		UPDATE [Import.Models] SET ManufacturerCode	= NULL WHERE LTRIM(RTRIM(ManufacturerCode)) = ''
		UPDATE [Import.Models] SET ModelYear		= NULL WHERE LTRIM(RTRIM(ModelYear)) = ''
		UPDATE [Import.Models] SET ModelCode		= NULL WHERE LTRIM(RTRIM(ModelCode)) = ''
		UPDATE [Import.Models] SET ModelGroup		= NULL WHERE LTRIM(RTRIM(ModelGroup)) = ''
		UPDATE [Import.Models] SET ModelDescription	= NULL WHERE LTRIM(RTRIM(ModelDescription)) = ''
		UPDATE [Import.Models] SET TasModel			= NULL WHERE LTRIM(RTRIM(TasModel)) = ''
		UPDATE [Import.Models] SET RateClass		= NULL WHERE LTRIM(RTRIM(RateClass)) = ''
		UPDATE [Import.Models] SET EngineSize		= NULL WHERE LTRIM(RTRIM(EngineSize)) = ''
		UPDATE [Import.Models] SET FuelType			= NULL WHERE LTRIM(RTRIM(FuelType)) = ''
		UPDATE [Import.Models] SET EstCap			= NULL WHERE LTRIM(RTRIM(EstCap)) = ''
		UPDATE [Import.Models] SET EstDepr			= NULL WHERE LTRIM(RTRIM(EstDepr)) = ''
		UPDATE [Import.Models] SET EstVB			= NULL WHERE LTRIM(RTRIM(EstVB)) = ''
		UPDATE [Import.Models] SET EstAmrt			= NULL WHERE LTRIM(RTRIM(EstAmrt)) = ''
		UPDATE [Import.Models] SET FastSpec			= NULL WHERE LTRIM(RTRIM(FastSpec)) = ''
		UPDATE [Import.Models] SET PrepHR			= NULL WHERE LTRIM(RTRIM(PrepHR)) = ''
		UPDATE [Import.Models] SET RecStoredate		= NULL WHERE LTRIM(RTRIM(RecStoredate)) = ''
		
	-- 1 ADD NEW MODEL CODES
	---------------------------------------------------------------------------------------------
		MERGE dbo.[Dimension.ModelCodes] AS TARGET
		USING 
		(
			SELECT ModelCode
			FROM [Import.Models]
			WHERE ModelCode IS NOT NULL
			GROUP BY  ModelCode
		)
		AS SOURCE
		ON
		(TARGET.ModelCode = SOURCE.ModelCode)
		WHEN NOT MATCHED BY TARGET THEN
			INSERT ( ModelCode)
			VALUES (SOURCE.ModelCode);
		
	-- 2 ADD NEW MODELS
	---------------------------------------------------------------------------------------------	
	
		MERGE dbo.[Dimension.Models] AS TARGET
		USING 
		(
			SELECT 
				[Dimension.ModelCodes].ModelCodeId ,[Dimension.Companies].CompanyId , [Import.Models].ModelYear
			FROM [Import.Models]
			INNER JOIN [Dimension.ModelCodes] ON 
				[Import.Models].ModelCode	= [Dimension.ModelCodes].ModelCode
			INNER JOIN [Dimension.Companies]  ON 
				[Import.Models].CompanyCode = [Dimension.Companies].CompanyCode
			GROUP BY 
				[Dimension.ModelCodes].ModelCodeId ,[Dimension.Companies].CompanyId , [Import.Models].ModelYear
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
		
		
	-- 3 ADD NEW MANUFACTURER VISION CODES
	---------------------------------------------------------------------------------------------	
		INSERT INTO [Dimension.ManufacturerVision]	
			
		SELECT 
		[Dimension.Manufacturer].ManufacturerId,[Import.Models].ManufacturerCode, 
		MAX([Dimension.ManufacturerVision].Position) + 1
		FROM [Import.Models] , [Dimension.Manufacturer]
		INNER JOIN [Dimension.ManufacturerVision] ON	[Dimension.Manufacturer].ManufacturerId = 
														[Dimension.ManufacturerVision].ManufacturerId
		WHERE [Import.Models].ManufacturerCode NOT IN
		(	
			SELECT VisionCode AS "ManufacturerCode" 
			FROM [Dimension.ManufacturerVision] 
			WHERE VisionCode IS NOT NULL
		)
		AND [Dimension.Manufacturer].ManufacturerName = 'UNKNOWN'
		GROUP BY [Import.Models].ManufacturerCode , [Dimension.Manufacturer].ManufacturerId ,
		[Dimension.ManufacturerVision].Position
				
				
		UPDATE [Dimension.ManufacturerVision] SET VisionCode = LTRIM(RTRIM(VisionCode))	
		
		
	-- 4 ADD NEW MODEL DETAILS
	---------------------------------------------------------------------------------------------	
		MERGE dbo.[Dimension.ModelDetails] AS TARGET
		USING
		(
			SELECT 
				[Dimension.Models].ModelId		 , [Dimension.Companies].CompanyId			,
				[Import.Models].TasModel		 , [Import.Models].ModelGroup				, 
				[Import.Models].ModelDescription , [Dimension.Manufacturer].ManufacturerId  , 
				[Import.Models].RateClass		 , [Import.Models].EngineSize				, 
				[Import.Models].FuelType		 , [Import.Models].EstCap					, 
				[Import.Models].EstDepr			 , [Import.Models].EstVB					, 
				[Import.Models].EstAmrt			 , [Import.Models].FastSpec					, 
				[Import.Models].RecStoredate	 ,
				ROW_NUMBER() OVER 
				(
					PARTITION BY 
							[Dimension.Models].ModelId , [Dimension.Companies].CompanyId 
					ORDER BY (SELECT 0)
				) AS "Position"
			FROM [Import.Models]
			INNER JOIN [Dimension.ModelCodes]	ON	
					[Import.Models].ModelCode			= [Dimension.ModelCodes].ModelCode
			INNER JOIN [Dimension.Companies]	ON
					[Import.Models].CompanyCode			= [Dimension.Companies].CompanyCode
			INNER JOIN [Dimension.Models]		ON	
					[Dimension.ModelCodes].ModelCodeId	= [Dimension.Models].ModelCodeId and
					[Dimension.Companies].CompanyId		= [Dimension.Models].CompanyId and
					[Import.Models].ModelYear			= [Dimension.Models].ModelYear
			INNER JOIN [Dimension.ManufacturerVision]	ON 
					[Import.Models].ManufacturerCode	= [Dimension.ManufacturerVision].VisionCode
			INNER JOIN [Dimension.Manufacturer]	ON 
					[Dimension.ManufacturerVision].ManufacturerId = [Dimension.Manufacturer].ManufacturerId
			GROUP BY 
				[Dimension.Models].ModelId		 , [Dimension.Companies].CompanyId			,
				[Import.Models].TasModel		 , [Import.Models].ModelGroup				, 
				[Import.Models].ModelDescription , [Dimension.Manufacturer].ManufacturerId  , 
				[Import.Models].RateClass		 , [Import.Models].EngineSize				, 
				[Import.Models].FuelType		 , [Import.Models].EstCap					, 
				[Import.Models].EstDepr			 , [Import.Models].EstVB					, 
				[Import.Models].EstAmrt			 , [Import.Models].FastSpec					, 
				[Import.Models].RecStoredate	 
			
					
		) AS SOURCE
		ON 
		(
			TARGET.ModelId = SOURCE.ModelId AND TARGET.Position = SOURCE.Position
		)
		WHEN MATCHED AND
		(
				(TARGET.TasModelCode			<> SOURCE.TasModel
					OR  (TARGET.TasModelCode IS NULL AND SOURCE.TasModel IS NOT NULL) )
						OR  (TARGET.ModelGroup		<> SOURCE.ModelGroup
					OR  (TARGET.ModelGroup IS NULL AND SOURCE.ModelGroup IS NOT NULL) )
						OR  (TARGET.ModelDescription	<> SOURCE.ModelDescription
					OR  (TARGET.ModelDescription IS NULL AND SOURCE.ModelDescription IS NOT NULL) )
						OR  (TARGET.RateClass		<> SOURCE.RateClass
					OR  (TARGET.RateClass IS NULL AND SOURCE.RateClass IS NOT NULL) )
						OR  (TARGET.EngineSize		<> SOURCE.EngineSize
					OR  (TARGET.EngineSize IS NULL AND SOURCE.EngineSize IS NOT NULL) )
						OR  (TARGET.ManufacturerId	<> SOURCE.ManufacturerId
					OR  (TARGET.ManufacturerId IS NULL AND SOURCE.ManufacturerId IS NOT NULL) )
						OR  (TARGET.FuelType			<> SOURCE.FuelType
							OR  (TARGET.FuelType IS NULL AND SOURCE.FuelType IS NOT NULL) )
		)
				
		THEN
		UPDATE SET
			TARGET.TasModelCode		= SOURCE.TasModel,
			TARGET.ModelGroup		= SOURCE.ModelGroup,
			TARGET.ModelDescription	= SOURCE.ModelDescription	,
			TARGET.ManufacturerId	= SOURCE.ManufacturerId	,
			TARGET.RateClass		= SOURCE.RateClass		,
			TARGET.EngineSize		= SOURCE.EngineSize		,
			TARGET.FuelType			= SOURCE.FuelType			,
			TARGET.EstimatedCap			=	CASE WHEN ISNUMERIC(SOURCE.EstCap)	= 1 THEN CONVERT(FLOAT,SOURCE.EstCap)	END,
			TARGET.EstimatedDeprRate	=	CASE WHEN ISNUMERIC(SOURCE.EstDepr) = 1 THEN CONVERT(FLOAT,SOURCE.EstDepr)	END,
			TARGET.EstimatedVolBonus	=	CASE WHEN ISNUMERIC(SOURCE.EstVB)	= 1 THEN CONVERT(FLOAT,SOURCE.EstVB)	END,
			TARGET.EstimatedVBAmtPeriod	=	CASE WHEN ISNUMERIC(SOURCE.EstAmrt) = 1 THEN CONVERT(FLOAT,SOURCE.EstAmrt)	END,
			TARGET.FastSpec				=	SOURCE.FastSpec		,
			TARGET.ReceivableStoreDate	=	CASE WHEN ISDATE(SOURCE.RecStoredate) = 1 
												THEN CONVERT(DATETIME,SOURCE.RecStoredate,103) END
												,
			TARGET.LogId				= @NEWLOGID
					
		WHEN NOT MATCHED BY TARGET THEN
		INSERT 
			(
				ModelId , TasModelCode , ModelGroup , ModelDescription , ManufacturerId , RateClass , 
				EngineSize , FuelType , EstimatedCap , EstimatedDeprRate , EstimatedVolBonus , EstimatedVBAmtPeriod , 
				FastSpec , ReceivableStoreDate , Position , LogId
			)
		VALUES 
			( 
				SOURCE.ModelId , SOURCE.TasModel , SOURCE.ModelGroup , SOURCE.ModelDescription ,
				SOURCE.ManufacturerId , SOURCE.RateClass , SOURCE.EngineSize , SOURCE.FuelType , 
				CASE WHEN ISNUMERIC(SOURCE.EstCap)	= 1 THEN CONVERT(FLOAT,SOURCE.EstCap)	END,
				CASE WHEN ISNUMERIC(SOURCE.EstDepr) = 1 THEN CONVERT(FLOAT,SOURCE.EstDepr)	END,
				CASE WHEN ISNUMERIC(SOURCE.EstVB)	= 1 THEN CONVERT(FLOAT,SOURCE.EstVB)	END,
				CASE WHEN ISNUMERIC(SOURCE.EstAmrt) = 1 THEN CONVERT(FLOAT,SOURCE.EstAmrt)	END,
				SOURCE.FastSpec , 
				CASE WHEN ISDATE(SOURCE.RecStoredate) = 1 THEN CONVERT(DATETIME,SOURCE.RecStoredate,103) END ,
				SOURCE.Position , @NEWLOGID
				);
  
END