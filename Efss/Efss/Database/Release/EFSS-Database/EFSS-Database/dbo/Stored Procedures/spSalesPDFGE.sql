
-- =============================================
-- Author:		Javier
-- Create date: August 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spSalesPDFGE]
		@type				INT			  = NULL,
		@countryId			INT			  = NULL,
		@companyId			INT			  = NULL,
		@buyerId			INT			  = NULL,
		@fileDate			VARCHAR(20)   = NULL,
		@invoiceDate		VARCHAR(20)   = NULL,
		@documentType		VARCHAR(50)   = NULL,
		@documentSubType	VARCHAR(50)   = NULL,
		@docItemId			INT			  = NULL,
		@unit				VARCHAR(50)   = NULL,
		@serial				VARCHAR(50)   = NULL,
		@plate				VARCHAR(50)   = NULL,
		@manufacturer		VARCHAR(50)   = NULL,
		@buyerCode			VARCHAR(20)	  = NULL,
		@buyerName			VARCHAR(255)  = NULL,
		@invoiceFrom		INT			  = NULL,
		@invoiceTo			INT			  = NULL,
		@dateFrom			VARCHAR(25)   = NULL,
		@dateTo				VARCHAR(25)   = NULL,
		@vehicleType		VARCHAR(5)	  = NULL,
		@invoiceMode		VARCHAR(10)   = NULL,
		@freeFormatText     VARCHAR(2000) = NULL
