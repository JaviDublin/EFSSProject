-- =============================================
-- Author:		Javier
-- Create date: July 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spDBImportSalesReportTax]
	
AS
BEGIN
	
	SET NOCOUNT ON;

    MERGE [Fact.FleetTaxReport] AS TARGET
	USING
	(
		SELECT 
			CompanyId , Serial , Plate ,  Unit , ModelDetailId , RegTaxAmount , BuyerId , VehicleId , LogId ,
			InvoiceDate , Mileage , InvoiceNet  , SaleDate , SaleDocumentNumber , ManufacturerName , InvoiceNumber
		FROM [Staging.SalesOR]
		WHERE CompanyCode = 'SP'
	
	) AS SOURCE

	ON
	(
		TARGET.CompanyId	 = SOURCE.CompanyId AND
		TARGET.Plate		 = SOURCE.Plate AND
		TARGET.SaleDocumentNumber = SOURCE.SaleDocumentNumber AND
		TARGET.ModelDetailId = SOURCE.ModelDetailId AND
		TARGET.RegTaxAmount  = SOURCE.RegTaxAmount
		
	)
	WHEN NOT MATCHED THEN
	INSERT 
	(
		CompanyId , Serial , Plate ,  Unit , ModelDetailId , RegTaxAmount , BuyerId , VehicleId , LogId ,
			InvoiceDate , Mileage , InvoiceNet  , SaleDate , SaleDocumentNumber , ManufacturerName , InvoiceNumber
	)
	VALUES
	(
		SOURCE.CompanyId , SOURCE.Serial , SOURCE.Plate ,  SOURCE.Unit , SOURCE.ModelDetailId , 
		SOURCE.RegTaxAmount , SOURCE.BuyerId , SOURCE.VehicleId , SOURCE.LogId ,
		SOURCE.InvoiceDate , SOURCE.Mileage , SOURCE.InvoiceNet  , SOURCE.SaleDate , SOURCE.SaleDocumentNumber ,
		SOURCE.ManufacturerName , SOURCE.InvoiceNumber
	);

	UPDATE [Fact.FleetTaxReport] SET
		[Fact.FleetTaxReport].ManufacturerId = [Dimension.Manufacturer].ManufacturerId
	FROM 
		[Fact.FleetTaxReport]
	INNER JOIN [Dimension.Manufacturer] ON 
		[Fact.FleetTaxReport].ManufacturerName = [Dimension.Manufacturer].ManufacturerName
	WHERE 
		[Fact.FleetTaxReport].ManufacturerId IS NULL	
		
	UPDATE [Fact.FleetTaxReport] SET
		[Fact.FleetTaxReport].ManufacturerId = [Dimension.ModelDetails].ManufacturerId
	FROM [Fact.FleetTaxReport]
	INNER JOIN [Dimension.ModelDetails] ON [Fact.FleetTaxReport].ModelDetailId = [Dimension.ModelDetails].ModelDetailId

	UPDATE [Fact.FleetTaxReport] SET Processed = 0 WHERE Processed IS NULL
	
	UPDATE [Fact.FleetTaxReport] SET Processed = 1 WHERE RegTaxAmount = 0
	
	UPDATE [Fact.FleetTaxReport] SET IsCorrect = 1 WHERE IsCorrect IS NULL
	
	UPDATE [Fact.FleetTaxReport] SET 
		BankRegCode = '28600000000000000000000000000 20130883250200085877000000000000'
	WHERE RegTaxAmount = 0 AND BankRegCode IS NULL
	
	UPDATE [Fact.FleetTaxReport] SET
		[Fact.FleetTaxReport].CO2			= [Fact.FleetSP].CO2 
	FROM [Fact.FleetTaxReport]
	INNER JOIN [Fact.FleetSP] ON 
		[Fact.FleetTaxReport].Serial = [Fact.FleetSP].Serial
	WHERE [Fact.FleetTaxReport].CO2 IS NULL
	
	UPDATE [Fact.FleetTaxReport] SET
		[Fact.FleetTaxReport].ITVSerial		= [Fact.FleetSP].ITVSerial 
	FROM [Fact.FleetTaxReport]
	INNER JOIN [Fact.FleetSP] ON 
		[Fact.FleetTaxReport].Serial = [Fact.FleetSP].Serial
	WHERE [Fact.FleetTaxReport].ITVSerial IS NULL
	
	UPDATE [Fact.FleetTaxReport] SET
		[Fact.FleetTaxReport].FuelType		= [Fact.FleetSP].FuelType 
	FROM [Fact.FleetTaxReport]
	INNER JOIN [Fact.FleetSP] ON 
		[Fact.FleetTaxReport].Serial = [Fact.FleetSP].Serial
	WHERE [Fact.FleetTaxReport].FuelType IS NULL
	
	UPDATE [Fact.FleetTaxReport] SET
		[Fact.FleetTaxReport].TaxCode		= [Fact.FleetSP].TaxCode
	FROM [Fact.FleetTaxReport]
	INNER JOIN [Fact.FleetSP] ON 
		[Fact.FleetTaxReport].Serial = [Fact.FleetSP].Serial
	WHERE [Fact.FleetTaxReport].TaxCode IS NULL
	
	UPDATE [Fact.FleetTaxReport] SET
		[Fact.FleetTaxReport].TaxPCT		= [Fact.FleetSP].TaxPCT
	FROM [Fact.FleetTaxReport]
	INNER JOIN [Fact.FleetSP] ON 
		[Fact.FleetTaxReport].Serial = [Fact.FleetSP].Serial
	WHERE [Fact.FleetTaxReport].TaxPCT IS NULL
	
	UPDATE [Fact.FleetTaxReport] SET
		[Fact.FleetTaxReport].VehicleCode	= [Fact.FleetSP].VehicleCode
	FROM [Fact.FleetTaxReport]
	INNER JOIN [Fact.FleetSP] ON 
		[Fact.FleetTaxReport].Serial = [Fact.FleetSP].Serial
	WHERE [Fact.FleetTaxReport].VehicleCode IS NULL
	
	UPDATE [Fact.FleetTaxReport] SET
		[Fact.FleetTaxReport].MSODate		= [Fact.FleetSP].MSODate
	FROM [Fact.FleetTaxReport]
	INNER JOIN [Fact.FleetSP] ON 
		[Fact.FleetTaxReport].Serial = [Fact.FleetSP].Serial
	WHERE [Fact.FleetTaxReport].MSODate IS NULL
	
	UPDATE [Fact.FleetTaxReport] SET
		[Fact.FleetTaxReport].EngineSize	= [Fact.FleetSP].EngineSize 
	FROM [Fact.FleetTaxReport]
	INNER JOIN [Fact.FleetSP] ON 
		[Fact.FleetTaxReport].Serial = [Fact.FleetSP].Serial
	WHERE [Fact.FleetTaxReport].EngineSize IS NULL
	
	UPDATE [Fact.FleetTaxReport] SET
		[Fact.FleetTaxReport].MSODate = [Archive.Sales].MSODate
	FROM [Fact.FleetTaxReport]
	INNER JOIN [Archive.Sales] ON
		[Fact.FleetTaxReport].Serial = [Archive.Sales].Serial AND [Archive.Sales].CompanyCode = 'SP'
	WHERE 
		[Fact.FleetTaxReport].MSODate IS NULL
	
	UPDATE [Fact.FleetTaxReport] SET
		FuelType = 'G'
	WHERE 
		FuelType IN ('GASOLINA','GA')

	UPDATE [Fact.FleetTaxReport] SET
		FuelType = 'D'
	WHERE 
		FuelType IN ('DIESEL','GO')
	
	UPDATE 	[Fact.FleetTaxReport] SET
		[Fact.FleetTaxReport].FileDate = [Application.FileLog].DateLog
	FROM [Fact.FleetTaxReport]
		INNER JOIN [Application.FileLog] ON [Fact.FleetTaxReport].LogId = [Application.FileLog].LogId
	
	

	
	
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
	
	
	
	update [Fact.FleetTaxReport] set 
		CO2 = fsp.CO2 
	from [Fact.FleetTaxReport] ftr
	inner join [Fact.FleetSP] fsp on ftr.Serial = fsp.Serial
	where ftr.CO2 <> fsp.CO2 and fsp.CO2 is not null

	--UPDATE [Fact.FleetTaxReport] SET 
	--	Processed = 1
	--WHERE
	--	RegTaxAmount = 0 AND (Processed = 0 OR Processed IS NULL)
	
END