-- =============================================
-- Author:		Javier
-- Create date: September 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spReportsDashboardListing]
		@companyId		INT = NULL	,
		@countryId		INT = NULL	,
		@manufacturerid INT = NULL  ,
		@buyerName		VARCHAR(255) = NULL,
		@buyback		VARCHAR(50) = NULL	,
		@nrbounus		VARCHAR(50) = NULL  ,
		@vbouns			VARCHAR(50) = NULL  ,
		@open			VARCHAR(1)  = NULL  ,
		@matched        VARCHAR(1)  = NULL  ,
		@unapplied		VARCHAR(1)  = NULL
AS
BEGIN
	
	SET NOCOUNT ON;
	
	IF @companyId		= 0		BEGIN SET @companyId		= NULL END
	IF @manufacturerid	= 0		BEGIN SET @manufacturerid	= NULL END
	IF @buyerName		= '0'	BEGIN SET @buyerName		= NULL END
	
	DECLARE @docSubType INT = NULL
	DECLARE @tableTypes TABLE (RecvType VARCHAR(20))
	IF @buyback IS NOT NULL AND @buyback <> '0'
	BEGIN
		INSERT INTO @tableTypes
		SELECT RecvType FROM [Dimension.ReceivableTypes] WHERE DocSubType = 'BUYBACK'
	END
	
	IF @nrbounus IS NOT NULL AND @nrbounus <> '0'
	BEGIN
		INSERT INTO @tableTypes
		SELECT RecvType FROM [Dimension.ReceivableTypes] WHERE DocSubType = 'NON RETURN BONUS'
	END
	
	IF @vbouns IS NOT NULL AND @vbouns <> '0'
	BEGIN
		INSERT INTO @tableTypes
		SELECT RecvType FROM [Dimension.ReceivableTypes] WHERE DocSubType = 'VOLUME BONUS'
	END
	
	SET @docSubType = (SELECT COUNT(*) FROM @tableTypes)
	IF @docSubType = 0 BEGIN SET @docSubType = NULL END
	
	DECLARE @tableStatus table(OMU varchar(1))
	IF @open IS NOT NULL
	BEGIN
		INSERT INTO @tableStatus VALUES (@open)
	END
	
	IF @matched IS NOT NULL
	BEGIN
		INSERT INTO @tableStatus VALUES (@matched)
	END
	
	IF @unapplied IS NOT NULL
	BEGIN
		INSERT INTO @tableStatus VALUES (@unapplied)
	END
	
	DECLARE @status INT
	SET @status =  (SELECT COUNT(*) FROM @tableStatus)
	IF @status = 0 BEGIN SET @status = NULL END
	
	
	DECLARE @Vehicles TABLE (VehicleId INT , BuyerName VARCHAR(255), Mileage INT , 
								InvoiceDate DATETIME, Position INT)
	INSERT INTO @Vehicles
	SELECT [Archive.Sales].VehicleId , [Archive.Sales].BuyerName , MAX([Archive.Sales].Mileage) , 
	[Archive.Sales].InvoiceDate,
	ROW_NUMBER() OVER (PARTITION BY [Archive.Sales].VehicleId ORDER BY (SELECT 0)) AS RNS
	FROM [Archive.Sales]
	INNER JOIN [Staging.Dashboard] ON 
		[Archive.Sales].Serial = [Staging.Dashboard].Serial 
	AND [Archive.Sales].CompanyCode = [Staging.Dashboard].CompanyCode
	GROUP BY 
		[Archive.Sales].VehicleId , [Archive.Sales].BuyerName , [Archive.Sales].InvoiceDate
	ORDER BY 
		[Archive.Sales].VehicleId , [Archive.Sales].InvoiceDate DESC
		
	DELETE FROM @Vehicles WHERE Position >= 2
	
	
	SELECT 
		[Staging.Dashboard].CompanyCode ,
		[Staging.Dashboard].Serial , 
		[Staging.Dashboard].Plate,
		[Staging.Dashboard].RecvType , 
		[Staging.Dashboard].ManufacturerName,
		v.BuyerName,
		CONVERT(VARCHAR(11),[Staging.Dashboard].InvoiceDate,103) as "InvoiceDate" , -- 'Sale date'
		[Staging.Dashboard].SaleDocumentNumber,
		
		CASE WHEN [Dimension.ReceivableTypes].DocSubType = 'VOLUME BONUS' THEN
				REPLACE(CONVERT(VARCHAR,[Staging.Dashboard].InvoiceNbr),'/','\')
		ELSE
			CASE WHEN [Dimension.ReceivableTypes].DocSubType = 'NON RETURN BONUS' THEN
				REPLACE(CONVERT(VARCHAR,[Staging.Dashboard].InvoiceNbr),'/','\')
			ELSE
				CONVERT(VARCHAR,[Staging.Dashboard].InvoiceNumber)
			END
		END AS "InvoiceNumber" ,
		
		[Staging.Dashboard].RecvAmt  AS "RecvAmt",
		[Staging.Dashboard].OMU			AS "OMU",
		CONVERT(VARCHAR(11),[Staging.Dashboard].OutServiceDate,103) AS "OutServiceDate",
		CONVERT(VARCHAR(11),[Staging.Dashboard].InServiceDate,103) AS "InServiceDate",
		CONVERT(VARCHAR,[Staging.Dashboard].CapitalCost) AS "CapitalCost",
		CONVERT(VARCHAR,[Staging.Dashboard].Depreciation) AS "Depreciation",
		CONVERT(VARCHAR,[Staging.Dashboard].NetRecv) AS "NetRecv",
		CONVERT(VARCHAR,v.Mileage) AS "Mileage",
		[Staging.Dashboard].PurchInvoiceNumber,
		CONVERT(VARCHAR(11),[Staging.Dashboard].RecvDueDate,103) AS "RecvDueDate",
		
		CASE WHEN 
			CONVERT(VARCHAR(11),[Staging.Dashboard].DueDtAge,103) = '8-30'
		THEN
			CHAR(39) + CONVERT(VARCHAR(11),[Staging.Dashboard].DueDtAge,103)
		ELSE
			CONVERT(VARCHAR(11),[Staging.Dashboard].DueDtAge,103) 
		END AS "DueDtAge"
		
	FROM [Staging.Dashboard]
	LEFT JOIN @Vehicles AS v ON 
		[Staging.Dashboard].VehicleId = v.VehicleId
	LEFT JOIN [Dimension.ReceivableTypes] ON
		[Staging.Dashboard].RecvType = [Dimension.ReceivableTypes].RecvType
	WHERE 
		[Staging.Dashboard].GroupId		= @countryId 
		--[Staging.Dashboard].CountryId = @countryId 
	AND
		((@companyId	IS NULL) OR ([Staging.Dashboard].CompanyId = @companyId))
	AND 
		((@manufacturerid IS NULL) OR ([Staging.Dashboard].ManufacturerId = @manufacturerid))
	AND 
		((@buyerName	IS NULL) OR (v.BuyerName = @buyerName))
	AND
		((@docSubType	IS NULL) OR ([Staging.Dashboard].RecvType IN (SELECT RecvType FROM @tableTypes)))
	AND 
		((@status		IS NULL) OR ([Staging.Dashboard].OMU IN (SELECT OMU FROM @tableStatus)))
		
		
END