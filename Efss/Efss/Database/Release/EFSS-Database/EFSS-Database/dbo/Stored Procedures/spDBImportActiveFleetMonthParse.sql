-- =============================================
-- Author:		Javier
-- Create date: July 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spDBImportActiveFleetMonthParse]
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @FileId	INT
	SET @FileId	= (SELECT FileId FROM [Application.Files]	WHERE FileCode = 'FAFRM')
		
	--2.1 Find Country Id and Company Id
	--------------------------------------------------------------------------------------------
		
		UPDATE [Staging.ActiveFleetMonth] SET
		[Staging.ActiveFleetMonth].CompanyId = [Dimension.Companies].CompanyId ,
		[Staging.ActiveFleetMonth].CountryId = [Dimension.Companies].CountryId
		FROM [Staging.ActiveFleetMonth]
		INNER JOIN [Dimension.Companies] ON 
					[Staging.ActiveFleetMonth].CompanyCode = [Dimension.Companies].CompanyCode
		
	--2.2 Add Log id
	--------------------------------------------------------------------------------------------	
		DECLARE @NEWLOGID INT
		INSERT INTO [Application.FileLog]
		VALUES (@FileId,GETDATE())
		SET @NEWLOGID = @@IDENTITY
		
		UPDATE [Staging.ActiveFleetMonth] SET LogId = @NEWLOGID
		UPDATE [Staging.ActiveFleetMonth] SET FileId = @FileId
		
	-- 2.3 Add the New vehicles
	---------------------------------------------------------------------	
	
		MERGE [Fact.Vehicles] WITH (TABLOCK) AS TARGET
		USING 
		(
			SELECT Serial , Unit , CountryId
			FROM [Staging.ActiveFleetMonth]
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
			
		UPDATE [Staging.ActiveFleetMonth] SET
			[Staging.ActiveFleetMonth].AppVehicleId = [Fact.Vehicles].VehicleId
		FROM [Staging.ActiveFleetMonth]
		INNER JOIN [Fact.Vehicles]		   ON 
			[Staging.ActiveFleetMonth].Serial = [Fact.Vehicles].Serial 
		AND [Staging.ActiveFleetMonth].Unit = [Fact.Vehicles].Unit 
		AND [Staging.ActiveFleetMonth].CountryId = [Fact.Vehicles].CountryId
		
		
	-- 5 - MODELS
	--------------------------------------------------------------------------------------------
	--------------------------------------------------------------------------------------------
	--------------------------------------------------------------------------------------------
	
		UPDATE [Staging.ActiveFleetMonth] SET
		[Staging.ActiveFleetMonth].ModelCode = [Staging.ActiveFleetDay].ModelCode
		FROM [Staging.ActiveFleetMonth]
		INNER JOIN [Staging.ActiveFleetDay] ON 
			[Staging.ActiveFleetMonth].Serial = [Staging.ActiveFleetDay].Serial AND
			[Staging.ActiveFleetMonth].CompanyCode = [Staging.ActiveFleetDay].CompanyCode
		WHERE 
			[Staging.ActiveFleetMonth].ModelCode IS NULL
			
		UPDATE [Staging.ActiveFleetMonth] SET
		[Staging.ActiveFleetMonth].ModelCodeId = [Staging.ActiveFleetDay].ModelCodeId
		FROM [Staging.ActiveFleetMonth]
		INNER JOIN [Staging.ActiveFleetDay] ON 
			[Staging.ActiveFleetMonth].Serial = [Staging.ActiveFleetDay].Serial AND
			[Staging.ActiveFleetMonth].CompanyCode = [Staging.ActiveFleetDay].CompanyCode
		WHERE 
			[Staging.ActiveFleetMonth].ModelCodeId IS NULL
			
		UPDATE [Staging.ActiveFleetMonth] SET
		[Staging.ActiveFleetMonth].ModelId = [Staging.ActiveFleetDay].ModelId
		FROM [Staging.ActiveFleetMonth]
		INNER JOIN [Staging.ActiveFleetDay] ON 
			[Staging.ActiveFleetMonth].Serial = [Staging.ActiveFleetDay].Serial AND
			[Staging.ActiveFleetMonth].CompanyCode = [Staging.ActiveFleetDay].CompanyCode
		WHERE 
			[Staging.ActiveFleetMonth].ModelId IS NULL
			
		UPDATE [Staging.ActiveFleetMonth] SET
		[Staging.ActiveFleetMonth].ModelDetailId = [Staging.ActiveFleetDay].ModelDetailId
		FROM [Staging.ActiveFleetMonth]
		INNER JOIN [Staging.ActiveFleetDay] ON 
			[Staging.ActiveFleetMonth].Serial = [Staging.ActiveFleetDay].Serial AND
			[Staging.ActiveFleetMonth].CompanyCode = [Staging.ActiveFleetDay].CompanyCode
		WHERE 
			[Staging.ActiveFleetMonth].ModelDetailId IS NULL
			
		UPDATE [Staging.ActiveFleetMonth] SET
		[Staging.ActiveFleetMonth].ManufacturerName = [Staging.ActiveFleetDay].ManufacturerName
		FROM [Staging.ActiveFleetMonth]
		INNER JOIN [Staging.ActiveFleetDay] ON 
			[Staging.ActiveFleetMonth].Serial = [Staging.ActiveFleetDay].Serial AND
			[Staging.ActiveFleetMonth].CompanyCode = [Staging.ActiveFleetDay].CompanyCode
		WHERE 
			[Staging.ActiveFleetMonth].ManufacturerName IS NULL
			
		UPDATE [Staging.ActiveFleetMonth] SET
		[Staging.ActiveFleetMonth].ManufacturerId = [Staging.ActiveFleetDay].ManufacturerId
		FROM [Staging.ActiveFleetMonth]
		INNER JOIN [Staging.ActiveFleetDay] ON 
			[Staging.ActiveFleetMonth].Serial = [Staging.ActiveFleetDay].Serial AND
			[Staging.ActiveFleetMonth].CompanyCode = [Staging.ActiveFleetDay].CompanyCode
		WHERE 
			[Staging.ActiveFleetMonth].ManufacturerId IS NULL
	
	
	-- 5.1 Get the Model Details
	--------------------------------------------------------------------------------------------
	
		
		UPDATE [Staging.ActiveFleetMonth] SET
			[Staging.ActiveFleetMonth].ModelCodeId = [Dimension.ModelCodes].ModelCodeId
		FROM [Staging.ActiveFleetMonth]
		INNER JOIN [Dimension.ModelCodes] ON 
			[Staging.ActiveFleetMonth].ModelCode   = [Dimension.ModelCodes].ModelCode
			
		INSERT INTO [Dimension.ModelCodes]
		SELECT ModelCode 
		FROM [Staging.ActiveFleetMonth] 
		WHERE ModelCodeId IS NULL AND ModelCode IS NOT NULL
		GROUP BY ModelCode
		
		UPDATE [Staging.ActiveFleetMonth] SET
			[Staging.ActiveFleetMonth].ModelCodeId = [Dimension.ModelCodes].ModelCodeId
		FROM [Staging.ActiveFleetMonth]
		INNER JOIN [Dimension.ModelCodes] ON 
			[Staging.ActiveFleetMonth].ModelCode = [Dimension.ModelCodes].ModelCode
		WHERE [Staging.ActiveFleetMonth].ModelCodeId IS NULL
		
		MERGE dbo.[Dimension.Models] AS TARGET
		USING 
		(
			SELECT 
				[Dimension.ModelCodes].ModelCodeId	,
				[Dimension.Companies].CompanyId		, 
				[Staging.ActiveFleetMonth].ModelYear
			FROM [Staging.ActiveFleetMonth]
			INNER JOIN [Dimension.ModelCodes] ON 
				[Staging.ActiveFleetMonth].ModelCode	= [Dimension.ModelCodes].ModelCode
			INNER JOIN [Dimension.Companies]  ON 
				[Staging.ActiveFleetMonth].CompanyCode = [Dimension.Companies].CompanyCode
			GROUP BY 
				[Dimension.ModelCodes].ModelCodeId	,
				[Dimension.Companies].CompanyId		, 
				[Staging.ActiveFleetMonth].ModelYear

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
		
		UPDATE [Staging.ActiveFleetMonth] SET
			[Staging.ActiveFleetMonth].ModelId = [Dimension.Models].ModelId
		FROM [Staging.ActiveFleetMonth]
		INNER JOIN [Dimension.Models] ON 
					[Staging.ActiveFleetMonth].ModelCodeId = [Dimension.Models].ModelCodeId
				AND [Staging.ActiveFleetMonth].CompanyId   = [Dimension.Models].CompanyId 
				AND [Staging.ActiveFleetMonth].ModelYear   = [Dimension.Models].ModelYear
		WHERE [Staging.ActiveFleetMonth].ModelCodeId IS NOT NULL	
		
		UPDATE [Staging.ActiveFleetMonth] SET
			[Staging.ActiveFleetMonth].ModelDetailId = [Dimension.ModelDetails].ModelDetailId
		FROM [Staging.ActiveFleetMonth]
		INNER JOIN  [Dimension.ModelDetails] ON 
			[Staging.ActiveFleetMonth].ModelId	= [Dimension.ModelDetails].ModelId
		AND [Dimension.ModelDetails].Position	= 1		
		
		UPDATE [Staging.ActiveFleetMonth] SET
			[Staging.ActiveFleetMonth].ManufacturerName = [Dimension.Manufacturer].ManufacturerName
		FROM [Staging.ActiveFleetMonth]
		INNER JOIN [Dimension.ModelDetails] ON 
			[Staging.ActiveFleetMonth].ModelId = [Dimension.ModelDetails].ModelId AND
			[Dimension.ModelDetails].Position = 1
		INNER JOIN [Dimension.Manufacturer] ON 
			[Dimension.ModelDetails].ManufacturerId = [Dimension.Manufacturer].ManufacturerId
		WHERE 
			[Staging.ActiveFleetMonth].ManufacturerName IS NULL
		
		INSERT INTO [Dimension.ModelDetails] 
				(ModelId , ModelDescription , ManufacturerId , ModelGroup , Position)
		SELECT 
			[Staging.ActiveFleetMonth].ModelId , 
			[Staging.ActiveFleetMonth].ModelDescription , 
			[Dimension.Manufacturer].ManufacturerId ,
			[Staging.ActiveFleetMonth].ManufacturerName , 1
		FROM [Staging.ActiveFleetMonth] 
		INNER JOIN [Dimension.Manufacturer] ON 
				[Staging.ActiveFleetMonth].ManufacturerName = [Dimension.Manufacturer].ManufacturerName
		WHERE 
				[Staging.ActiveFleetMonth].ModelDetailId IS NULL 
			AND [Staging.ActiveFleetMonth].ModelId IS NOT NULL
		GROUP BY 
			[Staging.ActiveFleetMonth].ModelId , [Staging.ActiveFleetMonth].ModelDescription , 
			[Dimension.Manufacturer].ManufacturerId ,
			[Staging.ActiveFleetMonth].ManufacturerName
		
		
		
		
		
		UPDATE [Staging.ActiveFleetMonth] SET
				[Staging.ActiveFleetMonth].ModelDetailId = [Dimension.ModelDetails].ModelDetailId
		FROM [Staging.ActiveFleetMonth]
		INNER JOIN  [Dimension.ModelDetails] ON 
			[Staging.ActiveFleetMonth].ModelId			= [Dimension.ModelDetails].ModelId
		AND [Dimension.ModelDetails].Position	= 1
		WHERE [Staging.ActiveFleetMonth].ModelDetailId IS NULL	
		
		UPDATE [Staging.ActiveFleetMonth] SET ModelCodeId	= 0	WHERE ModelCodeId IS NULL
		UPDATE [Staging.ActiveFleetMonth] SET ModelId		= 0	WHERE ModelId IS NULL
		UPDATE [Staging.ActiveFleetMonth] SET ModelDetailId	= 0	WHERE ModelDetailId IS NULL	
		
		UPDATE [Staging.ActiveFleetMonth] SET
			[Staging.ActiveFleetMonth].ManufacturerId = [Dimension.ModelDetails].ManufacturerId
		FROM [Staging.ActiveFleetMonth]
		INNER JOIN [Dimension.ModelDetails] ON 
				[Staging.ActiveFleetMonth].ModelDetailId = [Dimension.ModelDetails].ModelDetailId
				
		UPDATE [Staging.ActiveFleetMonth] SET ManufacturerId = 0 WHERE ManufacturerId IS NULL
		
		UPDATE [Staging.ActiveFleetMonth] SET 
			[Staging.ActiveFleetMonth].ManufacturerId = [Dimension.Manufacturer].ManufacturerId
		FROM [Staging.ActiveFleetMonth]
		INNER JOIN [Dimension.Manufacturer] ON
			[Staging.ActiveFleetMonth].ManufacturerName = [Dimension.Manufacturer].ManufacturerName
		WHERE
			[Staging.ActiveFleetMonth].ManufacturerId = 0
		
		UPDATE [Staging.ActiveFleetMonth] SET 
			ManufacturerId = 31 
		WHERE ManufacturerName = 'VAUXHALL' AND ManufacturerId = 0
		
		
		DECLARE @UNKMANUFACTURER INT
		SET @UNKMANUFACTURER = (SELECT ManufacturerId 
								FROM [Dimension.Manufacturer] 
								WHERE ManufacturerName = 'UNKNOWN')
		
		UPDATE [Staging.ActiveFleetMonth] SET 
			ManufacturerId = @UNKMANUFACTURER 
		WHERE ManufacturerId = 0
			
  
END