-- =============================================
-- Author:		Javier
-- Create date: August 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spSalesPDFBELU]
		@countryId			INT			= NULL,
		@companyId			INT			= NULL,
		@buyerId			INT			= NULL,
		@fileDate			VARCHAR(20) = NULL,
		@invoiceDate		VARCHAR(20) = NULL,
		@documentType		VARCHAR(50) = NULL,
		@documentSubType	VARCHAR(50) = NULL,
		@docItemId			INT			= NULL,
		@unit				VARCHAR(50) = NULL,
		@serial				VARCHAR(50) = NULL,
		@plate				VARCHAR(50) = NULL,
		@manufacturer		VARCHAR(50) = NULL,
		@buyerCode			VARCHAR(20)	= NULL,
		@buyerName			VARCHAR(255)= NULL,
		@invoiceFrom		INT			= NULL,
		@invoiceTo			INT			= NULL,
		@dateFrom			VARCHAR(25) = NULL,
		@dateTo				VARCHAR(25) = NULL,
		@vehicleType		VARCHAR(5)	= NULL,
		@type				INT			= NULL,
		@invoiceMode		VARCHAR(10)   = NULL,
		@freeFormatText     VARCHAR(2000) = NULL
AS
BEGIN
	
	SET NOCOUNT ON;

   	DECLARE @df DATETIME ,
			@dt DATETIME
			
			
	IF @dateTo IS NULL OR @dateTo = '0'
	BEGIN
		IF @dateFrom IS NULL OR @dateFrom = '0'
		BEGIN
			SET @dateTo = (SELECT MAX(InvoiceDate) FROM [Archive.Sales])
			SET @dt = CONVERT(DATETIME , @dateTo ,103)
		END
		ELSE
		BEGIN
			SET @dateTo = @dateFrom
			SET @dt = CONVERT(DATETIME , @dateTo	+ ' 23:59',103)
		END
	END
	ELSE
	BEGIN
		SET @dt = CONVERT(DATETIME , @dateTo	+ ' 23:59',103)
	END
	
	IF @dateFrom IS NULL OR @dateFrom = '0'
	BEGIN
		SET @dateFrom = (SELECT MIN(InvoiceDate) FROM [Archive.Sales])
		SET @df = CONVERT(DATETIME , @dateFrom , 103)
	END
	ELSE
	BEGIN
		SET @df = CONVERT(DATETIME , @dateFrom , 103)
	END
			
	IF @invoiceFrom	= 0 BEGIN SET @invoiceFrom	= NULL END
	IF @invoiceTo	= 0 BEGIN SET @invoiceTo	= NULL END

	
	DECLARE @TABLE_OUTPUT TABLE
	(
		DOCITEMID			INT				,	DOCUMENTID				INT			, 
		COMPANYID			INT				,   DOCUMENT_NUMBER			VARCHAR(50) ,
		DOCUMENT_TYPE		VARCHAR(50)		,	DOCUMENT_SUB_TYPE		VARCHAR(50) , 
		COMPANY_CODE		VARCHAR(20)		,
		COMPANY_NAME		VARCHAR(255)	,	COMPANY_FISCAL_CODE		VARCHAR(100),
		COMPANY_ADDRESS_1	VARCHAR(255)	,	COMPANY_ADDRESS_2		VARCHAR(255),
		COMPANY_ADDRESS_3	VARCHAR(255)	,	COMPANY_ADDRESS_4		VARCHAR(255),
		COMPANY_ADDRESS_5	VARCHAR(255)	,	COMPANY_ADDRESS_6		VARCHAR(255),
		COMPANY_ADDRESS_7	VARCHAR(255)	,	COMPANY_ADDRESS_8		VARCHAR(255),
		COMPANY_ADDRESS_9	VARCHAR(255)	,	COMPANY_ADDRESS_10		VARCHAR(255),
		COMPANY_ADDRESS_11	VARCHAR(255)	,	COMPANY_ADDRESS_12		VARCHAR(255),
		BUYER_ID			INT				,	BUYER_CODE				VARCHAR(10)	,
		BUYER_NAME			VARCHAR(500)    ,   BUYER_TAX_CODE			VARCHAR(50)	,
		BUYER_FISCAL_CODE	VARCHAR(50)		,   BUYER_TYPE				VARCHAR(50)	,
		BUYER_ADDRESS_1		VARCHAR(255)	,   BUYER_ADDRESS_2			VARCHAR(255),	
		BUYER_ADDRESS_3		VARCHAR(255)	,   
		VEHICLE_SERIAL		VARCHAR(50)     ,   VEHICLE_UNIT			VARCHAR(20)	,
		INVOICE_NET			VARCHAR(50)		,	INVOICE_VAT				VARCHAR(50)		,
		INVOICE_TOTAL		VARCHAR(50)		,   VEHICLE_PLATE			VARCHAR(20) ,
		IN_SERVICE_DATE		VARCHAR(11)		,	OUT_SERVICE_DATE		VARCHAR(11)	,	
		MSO_DATE			VARCHAR(11)		,	
		MANUFACTURER_NAME	VARCHAR(50)		,	MODEL_DESCRIPTION		VARCHAR(255),
		MILEAGE				FLOAT			,	
		TODAY				VARCHAR(11)		,	INVOICE_DATE		VARCHAR(20)		,
		COUNTRYVAT			FLOAT			,	SALE_TYPE			VARCHAR(5)	,
		VAT_PCT				VARCHAR(50)	
	)
	
	
	IF @type = 1
	BEGIN
		INSERT INTO @TABLE_OUTPUT
	
		SELECT
			sl.DocItemId			, 
			sl.DocumentId			, 
			sl.CompanyId			, 
			CONVERT(INT,dc.DocumentNumber)	, 
			dt.DocType				, 
			dt.DocSubType			,
			cp.CompanyCode			, 
			cp.CompanyName			, 
			cp.CompanyFiscalCode	,
			ca.Address1				, 
			ca.Address2				, 
			ca.Address3				,
			ca.Address4				, 
			ca.Address5				, 
			ca.Address6				,
			ca.Address7				, 
			ca.Address8				, 
			ca.Address9				,
			ca.Address10			, 
			ca.Address11			, 
			ca.Address12			,
			br.BuyerId				, 
			br.BuyerCode			, 
			sl.BuyerName			,
			br.BuyerTaxCode			, 
			br.BuyerFiscalCode		, 
			''						,
			--bt.BuyerType			, 
			sl.BuyerAddress1		, 
			sl.BuyerAddress2		, 
			sl.BuyerAddress3		,
			sl.Serial				, 
			CONVERT(INT,sl.Unit)	, 
			CONVERT(VARCHAR,CONVERT(MONEY,sl.InvoiceNet),1)	, 
			CONVERT(VARCHAR,CONVERT(MONEY,sl.InvoiceVat),1)	, 
			CONVERT(VARCHAR,CONVERT(MONEY,sl.InvoiceTotal),1)	, 
			sl.Plate				,
			CONVERT(VARCHAR(11),sl.InServiceDate,103)	,
			CONVERT(VARCHAR(11),sl.OutServiceDate,103)	,
			CONVERT(VARCHAR(11),sl.MSODate,103)			,
			sl.ManufacturerName		, 
			sl.ModelDescription		,
			CONVERT(VARCHAR,sl.Mileage),
			CONVERT(VARCHAR(11),GETDATE(),104),
			CONVERT(VARCHAR(11),sl.InvoiceDate,103) ,
			cn.CountryVat	,
			sl.SaleType		,
			CONVERT(VARCHAR,cn.CountryVat) + '%' 
	
	FROM 
	[Archive.Sales] sl
		INNER JOIN [Application.FileLog] AS fl ON sl.LogId = fl.LogId
		INNER JOIN 
			[Dimension.DocumentTypes]	AS dt ON sl.DocumentTypeId	= dt.DocumentTypeId
		INNER JOIN 
			[Dimension.Companies]		AS cp ON sl.CompanyId		= cp.CompanyId
		INNER JOIN 
			[Dimension.CompanyAddress]  AS ca ON sl.CompanyId		= ca.CompanyId
		INNER JOIN 
			[Dimension.Buyers]			AS br ON sl.BuyerAddressId	= br.BuyerId
		INNER JOIN 
			[Dimension.Countries]		AS cn ON sl.CountryId		= cn.CountryId
		LEFT JOIN 
			[Dimension.TaxCodes]		AS tc ON sl.TaxDescription3 = tc.TaxCode
		LEFT JOIN 
			[Dimension.TaxCodes]		AS tx ON sl.TaxDescription2 = tx.TaxCode
		LEFT JOIN 
			[Fact.BuyerExceptions]		AS be ON sl.BuyerAddressId	= be.BuyerId
		INNER JOIN 
			[Fact.Documents]			AS dc ON sl.DocumentId		= dc.DocumentId
		LEFT JOIN 
			[Fact.BuyersAddress]		AS ba ON sl.BuyerAddressId		= ba.BuyerId
											AND  sl.ContactTypeId   = ba.ContactTypeId
											AND  ba.Position		= 1
	WHERE 
			 cp.CountryId = @countryId
		AND 
			((@buyerId IS NULL)		OR ( br.BuyerId		=  @buyerId))
		AND 
			((@companyId IS NULL)	OR (cp.CompanyId	= @companyId))
		AND 
			((@fileDate IS NULL)	OR (CONVERT(VARCHAR(11),fl.DateLog,103) = @fileDate))
		AND 
			((@invoiceDate IS NULL) OR (CONVERT(VARCHAR(11),sl.InvoiceDate,103) = @invoiceDate))
		AND
			((@documentType IS NULL) OR ( dt.DocType = @documentType))
		AND
			((@documentSubType IS NULL) OR (dt.DocSubType =  @documentSubType))
		AND 
			((@docItemId IS NULL) OR (sl.DocItemId = @docItemId))
		AND	
			((@unit	IS NULL) OR (sl.Unit LIKE '%' + @unit	+ '%'))
		AND	
			((@serial IS NULL) OR (sl.Serial LIKE '%' + @serial	+ '%'))
		AND 
			((@plate	IS NULL) OR ((sl.Plate LIKE '%' + @plate + '%')))
		AND	
			((@vehicleType IS NULL) OR (sl.VehicleType = @vehicleType))
		AND	
			((@manufacturer IS NULL) OR ((sl.ManufacturerName LIKE '%' + @manufacturer + '%')))
		AND	
			((@buyerName IS NULL) OR (br.Buyername		LIKE '%' + @buyerName + '%'))
		AND	
			((@buyerCode IS NULL) OR (br.BuyerCode LIKE '%' + @buyerCode))
		AND 
			((@invoiceFrom IS NULL) OR (CONVERT(INT,dc.DocumentNumber) BETWEEN @invoiceFrom AND @invoiceTo))
		AND 
			((@dateFrom	IS NULL) OR ((sl.InvoiceDate   >= @df AND  sl.InvoiceDate   <= @dt)))
			
	ORDER BY 
		cp.CompanyCode , br.BuyerCode
	
	END
	ELSE IF @type = 2
	BEGIN
		INSERT INTO @TABLE_OUTPUT
	
		SELECT
			sl.DocItemId			, 
			sl.DocumentId			, 
			sl.CompanyId			, 
			CONVERT(INT,dc.DocumentNumber)	, 
			dt.DocType				, 
			dt.DocSubType			,
			cp.CompanyCode			, 
			cp.CompanyName			, 
			cp.CompanyFiscalCode	,
			ca.Address1				, 
			ca.Address2				, 
			ca.Address3				,
			ca.Address4				, 
			ca.Address5				, 
			ca.Address6				,
			ca.Address7				, 
			ca.Address8				, 
			ca.Address9				,
			ca.Address10			, 
			ca.Address11			, 
			ca.Address12			,
			br.BuyerId				, 
			br.BuyerCode			, 
			sl.BuyerName			,
			br.BuyerTaxCode			, 
			br.BuyerFiscalCode		, 
			''						,
			--bt.BuyerType			, 
			sl.BuyerAddress1		, 
			sl.BuyerAddress2		, 
			sl.BuyerAddress3		,
			sl.Serial				, 
			CONVERT(INT,sl.Unit)	, 
			CONVERT(VARCHAR,CONVERT(MONEY,sl.InvoiceNet),1)	, 
			CONVERT(VARCHAR,CONVERT(MONEY,sl.InvoiceVat),1)	, 
			CONVERT(VARCHAR,CONVERT(MONEY,sl.InvoiceTotal),1)	, 
			sl.Plate				,
			CONVERT(VARCHAR(11),sl.InServiceDate,103)	,
			CONVERT(VARCHAR(11),sl.OutServiceDate,103)	,
			CONVERT(VARCHAR(11),sl.MSODate,103)			,
			sl.ManufacturerName		, 
			sl.ModelDescription		,
			CONVERT(VARCHAR,sl.Mileage),
			CONVERT(VARCHAR(11),GETDATE(),104),
			CONVERT(VARCHAR(11),sl.InvoiceDate,103) ,
			cn.CountryVat	,
			sl.SaleType		,
			CONVERT(VARCHAR,cn.CountryVat) + '%' 
			
	
	FROM [Archive.Sales] sl
		INNER JOIN [Application.FileLog] AS fl ON sl.LogId = fl.LogId
		INNER JOIN 
			[Dimension.DocumentTypes]	AS dt ON sl.DocumentTypeId	= dt.DocumentTypeId
		INNER JOIN 
			[Dimension.Companies]		AS cp ON sl.CompanyId		= cp.CompanyId
		INNER JOIN 
			[Dimension.CompanyAddress]  AS ca ON sl.CompanyId		= ca.CompanyId
		INNER JOIN 
			[Dimension.Buyers]			AS br ON sl.BuyerAddressId	= br.BuyerId
		INNER JOIN 
			[Dimension.Countries]		AS cn ON sl.CountryId		= cn.CountryId
		LEFT JOIN 
			[Dimension.TaxCodes]		AS tc ON sl.TaxDescription3 = tc.TaxCode
		LEFT JOIN 
			[Dimension.TaxCodes]		AS tx ON sl.TaxDescription2 = tx.TaxCode
		LEFT JOIN 
			[Fact.BuyerExceptions]		AS be ON sl.BuyerAddressId	= be.BuyerId
		INNER JOIN 
			[Fact.Documents]			AS dc ON sl.DocumentId		= dc.DocumentId
		LEFT JOIN 
			[Fact.BuyersAddress]		AS ba ON sl.BuyerAddressId	= ba.BuyerId
											AND  sl.ContactTypeId   = ba.ContactTypeId
											AND  ba.Position		= 1 
	WHERE 
			 cp.CountryId = @countryId
		AND 
			((@buyerId IS NULL)		OR ( br.BuyerId	=  @buyerId))
		AND 
			((@fileDate IS NULL)	OR (CONVERT(VARCHAR(11),fl.DateLog,103) = @fileDate))
		AND 
			((@invoiceDate IS NULL) OR (CONVERT(VARCHAR(11),sl.InvoiceDate,103) = @invoiceDate))
	ORDER BY 
		cp.CompanyCode , br.BuyerCode
		
		
		
		UPDATE @TABLE_OUTPUT SET BUYER_TAX_CODE		= BUYER_FISCAL_CODE WHERE BUYER_TAX_CODE IS NULL
		UPDATE @TABLE_OUTPUT SET BUYER_FISCAL_CODE	= BUYER_TAX_CODE WHERE BUYER_FISCAL_CODE IS NULL
		
		
		
	END
	ELSE IF @type = 3
	BEGIN
		INSERT INTO @TABLE_OUTPUT
	
		SELECT
			sl.DocItemId			, 
			sl.DocumentId			, 
			sl.CompanyId			, 
			CONVERT(INT,dc.DocumentNumber)	, 
			dt.DocType				, 
			dt.DocSubType			,
			cp.CompanyCode			, 
			cp.CompanyName			, 
			cp.CompanyFiscalCode	,
			ca.Address1				, 
			ca.Address2				, 
			ca.Address3				,
			ca.Address4				, 
			ca.Address5				, 
			ca.Address6				,
			ca.Address7				, 
			ca.Address8				, 
			ca.Address9				,
			ca.Address10			, 
			ca.Address11			, 
			ca.Address12			,
			br.BuyerId				, 
			br.BuyerCode			, 
			sl.BuyerName			,
			br.BuyerTaxCode			, 
			br.BuyerFiscalCode		,
			''						, 
			--bt.BuyerType			, 
			sl.BuyerAddress1		, 
			sl.BuyerAddress2		, 
			sl.BuyerAddress3		,
			sl.Serial				, 
			CONVERT(INT,sl.Unit)	, 
			CONVERT(VARCHAR,CONVERT(MONEY,sl.InvoiceNet),1)	, 
			CONVERT(VARCHAR,CONVERT(MONEY,sl.InvoiceVat),1)	, 
			CONVERT(VARCHAR,CONVERT(MONEY,sl.InvoiceTotal),1)	, 
			sl.Plate				,
			CONVERT(VARCHAR(11),sl.InServiceDate,103)	,
			CONVERT(VARCHAR(11),sl.OutServiceDate,103)	,
			CONVERT(VARCHAR(11),sl.MSODate,103)			,
			sl.ManufacturerName		, 
			sl.ModelDescription		,
			CONVERT(VARCHAR,sl.Mileage),
			CONVERT(VARCHAR(11),GETDATE(),104),
			CONVERT(VARCHAR(11),sl.InvoiceDate,103) ,
			cn.CountryVat	,
			sl.SaleType		,
			CONVERT(VARCHAR,cn.CountryVat) + '%' 
	
	FROM 
	[Archive.Sales] sl
		INNER JOIN [Application.FileLog] AS fl ON sl.LogId = fl.LogId
		INNER JOIN 
			[Dimension.DocumentTypes]	AS dt ON sl.DocumentTypeId	= dt.DocumentTypeId
		INNER JOIN 
			[Dimension.Companies]		AS cp ON sl.CompanyId		= cp.CompanyId
		INNER JOIN 
			[Dimension.CompanyAddress]  AS ca ON sl.CompanyId		= ca.CompanyId
		INNER JOIN 
			[Dimension.Buyers]			AS br ON sl.BuyerAddressId	= br.BuyerId
		INNER JOIN 
			[Dimension.Countries]		AS cn ON sl.CountryId		= cn.CountryId
		LEFT JOIN 
			[Dimension.TaxCodes]		AS tc ON sl.TaxDescription3 = tc.TaxCode
		LEFT JOIN 
			[Dimension.TaxCodes]		AS tx ON sl.TaxDescription2 = tx.TaxCode
		LEFT JOIN 
			[Fact.BuyerExceptions]		AS be ON sl.BuyerAddressId	= be.BuyerId
		INNER JOIN 
			[Fact.Documents]			AS dc ON sl.DocumentId		= dc.DocumentId
		LEFT JOIN 
			[Fact.BuyersAddress]		AS ba ON sl.BuyerAddressId		= ba.BuyerId
											AND  sl.ContactTypeId   = ba.ContactTypeId
											AND  ba.Position		= 1
	WHERE 
			sl.DocItemId = @docItemId
	
	ORDER BY 
		cp.CompanyCode , br.BuyerCode
	
	END
	
	
	IF @freeFormatText IS NULL	BEGIN SET @freeFormatText	= '' END
	IF @invoiceMode = '1' OR @invoiceMode is null		
	BEGIN SET @invoiceMode		= '' END ELSE BEGIN SET @invoiceMode = 'KOPIE' END
	
	
	UPDATE @TABLE_OUTPUT SET BUYER_ADDRESS_1 = '' WHERE BUYER_ADDRESS_1 = 'UNKNOWN'
	UPDATE @TABLE_OUTPUT SET BUYER_ADDRESS_2 = '' WHERE BUYER_ADDRESS_2 = 'UNKNOWN'
	UPDATE @TABLE_OUTPUT SET BUYER_ADDRESS_3 = '' WHERE BUYER_ADDRESS_3 = 'UNKNOWN'
	
	
	SELECT 
		DOCITEMID			, DOCUMENTID			, COMPANYID				, 
		DOCUMENT_NUMBER		, DOCUMENT_TYPE			, DOCUMENT_SUB_TYPE		, 
		COMPANY_CODE		, COMPANY_NAME			, COMPANY_FISCAL_CODE	,
		COMPANY_ADDRESS_1	, COMPANY_ADDRESS_2		, COMPANY_ADDRESS_3		,
		COMPANY_ADDRESS_4	, COMPANY_ADDRESS_5		, COMPANY_ADDRESS_6		, 
		COMPANY_ADDRESS_7	, COMPANY_ADDRESS_8		, COMPANY_ADDRESS_9		, 
		COMPANY_ADDRESS_10	, COMPANY_ADDRESS_11	, COMPANY_ADDRESS_12	,
		BUYER_ID			, BUYER_CODE			, BUYER_NAME			, 
		BUYER_TAX_CODE		, BUYER_FISCAL_CODE		, BUYER_TYPE			, 
		BUYER_ADDRESS_1		, BUYER_ADDRESS_2		, BUYER_ADDRESS_3		, 
		VEHICLE_SERIAL		, VEHICLE_UNIT			, INVOICE_NET			, 
		INVOICE_VAT			, INVOICE_TOTAL			, VEHICLE_PLATE			,	
		IN_SERVICE_DATE		, OUT_SERVICE_DATE		, MSO_DATE				,
		MANUFACTURER_NAME	, MODEL_DESCRIPTION		, MILEAGE				, 
		TODAY				, INVOICE_DATE			, COUNTRYVAT			, 
		SALE_TYPE			, VAT_PCT				,
		@invoiceMode		AS "INVOICE_MODE",
		@freeFormatText		AS "FREE_FORMAT_TEXT"
	FROM @TABLE_OUTPUT 
		
END