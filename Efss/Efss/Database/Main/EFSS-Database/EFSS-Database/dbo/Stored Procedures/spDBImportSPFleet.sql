-- =============================================
-- Author:		Javier
-- Create date: August 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spDBImportSPFleet]
	@Serial				VARCHAR	(50),
	@ITVSerial			VARCHAR	(50),
	@CO2				VARCHAR	(50),
	@msoDate			VARCHAR (50),
	@fuelType			VARCHAR (50),
	@unit				VARCHAR (50),
	@vehicleCode		VARCHAR (10),
	@engineSize			VARCHAR (20)
	
	
AS
BEGIN

	SET NOCOUNT ON;
	
	INSERT INTO [Import.FleetSP]
			(Serial , ITVSerial , CO2 , MSODate , FuelType , Unit , VehicleCode , EngineSize)
		VALUES
		(	@Serial   ,
			@ITVSerial,
			@CO2      ,
			@msoDate  ,
			@fuelType ,
			@unit	  ,
			@vehicleCode ,
			@engineSize
		)
	
	
  
END