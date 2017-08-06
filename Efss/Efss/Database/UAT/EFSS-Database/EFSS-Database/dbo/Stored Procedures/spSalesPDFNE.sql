
-- =============================================
-- Author:		Javier
-- Create date: August 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spSalesPDFNE]
		@type				INT			= NULL,
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
		@invoiceMode		VARCHAR(10)   = NULL,
		@freeFormatText     VARCHAR(2000) = NULL
AS
BEGIN
	
	SET NOCOUNT ON;
	
	-- @type = 1 : SEARCH FORM
	-- @type = 2 : PRINT INVOICES FORM (VENDORS LIST)
	-- @type = 3 : PRINT INVOICES FORM (INVOICES LIST)
	
	
	IF @companyId = 0 BEGIN SET @companyId = NULL END
	
	DECLARE @df DATETIME ,
			@dt DATETIME
			
			

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
		COMPANY_ADDRESS_7	VARCHAR(255)	,	COMPANY_ADDRESS_8		VARCHAR(255)	,
		BUYER_ID			INT				,	BUYER_CODE				VARCHAR(10)	,
		BUYER_NAME			VARCHAR(500)    ,   BUYER_TAX_CODE			VARCHAR(50)	,
		BUYER_FISCAL_CODE	VARCHAR(50)		,   
		BUYER_ADDRESS_1		VARCHAR(255)	,   BUYER_ADDRESS_2			VARCHAR(255),	
		VEHICLE_SERIAL		VARCHAR(50)     ,   VEHICLE_UNIT			VARCHAR(20)	,
		INVOICE_NET			VARCHAR(50)		,	INVOICE_VAT				VARCHAR(50)	,
		INVOICE_TOTAL		VARCHAR(50)		,   VEHICLE_PLATE			VARCHAR(20) ,
		MANUFACTURER_NAME	VARCHAR(50)		,	MODEL_DESCRIPTION		VARCHAR(255),
		TODAY				VARCHAR(11)		,	INVOICE_DATE			VARCHAR(20)	,
		COUNTRYVAT			VARCHAR(10)		,	SALE_TYPE				VARCHAR(5)	,
		MILEAGE				VARCHAR(10)		,	MSO_DATE				VARCHAR(11) ,
		SALE_DOC_NUMBER		VARCHAR(50)		,	CALC_VAT_AMT			VARCHAR(50)	,	
		UN_AMT				VARCHAR(50)		,	CALC_PLUS_UMT			VARCHAR(50)	,
		DAMAGE				VARCHAR(50)		,	FUEL_CHARGE				VARCHAR(50)	,
		ORIGINAL_BPM		VARCHAR(50)		,	EXT_BTW					VARCHAR(50)	
	)	
	
	
	-- Type 1 - Car Search Form
	-- Type 2 - Invoicing Form
	-- Type 3 - Invoicing Form - Invoice Level
	
	IF @type = 1
	BEGIN
				
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
					
		IF @InvoiceFrom = NULL
			BEGIN
				IF @invoiceTo IS NULL
				BEGIN
					SET @InvoiceFrom = (SELECT MIN(CONVERT(INT,InvoiceNumber)) 
											FROM [Archive.Sales] WHERE CompanyId = @companyId)
					SET @invoiceTo	 = (SELECT MAX(CONVERT(INT,InvoiceNumber)) 
											FROM [Archive.Sales] WHERE CompanyId = @companyId)
				END
				ELSE
				BEGIN
					SET @InvoiceFrom = (SELECT MIN(CONVERT(INT,InvoiceNumber)) 
											FROM [Archive.Sales] WHERE CompanyId = @companyId)
				END
				
			END
			ELSE
			BEGIN
				IF @invoiceTo IS NULL
				BEGIN
					SET @invoiceTo = @InvoiceFrom
				END
			END
		
		
		INSERT INTO @TABLE_OUTPUT
	
		SELECT 
		sl.DocItemId				, 
			sl.DocumentId			, 
			sl.CompanyId			, 
			CONVERT(INT,sl.SaleDocumentNumber)	, 
			--CONVERT(INT,sl.InvoiceNumber)	, 
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
			br.BuyerId				, 
			sl.BuyerCode			, 
			sl.BuyerName			,
			br.BuyerTaxCode			, 
			br.BuyerFiscalCode		, 
			sl.BuyerAddress1		, 
			sl.BuyerAddress2		, 
			sl.Serial				, 
			CONVERT(INT,sl.Unit)	, 
			CONVERT(VARCHAR,CONVERT(MONEY,sl.InvoiceNet),1) , 
			CONVERT(VARCHAR,CONVERT(MONEY,sl.InvoiceVat),1), 
			CONVERT(VARCHAR,CONVERT(MONEY,sl.InvoiceTotal),1), 
			sl.Plate				,
			sl.ManufacturerName		, 
			sl.ModelDescription		,
			CONVERT(VARCHAR(11),GETDATE(),104),
			CONVERT(VARCHAR(11),sl.InvoiceDate,103) ,
			vv.CountryVat			,
			sl.SaleType				,
			sl.Mileage				, 
			CONVERT(VARCHAR(11),sl.MSODate,103)	,
			sl.SaleDocumentNumber	,
			CONVERT(VARCHAR,CONVERT(MONEY,sl.CalcVatAmortized),1)	,
			CONVERT(VARCHAR,CONVERT(MONEY,sl.Unamortized),1)		,
			CONVERT(VARCHAR,CONVERT(MONEY,sl.CalcVatAmortized + sl.Unamortized),1),
			CONVERT(VARCHAR,CONVERT(MONEY,sl.Damage),1)			, 
			CONVERT(VARCHAR,CONVERT(MONEY,sl.FuelCharge	),1)		,
			CONVERT(VARCHAR,CONVERT(MONEY,sl.OriginalBPM),1)		,
			CONVERT(VARCHAR,CONVERT(MONEY,(sl.CalcVatAmortized + sl.Unamortized + sl.FuelCharge) - sl.Damage),1)

		FROM [Archive.Sales] sl
		INNER JOIN [Application.FileLog] AS fl ON sl.LogId = fl.LogId
		INNER JOIN 
			[Dimension.DocumentTypes]	AS dt ON sl.DocumentTypeId	= dt.DocumentTypeId
		INNER JOIN 
			[Dimension.Companies]		AS cp ON sl.CompanyId		= cp.CompanyId
		--INNER JOIN 
		--	[Dimension.CompanyAddress]  AS ca ON sl.CompanyId		= ca.CompanyId
		INNER JOIN 
			[Dimension.CompanyAddress]  AS ca ON sl.CompanyId		= ca.CompanyId
			AND sl.InvoiceDate between isnull(ca.StartDate, '2000-01-01') and isnull(ca.EndDate,getdate())
		INNER JOIN 
			[Dimension.Buyers]			AS br ON sl.BuyerId			= br.BuyerId
		INNER JOIN 
			[Dimension.Countries]		AS cn ON sl.CountryId		= cn.CountryId
		INNER JOIN 
			[Fact.Documents]			AS dc ON sl.DocumentId		= dc.DocumentId
		LEFT JOIN 
			[Fact.BuyersAddress]		AS ba ON sl.BuyerId			= ba.BuyerId
											AND  sl.ContactTypeId   = ba.ContactTypeId
											AND  ba.Position		= 1 
		INNER JOIN [Dimension.VatValues] as vv on cn.CountryId = vv.CountryId and
			sl.InvoiceDate between vv.StartDate and vv.EndDate

		WHERE 
				sl.CountryId = 5
		AND
				sl.CompanyId	= @companyId
		AND 
			((@buyerId IS NULL)		OR ( sl.BuyerId	=  @buyerId))
		AND 
			((@fileDate IS NULL)	OR (CONVERT(VARCHAR(11),fl.DateLog,103) = @fileDate))
		AND 
			((@invoiceDate IS NULL) OR (CONVERT(VARCHAR(11),sl.InvoiceDate,103) = @invoiceDate))
		AND 
			((@companyId IS NULL)	OR (sl.CompanyId	= @companyId))
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
			((@invoiceFrom IS NULL) OR (CONVERT(INT,sl.InvoiceNumber) BETWEEN @invoiceFrom AND @invoiceTo))
		AND 
			((@dateFrom	IS NULL) OR ((sl.InvoiceDate   >= @df AND  sl.InvoiceDate   <= @dt)))
		
		
		-- Changed 15/12/2011 (Not Active)
		------------------------------------------------------------------------------
		--DECLARE @TABLEINVOICES TABLE (InvoiceNumber varchar(50))
		
		--INSERT INTO @TABLEINVOICES	
		--SELECT sl.SaleDocumentNumber
		--FROM [Archive.Sales] sl
		--INNER JOIN [Application.FileLog] AS fl ON sl.LogId = fl.LogId
		--INNER JOIN 
		--	[Dimension.DocumentTypes]	AS dt ON sl.DocumentTypeId	= dt.DocumentTypeId
		--INNER JOIN 
		--	[Dimension.Companies]		AS cp ON sl.CompanyId		= cp.CompanyId
		--INNER JOIN 
		--	[Dimension.CompanyAddress]  AS ca ON sl.CompanyId		= ca.CompanyId
		--INNER JOIN 
		--	[Dimension.Buyers]			AS br ON sl.BuyerId			= br.BuyerId
		--INNER JOIN 
		--	[Dimension.Countries]		AS cn ON sl.CountryId		= cn.CountryId
		--INNER JOIN 
		--	[Fact.Documents]			AS dc ON sl.DocumentId		= dc.DocumentId
		--LEFT JOIN 
		--	[Fact.BuyersAddress]		AS ba ON sl.BuyerId			= ba.BuyerId
		--									AND  sl.ContactTypeId   = ba.ContactTypeId
		--									AND  ba.Position		= 1 
		--WHERE 
		--			sl.CountryId = 5
		--	AND 
		--		((@buyerId IS NULL)		OR ( sl.BuyerId	=  @buyerId))
		--	AND 
		--		((@fileDate IS NULL)	OR (CONVERT(VARCHAR(11),fl.DateLog,103) = @fileDate))
		--	AND 
		--		((@invoiceDate IS NULL) OR (CONVERT(VARCHAR(11),sl.InvoiceDate,103) = @invoiceDate))
		--	AND 
		--		((@companyId IS NULL)	OR (sl.CompanyId	= @companyId))
		--	AND 
		--		((@fileDate IS NULL)	OR (CONVERT(VARCHAR(11),dc.DateCreated,103) = @fileDate))
		--	AND 
		--		((@invoiceDate IS NULL) OR (CONVERT(VARCHAR(11),sl.InvoiceDate,103) = @invoiceDate))
		--	AND
		--		((@documentType IS NULL) OR ( dt.DocType = @documentType))
		--	AND
		--		((@documentSubType IS NULL) OR (dt.DocSubType =  @documentSubType))
		--	AND 
		--		((@docItemId IS NULL) OR (sl.DocItemId = @docItemId))
		--	AND	
		--		((@unit	IS NULL) OR (sl.Unit LIKE '%' + @unit	+ '%'))
		--	AND	
		--		((@serial IS NULL) OR (sl.Serial LIKE '%' + @serial	+ '%'))
		--	AND 
		--		((@plate	IS NULL) OR ((sl.Plate LIKE '%' + @plate + '%')))
		--	AND	
		--		((@vehicleType IS NULL) OR (sl.VehicleType = @vehicleType))
		--	AND	
		--		((@manufacturer IS NULL) OR ((sl.ManufacturerName LIKE '%' + @manufacturer + '%')))
		--	AND	
		--		((@buyerName IS NULL) OR (br.Buyername		LIKE '%' + @buyerName + '%'))
		--	AND	
		--		((@buyerCode IS NULL) OR (br.BuyerCode LIKE '%' + @buyerCode))
		--	AND 
		--		((@invoiceFrom IS NULL) OR (CONVERT(INT,sl.SaleDocumentNumber) BETWEEN @invoiceFrom AND @invoiceTo))
		--	AND 
		--		((@dateFrom	IS NULL) OR ((sl.InvoiceDate   >= @df AND  sl.InvoiceDate   <= @dt)))
			
		--	GROUP BY
		--		sl.SaleDocumentNumber
			
				
		--INSERT INTO @TABLE_OUTPUT
		
		--	SELECT
		--	sl.DocItemId			, 
		--	sl.DocumentId			, 
		--	sl.CompanyId			, 
		--	CONVERT(INT,sl.SaleDocumentNumber)	, 
		--	dt.DocType				, 
		--	dt.DocSubType			,
		--	cp.CompanyCode			, 
		--	cp.CompanyName			, 
		--	cp.CompanyFiscalCode	,
		--	ca.Address1				, 
		--	ca.Address2				, 
		--	ca.Address3				,
		--	ca.Address4				, 
		--	ca.Address5				, 
		--	ca.Address6				,
		--	br.BuyerId				, 
		--	br.BuyerCode			, 
		--	br.BuyerName			,
		--	br.BuyerTaxCode			, 
		--	br.BuyerFiscalCode		, 
		--	ba.BuyerAddress1		, 
		--	ba.BuyerAddress2		, 
		--	sl.Serial				, 
		--	CONVERT(INT,sl.Unit)	, 
		--	CONVERT(VARCHAR,CONVERT(MONEY,sl.InvoiceNet),1) , 
		--	CONVERT(VARCHAR,CONVERT(MONEY,sl.InvoiceVat),1), 
		--	CONVERT(VARCHAR,CONVERT(MONEY,sl.InvoiceTotal),1), 
		--	sl.Plate				,
		--	sl.ManufacturerName		, 
		--	sl.ModelDescription		,
		--	CONVERT(VARCHAR(11),GETDATE(),104),
		--	CONVERT(VARCHAR(11),sl.InvoiceDate,103) ,
		--	cn.CountryVat			,
		--	sl.SaleType				,
		--	sl.Mileage				, 
		--	CONVERT(VARCHAR(11),sl.MSODate,103)	,
		--	sl.SaleDocumentNumber	,
		--	CONVERT(VARCHAR,CONVERT(MONEY,sl.CalcVatAmortized),1)	,
		--	CONVERT(VARCHAR,CONVERT(MONEY,sl.Unamortized),1)		,
		--	CONVERT(VARCHAR,CONVERT(MONEY,sl.CalcVatAmortized + sl.Unamortized),1),
		--	CONVERT(VARCHAR,CONVERT(MONEY,sl.Damage),1)			, 
		--	CONVERT(VARCHAR,CONVERT(MONEY,sl.FuelCharge	),1)		,
		--	CONVERT(VARCHAR,CONVERT(MONEY,sl.OriginalBPM),1)		,
		--	CONVERT(VARCHAR,CONVERT(MONEY,(sl.CalcVatAmortized + sl.Unamortized + sl.FuelCharge) - sl.Damage),1)
	
		--FROM [Archive.Sales] sl
		
		--INNER JOIN 
		--	[Dimension.DocumentTypes]	AS dt ON sl.DocumentTypeId	= dt.DocumentTypeId
		--INNER JOIN 
		--	[Dimension.Companies]		AS cp ON sl.CompanyId		= cp.CompanyId
		--INNER JOIN 
		--	[Dimension.CompanyAddress]  AS ca ON sl.CompanyId		= ca.CompanyId
		--INNER JOIN 
		--	[Dimension.Buyers]			AS br ON sl.BuyerId			= br.BuyerId
		--INNER JOIN 
		--	[Dimension.Countries]		AS cn ON sl.CountryId		= cn.CountryId
		--INNER JOIN 
		--	[Fact.Documents]			AS dc ON sl.DocumentId		= dc.DocumentId
		--LEFT JOIN 
		--	[Fact.BuyersAddress]		AS ba ON sl.BuyerId			= ba.BuyerId
		--									AND  sl.ContactTypeId   = ba.ContactTypeId
		--									AND  ba.Position		= 1 
		--WHERE
		--	sl.SaleDocumentNumber IN (SELECT InvoiceNumber FROM @TABLEINVOICES)
		--AND sl.CompanyId	= @companyId
		
		
			
	END
	ELSE
	IF @type = 2
	BEGIN
		INSERT INTO @TABLE_OUTPUT
		
			SELECT
			sl.DocItemId			, 
			sl.DocumentId			, 
			sl.CompanyId			, 
			CONVERT(INT,sl.SaleDocumentNumber)	, 
			--CONVERT(INT,sl.InvoiceNumber)	, 
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
			br.BuyerId				, 
			sl.BuyerCode			, 
			sl.BuyerName			,
			br.BuyerTaxCode			, 
			br.BuyerFiscalCode		, 
			sl.BuyerAddress1		, 
			sl.BuyerAddress2		, 
			sl.Serial				, 
			CONVERT(INT,sl.Unit)	, 
			CONVERT(VARCHAR,CONVERT(MONEY,sl.InvoiceNet),1) , 
			CONVERT(VARCHAR,CONVERT(MONEY,sl.InvoiceVat),1), 
			CONVERT(VARCHAR,CONVERT(MONEY,sl.InvoiceTotal),1), 
			sl.Plate				,
			sl.ManufacturerName		, 
			sl.ModelDescription		,
			CONVERT(VARCHAR(11),GETDATE(),104),
			CONVERT(VARCHAR(11),sl.InvoiceDate,103) ,
			vv.CountryVat			,
			sl.SaleType				,
			sl.Mileage				, 
			CONVERT(VARCHAR(11),sl.MSODate,103)	,
			sl.SaleDocumentNumber	,
			CONVERT(VARCHAR,CONVERT(MONEY,sl.CalcVatAmortized),1)	,
			CONVERT(VARCHAR,CONVERT(MONEY,sl.Unamortized),1)		,
			CONVERT(VARCHAR,CONVERT(MONEY,sl.CalcVatAmortized + sl.Unamortized),1),
			CONVERT(VARCHAR,CONVERT(MONEY,sl.Damage),1)			, 
			CONVERT(VARCHAR,CONVERT(MONEY,sl.FuelCharge	),1)		,
			CONVERT(VARCHAR,CONVERT(MONEY,sl.OriginalBPM),1)		,
			CONVERT(VARCHAR,CONVERT(MONEY,(sl.CalcVatAmortized + sl.Unamortized + sl.FuelCharge) - sl.Damage),1)
	
		FROM [Archive.Sales] sl
		INNER JOIN [Application.FileLog] AS fl ON sl.LogId = fl.LogId
		INNER JOIN 
			[Dimension.DocumentTypes]	AS dt ON sl.DocumentTypeId	= dt.DocumentTypeId
		INNER JOIN 
			[Dimension.Companies]		AS cp ON sl.CompanyId		= cp.CompanyId
		--INNER JOIN 
		--	[Dimension.CompanyAddress]  AS ca ON sl.CompanyId		= ca.CompanyId
		INNER JOIN 
			[Dimension.CompanyAddress]  AS ca ON sl.CompanyId		= ca.CompanyId
			AND sl.InvoiceDate between isnull(ca.StartDate, '2000-01-01') and isnull(ca.EndDate,getdate())
		INNER JOIN 
			[Dimension.Buyers]			AS br ON sl.BuyerId			= br.BuyerId
		INNER JOIN 
			[Dimension.Countries]		AS cn ON sl.CountryId		= cn.CountryId
		INNER JOIN 
			[Fact.Documents]			AS dc ON sl.DocumentId		= dc.DocumentId
		LEFT JOIN 
			[Fact.BuyersAddress]		AS ba ON sl.BuyerId			= ba.BuyerId
											AND  sl.ContactTypeId   = ba.ContactTypeId
											AND  ba.Position		= 1 
		INNER JOIN [Dimension.VatValues] as vv on cn.CountryId = vv.CountryId and
							sl.InvoiceDate between vv.StartDate and vv.EndDate
		WHERE 
				sl.CountryId = 5
		AND 
			((@buyerId IS NULL)		OR ( sl.BuyerId	=  @buyerId))
		AND 
			((@fileDate IS NULL)	OR (CONVERT(VARCHAR(11),fl.DateLog,103) = @fileDate))
		AND 
			((@invoiceDate IS NULL) OR (CONVERT(VARCHAR(11),sl.InvoiceDate,103) = @invoiceDate))
	END
	ELSE
	IF @type = 3
	BEGIN
		INSERT INTO @TABLE_OUTPUT
		
			SELECT
			sl.DocItemId			, 
			sl.DocumentId			, 
			sl.CompanyId			, 
			CONVERT(INT,sl.SaleDocumentNumber)	, 
			--CONVERT(INT,sl.InvoiceNumber)	, 
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
			br.BuyerId				, 
			sl.BuyerCode			, 
			sl.BuyerName			,
			br.BuyerTaxCode			, 
			br.BuyerFiscalCode		, 
			sl.BuyerAddress1		, 
			sl.BuyerAddress2		, 
			sl.Serial				, 
			CONVERT(INT,sl.Unit)	, 
			CONVERT(VARCHAR,CONVERT(MONEY,sl.InvoiceNet),1) , 
			CONVERT(VARCHAR,CONVERT(MONEY,sl.InvoiceVat),1), 
			CONVERT(VARCHAR,CONVERT(MONEY,sl.InvoiceTotal),1), 
			sl.Plate				,
			sl.ManufacturerName		, 
			sl.ModelDescription		,
			CONVERT(VARCHAR(11),GETDATE(),104),
			CONVERT(VARCHAR(11),sl.InvoiceDate,103) ,
			vv.CountryVat			,
			sl.SaleType				,
			sl.Mileage				, 
			CONVERT(VARCHAR(11),sl.MSODate,103)	,
			sl.SaleDocumentNumber	,
			CONVERT(VARCHAR,CONVERT(MONEY,sl.CalcVatAmortized),1)	,
			CONVERT(VARCHAR,CONVERT(MONEY,sl.Unamortized),1)		,
			CONVERT(VARCHAR,CONVERT(MONEY,sl.CalcVatAmortized + sl.Unamortized),1),
			CONVERT(VARCHAR,CONVERT(MONEY,sl.Damage),1)			, 
			CONVERT(VARCHAR,CONVERT(MONEY,sl.FuelCharge	),1)		,
			CONVERT(VARCHAR,CONVERT(MONEY,sl.OriginalBPM),1)		,
			CONVERT(VARCHAR,CONVERT(MONEY,(sl.CalcVatAmortized + sl.Unamortized + sl.FuelCharge) - sl.Damage),1)
	
		FROM [Archive.Sales] sl
		INNER JOIN 
			[Dimension.DocumentTypes]	AS dt ON sl.DocumentTypeId	= dt.DocumentTypeId
		INNER JOIN 
			[Dimension.Companies]		AS cp ON sl.CompanyId		= cp.CompanyId
		--INNER JOIN 
		--	[Dimension.CompanyAddress]  AS ca ON sl.CompanyId		= ca.CompanyId
		INNER JOIN 
			[Dimension.CompanyAddress]  AS ca ON sl.CompanyId		= ca.CompanyId
			AND sl.InvoiceDate between isnull(ca.StartDate, '2000-01-01') and isnull(ca.EndDate,getdate())
		INNER JOIN 
			[Dimension.Buyers]			AS br ON sl.BuyerId			= br.BuyerId
		INNER JOIN 
			[Dimension.Countries]		AS cn ON sl.CountryId		= cn.CountryId
		INNER JOIN 
			[Fact.Documents]			AS dc ON sl.DocumentId		= dc.DocumentId
		LEFT JOIN 
			[Fact.BuyersAddress]		AS ba ON sl.BuyerId			= ba.BuyerId
											AND  sl.ContactTypeId   = ba.ContactTypeId
											AND  ba.Position		= 1 
		INNER JOIN [Dimension.VatValues] as vv on cn.CountryId = vv.CountryId and
			sl.InvoiceDate between vv.StartDate and vv.EndDate
		WHERE 
			sl.CountryId = 5
		AND
			sl.DocItemId = @docItemId
	END
	
	
	UPDATE @TABLE_OUTPUT SET COUNTRYVAT = '0' WHERE INVOICE_VAT = '0.00'
	
	IF @freeFormatText IS NULL	BEGIN SET @freeFormatText	= '' END
	
	IF @invoiceMode = '1' OR @invoiceMode is null		
	BEGIN SET @invoiceMode		= '' END ELSE BEGIN SET @invoiceMode = 'COPY' END
	
	
	UPDATE @TABLE_OUTPUT SET BUYER_ADDRESS_1 = '' WHERE BUYER_ADDRESS_1 = 'UNKNOWN'
	UPDATE @TABLE_OUTPUT SET BUYER_ADDRESS_2 = '' WHERE BUYER_ADDRESS_2 = 'UNKNOWN'
	
	
	
	SELECT
		DOCITEMID			,	DOCUMENTID				, 
		COMPANYID			,   DOCUMENT_NUMBER			,
		DOCUMENT_TYPE		,	DOCUMENT_SUB_TYPE		, 
		COMPANY_CODE		,
		COMPANY_NAME		,	COMPANY_FISCAL_CODE		,
		COMPANY_ADDRESS_1	,	COMPANY_ADDRESS_2		,
		COMPANY_ADDRESS_3	,	COMPANY_ADDRESS_4		,
		COMPANY_ADDRESS_5	,	COMPANY_ADDRESS_6		,
		COMPANY_ADDRESS_7	,	COMPANY_ADDRESS_8		,
		BUYER_ID			,	BUYER_CODE				,
		BUYER_NAME			,   BUYER_TAX_CODE			,
		BUYER_FISCAL_CODE	,   
		BUYER_ADDRESS_1		,   BUYER_ADDRESS_2			,	
		VEHICLE_SERIAL		,   VEHICLE_UNIT			,
		INVOICE_NET			,	INVOICE_VAT				,
		INVOICE_TOTAL		,   VEHICLE_PLATE			,
		MANUFACTURER_NAME	,	MODEL_DESCRIPTION		,
		TODAY				,	INVOICE_DATE			,
		COUNTRYVAT			,	SALE_TYPE				,
		MILEAGE				,	MSO_DATE				,
		SALE_DOC_NUMBER		,	CALC_VAT_AMT			,
		UN_AMT				,	CALC_PLUS_UMT			,
		DAMAGE				,	FUEL_CHARGE				,
		ORIGINAL_BPM		,	EXT_BTW					,
		@invoiceMode		AS "INVOICE_MODE",
		@freeFormatText		AS "FREE_FORMAT_TEXT"
	FROM 
		@TABLE_OUTPUT
	

   
END