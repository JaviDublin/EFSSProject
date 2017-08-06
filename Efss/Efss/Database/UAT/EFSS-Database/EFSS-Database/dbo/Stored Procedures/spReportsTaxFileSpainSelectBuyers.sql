-- =============================================
-- Author:		Javier
-- Create date: September 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spReportsTaxFileSpainSelectBuyers]
		@fileDate			VARCHAR(20)	= NULL,
		@InvoiceFrom		INT			= NULL,
		@invoiceTo			INT			= NULL,
		@taxFilter			INT			= NULL,
		@mileage			INT			= NULL,
		@saleDate			INT         = NULL
AS
BEGIN
	
	SET NOCOUNT ON;

	SET NOCOUNT ON;

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
		
		SELECT
			bu.BuyerName
		FROM 
			[Fact.FleetTaxReport] ft
		INNER JOIN [Dimension.Buyers] AS bu ON
			 ft.BuyerId = bu.BuyerId
		WHERE
			((@fileDate IS NULL) OR (CONVERT(VARCHAR(11),ft.FileDate,103) = @fileDate)) AND
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
				SUBSTRING(ft.VehicleCode , 1 , 2) = '10'
		GROUP BY
			bu.BuyerName
		ORDER BY 
			bu.BuyerName
			
  
END