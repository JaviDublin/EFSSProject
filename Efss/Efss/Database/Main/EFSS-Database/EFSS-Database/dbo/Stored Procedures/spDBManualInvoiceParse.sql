-- =============================================
-- Author:		Javier
-- Create date: September 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spDBManualInvoiceParse]
	
AS
BEGIN
	
	SET NOCOUNT ON;
	
	TRUNCATE TABLE [Staging.ManualInvoice]
	
	INSERT INTO [Staging.ManualInvoice]
	(
		CountryName,
		CompanyName,
		DocumentType,
		InvoiceType,
		InvoiceDate,
		BuyerName,
		BuyerCode,
		Serial,
		Amount,
		TaxCode,
		DescriptionName ,
		ManufacturerCode,
		BuyerAddress1
	)
	
	SELECT
		CountryName,
		CompanyName,
		DocumentType,
		InvoiceType,
		CASE WHEN ISDATE(CONVERT(DATETIME,InvoiceDate,103))= 1 THEN CONVERT(DATETIME,InvoiceDate,103) END ,
		BuyerName,
		BuyerCode,
		Serial,
		CASE WHEN ISNUMERIC(Amount)	= 1 THEN CONVERT(FLOAT,Amount) END,
		TaxCode,
		DescriptionName,
		ManufacturerCode,
		BuyerAddress
	FROM 
		[Import.ManualInvoice]
		
		
	UPDATE [Staging.ManualInvoice] SET
		[Staging.ManualInvoice].CountryId = [Dimension.Countries].CountryId
	FROM 
		[Staging.ManualInvoice]
	INNER JOIN [Dimension.Countries] ON
		[Staging.ManualInvoice].CountryName = [Dimension.Countries].CountryName
	
	UPDATE [Staging.ManualInvoice] SET
		[Staging.ManualInvoice].CompanyId = [Dimension.Companies].CompanyId
	FROM 
		[Staging.ManualInvoice]
	INNER JOIN [Dimension.Companies] ON
		[Staging.ManualInvoice].CountryId   = [Dimension.Companies].CountryId AND
		[Staging.ManualInvoice].CompanyName = [Dimension.Companies].CompanyName
		
	UPDATE [Staging.ManualInvoice] SET
		[Staging.ManualInvoice].TaxCodeId = [Dimension.TaxCodes].TaxCodeId
	FROM [Staging.ManualInvoice]
	INNER JOIN [Dimension.TaxCodes] ON 
		[Staging.ManualInvoice].TaxCode		= [Dimension.TaxCodes].TaxCode AND
		[Staging.ManualInvoice].CountryId	= [Dimension.TaxCodes].CountryId
		
	UPDATE [Staging.ManualInvoice] SET
		[Staging.ManualInvoice].ContactTypeId = [Dimension.ContactTypes].ContactTypeId
	FROM [Staging.ManualInvoice]
	INNER JOIN [Dimension.ContactTypes] ON 
		[Staging.ManualInvoice].CountryId = [Dimension.ContactTypes].CountryId
	AND [Staging.ManualInvoice].CompanyId = [Dimension.ContactTypes].CompanyId

	UPDATE [Staging.ManualInvoice] SET
		[Staging.ManualInvoice].DocumentTypeId = [Dimension.DocumentTypes].DocumentTypeId
	FROM [Staging.ManualInvoice]
	INNER JOIN [Dimension.DocumentTypes] ON
		[Staging.ManualInvoice].DocumentType = [Dimension.DocumentTypes].DocType AND
		[Staging.ManualInvoice].InvoiceType  = [Dimension.DocumentTypes].DocSubType AND
		[Dimension.DocumentTypes].IsManual = 1
		
	UPDATE [Staging.ManualInvoice] SET
		[Staging.ManualInvoice].BuyerId			= [Dimension.Buyers].BuyerId,
		[Staging.ManualInvoice].BuyerCode		= [Dimension.Buyers].BuyerCode,
		[Staging.ManualInvoice].BuyerAddressId	= [Fact.BuyersAddress].BuyerAddressId,
		[Staging.ManualInvoice].BuyerAddress2   = [Fact.BuyersAddress].BuyerAddress2,
		[Staging.ManualInvoice].BuyerAddress3   = [Fact.BuyersAddress].BuyerAddress3,
		[Staging.ManualInvoice].BuyerAddress4   = [Fact.BuyersAddress].BuyerAddress4,
		[Staging.ManualInvoice].BuyerFiscalCode = [Dimension.Buyers].BuyerFiscalCode
	FROM [Staging.ManualInvoice]
	INNER JOIN [Dimension.Buyers] ON 
		[Staging.ManualInvoice].CompanyId = [Dimension.Buyers].CompanyId AND
		[Staging.ManualInvoice].CountryId = [Dimension.Buyers].CountryId AND
		[Staging.ManualInvoice].BuyerName = [Dimension.Buyers].BuyerName AND 
		[Staging.ManualInvoice].ManufacturerCode = [Dimension.Buyers].ManufacturerCode
	INNER JOIN [Fact.BuyersAddress] ON
		[Dimension.Buyers].BuyerId = [Fact.BuyersAddress].BuyerId AND 
		[Staging.ManualInvoice].BuyerAddress1 = [Fact.BuyersAddress].BuyerAddress1
			
	UPDATE [Staging.ManualInvoice] SET
		[Staging.ManualInvoice].VehicleId = [Fact.Vehicles].VehicleId
	FROM [Staging.ManualInvoice] 
	INNER JOIN [Fact.Vehicles] ON
		[Staging.ManualInvoice].Serial		= [Fact.Vehicles].Serial AND
		[Staging.ManualInvoice].CountryId	= [Fact.Vehicles].CountryId
		
	UPDATE [Staging.ManualInvoice] SET
		[Staging.ManualInvoice].ManufacturerName = [Dimension.Manufacturer].ManufacturerName ,
		[Staging.ManualInvoice].ManufacturerId   = [Dimension.Manufacturer].ManufacturerId
	FROM [Staging.ManualInvoice]
	INNER JOIN [Dimension.ManufacturerVision] ON
		[Staging.ManualInvoice].ManufacturerCode = [Dimension.ManufacturerVision].VisionCode
	INNER JOIN [Dimension.Manufacturer] ON
		[Dimension.ManufacturerVision].ManufacturerId = [Dimension.Manufacturer].ManufacturerId
		
	-- MODELS
	--------------
	UPDATE [Staging.ManualInvoice] SET
		[Staging.ManualInvoice].ModelCodeId = [Archive.Sales].ModelCodeId
	FROM [Staging.ManualInvoice]
	INNER JOIN [Archive.Sales] ON 
		[Staging.ManualInvoice].VehicleId = [Archive.Sales].VehicleId AND
		[Staging.ManualInvoice].CompanyId = [Archive.Sales].CompanyId
	WHERE
		[Staging.ManualInvoice].ModelCodeId is NULL
	
	UPDATE [Staging.ManualInvoice] SET
		[Staging.ManualInvoice].ModelId = [Archive.Sales].ModelId
	FROM [Staging.ManualInvoice]
	INNER JOIN [Archive.Sales] ON 
		[Staging.ManualInvoice].VehicleId = [Archive.Sales].VehicleId AND
		[Staging.ManualInvoice].CompanyId = [Archive.Sales].CompanyId
	WHERE
		[Staging.ManualInvoice].ModelId is NULL
	
	UPDATE [Staging.ManualInvoice] SET
		[Staging.ManualInvoice].ModelDetailId = [Archive.Sales].ModelDetailId
	FROM [Staging.ManualInvoice]
	INNER JOIN [Archive.Sales] ON 
		[Staging.ManualInvoice].VehicleId = [Archive.Sales].VehicleId AND
		[Staging.ManualInvoice].CompanyId = [Archive.Sales].CompanyId
	WHERE
		[Staging.ManualInvoice].ModelDetailId is NULL	
	
	
	UPDATE [Staging.ManualInvoice] SET
		[Staging.ManualInvoice].ModelCodeId = [Staging.ActiveFleetDay].ModelCodeId
	FROM [Staging.ManualInvoice]
	INNER JOIN [Staging.ActiveFleetDay] ON 
		[Staging.ManualInvoice].VehicleId = [Staging.ActiveFleetDay].VehicleId AND
		[Staging.ManualInvoice].CompanyId = [Staging.ActiveFleetDay].CompanyId
	WHERE
		[Staging.ManualInvoice].ModelCodeId is NULL
	
	UPDATE [Staging.ManualInvoice] SET
		[Staging.ManualInvoice].ModelId = [Staging.ActiveFleetDay].ModelId
	FROM [Staging.ManualInvoice]
	INNER JOIN [Staging.ActiveFleetDay] ON 
		[Staging.ManualInvoice].VehicleId = [Staging.ActiveFleetDay].VehicleId AND
		[Staging.ManualInvoice].CompanyId = [Staging.ActiveFleetDay].CompanyId
	WHERE
		[Staging.ManualInvoice].ModelId is NULL
	
	UPDATE [Staging.ManualInvoice] SET
		[Staging.ManualInvoice].ModelDetailId = [Staging.ActiveFleetDay].ModelDetailId
	FROM [Staging.ManualInvoice]
	INNER JOIN [Staging.ActiveFleetDay] ON 
		[Staging.ManualInvoice].VehicleId = [Staging.ActiveFleetDay].VehicleId AND
		[Staging.ManualInvoice].CompanyId = [Staging.ActiveFleetDay].CompanyId
	WHERE
		[Staging.ManualInvoice].ModelDetailId is NULL	
		
	
	UPDATE [Staging.ManualInvoice] SET
		[Staging.ManualInvoice].ModelCodeId = [Staging.ActiveFleetMonth].ModelCodeId
	FROM [Staging.ManualInvoice]
	INNER JOIN [Staging.ActiveFleetMonth] ON 
		[Staging.ManualInvoice].VehicleId = [Staging.ActiveFleetMonth].VehicleId AND
		[Staging.ManualInvoice].CompanyId = [Staging.ActiveFleetMonth].CompanyId
	WHERE
		[Staging.ManualInvoice].ModelCodeId is NULL
	
	UPDATE [Staging.ManualInvoice] SET
		[Staging.ManualInvoice].ModelId = [Staging.ActiveFleetMonth].ModelId
	FROM [Staging.ManualInvoice]
	INNER JOIN [Staging.ActiveFleetMonth] ON 
		[Staging.ManualInvoice].VehicleId = [Staging.ActiveFleetMonth].VehicleId AND
		[Staging.ManualInvoice].CompanyId = [Staging.ActiveFleetMonth].CompanyId
	WHERE
		[Staging.ManualInvoice].ModelId is NULL
	
	UPDATE [Staging.ManualInvoice] SET
		[Staging.ManualInvoice].ModelDetailId = [Staging.ActiveFleetMonth].ModelDetailId
	FROM [Staging.ManualInvoice]
	INNER JOIN [Staging.ActiveFleetMonth] ON 
		[Staging.ManualInvoice].VehicleId = [Staging.ActiveFleetMonth].VehicleId AND
		[Staging.ManualInvoice].CompanyId = [Staging.ActiveFleetMonth].CompanyId
	WHERE
		[Staging.ManualInvoice].ModelDetailId is NULL		
	
	
	UPDATE [Staging.ManualInvoice] SET
		[Staging.ManualInvoice].ModelCodeId = [Staging.ActiveFleetYearAdds].ModelCodeId
	FROM [Staging.ManualInvoice]
	INNER JOIN [Staging.ActiveFleetYearAdds] ON 
		[Staging.ManualInvoice].VehicleId = [Staging.ActiveFleetYearAdds].VehicleId AND
		[Staging.ManualInvoice].CompanyId = [Staging.ActiveFleetYearAdds].CompanyId
	WHERE
		[Staging.ManualInvoice].ModelCodeId is NULL
	
	UPDATE [Staging.ManualInvoice] SET
		[Staging.ManualInvoice].ModelId = [Staging.ActiveFleetYearAdds].ModelId
	FROM [Staging.ManualInvoice]
	INNER JOIN [Staging.ActiveFleetYearAdds] ON 
		[Staging.ManualInvoice].VehicleId = [Staging.ActiveFleetYearAdds].VehicleId AND
		[Staging.ManualInvoice].CompanyId = [Staging.ActiveFleetYearAdds].CompanyId
	WHERE
		[Staging.ManualInvoice].ModelId is NULL
	
	UPDATE [Staging.ManualInvoice] SET
		[Staging.ManualInvoice].ModelDetailId = [Staging.ActiveFleetYearAdds].ModelDetailId
	FROM [Staging.ManualInvoice]
	INNER JOIN [Staging.ActiveFleetYearAdds] ON 
		[Staging.ManualInvoice].VehicleId = [Staging.ActiveFleetYearAdds].VehicleId AND
		[Staging.ManualInvoice].CompanyId = [Staging.ActiveFleetYearAdds].CompanyId
	WHERE
		[Staging.ManualInvoice].ModelDetailId is NULL		
	
	
	-- CREATE THE INVOICE NUMBER
	-------------------------------------------------------------------------------------------------------------
	DECLARE @companyId INT
	SET @companyId = (SELECT TOP 1 CompanyId FROM [Staging.ManualInvoice])
	
	DECLARE @DocumentNumber INT
	
	SET @DocumentNumber = 
		(
			SELECT MAX(CONVERT(INT,DocumentNumber))
			FROM [Fact.Documents]
			WHERE DocumentTypeId IN
				(
					SELECT DocumentTypeId 
					FROM [Dimension.DocumentTypes] 
					WHERE IsManual = 1
				)
			AND CompanyId = @companyId)
			
	IF @DocumentNumber IS NULL
	BEGIN
		SET @DocumentNumber = 1
	END
	ELSE
	BEGIN
		SET @DocumentNumber = @DocumentNumber + 1
	END
	
	--
	UPDATE [Staging.ManualInvoice] SET InvoiceNumber =
		STUFF(CONVERT(VARCHAR,@DocumentNumber),1,0,REPLICATE('0',7 - LEN(CONVERT(VARCHAR,@DocumentNumber))))	
		
		
		
	DECLARE @EXTRAID INT
	SET @EXTRAID =
	(
	SELECT 
		TOP 1 ExtrasId 
	FROM [Fact.VehiclesExtraCharges]
	WHERE 
		MileCharge	= 0 AND 
		PlusKM		= 0 AND 
		FuelCharge	= 0 AND
		Damage		= 0 AND 
		SuperCharge = 0 AND 
		HandleFee	= 0 AND 
		AddOn		= 0 AND
		Other1		= 0 AND 
		Other2		= 0 AND 
		Amount5		= 0 AND 
		Amount6		= 0 AND 
		RegTaxAmount = 0
	)
	
	UPDATE [Staging.ManualInvoice] SET ExtrasId = @EXTRAID
	
	UPDATE [Staging.ManualInvoice] SET InvoiceNet = Amount
	
	UPDATE [Staging.ManualInvoice] SET
		[Staging.ManualInvoice].VatPCT = [Dimension.TaxCodes].Vat
	FROM 
		[Staging.ManualInvoice]
	INNER JOIN [Dimension.TaxCodes] ON [Staging.ManualInvoice].TaxCodeId = [Dimension.TaxCodes].TaxCodeId
	
	UPDATE [Staging.ManualInvoice] SET InvoiceVat = 0 WHERE VatPCT = 0
	
	UPDATE [Staging.ManualInvoice] SET InvoiceVat = 
		convert(float,CONVERT(MONEY,ROUND(InvoiceNet * VatPCT / 100,2))) WHERE VatPCT > 0
	
	
	UPDATE [Staging.ManualInvoice] SET InvoiceTotal = InvoiceNet + InvoiceVat
	
	
	MERGE [Fact.Items] WITH (TABLOCK) AS TARGET
		USING 
		(
			SELECT VehicleId  , 1 as "DescriptionTypeId" , InvoiceNet , 
			InvoiceVat , InvoiceTotal , ExtrasId
			FROM [Staging.ManualInvoice]
			GROUP BY VehicleId  , InvoiceNet , InvoiceVat , 
			InvoiceTotal , ExtrasId
		) AS SOURCE
		ON
		(
			TARGET.DescriptionId	 = SOURCE.VehicleId			AND
			TARGET.DescriptionTypeId = SOURCE.DescriptionTypeId AND
			TARGET.Value			 = SOURCE.InvoiceNet		AND
			TARGET.Vat				 = SOURCE.InvoiceVat		AND
			TARGET.Total			 = SOURCE.InvoiceTotal		AND
			TARGET.ExtrasId			 = SOURCE.ExtrasId
			
		)
		WHEN NOT MATCHED BY TARGET THEN
		INSERT 
		(DescriptionId , DescriptionTypeId , ExtrasId , Value , Vat , Total)
		VALUES
		(SOURCE.VehicleId ,  1 , 
		SOURCE.ExtrasId , SOURCE.InvoiceNet , SOURCE.InvoiceVat , SOURCE.InvoiceTotal);
		
	UPDATE [Staging.ManualInvoice] SET
		[Staging.ManualInvoice].ItemId = [Fact.Items].ItemId
	FROM [Staging.ManualInvoice]
	INNER JOIN [Fact.Items] ON 
		[Staging.ManualInvoice].VehicleId		= [Fact.Items].DescriptionId
	AND [Staging.ManualInvoice].ExtrasId		= [Fact.Items].ExtrasId 
	AND [Staging.ManualInvoice].InvoiceNet		= [Fact.Items].Value
	AND [Staging.ManualInvoice].InvoiceVat		= [Fact.Items].Vat
	AND [Staging.ManualInvoice].InvoiceTotal	= [Fact.Items].Total
	
	
	
	MERGE [Fact.Documents] WITH (TABLOCK) AS TARGET
		USING
		(
			SELECT DocumentTypeId , CompanyId , BuyerId , InvoiceNumber 
			FROM [Staging.ManualInvoice]
			GROUP BY DocumentTypeId , CompanyId , BuyerId , InvoiceNumber 
		) AS SOURCE
		ON 
		(
			TARGET.DocumentTypeId	= SOURCE.DocumentTypeId    AND
			TARGET.CompanyId		= SOURCE.CompanyId   AND
			TARGET.BuyerId			= SOURCE.BuyerId   AND
			TARGET.DocumentNumber	= SOURCE.InvoiceNumber 
		)
		WHEN NOT MATCHED BY TARGET THEN
		INSERT 
		 (
			DocumentTypeId , CompanyId , BuyerId , DocumentNumber , LogId , DateCreated
		 )
		 VALUES 
		 (
			SOURCE.DocumentTypeId , SOURCE.CompanyId , SOURCE.BuyerId , SOURCE.InvoiceNumber , 0 , GETDATE()
		  );
	
	UPDATE [Staging.ManualInvoice] SET
		[Staging.ManualInvoice].DocumentId = [Fact.Documents].DocumentId 
	FROM [Staging.ManualInvoice]
	INNER JOIN [Fact.Documents] ON 
		[Staging.ManualInvoice].InvoiceNumber	= [Fact.Documents].DocumentNumber
	AND [Staging.ManualInvoice].BuyerId			= [Fact.Documents].BuyerId
	AND [Staging.ManualInvoice].CompanyId		= [Fact.Documents].CompanyId
	AND [Staging.ManualInvoice].DocumentTypeId	= [Fact.Documents].DocumentTypeId
	WHERE 
		[Staging.ManualInvoice].DocumentId IS NULL
	
	
	MERGE  [Fact.DocumentItems] WITH (TABLOCK) AS TARGET
		USING
		(
			SELECT DocumentId , ItemId , CompanyId
			FROM [Staging.ManualInvoice]
			GROUP BY DocumentId , ItemId , CompanyId
		) AS SOURCE
		ON 
		(
			TARGET.DocumentId	= SOURCE.DocumentId AND
			TARGET.ItemId		= SOURCE.ItemId AND
			TARGET.CompanyId	= SOURCE.CompanyId 
		)
		WHEN NOT MATCHED BY TARGET THEN
		INSERT 
			(
				DocumentId , ItemId , CompanyId
			)
		VALUES 
			(
				SOURCE.DocumentId , SOURCE.ItemId , SOURCE.CompanyId
			);
			
	UPDATE [Staging.ManualInvoice] SET
		[Staging.ManualInvoice].DocItemId = [Fact.DocumentItems].DocItemId
	FROM [Staging.ManualInvoice] 
	INNER JOIN [Fact.DocumentItems] ON 
		[Staging.ManualInvoice].DocumentId = [Fact.DocumentItems].DocumentId 
	AND [Staging.ManualInvoice].ItemId	 = [Fact.DocumentItems].ItemId 
	AND [Staging.ManualInvoice].CompanyId  = [Fact.DocumentItems].CompanyId 
	WHERE [Staging.ManualInvoice].DocItemId IS NULL;		


	INSERT INTO [Archive.ManualInvoice]
	(
		CountryName,
		CompanyName,
		DocumentType,
		InvoiceType,
		InvoiceDate,
		BuyerName,
		BuyerCode,
		Serial,
		Amount,
		TaxCode,
		DescriptionName,
		CompanyId,
		CountryId,
		TaxCodeId,
		DocumentTypeId,
		ContactTypeId,
		VehicleId,
		ModelCodeId,
		ModelId,
		ModelDetailId,
		BuyerId,
		ManufacturerName,
		ManufacturerId,
		DocumentId,
		ItemId,
		DocItemId,
		BuyerAddressId,
		BuyerAddress1,
		BuyerAddress2,
		BuyerAddress3,
		BuyerAddress4,
		BuyerFiscalCode,
		ManufacturerCode,
		InvoiceNumber,
		ExtrasId,
		InvoiceNet,
		InvoiceVat,
		InvoiceTotal,
		VatPCT
	)


	SELECT
		CountryName,
		CompanyName,
		DocumentType,
		InvoiceType,
		InvoiceDate,
		BuyerName,
		BuyerCode,
		Serial,
		Amount,
		TaxCode,
		DescriptionName,
		CompanyId,
		CountryId,
		TaxCodeId,
		DocumentTypeId,
		ContactTypeId,
		VehicleId,
		ModelCodeId,
		ModelId,
		ModelDetailId,
		BuyerId,
		ManufacturerName,
		ManufacturerId,
		DocumentId,
		ItemId,
		DocItemId,
		BuyerAddressId,
		BuyerAddress1,
		BuyerAddress2,
		BuyerAddress3,
		BuyerAddress4,
		BuyerFiscalCode,
		ManufacturerCode,
		InvoiceNumber,
		ExtrasId,
		InvoiceNet,
		InvoiceVat,
		InvoiceTotal,
		VatPCT
	FROM  [Staging.ManualInvoice]


    
END