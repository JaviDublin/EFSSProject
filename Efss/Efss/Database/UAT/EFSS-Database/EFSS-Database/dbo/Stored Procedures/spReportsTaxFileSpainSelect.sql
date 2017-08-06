-- =============================================
-- Author:		Javier
-- Create date: July 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spReportsTaxFileSpainSelect]
		@sortExpression		VARCHAR(50)	= NULL,
		@maximumRows		INT			= NULL,
		@startRowIndex		INT			= NULL,
		@fileDate			VARCHAR(20)	= NULL,
		@InvoiceFrom		INT			= NULL,
		@invoiceTo			INT			= NULL,
		@taxFilter			INT			= NULL,
		@mileage			INT			= NULL,
		@saleDate			INT         = NULL,
		@manufacturerName	VARCHAR(200)= NULL
AS
BEGIN
	
	SET NOCOUNT ON;

	IF @manufacturerName = 'ALL' BEGIN SET @manufacturerName = NULL END

	IF @InvoiceFrom = NULL
	BEGIN
		IF @invoiceTo IS NULL
		BEGIN
			SET @InvoiceFrom = (SELECT MIN(CONVERT(INT,SaleDocumentNumber)) FROM [Fact.FleetTaxReport])
			SET @invoiceTo	 = (SELECT MAX(CONVERT(INT,SaleDocumentNumber)) FROM [Fact.FleetTaxReport])
		END
		ELSE
		BEGIN
			SET @InvoiceFrom = (SELECT MIN(CONVERT(INT,SaleDocumentNumber)) FROM [Fact.FleetTaxReport])
		END
		
	END
	ELSE
	BEGIN
		IF @invoiceTo IS NULL
		BEGIN
			SET @invoiceTo = @InvoiceFrom
		END
	END
	
	DECLARE @regAmtA INT,
			@regAmtB INT
			
	IF @taxFilter = 1
	BEGIN
		SET @regAmtA = 0
		SET @regAmtB = NULL
		
	END			
	ELSE IF @taxFilter = 2
	BEGIN
		SET @regAmtA = NULL
		SET @regAmtB = 0
	END
	
	
		DECLARE @mileageShort	INT,
				@mileageBig		INT
			
		IF @mileage = 1
		BEGIN
			SET @mileageShort	= NULL
			SET @mileageBig		= NULL
		END
		ELSE IF @mileage = 2
		BEGIN
			SET @mileageShort	= 2
			SET @mileageBig		= NULL
		END
		ELSE IF @mileage = 3
		BEGIN
			SET @mileageShort	= NULL
			SET @mileageBig		= 3
		END
		
		DECLARE @saleDateShort	INT,
				@saleDateBig	INT
				
		IF @saleDate = 1
		BEGIN
			SET @saleDateShort	= NULL
			SET @saleDateBig	= NULL
		END
		ELSE IF @saleDate = 2
		BEGIN
			SET @saleDateShort	= 2
			SET @saleDateBig	= NULL
		END
		ELSE IF @saleDate = 3
		BEGIN
			SET @saleDateShort	= NULL
			SET @saleDateBig	= 3
		END
	
	
		SELECT t.[count] as 'Count' , t.RowId , 
		t.Serial , t.Plate , 
		convert(varchar,t.Mileage) as "Mileage" , 
		t.ManufacturerName ,
		t.InvoiceNumber ,  t.SaleDocumentNumber  , 
		convert(varchar,t.RegTaxAmount) as "RegTaxAmount" , 
		convert(varchar(11),t.FileDate,103) as "FileDate" ,
		t.FuelType , t.CO2 , t.ITVSerial , t.VehicleCode , t.IsCorrect ,
		convert(varchar(11),t.NRCDate,103) as "NRCDate" , t.Processed , t.IsExported
		FROM
		(
			SELECT 
			COUNT(ft.RowId) OVER() AS 'Count' ,
			ROW_NUMBER() OVER 
			(ORDER BY
					CASE WHEN @sortExpression = 'Serial' THEN ft.Serial END ASC,
					CASE WHEN @sortExpression = 'Serial DESC' THEN ft.Serial END DESC,
					CASE WHEN @sortExpression = 'Plate' THEN ft.Plate END ASC,
					CASE WHEN @sortExpression = 'Plate DESC' THEN ft.Plate END DESC,
					CASE WHEN @sortExpression = 'Mileage' THEN ft.Mileage END ASC,
					CASE WHEN @sortExpression = 'Mileage DESC' THEN ft.Mileage END DESC,
					CASE WHEN @sortExpression = 'ManufacturerName' THEN ft.ManufacturerName END ASC,
					CASE WHEN @sortExpression = 'ManufacturerName DESC' THEN ft.ManufacturerName END DESC,
					CASE WHEN @sortExpression = 'InvoiceNumber' THEN ft.InvoiceNumber END ASC,
					CASE WHEN @sortExpression = 'InvoiceNumber DESC' THEN ft.InvoiceNumber END DESC,
					CASE WHEN @sortExpression = 'SaleDocumentNumber' THEN ft.SaleDocumentNumber END ASC,
					CASE WHEN @sortExpression = 'SaleDocumentNumber DESC' THEN ft.SaleDocumentNumber END DESC,	
					CASE WHEN @sortExpression = 'RegTaxAmount' THEN ft.RegTaxAmount END ASC,
					CASE WHEN @sortExpression = 'RegTaxAmount DESC' THEN ft.RegTaxAmount END DESC,
					CASE WHEN @sortExpression = 'FileDate' THEN ft.FileDate END ASC,
					CASE WHEN @sortExpression = 'FileDate DESC' THEN ft.FileDate END DESC,
					CASE WHEN @sortExpression = 'FuelType' THEN ft.FuelType END ASC,
					CASE WHEN @sortExpression = 'FuelType DESC' THEN ft.FuelType END DESC,
					CASE WHEN @sortExpression = 'CO2' THEN ft.CO2 END ASC,
					CASE WHEN @sortExpression = 'CO2 DESC' THEN ft.CO2 END DESC,
					CASE WHEN @sortExpression = 'ITVSerial' THEN ft.ITVSerial END ASC,
					CASE WHEN @sortExpression = 'ITVSerial DESC' THEN ft.ITVSerial END DESC,
					CASE WHEN @sortExpression = 'VehicleCode' THEN ft.VehicleCode END ASC,
					CASE WHEN @sortExpression = 'VehicleCode DESC' THEN ft.VehicleCode END DESC,
					CASE WHEN @sortExpression = 'IsCorrect' THEN ft.IsCorrect END ASC,
					CASE WHEN @sortExpression = 'IsCorrect DESC' THEN ft.IsCorrect END DESC,
					CASE WHEN @sortExpression = 'NRCDate' THEN ft.NRCDate END ASC,
					CASE WHEN @sortExpression = 'NRCDate DESC' THEN ft.NRCDate END DESC,
					CASE WHEN @sortExpression = 'Processed' THEN ft.Processed END ASC,
					CASE WHEN @sortExpression = 'Processed DESC' THEN ft.Processed END DESC,
					CASE WHEN @sortExpression = 'IsExported' THEN ft.IsExported END ASC,
					CASE WHEN @sortExpression = 'IsExported DESC' THEN ft.IsExported END DESC
					
			
			) AS ROW ,
				ft.RowId , ft.Serial , ft.Plate , ft.Mileage , ft.ManufacturerName ,
				ft.InvoiceNumber ,  ft.SaleDocumentNumber  , ft.RegTaxAmount , ft.FileDate ,
				ft.FuelType , ft.CO2 , ft.ITVSerial , ft.VehicleCode , ft.IsCorrect ,
				ft.NRCDate , ft.Processed , ft.IsExported
			FROM 
				[Fact.FleetTaxReport] ft
			INNER JOIN [Dimension.Buyers] AS bu ON
						ft.BuyerId = bu.BuyerId
		WHERE
			((@fileDate IS NULL) OR (CONVERT(VARCHAR(11),ft.FileDate,103) = @fileDate)) 
			AND
			((@InvoiceFrom IS NULL) OR(CONVERT(INT,ft.SaleDocumentNumber) between @InvoiceFrom and @invoiceTo)) 
			AND
			((@regAmtB IS NULL) OR (ft.RegTaxAmount = 0)) 
			AND
			((@regAmtA IS NULL) OR (ft.RegTaxAmount > 0)) 
			AND
			((@mileageShort IS NULL) OR(ft.Mileage < 6000))
			AND
			((@mileageBig IS NULL) OR(ft.Mileage >= 6000))
			
			AND
			((@saleDateShort IS NULL) OR (DATEDIFF(MONTH,ft.MSODate , ft.SaleDate) <= 6 ))
			
			AND
			((@saleDateBig IS NULL) OR (DATEDIFF(MONTH,ft.MSODate , ft.SaleDate) > 6))
			
			AND
			((@manufacturerName IS NULL) OR (bu.BuyerName = @manufacturerName))
			AND
				SUBSTRING(ft.VehicleCode , 1 , 2) = '10'
			
		
		GROUP BY 
				ft.RowId , ft.Serial , ft.Plate , ft.Mileage , ft.ManufacturerName ,
				ft.InvoiceNumber ,  ft.SaleDocumentNumber  , ft.RegTaxAmount , ft.FileDate ,
				ft.FuelType , ft.CO2 , ft.ITVSerial , ft.VehicleCode , ft.IsCorrect ,
				ft.NRCDate , ft.Processed , ft.IsExported
		) AS t
		WHERE (t.ROW BETWEEN @startRowIndex AND @maximumRows)
		ORDER BY t.SaleDocumentNumber ASC
	
	

END