-- =============================================
-- Author:		Javier
-- Create date: August 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spDBImportSPFleetTransfer]
	
AS
BEGIN
	
	SET NOCOUNT ON;
	
	DELETE FROM [Import.FleetSP] WHERE Serial is null
	
	UPDATE [Import.FleetSP] SET Unit = REPLACE(Unit,'-','')
	
	UPDATE [Import.FleetSP] SET Unit = '00000' + Unit WHERE LEN(Unit) = 5
	UPDATE [Import.FleetSP] SET Unit = '0000'  + Unit WHERE LEN(Unit) = 6
	UPDATE [Import.FleetSP] SET Unit = '000'   + Unit WHERE LEN(Unit) = 7
	UPDATE [Import.FleetSP] SET Unit = '00'    + Unit WHERE LEN(Unit) = 8
	UPDATE [Import.FleetSP] SET Unit = '0'     + Unit WHERE LEN(Unit) = 9
	
	
	MERGE [Fact.Vehicles] WITH (TABLOCK) AS TARGET
		USING 
		(
			SELECT Serial , Unit , 8 AS "CountryId"
			FROM [Import.FleetSP]
			GROUP BY Serial , Unit 
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
	
	MERGE [Fact.FleetSP] AS TARGET
	USING 
		
		(
			SELECT 
				Serial , ITVSerial , CO2 , FuelType , Unit , MSODate , VehicleCode , EngineSize
			FROM [Import.FleetSP] 
			GROUP BY
				Serial , ITVSerial , CO2 , FuelType , Unit , MSODate , VehicleCode , EngineSize
		)
		
	
	AS SOURCE
	ON 
	(
		TARGET.Serial = SOURCE.Serial
	)
	WHEN MATCHED THEN
	UPDATE SET
		TARGET.ITVSerial	= SOURCE.ITVSerial,
		TARGET.CO2			= CONVERT(INT,SOURCE.CO2) ,
		TARGET.FuelType		= SOURCE.FuelType   ,
		TARGET.MSODate		= CONVERT(DATETIME,SOURCE.MSODate,103),
		TARGET.VehicleCode  = SOURCE.VehicleCode,
		TARGET.EngineSize   = SOURCE.EngineSize
	WHEN NOT MATCHED THEN
	INSERT (Serial , ITVSerial , CO2 , FuelType , Unit , MSODate , VehicleCode , EngineSize)
	VALUES (SOURCE.Serial , SOURCE.ITVSerial , CONVERT(INT,SOURCE.CO2) , SOURCE.FuelType , SOURCE.Unit ,
			CONVERT(DATETIME,SOURCE.MSODate,103) , SOURCE.VehicleCode , SOURCE.EngineSize);
	
	
   
END