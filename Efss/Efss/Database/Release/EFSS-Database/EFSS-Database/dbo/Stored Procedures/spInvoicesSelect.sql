-- =============================================
-- Author:		Javier
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spInvoicesSelect]
		@buyerId int = null,
		@documentId int = null,
		@date varchar(30) = null
AS
BEGIN
	
	SELECT 
	[Fact.Documents].DocumentId					, 
	[Dimension.DocumentTypes].DocType			AS 'DOCUMENT_TYPE',
	[Dimension.DocumentTypes].DocSubType		AS 'DOCUMENT_SUB_TYPE',
	[Fact.Documents].CompanyId					,  
	[Dimension.Companies].CompanyName			AS 'COMPANY_NAME',
	[Dimension.Companies].CompanyFiscalCode		AS 'COMPANY_FISCAL_CODE',
	[Dimension.Companies].CompanyCode			AS 'COMPANY_CODE',
	[Dimension.CompanyAddress].Address1			AS 'COMPANY_ADDRESS_1',
	[Dimension.CompanyAddress].Address2			AS 'COMPANY_ADDRESS_2',
	[Dimension.CompanyAddress].Address3			AS 'COMPANY_ADDRESS_3',
	[Dimension.CompanyAddress].Address4			AS 'COMPANY_ADDRESS_4',
	[Dimension.CompanyAddress].Address5			AS 'COMPANY_ADDRESS_5',
	[Dimension.CompanyAddress].Address6			AS 'COMPANY_ADDRESS_6',
	[Dimension.CompanyAddress].Address7			AS 'COMPANY_ADDRESS_7',
	[Dimension.CompanyAddress].Address8			AS 'COMPANY_ADDRESS_8',
	[Dimension.CompanyAddress].Address9			AS 'COMPANY_ADDRESS_9',
	[Dimension.CompanyAddress].Address10		AS 'COMPANY_ADDRESS_10',
	[Dimension.CompanyAddress].Address11		AS 'COMPANY_ADDRESS_11',
	[Dimension.CompanyAddress].Address12		AS 'COMPANY_ADDRESS_12',
	[Dimension.Buyers].BuyerId					,
	[Dimension.Buyers].BuyerName				AS 'BUYER_NAME',
	[Dimension.Buyers].BuyerCode				AS 'BUYER_CODE',
	[Dimension.Buyers].BuyerFiscalCode			AS 'BUYER_FISCAL_CODE',
	[Dimension.Buyers].BuyerTaxCode				AS 'BUYER_TAX_CODE',
	[Fact.BuyersAddress].BuyerAddress1			AS 'BUYER_ADDRESS_1',
	[Fact.BuyersAddress].BuyerAddress2			AS 'BUYER_ADDRESS_2',
	[Fact.BuyersAddress].BuyerAddress3			AS 'BUYER_ADDRESS_3',
	[Fact.BuyersAddress].BuyerAddress4			AS 'BUYER_ADDRESS_4',
	[Fact.BuyersAddress].BuyerAddress5			AS 'BUYER_ADDRESS_5',
	[Fact.BuyersAddress].BuyerAddress6			AS 'BUYER_ADDRESS_6',
	[Fact.Vehicles].Serial						AS 'VEHICLE_SERIAL',
	[Archive.Sales].Plate						AS 'VEHICLE_PLATE',
	CONVERT(VARCHAR,
		CONVERT(INT,
	[Fact.Vehicles].Unit))						AS 'VEHICLE_UNIT' ,
	
	[Fact.Items].Value						AS 'INVOICE_NET',

	[Fact.Items].Vat							AS 'INVOICE_VAT',	
	
	[Fact.Items].Total							AS 'INVOICE_TOTAL',
	[Dimension.Manufacturer].ManufacturerName	AS 'MANUFACTURER_NAME',
	[Dimension.ModelDetails].ModelDescription	AS 'MODEL_DESCRIPTION',
	CONVERT(VARCHAR(11),
	[Archive.Sales].InServiceDate,103)			AS 'IN_SERVICE_DATE',
	CONVERT(VARCHAR(11),
	[Archive.Sales].OutServiceDate,103)			AS 'OUT_SERVICE_DATE',
	CONVERT(VARCHAR(11),
	[Archive.Sales].MSODate,103)				AS 'MSO_DATE',
	CONVERT(VARCHAR,
	[Dimension.Countries].CountryVat) + '%'		AS 'VAT_PCT' ,
	[Fact.Documents].DocumentNumber				AS 'DOCUMENT_NUMBER',
	[Fact.VehiclesExtraCharges].ExtrasId,
	[Fact.VehiclesExtraCharges].SuperCharge		AS 'SUPER_CHARGE',
	[Fact.VehiclesExtraCharges].RegTaxAmount	AS 'REG_TAX_AMOUNT',
	[Fact.VehiclesExtraCharges].PlusKM			AS 'PLUS_KM',	
	[Fact.VehiclesExtraCharges].MileCharge		AS 'MILE_CHARGE',
	[Fact.VehiclesExtraCharges].Damage			AS 'DAMAGE',	
	[Fact.VehiclesExtraCharges].Amount5			AS 'AMOUNT_5',
	[Fact.VehiclesExtraCharges].AddOn			AS 'ADD_ON',
	[Fact.VehiclesExtraCharges].Amount6			AS 'AMOUNT_6',
	--[Fact.VehiclesExtraCharges].Amount7			AS 'AMOUNT_7',
	[Fact.VehiclesExtraCharges].FuelCharge		AS 'FUEL_CHARGE',
	[Fact.VehiclesExtraCharges].HandleFee		AS 'HANDLE_FEE',
	[Fact.VehiclesExtraCharges].Other1			AS 'OTHER_1',
	[Fact.VehiclesExtraCharges].Other2			AS 'OTHER_2',
	[Archive.Sales].CapitalCost				AS 'CAPITAL_COST',
	[Archive.Sales].BookValue					AS 'BOOK_VALUE',
	LEFT(
	CONVERT(CHAR(14),
	CAST([Archive.Sales].BuyBackCap AS MONEY),1),14)		
												AS 'BUYBACK_CAP' ,
	[Archive.Sales].Depreciation				AS 'DEPRECIATION',
	CONVERT(VARCHAR,
	[Archive.Sales].Mileage)					AS 'MILEAGE',
	CONVERT(VARCHAR,
	DATEDIFF(DAY,[Archive.Sales].InServiceDate,[Archive.Sales].OutServiceDate))
												AS 'DAYS_IN_SERVICE',
	CONVERT(VARCHAR,
	DATEDIFF(DAY,[Archive.Sales].MSODate,[Archive.Sales].OutServiceDate))	
												AS 'DAYS_MSO'	,
	CONVERT(VARCHAR,
	[Fact.VehiclesExtraCharges].SuperCharge	+ 
	[Fact.VehiclesExtraCharges].HandleFee)		AS 'EXTRAS_TOTAL',
	CONVERT(VARCHAR(11),GETDATE(),104)			AS 'TODAY'		 ,
	'RV ' +
	CONVERT(
	VARCHAR,
	ROUND((
	CONVERT(FLOAT,[Archive.Sales].BookValue)/
	CONVERT(FLOAT,[Archive.Sales].BuyBackCap))*100,1)) + ' %' 
												AS 'INVOICE_DET',
											
	[Archive.Sales].TransferFees				AS 'TRANSFER_FEES',
	
	[Archive.Sales].TransferFeesNoVat			AS 'TRANSFER_FEES_NO_VAT',
	
	[Fact.Items].Value +
	[Archive.Sales].TransferFees				AS 'NET_PLUS_FEE',
	
	[Archive.Sales].OriginalBPM				AS 'ORIGINAL_BPM',
	[Archive.Sales].CalcVatAmortized			AS 'CALC_VAT_AMT',
	[Archive.Sales].Unamortized				AS 'UN_AMT'	,

	[Archive.Sales].CalcVatAmortized +
	[Archive.Sales].Unamortized			    AS 'CALC_PLUS_UMT',
	CONVERT(VARCHAR,
	[Archive.Sales].InvoiceDate,103)			AS 'INVOICE_DATE'
	FROM [Fact.DocumentItems]
	INNER JOIN [Fact.Documents]				ON
					[Fact.DocumentItems].DocumentId = [Fact.Documents].DocumentId
	INNER JOIN [Dimension.DocumentTypes]	ON 
					[Fact.Documents].DocumentTypeId = [Dimension.DocumentTypes].DocumentTypeId
	INNER JOIN [Dimension.Companies]		ON 
					[Fact.Documents].CompanyId = [Dimension.Companies].CompanyId
	INNER JOIN [Dimension.Countries]		ON
					[Dimension.Companies].CountryId = [Dimension.Countries].CountryId	
	INNER JOIN [Dimension.CompanyAddress]	ON 
					[Fact.Documents].CompanyId = [Dimension.CompanyAddress].CompanyId
	INNER JOIN [Dimension.Buyers]			ON 
					[Fact.Documents].BuyerId = [Dimension.Buyers].BuyerId
	INNER JOIN [Dimension.ContactTypes]		ON 
					[Fact.Documents].CompanyId = [Dimension.ContactTypes].CompanyId
	INNER JOIN [Fact.BuyersAddress]			ON
					[Fact.Documents].BuyerId = [Fact.BuyersAddress].BuyerId
				AND [Fact.BuyersAddress].ContactTypeId = [Dimension.ContactTypes].ContactTypeId
	INNER JOIN [Fact.Items]					ON
					[Fact.DocumentItems].ItemId =  [Fact.Items].ItemId
	INNER JOIN [Fact.Vehicles]				ON
					[Fact.Items].DescriptionId = [Fact.Vehicles].VehicleId
	INNER JOIN [Fact.VehiclesExtraCharges]	ON
					[Fact.Items].ExtrasId = [Fact.VehiclesExtraCharges].ExtrasId	
	INNER JOIN [Archive.Sales]			ON
					[Fact.DocumentItems].DocumentId = [Archive.Sales].DocumentId
				AND [Fact.DocumentItems].ItemId  = [Archive.Sales].ItemId
	INNER JOIN [Dimension.ModelDetails]		ON
					[Archive.Sales].ModelDetailId = [Dimension.ModelDetails].ModelDetailId
	INNER JOIN [Dimension.Manufacturer]		ON
					[Dimension.ModelDetails].ManufacturerId = [Dimension.Manufacturer].ManufacturerId
	
				
	WHERE [Fact.DocumentItems].DocumentId  = @documentId
	
END