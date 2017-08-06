-- =============================================
-- Author:		Javier
-- Create date: May 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spSalesReportFileToExcel]
	@countryId			INT			= NULL,
	@companyId			INT			= NULL,
	@buyerId			INT			= NULL,
	@fileDate			VARCHAR(50) = NULL,
	@invoiceDate		VARCHAR(50)	= NULL,
	@documentType		VARCHAR(50) = NULL,
	@documentSubType	VARCHAR(50) = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @TABLE_OUTPUT TABLE
	(
	COMPANY_CODE		VARCHAR(20)		,	VEHICLE_SERIAL			VARCHAR(50)	, 
	VEHICLE_PLATE		VARCHAR(20)		,	VEHICLE_UNIT			VARCHAR(20)	,
	COMPANY_NAME		VARCHAR(255)	,	COMPANY_FISCAL_CODE		VARCHAR(100),
	COMPANY_ADDRESS_1	VARCHAR(255)	,	COMPANY_ADDRESS_2		VARCHAR(255),
	COMPANY_ADDRESS_3	VARCHAR(255)	,	COMPANY_ADDRESS_4		VARCHAR(255),
	COMPANY_ADDRESS_5	VARCHAR(255)	,	COMPANY_ADDRESS_6		VARCHAR(255),
	COMPANY_ADDRESS_7	VARCHAR(255)	,	COMPANY_ADDRESS_8		VARCHAR(255),
	COMPANY_ADDRESS_9	VARCHAR(255)	,	COMPANY_ADDRESS_10		VARCHAR(255),
	COMPANY_ADDRESS_11	VARCHAR(255)	,	COMPANY_ADDRESS_12		VARCHAR(255),
	BUYER_ID			INT				,	BUYER_NAME				VARCHAR(500),
	BUYER_CODE			VARCHAR(10)		,	BUYER_FISCAL_CODE		VARCHAR(50)	,
	BUYER_TAX_CODE		VARCHAR(50)		,	BUYER_ADDRESS_1			VARCHAR(255),
	BUYER_ADDRESS_2		VARCHAR(255)	,	BUYER_ADDRESS_3			VARCHAR(255),
	BUYER_ADDRESS_4		VARCHAR(255)	,	BUYER_ADDRESS_5			VARCHAR(255),
	BUYER_ADDRESS_6		VARCHAR(255)	,	DOCUMENT_NUMBER			VARCHAR(50)	,
	INVOICE_NET			FLOAT			,	INVOICE_VAT				FLOAT		,
	INVOICE_TOTAL		FLOAT			,	IN_SERVICE_DATE			VARCHAR(11)	,
	OUT_SERVICE_DATE	VARCHAR(11)		,	MSO_DATE				VARCHAR(11)	,
	DOCUMENT_TYPE		VARCHAR(50)		,	DOCUMENT_SUB_TYPE		VARCHAR(50)	,
	MANUFACTURER_NAME	VARCHAR(50)		,	MODEL_DESCRIPTION		VARCHAR(255),
	VAT_PCT				VARCHAR(50)		,	SUPER_CHARGE			FLOAT		,
	REG_TAX_AMOUNT		FLOAT			,	PLUS_KM					FLOAT		,
	MILE_CHARGE			FLOAT			,	DAMAGE					FLOAT		,
	AMOUNT_5			FLOAT			,	ADD_ON					FLOAT		,
	AMOUNT_6			FLOAT			,	AMOUNT_7				VARCHAR(200),
	FUEL_CHARGE			FLOAT			,	HANDLE_FEE				FLOAT		,
	OTHER_1				FLOAT			,	OTHER_2					FLOAT		,
	CAPITAL_COST		FLOAT			,	BOOK_VALUE				FLOAT		,
	BUYBACK_CAP			CHAR(14)		,	DEPRECIATION			FLOAT		,
	MILEAGE				FLOAT			,	DAYS_IN_SERVICE			INT			,
	DAYS_MSO			INT				,	EXTRAS_TOTAL			FLOAT		,
	TODAY				VARCHAR(11)		,	INVOICE_DET				VARCHAR(50)	,
	TRANSFER_FEES		FLOAT			,	TRANSFER_FEES_NO_VAT	FLOAT		,
	NET_PLUS_FEE		FLOAT			,	ORIGINAL_BPM			FLOAT		,
	CALC_VAT_AMT		FLOAT			,	UN_AMT					FLOAT		,
	CALC_PLUS_UMT		FLOAT			,	INVOICE_DATE			VARCHAR(20))


	DECLARE @dateFile DATETIME
	SET @dateFile = CONVERT(DATETIME,@fileDate,103)
	
	DECLARE @dateInvoice DATETIME
	SET @dateInvoice = CONVERT(DATETIME,@invoiceDate,103)

	DECLARE @FileIdOR INT,
			@FileIdCN INT
			
	SET @FileIdOR = 
		(
			SELECT 
				FileId 
			FROM 
				[Application.Files] 
			WHERE 
				FileCode = 'FSROR'
		)
	
	SET @FileIdCN = 
		(
			SELECT 
				FileId 
			FROM 
				[Application.Files] 
			WHERE 
				FileCode = 'FSRCN'
		)
   
	DECLARE @LogIdOR INT,
			@LogIdCN INT
			
	SET @LogIdOR = 
		(	
			SELECT 
				MAX(LogId) 
			FROM 
				[Application.FileLog] 
			WHERE 
					CONVERT(VARCHAR(11),DateLog,103) = CONVERT(VARCHAR(11),@dateFile,103)
				AND FileId = @FileIdOR
		)
	
	SET @LogIdCN =
		(
			SELECT
				MAX(LogId)
			FROM
				[Application.FileLog]
			WHERE 
					CONVERT(VARCHAR(11),DateLog,103) = CONVERT(VARCHAR(11),@dateFile,103)
				AND FileId = @FileIdCN
		)
	
	
	IF @LogIdOR IS NULL BEGIN SET @LogIdOR = 0 END
	IF @LogIdCN IS NULL BEGIN SET @LogIdCN = 0 END
	
	IF @documentType = 'INVOICE'
	BEGIN
		INSERT INTO @TABLE_OUTPUT
		SELECT 
		[Archive.Sales].CompanyCode , 
		[Archive.Sales].Serial , 
		[Archive.Sales].Plate , 
		[Archive.Sales].Unit ,
		[Dimension.Companies].CompanyName ,
		[Dimension.Companies].CompanyFiscalCode,
		[Dimension.CompanyAddress].Address1,
		[Dimension.CompanyAddress].Address2,
		[Dimension.CompanyAddress].Address3,
		[Dimension.CompanyAddress].Address4,
		[Dimension.CompanyAddress].Address5,
		[Dimension.CompanyAddress].Address6,
		[Dimension.CompanyAddress].Address7,
		[Dimension.CompanyAddress].Address8,
		[Dimension.CompanyAddress].Address9,
		[Dimension.CompanyAddress].Address10,
		[Dimension.CompanyAddress].Address11,
		[Dimension.CompanyAddress].Address12,
		[Dimension.Buyers].BuyerId,
		[Dimension.Buyers].BuyerName,
		[Dimension.Buyers].BuyerCode,
		[Dimension.Buyers].BuyerFiscalCode,
		[Dimension.Buyers].BuyerTaxCode	,
		[Fact.BuyersAddress].BuyerAddress1,
		[Fact.BuyersAddress].BuyerAddress2,
		[Fact.BuyersAddress].BuyerAddress3,
		[Fact.BuyersAddress].BuyerAddress4,
		[Fact.BuyersAddress].BuyerAddress5,
		[Fact.BuyersAddress].BuyerAddress6,
		[Archive.Sales].InvoiceNumber,
		[Archive.Sales].InvoiceNet,
		[Archive.Sales].InvoiceVat,	
		[Archive.Sales].InvoiceTotal,
		CONVERT(VARCHAR(11),
		[Archive.Sales].InServiceDate,103),
		CONVERT(VARCHAR(11),
		[Archive.Sales].OutServiceDate,103),
		CONVERT(VARCHAR(11),
		[Archive.Sales].MSODate,103) ,
		[Dimension.DocumentTypes].DocType,
		[Dimension.DocumentTypes].DocSubType,
		[Dimension.Manufacturer].ManufacturerName,
		[Dimension.ModelDetails].ModelDescription,
		
		CONVERT(VARCHAR,
		[Dimension.Countries].CountryVat) + '%',
		[Archive.Sales].SuperCharge,
		[Archive.Sales].RegTaxAmount,
		[Archive.Sales].PlusKM,	
		[Archive.Sales].MileCharge,
		[Archive.Sales].Damage,	
		[Archive.Sales].Amount5,
		[Archive.Sales].AddOn,
		[Archive.Sales].Amount6,
		[Archive.Sales].Amount7,
		[Archive.Sales].FuelCharge,
		[Archive.Sales].HandleFee,
		[Archive.Sales].Other1,
		[Archive.Sales].Other2,
		[Archive.Sales].CapitalCost,
		[Archive.Sales].BookValue,
		LEFT(CONVERT(CHAR(14),CAST([Archive.Sales].BuyBackCap AS MONEY),1),14),
		[Archive.Sales].Depreciation,
		CONVERT(VARCHAR,[Archive.Sales].Mileage),
		CONVERT(VARCHAR,DATEDIFF(DAY,[Archive.Sales].InServiceDate,[Archive.Sales].OutServiceDate)),
		CONVERT(VARCHAR,DATEDIFF(DAY,[Archive.Sales].MSODate,[Archive.Sales].OutServiceDate)),
		CONVERT(VARCHAR,
		[Archive.Sales].SuperCharge	+ 
		[Archive.Sales].HandleFee),
		CONVERT(VARCHAR(11),GETDATE(),104),
		'RV ' +
		
		CASE WHEN CONVERT(FLOAT,[Archive.Sales].BuyBackCap) = 0 THEN '0' ELSE
		CONVERT(VARCHAR,ROUND(
		(
		CONVERT(FLOAT,[Archive.Sales].BookValue)/
		CONVERT(FLOAT,[Archive.Sales].BuyBackCap)
		)
		*100,1)) 
		END
		+ ' %',									
		[Archive.Sales].TransferFees,
		[Archive.Sales].TransferFeesNoVat,
		[Archive.Sales].InvoiceNet + [Archive.Sales].TransferFees,
		[Archive.Sales].OriginalBPM,
		[Archive.Sales].CalcVatAmortized,
		[Archive.Sales].Unamortized,
		[Archive.Sales].CalcVatAmortized + [Archive.Sales].Unamortized,
		CONVERT(VARCHAR(11),[Archive.Sales].InvoiceDate,103)
		
	
		FROM [Archive.Sales]
		INNER JOIN [Dimension.Companies]		ON 
			[Archive.Sales].CompanyId	= [Dimension.Companies].CompanyId
		INNER JOIN [Dimension.CompanyAddress]	ON
			[Archive.Sales].CompanyId	= [Dimension.CompanyAddress].CompanyId	
		INNER JOIN [Dimension.Buyers]			ON
			[Archive.Sales].BuyerId	= [Dimension.Buyers].BuyerId
		INNER JOIN [Fact.BuyersAddress]			ON
			[Archive.Sales].BuyerId =	[Fact.BuyersAddress].BuyerId
			AND [Archive.Sales].ContactTypeId = [Fact.BuyersAddress].ContactTypeId
		INNER JOIN [Dimension.ModelDetails]		ON
					[Archive.Sales].ModelDetailId = [Dimension.ModelDetails].ModelDetailId
		INNER JOIN [Dimension.Manufacturer]		ON
					[Dimension.ModelDetails].ManufacturerId = [Dimension.Manufacturer].ManufacturerId
		INNER JOIN [Dimension.DocumentTypes]	ON 
					[Archive.Sales].DocumentTypeId = [Dimension.DocumentTypes].DocumentTypeId
		INNER JOIN [Dimension.Countries]		ON
					[Archive.Sales].CountryId = [Dimension.Countries].CountryId
		WHERE 
		[Archive.Sales].LogId = @LogIdOR 
		AND [Archive.Sales].CountryId = @countryId
		AND ((@buyerId		IS NULL) OR ([Archive.Sales].BuyerId		= @buyerId))
		AND ((@companyId	IS NULL) OR ([Archive.Sales].CompanyId	= @companyId))
		AND ((@dateInvoice	IS NULL) OR ([Archive.Sales].InvoiceDate	= @dateInvoice))
	END
	ELSE IF @documentType = 'CREDIT NOTE'
	BEGIN
		INSERT INTO @TABLE_OUTPUT 
		SELECT 
		[Archive.Sales].CompanyCode , 
		[Archive.Sales].Serial , 
		[Archive.Sales].Plate , 
		[Archive.Sales].Unit ,
		[Dimension.Companies].CompanyName ,
		[Dimension.Companies].CompanyFiscalCode,
		[Dimension.CompanyAddress].Address1,
		[Dimension.CompanyAddress].Address2,
		[Dimension.CompanyAddress].Address3,
		[Dimension.CompanyAddress].Address4,
		[Dimension.CompanyAddress].Address5,
		[Dimension.CompanyAddress].Address6,
		[Dimension.CompanyAddress].Address7,
		[Dimension.CompanyAddress].Address8,
		[Dimension.CompanyAddress].Address9,
		[Dimension.CompanyAddress].Address10,
		[Dimension.CompanyAddress].Address11,
		[Dimension.CompanyAddress].Address12,
		[Dimension.Buyers].BuyerId,
		[Dimension.Buyers].BuyerName,
		[Dimension.Buyers].BuyerCode,
		[Dimension.Buyers].BuyerFiscalCode,
		[Dimension.Buyers].BuyerTaxCode,
		[Fact.BuyersAddress].BuyerAddress1,
		[Fact.BuyersAddress].BuyerAddress2,
		[Fact.BuyersAddress].BuyerAddress3,
		[Fact.BuyersAddress].BuyerAddress4,
		[Fact.BuyersAddress].BuyerAddress5,
		[Fact.BuyersAddress].BuyerAddress6,
		[Archive.Sales].InvoiceNumber,
		[Archive.Sales].InvoiceNet,
		[Archive.Sales].InvoiceVat,	
		[Archive.Sales].InvoiceTotal,
		CONVERT(VARCHAR(11),
		[Archive.Sales].InServiceDate,103),
		CONVERT(VARCHAR(11),
		[Archive.Sales].OutServiceDate,103),
		CONVERT(VARCHAR(11),
		[Archive.Sales].MSODate,103),
		[Dimension.DocumentTypes].DocType,
		[Dimension.DocumentTypes].DocSubType,
		[Dimension.Manufacturer].ManufacturerName,
		[Dimension.ModelDetails].ModelDescription,
		CONVERT(VARCHAR,
		[Dimension.Countries].CountryVat) + '%',
		[Archive.Sales].SuperCharge,
		[Archive.Sales].RegTaxAmount,
		[Archive.Sales].PlusKM,	
		[Archive.Sales].MileCharge,
		[Archive.Sales].Damage,	
		[Archive.Sales].Amount5,
		[Archive.Sales].AddOn,
		[Archive.Sales].Amount6,
		[Archive.Sales].Amount7,
		[Archive.Sales].FuelCharge,
		[Archive.Sales].HandleFee,
		[Archive.Sales].Other1,
		[Archive.Sales].Other2,
		[Archive.Sales].CapitalCost,
		[Archive.Sales].BookValue,
		LEFT(
		CONVERT(CHAR(14),
		CAST([Archive.Sales].BuyBackCap AS MONEY),1),14),
		[Archive.Sales].Depreciation,
		CONVERT(VARCHAR,
		[Archive.Sales].Mileage),
		CONVERT(VARCHAR,
		DATEDIFF(DAY,[Archive.Sales].InServiceDate,[Archive.Sales].OutServiceDate)),
		CONVERT(VARCHAR,
		DATEDIFF(DAY,[Archive.Sales].MSODate,[Archive.Sales].OutServiceDate)),
		CONVERT(VARCHAR,
		[Archive.Sales].SuperCharge	+ 
		[Archive.Sales].HandleFee),
		CONVERT(VARCHAR(11),GETDATE(),104),
		'RV ' +
		
		CASE WHEN [Archive.Sales].BuyBackCap = 0 THEN '0' ELSE
		CONVERT(VARCHAR,ROUND(
		(
		[Archive.Sales].BookValue/
		[Archive.Sales].BuyBackCap
		)
		*100,1)) 
		END
		+ ' %',								
		
		[Archive.Sales].TransferFees,
		[Archive.Sales].TransferFeesNoVat,
		[Archive.Sales].InvoiceNet + [Archive.Sales].TransferFees,
		[Archive.Sales].OriginalBPM,
		[Archive.Sales].CalcVatAmortized,
		[Archive.Sales].Unamortized,
		[Archive.Sales].CalcVatAmortized + [Archive.Sales].Unamortized,
		CONVERT(VARCHAR(11),[Archive.Sales].InvoiceDate,103)
	
		FROM [Archive.Sales]
		INNER JOIN [Dimension.Companies]		ON 
			[Archive.Sales].CompanyId = [Dimension.Companies].CompanyId
		INNER JOIN [Dimension.CompanyAddress]	ON
			[Archive.Sales].CompanyId = [Dimension.CompanyAddress].CompanyId	
		INNER JOIN [Dimension.Buyers]			ON
			[Archive.Sales].BuyerId	= [Dimension.Buyers].BuyerId
		INNER JOIN [Fact.BuyersAddress]			ON
			[Archive.Sales].BuyerId =	[Fact.BuyersAddress].BuyerId
			AND [Archive.Sales].ContactTypeId = [Fact.BuyersAddress].ContactTypeId
		INNER JOIN [Dimension.ModelDetails]		ON
					[Archive.Sales].ModelDetailId = [Dimension.ModelDetails].ModelDetailId
		INNER JOIN [Dimension.Manufacturer]		ON
					[Dimension.ModelDetails].ManufacturerId = [Dimension.Manufacturer].ManufacturerId
		INNER JOIN [Dimension.DocumentTypes]	ON 
					[Archive.Sales].DocumentTypeId = [Dimension.DocumentTypes].DocumentTypeId
		INNER JOIN [Dimension.Countries]		ON
					[Archive.Sales].CountryId = [Dimension.Countries].CountryId
		WHERE 
		[Archive.Sales].LogId = @LogIdOR 
		AND [Archive.Sales].CountryId = @countryId
		AND ((@buyerId		IS NULL) OR ([Archive.Sales].BuyerId			= @buyerId))
		AND ((@companyId	IS NULL) OR ([Archive.Sales].CompanyId		= @companyId))
		AND ((@dateInvoice	IS NULL) OR ([Archive.Sales].InvoiceDate	= @dateInvoice))
	END
	ELSE
	BEGIN
		INSERT INTO @TABLE_OUTPUT
		SELECT 
		[Archive.Sales].CompanyCode , 
		[Archive.Sales].Serial , 
		[Archive.Sales].Plate , 
		[Archive.Sales].Unit ,
		[Dimension.Companies].CompanyName ,
		[Dimension.Companies].CompanyFiscalCode,
		[Dimension.CompanyAddress].Address1,
		[Dimension.CompanyAddress].Address2,
		[Dimension.CompanyAddress].Address3,
		[Dimension.CompanyAddress].Address4,
		[Dimension.CompanyAddress].Address5,
		[Dimension.CompanyAddress].Address6,
		[Dimension.CompanyAddress].Address7,
		[Dimension.CompanyAddress].Address8,
		[Dimension.CompanyAddress].Address9,
		[Dimension.CompanyAddress].Address10,
		[Dimension.CompanyAddress].Address11,
		[Dimension.CompanyAddress].Address12,
		[Dimension.Buyers].BuyerId,
		[Dimension.Buyers].BuyerName,
		[Dimension.Buyers].BuyerCode,
		[Dimension.Buyers].BuyerFiscalCode,
		[Dimension.Buyers].BuyerTaxCode	,
		[Fact.BuyersAddress].BuyerAddress1,
		[Fact.BuyersAddress].BuyerAddress2,
		[Fact.BuyersAddress].BuyerAddress3,
		[Fact.BuyersAddress].BuyerAddress4,
		[Fact.BuyersAddress].BuyerAddress5,
		[Fact.BuyersAddress].BuyerAddress6,
		[Archive.Sales].InvoiceNumber,
		[Archive.Sales].InvoiceNet,
		[Archive.Sales].InvoiceVat,	
		[Archive.Sales].InvoiceTotal,
		CONVERT(VARCHAR(11),
		[Archive.Sales].InServiceDate,103),
		CONVERT(VARCHAR(11),
		[Archive.Sales].OutServiceDate,103),
		CONVERT(VARCHAR(11),
		[Archive.Sales].MSODate,103) ,
		[Dimension.DocumentTypes].DocType,
		[Dimension.DocumentTypes].DocSubType,
		[Dimension.Manufacturer].ManufacturerName,
		[Dimension.ModelDetails].ModelDescription,
		
		CONVERT(VARCHAR,
		[Dimension.Countries].CountryVat) + '%',
		[Archive.Sales].SuperCharge,
		[Archive.Sales].RegTaxAmount,
		[Archive.Sales].PlusKM,	
		[Archive.Sales].MileCharge,
		[Archive.Sales].Damage,	
		[Archive.Sales].Amount5,
		[Archive.Sales].AddOn,
		[Archive.Sales].Amount6,
		[Archive.Sales].Amount7,
		[Archive.Sales].FuelCharge,
		[Archive.Sales].HandleFee,
		[Archive.Sales].Other1,
		[Archive.Sales].Other2,
		[Archive.Sales].CapitalCost,
		[Archive.Sales].BookValue,
		LEFT(CONVERT(CHAR(14),CAST([Archive.Sales].BuyBackCap AS MONEY),1),14),
		[Archive.Sales].Depreciation,
		CONVERT(VARCHAR,[Archive.Sales].Mileage),
		CONVERT(VARCHAR,DATEDIFF(DAY,[Archive.Sales].InServiceDate,[Archive.Sales].OutServiceDate)),
		CONVERT(VARCHAR,DATEDIFF(DAY,[Archive.Sales].MSODate,[Archive.Sales].OutServiceDate)),
		CONVERT(VARCHAR,
		[Archive.Sales].SuperCharge	+ 
		[Archive.Sales].HandleFee),
		CONVERT(VARCHAR(11),GETDATE(),104),
		'RV ' +
		
		CASE WHEN CONVERT(FLOAT,[Archive.Sales].BuyBackCap) = 0 THEN '0' ELSE
		CONVERT(VARCHAR,ROUND(
		(
		CONVERT(FLOAT,[Archive.Sales].BookValue)/
		CONVERT(FLOAT,[Archive.Sales].BuyBackCap)
		)
		*100,1)) 
		END
		+ ' %',									
		[Archive.Sales].TransferFees,
		[Archive.Sales].TransferFeesNoVat,
		[Archive.Sales].InvoiceNet + [Archive.Sales].TransferFees,
		[Archive.Sales].OriginalBPM,
		[Archive.Sales].CalcVatAmortized,
		[Archive.Sales].Unamortized,
		[Archive.Sales].CalcVatAmortized + [Archive.Sales].Unamortized,
		CONVERT(VARCHAR(11),[Archive.Sales].InvoiceDate,103)
		
	
		FROM [Archive.Sales]
		INNER JOIN [Dimension.Companies]		ON 
			[Archive.Sales].CompanyId	= [Dimension.Companies].CompanyId
		INNER JOIN [Dimension.CompanyAddress]	ON
			[Archive.Sales].CompanyId	= [Dimension.CompanyAddress].CompanyId	
		INNER JOIN [Dimension.Buyers]			ON
			[Archive.Sales].BuyerId	= [Dimension.Buyers].BuyerId
		INNER JOIN [Fact.BuyersAddress]			ON
			[Archive.Sales].BuyerId =	[Fact.BuyersAddress].BuyerId
			AND [Archive.Sales].ContactTypeId = [Fact.BuyersAddress].ContactTypeId
		INNER JOIN [Dimension.ModelDetails]		ON
					[Archive.Sales].ModelDetailId = [Dimension.ModelDetails].ModelDetailId
		INNER JOIN [Dimension.Manufacturer]		ON
					[Dimension.ModelDetails].ManufacturerId = [Dimension.Manufacturer].ManufacturerId
		INNER JOIN [Dimension.DocumentTypes]	ON 
					[Archive.Sales].DocumentTypeId = [Dimension.DocumentTypes].DocumentTypeId
		INNER JOIN [Dimension.Countries]		ON
					[Archive.Sales].CountryId = [Dimension.Countries].CountryId
		WHERE 
		[Archive.Sales].LogId = @LogIdOR 
		AND [Archive.Sales].CountryId = @countryId
		AND ((@buyerId		IS NULL) OR ([Archive.Sales].BuyerId		= @buyerId))
		AND ((@companyId	IS NULL) OR ([Archive.Sales].CompanyId	= @companyId))
		AND ((@dateInvoice	IS NULL) OR ([Archive.Sales].InvoiceDate	= @dateInvoice))
	END
	
	
	SELECT * FROM @TABLE_OUTPUT
	
END