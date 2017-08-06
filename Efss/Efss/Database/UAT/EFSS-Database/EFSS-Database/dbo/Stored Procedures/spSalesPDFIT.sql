
-- =============================================
-- Author:		Javier
-- Create date: August 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spSalesPDFIT]
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
		BUYER_ID			INT				,	BUYER_CODE				VARCHAR(10)	,
		BUYER_NAME			VARCHAR(500)    ,   BUYER_TAX_CODE			VARCHAR(50)	,
		BUYER_FISCAL_CODE	VARCHAR(50)		,   
		BUYER_ADDRESS_1		VARCHAR(255)	,   BUYER_ADDRESS_2			VARCHAR(255),	
		BUYER_ADDRESS_3		VARCHAR(255)	,   BUYER_ADDRESS_4			VARCHAR(255),	
		VEHICLE_SERIAL		VARCHAR(50)     ,   VEHICLE_UNIT			VARCHAR(20)	,
		INVOICE_NET			VARCHAR(20)		,	INVOICE_VAT				VARCHAR(20)	,
		INVOICE_TOTAL		VARCHAR(20)		,   VEHICLE_PLATE			VARCHAR(20) ,
		MANUFACTURER_NAME	VARCHAR(50)		,	MODEL_DESCRIPTION		VARCHAR(255),
		TODAY				VARCHAR(11)		,	
		TRANSFER_FEES		VARCHAR(20)		,	TRANSFER_FEES_NO_VAT	VARCHAR(20)		,
		NET_PLUS_FEE		VARCHAR(20)		,	INVOICE_DATE			VARCHAR(20)	,
		COUNTRYVAT			VARCHAR(50)		,	AREA_CODE				VARCHAR(20) ,
		SALE_TYPE			VARCHAR(5)		,	
		TAX_DESCRIPTION		VARCHAR(255)	,
		REPORT_VALUE_1      VARCHAR(255)    ,   
		REPORT_VALUE_2      VARCHAR(255)	,
		TAX_DESCRIPTION_2   VARCHAR(255)	,	
		VALUE_TAX_TRANS		VARCHAR(50)		,
		VALUE_TAX_TEXT		VARCHAR(255)    ,   NET_MINUS_FEE			VARCHAR(20) ,
		NET_MINUS_FEE_NV    VARCHAR(20)     ,   OLD_INVOICE_NUMBER		VARCHAR(20) ,
		OLD_INVOICE_DATE    VARCHAR(20)
	)


	IF @type = 1
	BEGIN
		
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
		sl.DocItemId ,
		sl.DocumentId,
		sl.CompanyId,
		CONVERT(INT,sl.InvoiceNumber),
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
		sl.BuyerId				, 
		br.BuyerCode			, 
		sl.BuyerName			,
		br.BuyerTaxCode			, 
		br.BuyerFiscalCode		,
		sl.BuyerAddress1		, 
		sl.BuyerAddress2		, 
		sl.BuyerAddress3		,
		sl.BuyerAddress4		,
		sl.Serial				,
		CONVERT(INT,sl.Unit)	, 
		CONVERT(VARCHAR,CONVERT(MONEY,sl.InvoiceNet),1) , 
		CONVERT(VARCHAR,CONVERT(MONEY,sl.InvoiceVat),1), 
		
		CASE WHEN sl.SaleType = 'P' THEN 
			CONVERT(VARCHAR,CONVERT(MONEY,sl.InvoiceTotal),1)
		ELSE
			CONVERT(VARCHAR,CONVERT(MONEY,sl.InvoiceTotal + sl.TransferFees + sl.TransferFeesNoVat),1)
		END ,
		
		sl.Plate				,
		sl.ManufacturerName		, 
		sl.ModelDescription		,
		CONVERT(VARCHAR(11),GETDATE(),104),
		CONVERT(VARCHAR,CONVERT(MONEY,sl.TransferFees),1), 
		CONVERT(VARCHAR,CONVERT(MONEY,sl.TransferFeesNoVat),1), 
		CONVERT(VARCHAR,CONVERT(MONEY,sl.InvoiceNet + sl.TransferFees),1),
		CONVERT(VARCHAR(11),sl.InvoiceDate,103) ,
		cn.CountryVat			,
		sl.AreaCode				,
		sl.SaleType,
		tc.TaxDescription       ,
		be.ReportValue1			,
		be.ReportValue2         ,
		tx.TaxDescription		,
		CASE WHEN tx.CodeStatus = 1 THEN 
				CASE WHEN tc.CodeStatus = 1 THEN
					CONVERT(VARCHAR,CONVERT(MONEY,sl.TransferFeesNoVat + sl.InvoiceVat),1)
				ELSE
					CONVERT(VARCHAR,CONVERT(MONEY,sl.TransferFeesNoVat),1)
				END
		ELSE
				CASE WHEN tc.CodeStatus = 1 THEN
					CONVERT(VARCHAR,CONVERT(MONEY,sl.InvoiceVat),1)
				ELSE
					'0.00'
				END
		END,
		
		-- Old Text
		--'Imposta di bollo dovuta = 1,29 assolta in modo virtuale in base 
		--alla autorizzazione D.R.E. N.369 Rep 2 T del 12,3,1933',
		
		-- New Text (Requested by Michal changed by Javier 12/12/2012)
		
		CASE WHEN cp.CompanyCode = 'IT' THEN
			'Imposta di bollo dovuta = 1,81 assolta in modo virtuale in base alla autorizzazione D.R.E. n. n. 369 Rep. 2T del 12/02/1993'
		ELSE
			'Imposta di bollo dovuta = 1,81 assolta in modo virtuale in base alla autorizzazione D.R.E. n. 013727/09 del 02/02/2009'
		END,
					
		CASE WHEN sl.SaleType = 'P' THEN 
			CONVERT(VARCHAR,CONVERT(MONEY,sl.InvoiceNet - sl.TransferFees - sl.TransferFeesNoVat),1)
		ELSE
			CONVERT(VARCHAR,CONVERT(MONEY,sl.InvoiceNet),1)
		END,
		
		CASE WHEN sl.SaleType = 'P' THEN 
			CONVERT(VARCHAR,CONVERT(MONEY,sl.InvoiceNet - sl.TransferFeesNoVat),1)
		ELSE
			CONVERT(VARCHAR,CONVERT(MONEY,sl.InvoiceNet + sl.TransferFees),1)
		END , 
		sl.OldInvoiceNumber ,
		CONVERT(VARCHAR(11),sl.OldInvoiceDate,103)
		
		
		FROM [Archive.Sales] sl
		INNER JOIN [Application.FileLog] AS fl ON sl.LogId = fl.LogId
		INNER JOIN 
			[Dimension.DocumentTypes]	AS dt ON sl.DocumentTypeId	= dt.DocumentTypeId
		INNER JOIN 
			[Dimension.Companies]		AS cp ON sl.CompanyId		= cp.CompanyId
		INNER JOIN 
			[Dimension.CompanyAddress]  AS ca ON sl.CompanyId		= ca.CompanyId
			AND sl.InvoiceDate between isnull(ca.StartDate, '2000-01-01') and isnull(ca.EndDate,getdate())
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
				sl.CountryId = 9
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
			
	END
	ELSE
	IF @type = 2
	BEGIN
		INSERT INTO @TABLE_OUTPUT
		
		SELECT
		sl.DocItemId ,
		sl.DocumentId,
		sl.CompanyId,
		CONVERT(INT,sl.InvoiceNumber),
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
		sl.BuyerId				, 
		br.BuyerCode			, 
		sl.BuyerName			,
		br.BuyerTaxCode			, 
		br.BuyerFiscalCode		,
		sl.BuyerAddress1		, 
		sl.BuyerAddress2		, 
		sl.BuyerAddress3		,
		sl.BuyerAddress4		,
		sl.Serial				,
		CONVERT(INT,sl.Unit)	, 
		CONVERT(VARCHAR,CONVERT(MONEY,sl.InvoiceNet),1) , 
		CONVERT(VARCHAR,CONVERT(MONEY,sl.InvoiceVat),1), 
		
		CASE WHEN sl.SaleType = 'P' THEN 
			CONVERT(VARCHAR,CONVERT(MONEY,sl.InvoiceTotal),1)
		ELSE
			CONVERT(VARCHAR,CONVERT(MONEY,sl.InvoiceTotal + sl.TransferFees + sl.TransferFeesNoVat),1)
		END ,
		sl.Plate				,
		sl.ManufacturerName		, 
		sl.ModelDescription		,
		CONVERT(VARCHAR(11),GETDATE(),104),
		CONVERT(VARCHAR,CONVERT(MONEY,sl.TransferFees),1), 
		CONVERT(VARCHAR,CONVERT(MONEY,sl.TransferFeesNoVat),1), 
		CONVERT(VARCHAR,CONVERT(MONEY,sl.InvoiceNet + sl.TransferFees),1),
		CONVERT(VARCHAR(11),sl.InvoiceDate,103) ,
		cn.CountryVat			,
		sl.AreaCode				,
		sl.SaleType,
		tc.TaxDescription       ,
		be.ReportValue1			,
		be.ReportValue2         ,
		tx.TaxDescription		,
		CASE WHEN tx.CodeStatus = 1 THEN 
				CASE WHEN tc.CodeStatus = 1 THEN
					CONVERT(VARCHAR,CONVERT(MONEY,sl.TransferFeesNoVat + sl.InvoiceVat),1)
				ELSE
					CONVERT(VARCHAR,CONVERT(MONEY,sl.TransferFeesNoVat),1)
				END
		ELSE
				CASE WHEN tc.CodeStatus = 1 THEN
					CONVERT(VARCHAR,CONVERT(MONEY,sl.InvoiceVat),1)
				ELSE
					'0.00'
				END
		END,
					 
		-- Old Text
		--'Imposta di bollo dovuta = 1,29 assolta in modo virtuale in base 
		--alla autorizzazione D.R.E. N.369 Rep 2 T del 12,3,1933',
		
		-- New Text (Requested by Michal changed by Javier 12/12/2012)
		CASE WHEN cp.CompanyCode = 'IT' THEN
			'Imposta di bollo dovuta = 1,81 assolta in modo virtuale in base alla autorizzazione D.R.E. n. n. 369 Rep. 2T del 12/02/1993'
		ELSE
			'Imposta di bollo dovuta = 1,81 assolta in modo virtuale in base alla autorizzazione D.R.E. n. 013727/09 del 02/02/2009'
		END,
					
		CASE WHEN sl.SaleType = 'P' THEN 
			CONVERT(VARCHAR,CONVERT(MONEY,sl.InvoiceNet - sl.TransferFees - sl.TransferFeesNoVat),1)
		ELSE
			CONVERT(VARCHAR,CONVERT(MONEY,sl.InvoiceNet),1)
		END,
	
		CASE WHEN sl.SaleType = 'P' THEN 
			CONVERT(VARCHAR,CONVERT(MONEY,sl.InvoiceNet - sl.TransferFeesNoVat),1)
		ELSE
			CONVERT(VARCHAR,CONVERT(MONEY,sl.InvoiceNet + sl.TransferFees),1)
		END , 
		sl.OldInvoiceNumber ,
		CONVERT(VARCHAR(11),sl.OldInvoiceDate,103)
		
		FROM [Archive.Sales] sl
		INNER JOIN [Application.FileLog] AS fl ON sl.LogId = fl.LogId
		INNER JOIN 
			[Dimension.DocumentTypes]	AS dt ON sl.DocumentTypeId	= dt.DocumentTypeId
		INNER JOIN 
			[Dimension.Companies]		AS cp ON sl.CompanyId		= cp.CompanyId
		INNER JOIN 
			[Dimension.CompanyAddress]  AS ca ON sl.CompanyId		= ca.CompanyId
			AND sl.InvoiceDate between isnull(ca.StartDate, '2000-01-01') and isnull(ca.EndDate,getdate())
		INNER JOIN 
			[Dimension.Buyers]			AS br ON sl.BuyerAddressId			= br.BuyerId
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
				sl.CountryId = 9
		AND 
			((@buyerId IS NULL)		OR ( sl.BuyerId	=  @buyerId))
		AND 
			((@fileDate IS NULL)	OR (CONVERT(VARCHAR(11),fl.DateLog,103) = @fileDate))
		AND 
			((@invoiceDate IS NULL) OR (CONVERT(VARCHAR(11),sl.InvoiceDate,103) = @invoiceDate))
	
	END
	ELSE IF @type = 3
	BEGIN
		INSERT INTO @TABLE_OUTPUT
		
		SELECT
		sl.DocItemId ,
		sl.DocumentId,
		sl.CompanyId,
		CONVERT(INT,sl.InvoiceNumber),
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
		sl.BuyerId				, 
		br.BuyerCode			, 
		sl.BuyerName			,
		br.BuyerTaxCode			, 
		br.BuyerFiscalCode		,
		sl.BuyerAddress1		, 
		sl.BuyerAddress2		, 
		sl.BuyerAddress3		,
		sl.BuyerAddress4		,
		sl.Serial				,
		CONVERT(INT,sl.Unit)	, 
		CONVERT(VARCHAR,CONVERT(MONEY,sl.InvoiceNet),1) , 
		CONVERT(VARCHAR,CONVERT(MONEY,sl.InvoiceVat),1), 
		
		CASE WHEN sl.SaleType = 'P' THEN 
			CONVERT(VARCHAR,CONVERT(MONEY,sl.InvoiceTotal),1)
		ELSE
			CONVERT(VARCHAR,CONVERT(MONEY,sl.InvoiceTotal + sl.TransferFees + sl.TransferFeesNoVat),1)
		END ,
		sl.Plate				,
		sl.ManufacturerName		, 
		sl.ModelDescription		,
		CONVERT(VARCHAR(11),GETDATE(),104),
		CONVERT(VARCHAR,CONVERT(MONEY,sl.TransferFees),1), 
		CONVERT(VARCHAR,CONVERT(MONEY,sl.TransferFeesNoVat),1), 
		CONVERT(VARCHAR,CONVERT(MONEY,sl.InvoiceNet + sl.TransferFees),1),
		CONVERT(VARCHAR(11),sl.InvoiceDate,103) ,
		cn.CountryVat			,
		sl.AreaCode				,
		sl.SaleType,
		tc.TaxDescription       ,
		be.ReportValue1			,
		be.ReportValue2         ,
		tx.TaxDescription		,
		CASE WHEN tx.CodeStatus = 1 THEN 
				CASE WHEN tc.CodeStatus = 1 THEN
					CONVERT(VARCHAR,CONVERT(MONEY,sl.TransferFeesNoVat + sl.InvoiceVat),1)
				ELSE
					CONVERT(VARCHAR,CONVERT(MONEY,sl.TransferFeesNoVat),1)
				END
		ELSE
				CASE WHEN tc.CodeStatus = 1 THEN
					CONVERT(VARCHAR,CONVERT(MONEY,sl.InvoiceVat),1)
				ELSE
					'0.00'
				END
		END,
					 
		-- Old Text
		--'Imposta di bollo dovuta = 1,29 assolta in modo virtuale in base 
		--alla autorizzazione D.R.E. N.369 Rep 2 T del 12,3,1933',
		
		-- New Text (Requested by Michal changed by Javier 12/12/2012)
		CASE WHEN cp.CompanyCode = 'IT' THEN
			'Imposta di bollo dovuta = 1,81 assolta in modo virtuale in base alla autorizzazione D.R.E. n. n. 369 Rep. 2T del 12/02/1993'
		ELSE
			'Imposta di bollo dovuta = 1,81 assolta in modo virtuale in base alla autorizzazione D.R.E. n. 013727/09 del 02/02/2009'
		END,
					
		CASE WHEN sl.SaleType = 'P' THEN 
			
			CONVERT(VARCHAR,CONVERT(MONEY,sl.InvoiceNet - sl.TransferFees - sl.TransferFeesNoVat),1)
		ELSE
			CONVERT(VARCHAR,CONVERT(MONEY,sl.InvoiceNet),1)
		END,
		
		CASE WHEN sl.SaleType = 'P' THEN 
			CONVERT(VARCHAR,CONVERT(MONEY,sl.InvoiceNet - sl.TransferFeesNoVat),1)
		ELSE
			CONVERT(VARCHAR,CONVERT(MONEY,sl.InvoiceNet + sl.TransferFees),1)
		END , 
		sl.OldInvoiceNumber ,
		CONVERT(VARCHAR(11),sl.OldInvoiceDate,103)
		
		FROM [Archive.Sales] sl
		INNER JOIN 
			[Dimension.DocumentTypes]	AS dt ON sl.DocumentTypeId	= dt.DocumentTypeId
		INNER JOIN 
			[Dimension.Companies]		AS cp ON sl.CompanyId		= cp.CompanyId
		INNER JOIN 
			[Dimension.CompanyAddress]  AS ca ON sl.CompanyId		= ca.CompanyId
			and sl.InvoiceDate between isnull(ca.StartDate, '2000-01-01') and isnull(ca.EndDate,getdate())
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
		INNER JOIN 
			[Fact.BuyersAddress]		AS ba ON sl.BuyerAddressId	= ba.BuyerId
											AND  sl.ContactTypeId   = ba.ContactTypeId
											AND  ba.Position		= 1 

		WHERE 
			sl.CountryId = 9
		and
			sl.DocItemId = @docItemId
					
	END
	
	UPDATE @TABLE_OUTPUT SET BUYER_TAX_CODE		= BUYER_FISCAL_CODE WHERE BUYER_TAX_CODE IS NULL
	UPDATE @TABLE_OUTPUT SET BUYER_FISCAL_CODE	= BUYER_TAX_CODE WHERE BUYER_FISCAL_CODE IS NULL
	UPDATE @TABLE_OUTPUT SET REPORT_VALUE_1		= '' WHERE REPORT_VALUE_1 IS NULL
	UPDATE @TABLE_OUTPUT SET REPORT_VALUE_2		= '' WHERE REPORT_VALUE_2 IS NULL
	UPDATE @TABLE_OUTPUT SET VALUE_TAX_TEXT     = '' WHERE 
		CONVERT(FLOAT,REPLACE(VALUE_TAX_TRANS,',','')) < 77.47	
		
	IF @freeFormatText IS NULL	BEGIN SET @freeFormatText	= '' END
	
	IF @invoiceMode = '1' OR @invoiceMode is null		
	BEGIN SET @invoiceMode		= '' END ELSE BEGIN SET @invoiceMode = 'COPY' END
	
	UPDATE @TABLE_OUTPUT SET BUYER_ADDRESS_1 = '' WHERE BUYER_ADDRESS_1 = 'UNKNOWN'
	UPDATE @TABLE_OUTPUT SET BUYER_ADDRESS_2 = '' WHERE BUYER_ADDRESS_2 = 'UNKNOWN'
	UPDATE @TABLE_OUTPUT SET BUYER_ADDRESS_3 = '' WHERE BUYER_ADDRESS_3 = 'UNKNOWN'
	UPDATE @TABLE_OUTPUT SET BUYER_ADDRESS_4 = '' WHERE BUYER_ADDRESS_4 = 'UNKNOWN'
	
	
	-- Changes 27 feb 2013 by Javier (also MESSAGE_INVERSIONE in the Select)
	--===========================================================================
	DECLARE @timeline DATETIME = '01 Mar 2013'
	
	DECLARE @YEAR VARCHAR(5) = '/' + CONVERT(VARCHAR(4),YEAR(GETDATE()))
	
	UPDATE @TABLE_OUTPUT SET 
		DOCUMENT_NUMBER = DOCUMENT_NUMBER + @YEAR
	WHERE 
		CONVERT(DATETIME,INVOICE_DATE,103) > = @timeline
		
	UPDATE @TABLE_OUTPUT SET
		TAX_DESCRIPTION = REPLACE(TAX_DESCRIPTION,'Non imp.','Operazione non imponible.')
	WHERE 
		CONVERT(DATETIME,INVOICE_DATE,103) > = @timeline
		
	--===========================================================================
	
	
	
		
	SELECT
		DOCITEMID			,	DOCUMENTID				, 
		COMPANYID			,   DOCUMENT_NUMBER			,
		DOCUMENT_TYPE		,	DOCUMENT_SUB_TYPE		, 
		COMPANY_CODE		,
		COMPANY_NAME		,	COMPANY_FISCAL_CODE		,
		COMPANY_ADDRESS_1	,	COMPANY_ADDRESS_2		,
		COMPANY_ADDRESS_3	,	COMPANY_ADDRESS_4		,
		COMPANY_ADDRESS_5	,	COMPANY_ADDRESS_6		,
		BUYER_ID			,	BUYER_CODE				,
		BUYER_NAME			,   BUYER_TAX_CODE			,
		BUYER_FISCAL_CODE	,  
		BUYER_ADDRESS_1		,   BUYER_ADDRESS_2			,	
		BUYER_ADDRESS_3		,   BUYER_ADDRESS_4			,	
		
		VEHICLE_SERIAL		,   VEHICLE_UNIT			,
		INVOICE_NET			,	INVOICE_VAT				,
		INVOICE_TOTAL		,   VEHICLE_PLATE			,
		MANUFACTURER_NAME	,	MODEL_DESCRIPTION		,
		TODAY				,	
		TRANSFER_FEES		,	TRANSFER_FEES_NO_VAT	,
		NET_PLUS_FEE		,	INVOICE_DATE			,
		COUNTRYVAT			,	AREA_CODE				,
		SALE_TYPE			,	TAX_DESCRIPTION			,
		REPORT_VALUE_1      ,   REPORT_VALUE_2          ,
		TAX_DESCRIPTION_2   ,   VALUE_TAX_TRANS			,
		VALUE_TAX_TEXT      ,   NET_MINUS_FEE			,
		NET_MINUS_FEE_NV	,   OLD_INVOICE_NUMBER		,
		OLD_INVOICE_DATE    ,
		@invoiceMode		AS "INVOICE_MODE",
		@freeFormatText		AS "FREE_FORMAT_TEXT"
		,
		CASE WHEN CONVERT(DATETIME,INVOICE_DATE,103) > = @timeline THEN 
			CASE WHEN 
				TAX_DESCRIPTION_2 like ('%Art. 41%') OR TAX_DESCRIPTION like ('%Art. 41%')
			THEN
				'Inversione contabile'
			ELSE
				''
			END 
		ELSE
		''
		END AS [MESSAGE_INVERSIONE]
	FROM 
		@TABLE_OUTPUT
   
END