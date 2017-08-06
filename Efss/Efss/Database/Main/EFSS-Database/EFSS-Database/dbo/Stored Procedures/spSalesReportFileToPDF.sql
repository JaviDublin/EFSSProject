-- =============================================
-- Author:		Javier
-- Create date: May 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spSalesReportFileToPDF]
		@countryId			INT = NULL,
		@companyId			INT = NULL,
		@buyerId			INT = NULL,
		@fileDate			VARCHAR(20) = NULL,
		@invoiceDate		VARCHAR(20) = NULL,
		@documentType		VARCHAR(50) = NULL,
		@documentSubType	VARCHAR(50) = NULL,
		@docItemId			INT = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

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
		BUYER_ADDRESS_3		VARCHAR(255)	,   BUYER_ADDRESS_4			VARCHAR(255),	
		BUYER_ADDRESS_5		VARCHAR(255)	,	BUYER_ADDRESS_6			VARCHAR(255),
		VEHICLE_SERIAL		VARCHAR(50)     ,   VEHICLE_UNIT			VARCHAR(20)	,
		INVOICE_NET			FLOAT			,	INVOICE_VAT				FLOAT		,
		INVOICE_TOTAL		FLOAT			,   VEHICLE_PLATE			VARCHAR(20) ,
		IN_SERVICE_DATE		VARCHAR(11)		,	OUT_SERVICE_DATE		VARCHAR(11)	,	
		MSO_DATE			VARCHAR(11)		,	CAR_COLOR				VARCHAR(20) ,
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
		CALC_PLUS_UMT		FLOAT			,	INVOICE_DATE			VARCHAR(20)	,
		COUNTRYVAT			FLOAT
	)
	
	
	INSERT INTO @TABLE_OUTPUT
	
	SELECT
		di.DocItemId		, dc.DocumentId			, cp.CompanyId , 
		dc.DocumentNumber	, dt.DocType			, dt.DocSubType ,
		cp.CompanyCode		, cp.CompanyName		, cp.CompanyFiscalCode ,
		ca.Address1			, ca.Address2			, ca.Address3 ,
		ca.Address4			, ca.Address5			, ca.Address6 ,
		ca.Address7			, ca.Address8			, ca.Address9 ,
	    ca.Address10		, ca.Address11			, ca.Address12,
	    br.BuyerId			, br.BuyerCode			, br.BuyerName,
		br.BuyerTaxCode		, br.BuyerFiscalCode	, bt.BuyerType , 
		ba.BuyerAddress1	, ba.BuyerAddress2		, ba.BuyerAddress3 ,
		ba.BuyerAddress4	, ba.BuyerAddress5		, ba.BuyerAddress6 ,
		vh.Serial			, vh.Unit				, it.Value			, 
		it.Vat				, it.Total				, sl.Plate		,
		CONVERT(VARCHAR(11),sl.InServiceDate,103)	,
		CONVERT(VARCHAR(11),sl.OutServiceDate,103)	,
		CONVERT(VARCHAR(11),sl.MSODate,103)			,
		sl.CarColor			, mf.ManufacturerName	, md.ModelDescription	,
		CONVERT(VARCHAR,cn.CountryVat) + '%'		,
		sl.SuperCharge , sl.RegTaxAmount			,
		sl.PlusKM			, sl.MileCharge			, sl.Damage			, sl.Amount5,
		sl.AddOn			, sl.Amount6			, sl.Amount7		, sl.FuelCharge , sl.HandleFee,
		sl.Other1			, sl.Other2				, sl.CapitalCost	, sl.BookValue	, 
		
		LEFT(CONVERT(CHAR(14),CAST(sl.BuyBackCap AS MONEY),1),14),
		sl.Depreciation,
		CONVERT(VARCHAR,sl.Mileage),
		CONVERT(VARCHAR,DATEDIFF(DAY,sl.InServiceDate,sl.OutServiceDate)),
		CONVERT(VARCHAR,DATEDIFF(DAY,sl.MSODate,sl.OutServiceDate)),
		CONVERT(VARCHAR,sl.SuperCharge	+ sl.HandleFee) ,
		CONVERT(VARCHAR(11),GETDATE(),104),
		'RV ' + CASE WHEN CONVERT(FLOAT,sl.BuyBackCap) = 0 THEN '0' ELSE
			CONVERT(VARCHAR,ROUND(
				( CONVERT(FLOAT,sl.BookValue) / CONVERT(FLOAT,sl.BuyBackCap) ) *100,1)) END + ' %' ,
		
		sl.TransferFees , sl.TransferFeesNoVat , it.Value + sl.TransferFees,
		sl.OriginalBPM , sl.CalcVatAmortized,
		sl.Unamortized , sl.CalcVatAmortized + sl.Unamortized,
		CONVERT(VARCHAR(11),sl.InvoiceDate,103) ,
		cn.CountryVat
	
	FROM [Fact.DocumentItems] di
	INNER JOIN [Fact.Documents]				AS dc ON di.DocumentId		= dc.DocumentId
	INNER JOIN [Fact.Items]					AS it ON di.ItemId			= it.ItemId
	INNER JOIN [Fact.Vehicles]				AS vh ON it.DescriptionId	= vh.VehicleId
	INNER JOIN [Dimension.DocumentTypes]	AS dt ON dc.DocumentTypeId	= dt.DocumentTypeId
	INNER JOIN [Dimension.Companies]		AS cp ON di.CompanyId		= cp.CompanyId
	INNER JOIN [Dimension.CompanyAddress]   AS ca ON cp.CompanyId		= ca.CompanyId
	INNER JOIN [Dimension.Countries]		AS cn ON cp.CountryId		= cn.CountryId
	INNER JOIN [Dimension.ContactTypes]     AS ct ON cp.CompanyId		= ct.CompanyId
	INNER JOIN [Dimension.Buyers]			AS br ON dc.BuyerId			= br.BuyerId
	INNER JOIN [Dimension.BuyerTypes]		AS bt ON br.BuyerTypeId		= bt.BuyerTypeId
	INNER JOIN [Fact.BuyersAddress]			AS ba ON dc.BuyerId         = ba.BuyerId
											AND  ct.ContactTypeId   = ba.ContactTypeId
											AND  ba.Position		= 1  
	LEFT  JOIN [Archive.Sales]				AS sl ON vh.VehicleId = sl.VehicleId
											AND  cp.CompanyId     = sl.CompanyId
	INNER JOIN [Dimension.ModelDetails]		AS md ON sl.ModelDetailId   = md.ModelDetailId
	INNER JOIN [Dimension.Manufacturer]		AS mf ON md.ManufacturerId  = mf.ManufacturerId
	WHERE 
			 cp.CountryId = @countryId
		AND 
			((@buyerId IS NULL)		OR ( br.BuyerId		=  @buyerId))
		AND 
			((@companyId IS NULL)	OR (cp.CompanyId	= @companyId))
		AND 
			((@fileDate IS NULL)	OR (CONVERT(VARCHAR(11),dc.DateCreated,103) = @fileDate))
		AND 
			((@invoiceDate IS NULL) OR (CONVERT(VARCHAR(11),sl.InvoiceDate,103) = @invoiceDate))
		AND
			((@documentType IS NULL) OR ( dt.DocType = @documentType))
		AND
			((@documentSubType IS NULL) OR (dt.DocSubType =  @documentSubType))
		AND 
			((@docItemId IS NULL) OR (di.DocItemId = @docItemId))
	GROUP BY
		di.DocItemId , dc.DocumentId , cp.CompanyId , 
		dc.DocumentNumber , dt.DocType , dt.DocSubType ,
		cp.CompanyCode   , cp.CompanyName	  , cp.CompanyFiscalCode ,
		ca.Address1		 , ca.Address2		  , ca.Address3 ,
		ca.Address4		 , ca.Address5		  , ca.Address6 ,
		ca.Address7		 , ca.Address8		  , ca.Address9 ,
	    ca.Address10     , ca.Address11		  , ca.Address12,
	    br.BuyerId		 , br.BuyerCode		  , br.BuyerName,
		br.BuyerTaxCode	 , br.BuyerFiscalCode , bt.BuyerType , 
		ba.BuyerAddress1 , ba.BuyerAddress2   , ba.BuyerAddress3 ,
		ba.BuyerAddress4 , ba.BuyerAddress5   , ba.BuyerAddress6 ,
		vh.Serial , vh.Unit ,	it.Value , it.Vat , it.Total ,
		sl.Plate,
		CONVERT(VARCHAR(11),sl.InServiceDate,103),
		CONVERT(VARCHAR(11),sl.OutServiceDate,103),
		CONVERT(VARCHAR(11),sl.MSODate,103) ,
		sl.CarColor , mf.ManufacturerName ,md.ModelDescription ,
		CONVERT(VARCHAR,cn.CountryVat) + '%'      ,
		sl.SuperCharge , sl.RegTaxAmount,
		sl.PlusKM , sl.MileCharge , sl.Damage ,	sl.Amount5,
		sl.AddOn  , sl.Amount6 , sl.Amount7     , sl.FuelCharge , sl.HandleFee,
		sl.Other1 , sl.Other2  , sl.CapitalCost , sl.BookValue ,
		sl.BuyBackCap , sl.Depreciation , sl.Mileage ,
		CONVERT(VARCHAR,DATEDIFF(DAY,sl.InServiceDate,sl.OutServiceDate)),
		CONVERT(VARCHAR,DATEDIFF(DAY,sl.MSODate,sl.OutServiceDate)) , sl.SuperCharge ,sl.HandleFee ,
		sl.TransferFees , sl.TransferFeesNoVat , 
		sl.OriginalBPM	, sl.CalcVatAmortized,
		sl.Unamortized	,
		CONVERT(VARCHAR(11),sl.InvoiceDate,103) ,
		cn.CountryVat
	ORDER BY 
		cp.CompanyCode , br.BuyerCode
	
	SELECT 
		DOCITEMID			, DOCUMENTID			, COMPANYID , 
		DOCUMENT_NUMBER		, DOCUMENT_TYPE			, DOCUMENT_SUB_TYPE , COMPANY_CODE		,
		COMPANY_NAME		, COMPANY_FISCAL_CODE	,
		COMPANY_ADDRESS_1	, COMPANY_ADDRESS_2		, COMPANY_ADDRESS_3 ,COMPANY_ADDRESS_4	,
		COMPANY_ADDRESS_5	, COMPANY_ADDRESS_6		, COMPANY_ADDRESS_7 ,COMPANY_ADDRESS_8	,
		COMPANY_ADDRESS_9	, COMPANY_ADDRESS_10	, COMPANY_ADDRESS_11,COMPANY_ADDRESS_12	,
		BUYER_ID			, BUYER_CODE			, BUYER_NAME		, BUYER_TAX_CODE	,
		BUYER_FISCAL_CODE	, BUYER_TYPE			, BUYER_ADDRESS_1	, BUYER_ADDRESS_2	,	
		BUYER_ADDRESS_3		, BUYER_ADDRESS_4		, BUYER_ADDRESS_5	, BUYER_ADDRESS_6	,
		VEHICLE_SERIAL		, VEHICLE_UNIT			, INVOICE_NET		, INVOICE_VAT		, 
		INVOICE_TOTAL		, VEHICLE_PLATE ,
		IN_SERVICE_DATE		, OUT_SERVICE_DATE		, MSO_DATE , CAR_COLOR ,
		MANUFACTURER_NAME	, MODEL_DESCRIPTION ,
		VAT_PCT				, SUPER_CHARGE		, REG_TAX_AMOUNT, PLUS_KM			,
		MILE_CHARGE			, DAMAGE			, AMOUNT_5		, ADD_ON			,
		AMOUNT_6			, AMOUNT_7			, FUEL_CHARGE	, HANDLE_FEE		,
		OTHER_1				, OTHER_2 			, CAPITAL_COST  , BOOK_VALUE		,
		BUYBACK_CAP			, DEPRECIATION		, MILEAGE		, DAYS_IN_SERVICE	,
		DAYS_MSO			, EXTRAS_TOTAL		, TODAY			, INVOICE_DET		,
		TRANSFER_FEES		, TRANSFER_FEES_NO_VAT				, NET_PLUS_FEE		,	ORIGINAL_BPM ,
		CALC_VAT_AMT		, UN_AMT			,CALC_PLUS_UMT	,	INVOICE_DATE ,
		COUNTRYVAT			
	FROM @TABLE_OUTPUT
		
END