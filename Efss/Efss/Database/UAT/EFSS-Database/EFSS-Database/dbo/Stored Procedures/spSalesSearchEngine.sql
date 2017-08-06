-- =============================================
-- Author:		Javier
-- Create date: May 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spSalesSearchEngine]
		@sortExpression		VARCHAR(50)=NULL,
		@maximumRows		INT=NULL,
		@startRowIndex		INT=NULL,
		@companyId			INT=NULL,
		@plate				VARCHAR(50) = NULL,
		@unit				VARCHAR(50) = NULL,
		@serial				VARCHAR(50) = NULL,
		@dateFrom			VARCHAR(25) = NULL,
		@dateTo				VARCHAR(25) = NULL,
		@invoiceFrom		INT			= NULL,
		@invoiceTo			INT			= NULL,
		@buyerCode			VARCHAR(20)	= NULL,
		@buyerName			VARCHAR(255)= NULL,
		@invoiceType		VARCHAR(50) = NULL,
		@invoiceSubType		VARCHAR(50) = NULL,
		@manufacturer		VARCHAR(50) = NULL,
		@vehicleType		VARCHAR(5)	= NULL,
		@saleType			VARCHAR(5)	= NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
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
	
	IF @invoiceFrom = 0 BEGIN SET @invoiceFrom = NULL END
	IF @invoiceTo   = 0 BEGIN SET @invoiceTo   = NULL END

	SELECT 
	t.[count] as 'Count' , t.DocItemId , t.Serial , t.Plate , t.Unit , t.DocumentNumber , 
	convert(varchar(11),t.InvoiceDate,103) as "InvoiceDate" , 
	t.DocType , t.DocSubType , t.BuyerCode , t.BuyerName , t.ModelCode , t.ManufacturerName , t.VehicleType
	FROM
	(
	
		SELECT 
		COUNT(u.DocItemId) OVER() as 'Count' ,
		ROW_NUMBER() OVER 
		(
			ORDER BY
			CASE WHEN @sortExpression = 'Serial' THEN v.Serial END ASC,
			CASE WHEN @sortExpression = 'Serial DESC' THEN v.Serial END DESC,
			CASE WHEN @sortExpression = 'Plate' THEN a.Plate END ASC,
			CASE WHEN @sortExpression = 'Plate DESC' THEN a.Plate END DESC,
			CASE WHEN @sortExpression = 'Unit' THEN v.Unit END ASC,
			CASE WHEN @sortExpression = 'Unit DESC' THEN v.Unit END DESC,
			CASE WHEN @sortExpression = 'DocumentNumber' THEN d.DocumentNumber END ASC,
			CASE WHEN @sortExpression = 'DocumentNumber DESC' THEN d.DocumentNumber END DESC,
			CASE WHEN @sortExpression = 'InvoiceDate' THEN a.InvoiceDate END ASC,
			CASE WHEN @sortExpression = 'InvoiceDate DESC' THEN a.InvoiceDate END DESC,
			CASE WHEN @sortExpression = 'DocType' THEN t.DocType END ASC,
			CASE WHEN @sortExpression = 'DocType DESC' THEN t.DocType END DESC,
			CASE WHEN @sortExpression = 'DocSubType' THEN t.DocSubType END ASC,
			CASE WHEN @sortExpression = 'DocSubType DESC' THEN t.DocSubType END DESC,
			CASE WHEN @sortExpression = 'BuyerCode' THEN b.BuyerCode END ASC,
			CASE WHEN @sortExpression = 'BuyerCode DESC' THEN b.BuyerCode END DESC,
			CASE WHEN @sortExpression = 'BuyerName' THEN b.BuyerName END ASC,
			CASE WHEN @sortExpression = 'BuyerName DESC' THEN b.BuyerName END DESC,
			CASE WHEN @sortExpression = 'ModelCode' THEN a.ModelCode END ASC,
			CASE WHEN @sortExpression = 'ModelCode DESC' THEN a.ModelCode END DESC,
			CASE WHEN @sortExpression = 'ManufacturerName' THEN a.ManufacturerName END ASC,
			CASE WHEN @sortExpression = 'ManufacturerName DESC' THEN a.ManufacturerName END DESC,
			CASE WHEN @sortExpression = 'VehicleType' THEN a.VehicleType END ASC,
			CASE WHEN @sortExpression = 'VehicleType DESC' THEN a.VehicleType END DESC
		)
		AS ROW,
		u.DocItemId , v.Serial , a.Plate , v.Unit , d.DocumentNumber ,
		a.InvoiceDate , t.DocType , t.DocSubType ,
		b.BuyerCode , b.BuyerName , a.ModelCode , a.ManufacturerName , a.VehicleType 
		FROM [Fact.DocumentItems] u
		INNER JOIN [Fact.Items]					AS i ON u.ItemId			= i.ItemId
		INNER JOIN [Fact.Vehicles]				AS v ON i.DescriptionId		= v.VehicleId
		INNER JOIN [Fact.Documents]				AS d ON u.DocumentId		= d.DocumentId
		INNER JOIN [Dimension.DocumentTypes]	AS t ON d.DocumentTypeId	= t.DocumentTypeId
		INNER JOIN [Dimension.Buyers]			AS b ON d.BuyerId			= b.BuyerId
		LEFT JOIN  [Archive.Sales]				AS a ON u.DocItemId			= a.DocItemId
		WHERE 
			u.CompanyId = @companyId
		AND	((@unit				IS NULL) OR (v.Unit				LIKE '%' + @unit	+ '%'))
		AND	((@serial			IS NULL) OR (v.Serial			LIKE '%' + @serial	+ '%'))
		AND	((@invoiceType		IS NULL) OR (t.DocType			= @invoiceType))
		AND	((@invoiceSubType	IS NULL) OR (t.DocSubType		= @invoiceSubType))
		AND	((@buyerName		IS NULL) OR (b.Buyername		LIKE '%' + @buyerName + '%'))
		AND	
			(
				(@buyerCode		IS NULL) OR 
					( 
						b.BuyerCode LIKE '%' + @buyerCode
					
					)
			)
		AND ((@invoiceFrom		IS NULL) OR (CONVERT(INT,d.DocumentNumber) BETWEEN @invoiceFrom AND @invoiceTo))
		AND (
				(@plate	IS NULL) OR 
				((a.Plate LIKE '%' + @plate + '%'))
			)
		AND	(
				(@manufacturer IS NULL) OR 
				((a.ManufacturerName LIKE '%' + @manufacturer + '%'))
			)
		AND (
				(@dateFrom	IS NULL) OR 
				(	(a.InvoiceDate   >= @df AND  a.InvoiceDate   <= @dt)
				)
			)
		AND	(
				(@vehicleType IS NULL) OR 
				(a.VehicleType	 = @vehicleType)
			)
		AND (
				(@saleType IS NULL) OR
				(a.SaleType = @saleType)
			)
		GROUP BY u.DocItemId , v.Serial , a.Plate , v.Unit , d.DocumentNumber ,
		a.InvoiceDate , t.DocType , t.DocSubType ,
		b.BuyerCode , b.BuyerName , a.ModelCode , a.ManufacturerName , a.VehicleType 
	
	) AS t
	WHERE (t.ROW BETWEEN @startRowIndex AND @maximumRows)
    
END