-- =============================================
-- Author:		Javier
-- Create date: August 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spDBImportSPFleetParse]
	
AS
BEGIN
	UPDATE [Fact.FleetSP] SET TaxCode = '010' , TaxPCT = 0 WHERE CO2 < 120
	UPDATE [Fact.FleetSP] SET TaxCode = '020' , TaxPCT = 4.75 WHERE CO2 >= 120 AND CO2 < 160
	UPDATE [Fact.FleetSP] SET TaxCode = '030' , TaxPCT = 9.75 WHERE CO2 >= 160 AND CO2 < 200
	UPDATE [Fact.FleetSP] SET TaxCode = '040' , TaxPCT = 14.75 WHERE CO2 >= 200 

	UPDATE [Fact.FleetSP] SET 
		[Fact.FleetSP].VehicleId  = [Fact.Vehicles].VehicleId
	FROM [Fact.FleetSP]
	INNER JOIN [Fact.Vehicles] ON
		[Fact.FleetSP].Serial = [Fact.Vehicles].Serial AND [Fact.Vehicles].CountryId = 8
		
		
		
	UPDATE [Fact.FleetTaxReport] SET
	[Fact.FleetTaxReport].ITVSerial = [Fact.FleetSP].ITVSerial
	FROM [Fact.FleetTaxReport]
	INNER JOIN [Fact.FleetSP] on [Fact.FleetTaxReport].Serial = [Fact.FleetSP].Serial 
	WHERE [Fact.FleetTaxReport].ITVSerial IS NULL

	UPDATE [Fact.FleetTaxReport] SET
		[Fact.FleetTaxReport].FuelType = [Fact.FleetSP].FuelType
	FROM [Fact.FleetTaxReport]
	INNER JOIN [Fact.FleetSP] on [Fact.FleetTaxReport].Serial = [Fact.FleetSP].Serial 
	WHERE [Fact.FleetTaxReport].FuelType IS NULL
	
	
	UPDATE [Fact.FleetTaxReport] SET
		FuelType = 'G'
	WHERE 
		FuelType IN ('GASOLINA','GA')

	UPDATE [Fact.FleetTaxReport] SET
		FuelType = 'D'
	WHERE 
		FuelType IN ('DIESEL','GO')
		

	UPDATE [Fact.FleetTaxReport] SET
		[Fact.FleetTaxReport].MSODate = [Fact.FleetSP].MSODate
	FROM [Fact.FleetTaxReport]
	INNER JOIN [Fact.FleetSP] on [Fact.FleetTaxReport].Serial = [Fact.FleetSP].Serial 
	WHERE [Fact.FleetTaxReport].MSODate IS NULL

	UPDATE [Fact.FleetTaxReport] SET
		[Fact.FleetTaxReport].CO2 = [Fact.FleetSP].CO2
	FROM [Fact.FleetTaxReport]
	INNER JOIN [Fact.FleetSP] on [Fact.FleetTaxReport].Serial = [Fact.FleetSP].Serial 
	WHERE [Fact.FleetTaxReport].CO2 IS NULL
	
	UPDATE [Fact.FleetTaxReport] SET
		[Fact.FleetTaxReport].TaxCode = [Fact.FleetSP].TaxCode
	FROM [Fact.FleetTaxReport]
	INNER JOIN [Fact.FleetSP] on [Fact.FleetTaxReport].Serial = [Fact.FleetSP].Serial 
	WHERE [Fact.FleetTaxReport].TaxCode IS NULL


	UPDATE [Fact.FleetTaxReport] SET
		[Fact.FleetTaxReport].TaxPCT = [Fact.FleetSP].TaxPCT
	FROM [Fact.FleetTaxReport]
	INNER JOIN [Fact.FleetSP] on [Fact.FleetTaxReport].Serial = [Fact.FleetSP].Serial 
	WHERE [Fact.FleetTaxReport].TaxPCT IS NULL
	
	UPDATE [Fact.FleetTaxReport] SET
		[Fact.FleetTaxReport].VehicleCode = [Fact.FleetSP].VehicleCode
	FROM [Fact.FleetTaxReport]
	INNER JOIN [Fact.FleetSP] on [Fact.FleetTaxReport].Serial = [Fact.FleetSP].Serial 
	WHERE [Fact.FleetTaxReport].VehicleCode IS NULL
	
	
	UPDATE [Fact.FleetTaxReport] SET
		[Fact.FleetTaxReport].EngineSize = [Fact.FleetSP].EngineSize
	FROM [Fact.FleetTaxReport]
	INNER JOIN [Fact.FleetSP] on [Fact.FleetTaxReport].Serial = [Fact.FleetSP].Serial 
	WHERE [Fact.FleetTaxReport].EngineSize IS NULL
	
	UPDATE [Fact.FleetTaxReport] SET 
		Processed = 1
	WHERE
		RegTaxAmount = 0 --AND (Processed = 0 OR Processed IS NULL)
		
		
		
	UPDATE [Fact.FleetTaxReport] SET
		IsCorrect = 0
	WHERE
		ITVSerial	IS NULL OR 
		FuelType	IS NULL OR 
		CO2			IS NULL OR 
		TaxCode		IS NULL OR 
		TaxPCT		IS NULL OR 
		EngineSize	IS NULL OR
		MSODate		IS NULL OR
		VehicleCode IS NULL
		
	UPDATE [Fact.FleetTaxReport] SET
		IsCorrect = 1
	WHERE
		ITVSerial	IS NOT NULL AND 
		FuelType	IS NOT NULL AND 
		CO2			IS NOT NULL AND 
		TaxCode		IS NOT NULL AND 
		TaxPCT		IS NOT NULL AND 
		EngineSize	IS NOT NULL AND 
		MSODate		IS NOT NULL AND 
		VehicleCode IS NOT NULL 
	
	UPDATE [Fact.FleetTaxReport] SET
		IsExported = 1
	WHERE
		SUBSTRING(VehicleCode,1,2) = '10'
		
	UPDATE [Fact.FleetTaxReport] SET
		IsExported = 0
	WHERE
		SUBSTRING(VehicleCode,1,2) <> '10'
	
END