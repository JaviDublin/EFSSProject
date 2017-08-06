-- =============================================
-- Author:		Javier
-- Create date: July 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spDBImportFleetYearAddsParse]
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @FileId INT	
	SET @FileId = (SELECT FileId FROM [Application.Files] WHERE FileCode = 'FYTDA')
		
	UPDATE [Staging.ActiveFleetYearAdds] SET AreaCode			= LTRIM(RTRIM(AreaCode))
	UPDATE [Staging.ActiveFleetYearAdds] SET Serial				= LTRIM(RTRIM(Serial))
	UPDATE [Staging.ActiveFleetYearAdds] SET Unit				= LTRIM(RTRIM(Unit))
	UPDATE [Staging.ActiveFleetYearAdds] SET Plate				= LTRIM(RTRIM(Plate))
	UPDATE [Staging.ActiveFleetYearAdds] SET ManufacturerName	= LTRIM(RTRIM(ManufacturerName))
	UPDATE [Staging.ActiveFleetYearAdds] SET VehicleType		= LTRIM(RTRIM(VehicleType))
	UPDATE [Staging.ActiveFleetYearAdds] SET ModelGroup			= LTRIM(RTRIM(ModelGroup))
	UPDATE [Staging.ActiveFleetYearAdds] SET ModelDescription	= LTRIM(RTRIM(ModelDescription))
	UPDATE [Staging.ActiveFleetYearAdds] SET CompanyCode		= LTRIM(RTRIM(CompanyCode))
	
	
	UPDATE [Staging.ActiveFleetYearAdds] SET
		[Staging.ActiveFleetYearAdds].CompanyId = [Dimension.Companies].CompanyId ,
		[Staging.ActiveFleetYearAdds].CountryId = [Dimension.Companies].CountryId
	FROM [Staging.ActiveFleetYearAdds]
	INNER JOIN [Dimension.Companies] ON 
		[Staging.ActiveFleetYearAdds].CompanyCode = [Dimension.Companies].CompanyCode
		
	--2.2 Add Log id
	--------------------------------------------------------------------------------------------	
	
	DECLARE @NEWLOGID INT
	INSERT INTO [Application.FileLog]
	--VALUES (5,GETDATE())
	VALUES (@FileId,GETDATE())
	SET @NEWLOGID = @@IDENTITY
	
	UPDATE [Staging.ActiveFleetYearAdds] SET LogId = @NEWLOGID
	
	-- 2.3 Add the New vehicles
	---------------------------------------------------------------------	
		MERGE [Fact.Vehicles] WITH (TABLOCK) AS TARGET
		USING 
		(
			SELECT Serial , Unit , CountryId
			FROM [Staging.ActiveFleetYearAdds]
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
		
		
			
		UPDATE [Staging.ActiveFleetYearAdds] SET
			[Staging.ActiveFleetYearAdds].AppVehicleId = [Fact.Vehicles].VehicleId
		FROM [Staging.ActiveFleetYearAdds]
		INNER JOIN [Fact.Vehicles]		ON 
			 [Staging.ActiveFleetYearAdds].Serial	= [Fact.Vehicles].Serial 
		AND	 [Staging.ActiveFleetYearAdds].Unit		= [Fact.Vehicles].Unit 
		AND	 [Staging.ActiveFleetYearAdds].CountryId = [Fact.Vehicles].CountryId
		
		
	-- 3 - MANUFACTURERS
	--------------------------------------------------------------------------------------------
	--------------------------------------------------------------------------------------------
	--------------------------------------------------------------------------------------------
	

		UPDATE [Staging.ActiveFleetYearAdds] SET
			[Staging.ActiveFleetYearAdds].ManufacturerId = [Dimension.Manufacturer].ManufacturerId
		FROM 
			[Staging.ActiveFleetYearAdds]
		INNER JOIN [Dimension.Manufacturer] ON
			[Staging.ActiveFleetYearAdds].ManufacturerName = [Dimension.Manufacturer].ManufacturerName
				
		UPDATE [Staging.ActiveFleetYearAdds] SET ManufacturerId = 0 WHERE ManufacturerId IS NULL
		
		
		UPDATE [Staging.ActiveFleetYearAdds] SET
			[Staging.ActiveFleetYearAdds].ManufacturerId	= [Dimension.ModelDetails].ManufacturerId,
			[Staging.ActiveFleetYearAdds].ManufacturerName = [Dimension.Manufacturer].ManufacturerName
		FROM [Staging.ActiveFleetYearAdds]
		INNER JOIN [Dimension.ModelCodes] ON
			[Staging.ActiveFleetYearAdds].ModelCode = [Dimension.ModelCodes].ModelCode
		INNER JOIN [Dimension.Models] ON
			[Dimension.ModelCodes].ModelCodeId = [Dimension.Models].ModelCodeId AND
			[Staging.ActiveFleetYearAdds].CompanyId = [Dimension.Models].CompanyId AND
			[Staging.ActiveFleetYearAdds].ModelYear = [Dimension.Models].ModelYear
		INNER JOIN [Dimension.ModelDetails] ON
			[Dimension.Models].ModelId = [Dimension.ModelDetails].ModelId 
		INNER JOIN [Dimension.Manufacturer] ON 
			[Dimension.ModelDetails].ManufacturerId = [Dimension.Manufacturer].ManufacturerId
		WHERE 
			[Staging.ActiveFleetYearAdds].ManufacturerId = 0

		
		
		UPDATE [Staging.ActiveFleetYearAdds] SET 
			ManufacturerId = 31 
		WHERE ManufacturerName = 'VAUXHALL' AND ManufacturerId = 0
		
		DECLARE @UNKMANUFACTURER INT
		SET @UNKMANUFACTURER = (SELECT ManufacturerId 
								FROM [Dimension.Manufacturer] 
								WHERE ManufacturerName = 'UNKNOWN')
		
		UPDATE [Staging.ActiveFleetYearAdds] SET 
			ManufacturerId = @UNKMANUFACTURER 
		WHERE ManufacturerId = 0
		
  
END