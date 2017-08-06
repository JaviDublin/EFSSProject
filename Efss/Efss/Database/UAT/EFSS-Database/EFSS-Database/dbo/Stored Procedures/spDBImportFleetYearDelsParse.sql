-- =============================================
-- Author:		Javier
-- Create date: July 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spDBImportFleetYearDelsParse]
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @FileId INT
	SET @FileId	= (SELECT Fileid FROM [Application.Files] WHERE FileCode = 'FYTDD')
	
	UPDATE [Staging.ActiveFleetYearDeletes] SET AreaCode			= LTRIM(RTRIM(AreaCode))
	UPDATE [Staging.ActiveFleetYearDeletes] SET Serial				= LTRIM(RTRIM(Serial))
	UPDATE [Staging.ActiveFleetYearDeletes] SET Unit				= LTRIM(RTRIM(Unit))
	UPDATE [Staging.ActiveFleetYearDeletes] SET Plate				= LTRIM(RTRIM(Plate))
	UPDATE [Staging.ActiveFleetYearDeletes] SET ManufacturerName	= LTRIM(RTRIM(ManufacturerName))
	UPDATE [Staging.ActiveFleetYearDeletes] SET VehicleType		= LTRIM(RTRIM(VehicleType))
	UPDATE [Staging.ActiveFleetYearDeletes] SET ModelGroup			= LTRIM(RTRIM(ModelGroup))
	UPDATE [Staging.ActiveFleetYearDeletes] SET ModelDescription	= LTRIM(RTRIM(ModelDescription))
	UPDATE [Staging.ActiveFleetYearDeletes] SET CompanyCode		= LTRIM(RTRIM(CompanyCode))
	

		
		
	--2.1 Find Country Id and Company Id
	--------------------------------------------------------------------------------------------
		UPDATE [Staging.ActiveFleetYearDeletes] SET
			[Staging.ActiveFleetYearDeletes].CompanyId = [Dimension.Companies].CompanyId ,
			[Staging.ActiveFleetYearDeletes].CountryId = [Dimension.Companies].CountryId
		FROM [Staging.ActiveFleetYearDeletes]
		INNER JOIN [Dimension.Companies] ON 
			[Staging.ActiveFleetYearDeletes].CompanyCode = [Dimension.Companies].CompanyCode
		
	--2.2 Add Log id
	--------------------------------------------------------------------------------------------		
		DECLARE @NEWLOGID INT
		INSERT INTO [Application.FileLog]
		VALUES (@FileId,GETDATE())
		SET @NEWLOGID = @@IDENTITY
		
		UPDATE [Staging.ActiveFleetYearDeletes] SET LogId = @NEWLOGID
	
	-- 2.3 Add the New vehicles
	---------------------------------------------------------------------	
		MERGE [Fact.Vehicles] WITH (TABLOCK) AS TARGET
		USING 
		(
			SELECT Serial , Unit , CountryId
			FROM [Staging.ActiveFleetYearDeletes]
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
		
		
			
		UPDATE [Staging.ActiveFleetYearDeletes] SET
			[Staging.ActiveFleetYearDeletes].AppVehicleId = [Fact.Vehicles].VehicleId
		FROM [Staging.ActiveFleetYearDeletes]
		INNER JOIN [Fact.Vehicles]		ON 
			 [Staging.ActiveFleetYearDeletes].Serial	= [Fact.Vehicles].Serial 
		AND	 [Staging.ActiveFleetYearDeletes].Unit		= [Fact.Vehicles].Unit 
		AND	 [Staging.ActiveFleetYearDeletes].CountryId = [Fact.Vehicles].CountryId
		
		
		-- 3 - MANUFACTURERS
		--------------------------------------------------------------------------------------------
		--------------------------------------------------------------------------------------------
		--------------------------------------------------------------------------------------------
	
		UPDATE [Staging.ActiveFleetYearDeletes] SET
			[Staging.ActiveFleetYearDeletes].ManufacturerId = [Dimension.Manufacturer].ManufacturerId
		FROM 
			[Staging.ActiveFleetYearDeletes]
		INNER JOIN [Dimension.Manufacturer] ON
			[Staging.ActiveFleetYearDeletes].ManufacturerName = [Dimension.Manufacturer].ManufacturerName

				
		UPDATE [Staging.ActiveFleetYearDeletes] SET ManufacturerId = 0 WHERE ManufacturerId IS NULL
		
		
		
		UPDATE [Staging.ActiveFleetYearDeletes] SET
			[Staging.ActiveFleetYearDeletes].ManufacturerId	= [Dimension.ModelDetails].ManufacturerId,
			[Staging.ActiveFleetYearDeletes].ManufacturerName = [Dimension.Manufacturer].ManufacturerName
		FROM [Staging.ActiveFleetYearDeletes]
		INNER JOIN [Dimension.ModelCodes] ON
			[Staging.ActiveFleetYearDeletes].ModelCode = [Dimension.ModelCodes].ModelCode
		INNER JOIN [Dimension.Models] ON
			[Dimension.ModelCodes].ModelCodeId = [Dimension.Models].ModelCodeId AND
			[Staging.ActiveFleetYearDeletes].CompanyId = [Dimension.Models].CompanyId AND
			[Staging.ActiveFleetYearDeletes].ModelYear = [Dimension.Models].ModelYear
		INNER JOIN [Dimension.ModelDetails] ON
			[Dimension.Models].ModelId = [Dimension.ModelDetails].ModelId 
		INNER JOIN [Dimension.Manufacturer] ON 
			[Dimension.ModelDetails].ManufacturerId = [Dimension.Manufacturer].ManufacturerId
		WHERE 
			[Staging.ActiveFleetYearDeletes].ManufacturerId = 0
		
		
		UPDATE [Staging.ActiveFleetYearDeletes] SET 
			ManufacturerId = 31 
		WHERE ManufacturerName = 'VAUXHALL' AND ManufacturerId = 0
		
		
		DECLARE @UNKMANUFACTURER INT
		SET @UNKMANUFACTURER = (SELECT ManufacturerId 
								FROM [Dimension.Manufacturer] 
								WHERE ManufacturerName = 'UNKNOWN')
		
		UPDATE [Staging.ActiveFleetYearDeletes] SET 
			ManufacturerId = @UNKMANUFACTURER 
		WHERE ManufacturerId = 0
		
		
		
		
  
END