AS
BEGIN
	
	SET NOCOUNT ON;

    DECLARE @df DATETIME ,
			@dt DATETIME
			
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
		BUYER_ID			INT				,	BUYER_CODE				VARCHAR(10)	,
		BUYER_NAME			VARCHAR(500)    ,   BUYER_TAX_CODE			VARCHAR(50)	,
		BUYER_FISCAL_CODE	VARCHAR(50)		,   
		BUYER_ADDRESS_1		VARCHAR(255)	,   BUYER_ADDRESS_2			VARCHAR(255),	
		VEHICLE_SERIAL		VARCHAR(50)     ,   VEHICLE_UNIT			VARCHAR(20)	,
		INVOICE_NET			VARCHAR(50)		,	INVOICE_VAT				VARCHAR(50)	,
		INVOICE_TOTAL		VARCHAR(50)		,   VEHICLE_PLATE			VARCHAR(20) ,
		IN_SERVICE_DATE		VARCHAR(11)		,	OUT_SERVICE_DATE		VARCHAR(11)	,	
		MSO_DATE			VARCHAR(11)		,	
		MANUFACTURER_NAME	VARCHAR(50)		,	MODEL_DESCRIPTION		VARCHAR(255),
		VAT_PCT				VARCHAR(50)		,	SUPER_CHARGE			FLOAT		,
		PLUS_KM				FLOAT			,	MILE_CHARGE				FLOAT		,	
		DAMAGE				FLOAT			,	ADD_ON					FLOAT		,
		FUEL_CHARGE			FLOAT			,	HANDLE_FEE				FLOAT		,
		CAPITAL_COST		VARCHAR(50)		,	DEPRECIATION			VARCHAR(50)	,
		MILEAGE				FLOAT			,	DAYS_IN_SERVICE			INT			,
		DAYS_MSO			INT				,	EXTRAS_TOTAL			FLOAT		,
		TODAY				VARCHAR(11)		,	INVOICE_DATE			VARCHAR(20)	,
		COUNTRYVAT			FLOAT			,	SALE_TYPE				VARCHAR(5)	,
		OLD_INVOICE_NUMBER		VARCHAR(20) ,	OLD_INVOICE_DATE		VARCHAR(20) ,
		BUYBACKCAP			VARCHAR(50)	
	)
	
	
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
		sl.DocItemId			, 
		sl.DocumentId			, 
		sl.CompanyId			, 
		CONVERT(INT,sl.InvoiceNumber)	, 
		dt.DocType				, 
		dt.DocSubType			,
		cp.CompanyCode			, 
		cp.CompanyName			, 
		cp.CompanyFiscalCode	,
		ca.Address1				, 
		ca.Address2				, 
		ca.Address3				,
		ca.Address4				, 
		sl.BuyerId				, 
		sl.BuyerCode			, 
		sl.BuyerName			,
		br.BuyerTaxCode			, 
		sl.BuyerFiscalCode		,
		sl.BuyerAddress1		, 
		sl.BuyerAddress2		,
		sl.Serial				,
		CONVERT(INT,sl.Unit)	,
		dbo.GermanMoneyFormat(CONVERT(MONEY,sl.InvoiceNet))	, 
		dbo.GermanMoneyFormat(CONVERT(MONEY,sl.InvoiceVat))	, 
		dbo.GermanMoneyFormat(CONVERT(MONEY,sl.InvoiceTotal))	, 
		sl.Plate				,
		CONVERT(VARCHAR(11),sl.InServiceDate,103)	,
		CONVERT(VARCHAR(11),sl.OutServiceDate,103)	,
		CONVERT(VARCHAR(11),sl.MSODate,103)			, 
		sl.ManufacturerName		, 
		sl.ModelDescription		,
		CONVERT(VARCHAR,cn.CountryVat) + '%'		,
		sl.SuperCharge			, 
		sl.PlusKM				, 
		sl.MileCharge			, 
		sl.Damage				, 
		sl.AddOn				, 
		sl.FuelCharge			, 
		sl.HandleFee			,
		dbo.GermanMoneyFormat(CONVERT(MONEY,sl.CapitalCost)) , 
		--dbo.GermanMoneyFormat(CONVERT(MONEY,sl.BuyBackCap)) , 
		--dbo.GermanMoneyFormat(CONVERT(MONEY,sl.Depreciation)),
		dbo.GermanMoneyFormat(CONVERT(MONEY,sl.Depreciation) + CONVERT(MONEY,sl.Amount5)),
		CONVERT(VARCHAR,sl.Mileage),
		
		CONVERT(VARCHAR,DATEDIFF(DAY,sl.InServiceDate,sl.OutServiceDate)),
		
		
		
		DATEDIFF(MONTH, sl.InServiceDate, sl.OutServiceDate) * 30 
	   + DAY(sl.OutServiceDate) 
	   - DAY(sl.InServiceDate)
	   - case when day(sl.InServiceDate)>=30 AND day(sl.OutServiceDate) = 31 then 1 else 0 end ,	
		CONVERT(VARCHAR,sl.SuperCharge	+ sl.HandleFee) ,
		CONVERT(VARCHAR(11),GETDATE(),104),
		CONVERT(VARCHAR(11),sl.InvoiceDate,103) ,
		cn.CountryVat			,
		sl.SaleType ,
		sl.OldInvoiceNumber ,
		CONVERT(VARCHAR(11),sl.OldInvoiceDate,103),
		dbo.GermanMoneyFormat(CONVERT(MONEY,sl.BuyBackCap))
		FROM [Archive.Sales] sl
		INNER JOIN [Application.FileLog] AS fl ON sl.LogId = fl.LogId
		INNER JOIN 
			[Dimension.DocumentTypes]	AS dt ON sl.DocumentTypeId	= dt.DocumentTypeId
		INNER JOIN 
			[Dimension.Companies]		AS cp ON sl.CompanyId		= cp.CompanyId
		INNER JOIN 
			[Dimension.CompanyAddress]  AS ca ON sl.CompanyId		= ca.CompanyId
		INNER JOIN 
			[Dimension.Buyers]			AS br ON sl.BuyerId			= br.BuyerId
		INNER JOIN 
			[Dimension.Countries]		AS cn ON sl.CountryId		= cn.CountryId
		INNER JOIN 
			[Fact.Documents]			AS dc ON sl.DocumentId		= dc.DocumentId
		INNER JOIN 
			[Fact.BuyersAddress]		AS ba ON sl.BuyerId			= ba.BuyerId
											AND  sl.ContactTypeId   = ba.ContactTypeId
											AND  ba.Position		= 1 
											
		WHERE 
				sl.CountryId = 4
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
	ELSE IF @type = 2
	BEGIN
		INSERT INTO @TABLE_OUTPUT
	
		SELECT 
		sl.DocItemId			, 
		sl.DocumentId			, 
		sl.CompanyId			, 
		CONVERT(INT,sl.InvoiceNumber)	, 
		dt.DocType				, 
		dt.DocSubType			,
		cp.CompanyCode			, 
		cp.CompanyName			, 
		cp.CompanyFiscalCode	,
		ca.Address1				, 
		ca.Address2				, 
		ca.Address3				,
		ca.Address4				, 
		sl.BuyerId				, 
		sl.BuyerCode			, 
		sl.BuyerName			,
		br.BuyerTaxCode			, 
		sl.BuyerFiscalCode		,
		sl.BuyerAddress1		, 
		sl.BuyerAddress2		,
		sl.Serial				,
		CONVERT(INT,sl.Unit)	,
		dbo.GermanMoneyFormat(CONVERT(MONEY,sl.InvoiceNet))	, 
		dbo.GermanMoneyFormat(CONVERT(MONEY,sl.InvoiceVat))	, 
		dbo.GermanMoneyFormat(CONVERT(MONEY,sl.InvoiceTotal))	, 
		sl.Plate				,
		CONVERT(VARCHAR(11),sl.InServiceDate,103)	,
		CONVERT(VARCHAR(11),sl.OutServiceDate,103)	,
		CONVERT(VARCHAR(11),sl.MSODate,103)			, 
		sl.ManufacturerName		, 
		sl.ModelDescription		,
		CONVERT(VARCHAR,cn.CountryVat) + '%'		,
		sl.SuperCharge			, 
		sl.PlusKM				, 
		sl.MileCharge			, 
		sl.Damage				, 
		sl.AddOn				, 
		sl.FuelCharge			, 
		sl.HandleFee			,
		dbo.GermanMoneyFormat(CONVERT(MONEY,sl.CapitalCost)) , 
		
		--dbo.GermanMoneyFormat(CONVERT(MONEY,sl.Depreciation)),
		dbo.GermanMoneyFormat(CONVERT(MONEY,sl.Depreciation) + CONVERT(MONEY,sl.Amount5)),
		CONVERT(VARCHAR,sl.Mileage),
		CONVERT(VARCHAR,DATEDIFF(DAY,sl.InServiceDate,sl.OutServiceDate)),
		
		DATEDIFF(MONTH, sl.InServiceDate, sl.OutServiceDate) * 30 
	   + DAY(sl.OutServiceDate) 
	   - DAY(sl.InServiceDate)
	   - case when day(sl.InServiceDate)>=30 AND day(sl.OutServiceDate) = 31 then 1 else 0 end ,
	   
		--CONVERT(INT,
		--CEILING(
		--	(

		--	CONVERT(MONEY,DATEDIFF(DAY,sl.MSODate,sl.OutServiceDate)) * 
			
		--	CASE WHEN bt.Rate IS NULL THEN CONVERT(MONEY,360.00) ELSE  CONVERT(MONEY,bt.Rate) END )
			
		--	/ CONVERT(MONEY,365.00) 
			
		--	)),
		CONVERT(VARCHAR,sl.SuperCharge	+ sl.HandleFee) ,
		CONVERT(VARCHAR(11),GETDATE(),104),
		CONVERT(VARCHAR(11),sl.InvoiceDate,103) ,
		cn.CountryVat			,
		sl.SaleType,
		sl.OldInvoiceNumber ,
		CONVERT(VARCHAR(11),sl.OldInvoiceDate,103),
		dbo.GermanMoneyFormat(CONVERT(MONEY,sl.BuyBackCap))
		
		FROM [Archive.Sales] sl
		INNER JOIN [Application.FileLog] AS fl ON sl.LogId = fl.LogId
		INNER JOIN 
			[Dimension.DocumentTypes]	AS dt ON sl.DocumentTypeId	= dt.DocumentTypeId
		INNER JOIN 
			[Dimension.Companies]		AS cp ON sl.CompanyId		= cp.CompanyId
		INNER JOIN 
			[Dimension.CompanyAddress]  AS ca ON sl.CompanyId		= ca.CompanyId
		INNER JOIN 
			[Dimension.Buyers]			AS br ON sl.BuyerId			= br.BuyerId
		INNER JOIN 
			[Dimension.Countries]		AS cn ON sl.CountryId		= cn.CountryId
		INNER JOIN 
			[Fact.Documents]			AS dc ON sl.DocumentId		= dc.DocumentId
		INNER JOIN 
			[Fact.BuyersAddress]		AS ba ON sl.BuyerId			= ba.BuyerId
											AND  sl.ContactTypeId   = ba.ContactTypeId
											AND  ba.Position		= 1 
		--LEFT JOIN 
		--	[Dimension.BuyersRate]		AS bt ON  sl.CompanyCode = bt.CompanyCode 
		--									AND	  sl.BuyerCode = bt.BuyerCode 
		--									AND   sl.ModelCode= bt.ModelCode 
		--									AND   sl.ModelYear = bt.ModelYear
		WHERE 
				sl.CountryId = 4
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
		sl.DocItemId			, 
		sl.DocumentId			, 
		sl.CompanyId			, 
		CONVERT(INT,sl.InvoiceNumber)	, 
		dt.DocType				, 
		dt.DocSubType			,
		cp.CompanyCode			, 
		cp.CompanyName			, 
		cp.CompanyFiscalCode	,
		ca.Address1				, 
		ca.Address2				, 
		ca.Address3				,
		ca.Address4				, 
		sl.BuyerId				, 
		sl.BuyerCode			, 
		sl.BuyerName			,
		br.BuyerTaxCode			, 
		sl.BuyerFiscalCode		,
		sl.BuyerAddress1		, 
		sl.BuyerAddress2		,
		sl.Serial				,
		CONVERT(INT,sl.Unit)	,
		dbo.GermanMoneyFormat(CONVERT(MONEY,sl.InvoiceNet))	, 
		dbo.GermanMoneyFormat(CONVERT(MONEY,sl.InvoiceVat))	, 
		dbo.GermanMoneyFormat(CONVERT(MONEY,sl.InvoiceTotal))	, 
		sl.Plate				,
		CONVERT(VARCHAR(11),sl.InServiceDate,103)	,
		CONVERT(VARCHAR(11),sl.OutServiceDate,103)	,
		CONVERT(VARCHAR(11),sl.MSODate,103)			, 
		sl.ManufacturerName		, 
		sl.ModelDescription		,
		CONVERT(VARCHAR,cn.CountryVat) + '%'		,
		sl.SuperCharge			, 
		sl.PlusKM				, 
		sl.MileCharge			, 
		sl.Damage				, 
		sl.AddOn				, 
		sl.FuelCharge			, 
		sl.HandleFee			,
		dbo.GermanMoneyFormat(CONVERT(MONEY,sl.CapitalCost)) , 
		--dbo.GermanMoneyFormat(CONVERT(MONEY,sl.Depreciation)),
		dbo.GermanMoneyFormat(CONVERT(MONEY,sl.Depreciation) + CONVERT(MONEY,sl.Amount5)),
		CONVERT(VARCHAR,sl.Mileage),
		CONVERT(VARCHAR,DATEDIFF(DAY,sl.InServiceDate,sl.OutServiceDate)),
		
		
		DATEDIFF(MONTH, sl.InServiceDate, sl.OutServiceDate) * 30 
	   + DAY(sl.OutServiceDate) 
	   - DAY(sl.InServiceDate)
	   - case when day(sl.InServiceDate)>=30 AND day(sl.OutServiceDate) = 31 then 1 else 0 end ,
		
		--CONVERT(INT,
		--CEILING(
		--	(

		--	CONVERT(MONEY,DATEDIFF(DAY,sl.MSODate,sl.OutServiceDate)) * 
			
		--	CASE WHEN bt.Rate IS NULL THEN CONVERT(MONEY,360.00) ELSE  CONVERT(MONEY,bt.Rate) END )
			
		--	/ CONVERT(MONEY,365.00) 
			
		--	)),
		
		CONVERT(VARCHAR,sl.SuperCharge	+ sl.HandleFee) ,
		CONVERT(VARCHAR(11),GETDATE(),104),
		CONVERT(VARCHAR(11),sl.InvoiceDate,103) ,
		cn.CountryVat			,
		sl.SaleType,
		sl.OldInvoiceNumber ,
		CONVERT(VARCHAR(11),sl.OldInvoiceDate,103),
		dbo.GermanMoneyFormat(CONVERT(MONEY,sl.BuyBackCap))
		
		FROM [Archive.Sales] sl
		INNER JOIN 
			[Dimension.DocumentTypes]	AS dt ON sl.DocumentTypeId	= dt.DocumentTypeId
		INNER JOIN 
			[Dimension.Companies]		AS cp ON sl.CompanyId		= cp.CompanyId
		INNER JOIN 
			[Dimension.CompanyAddress]  AS ca ON sl.CompanyId		= ca.CompanyId
		INNER JOIN 
			[Dimension.Buyers]			AS br ON sl.BuyerId			= br.BuyerId
		INNER JOIN 
			[Dimension.Countries]		AS cn ON sl.CountryId		= cn.CountryId
		INNER JOIN 
			[Fact.Documents]			AS dc ON sl.DocumentId		= dc.DocumentId
		INNER JOIN 
			[Fact.BuyersAddress]		AS ba ON sl.BuyerId			= ba.BuyerId
											AND  sl.ContactTypeId   = ba.ContactTypeId
											AND  ba.Position		= 1 
		--LEFT JOIN 
		--	[Dimension.BuyersRate]		AS bt ON  sl.CompanyCode = bt.CompanyCode 
		--									AND	  sl.BuyerCode = bt.BuyerCode 
		--									AND   sl.ModelCode= bt.ModelCode 
		--									AND   sl.ModelYear = bt.ModelYear
		WHERE 
				sl.CountryId = 4
			AND
				sl.DocItemId = @docItemId
	
	END
	
	
	
	UPDATE @TABLE_OUTPUT SET BUYER_TAX_CODE		= BUYER_FISCAL_CODE WHERE BUYER_TAX_CODE    IS NULL
	UPDATE @TABLE_OUTPUT SET BUYER_FISCAL_CODE	= BUYER_TAX_CODE    WHERE BUYER_FISCAL_CODE IS NULL
	
	IF @freeFormatText IS NULL	BEGIN SET @freeFormatText	= '' END
	
	IF @invoiceMode = '1' OR @invoiceMode is null		
	BEGIN SET @invoiceMode		= '' END ELSE BEGIN SET @invoiceMode = 'KOPIE' END
	
	
	UPDATE @TABLE_OUTPUT SET BUYER_ADDRESS_1 = '' WHERE BUYER_ADDRESS_1 = 'UNKNOWN'
	UPDATE @TABLE_OUTPUT SET BUYER_ADDRESS_2 = '' WHERE BUYER_ADDRESS_2 = 'UNKNOWN'
	
	UPDATE @TABLE_OUTPUT SET OLD_INVOICE_NUMBER = '' WHERE OLD_INVOICE_NUMBER IS NULL

	
	SELECT 
		DOCITEMID			, DOCUMENTID			, COMPANYID				, 
		DOCUMENT_NUMBER		, DOCUMENT_TYPE			, DOCUMENT_SUB_TYPE		,
		COMPANY_CODE		, COMPANY_NAME			, COMPANY_FISCAL_CODE	,
		COMPANY_ADDRESS_1	, COMPANY_ADDRESS_2		, COMPANY_ADDRESS_3		, 
		COMPANY_ADDRESS_4	, BUYER_ID				, BUYER_CODE			, 
		BUYER_NAME			, BUYER_TAX_CODE		,
		BUYER_FISCAL_CODE	, BUYER_ADDRESS_1		, BUYER_ADDRESS_2		,	
		VEHICLE_SERIAL		, VEHICLE_UNIT			, INVOICE_NET			, 
		INVOICE_VAT			, 
		INVOICE_TOTAL		, VEHICLE_PLATE ,
		IN_SERVICE_DATE		, OUT_SERVICE_DATE		, MSO_DATE			, 
		MANUFACTURER_NAME	, MODEL_DESCRIPTION		,
		VAT_PCT				, SUPER_CHARGE			, PLUS_KM			,
		MILE_CHARGE			, DAMAGE				, ADD_ON			,
		FUEL_CHARGE			, HANDLE_FEE			, CAPITAL_COST		, 
		DEPRECIATION		, MILEAGE				, DAYS_IN_SERVICE	,
		DAYS_MSO			, EXTRAS_TOTAL			, TODAY				, 
		INVOICE_DATE		, COUNTRYVAT			, SALE_TYPE			,
		@invoiceMode		AS "INVOICE_MODE",
		@freeFormatText		AS "FREE_FORMAT_TEXT"	,
		OLD_INVOICE_NUMBER		,
		OLD_INVOICE_DATE    , BUYBACKCAP
	FROM @TABLE_OUTPUT 
END