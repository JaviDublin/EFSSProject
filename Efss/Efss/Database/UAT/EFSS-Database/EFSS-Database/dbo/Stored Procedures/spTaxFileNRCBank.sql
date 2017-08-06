-- =============================================
-- Author:		Javier
-- Create date: September 2011
-- Description:	File to upload to La Caixa (bank)
-- =============================================
CREATE PROCEDURE [dbo].[spTaxFileNRCBank] 
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
	
	DECLARE @TABLE_OUTPUT TABLE 
		(pkid INT PRIMARY KEY IDENTITY , serial VARCHAR(50) , RegTaxAmount VARCHAR(20), Total VARCHAR(20))
		
		
	IF @manufacturerName = 'ALL' BEGIN SET @manufacturerName = null END
	
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
	
		
	INSERT INTO @TABLE_OUTPUT (serial , RegTaxAmount)
	
	SELECT 
		ft.Serial , ft.RegTaxAmount 
	FROM 
		[Fact.FleetTaxReport] ft
	INNER JOIN [Dimension.Buyers]		AS bu ON
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
		
		
	-- TABLE TO STORE ALL THE ROWS OF THE FILE
	---------------------------------------------------------------------------------------
	DECLARE @TABLEFILE TABLE (ROW VARCHAR(900))
	
	-- PARAMETERS AND VARIABLES
	---------------------------------------------------------------------------------------
	DECLARE @df DATETIME ,
			@dt DATETIME
			

	DECLARE @companyName		VARCHAR(100),
			@companyFiscalCode	VARCHAR(50) ,
			@year				VARCHAR(4)  ,
			@month				VARCHAR(2)  ,
			@day				VARCHAR(2)  ,
			@today				VARCHAR(50)	,
			@counter			INT			,
			@total				MONEY
			
	SET @companyName		= (SELECT CompanyName		FROM [Dimension.Companies] WHERE CompanyCode ='SP')
	SET @companyFiscalCode	= (SELECT ShortFiscalCode	FROM [Dimension.Companies] WHERE CompanyCode ='SP')
	SET @year				= CONVERT(varchar,YEAR (GETDATE())) 
	SET @month				= CONVERT(varchar,MONTH(GETDATE()))
	SET @day				= CONVERT(varchar,DAY  (GETDATE()))
	SET @today				= @year + @month + @day
	SET @counter			= 1
	SET @total				= 0


	-- HEADER OF THE FILE (ONE ROW)
	---------------------------------------------------------------------------------------
	DECLARE @FIRSTROW			VARCHAR(500),
			@FIRSTROW_PART_1	VARCHAR(50) ,
			@FIRSTROW_PART_2	VARCHAR(50) ,
			@FIRSTROW_PART_3	VARCHAR(255) 
	
	SET @FIRSTROW_PART_1 = '021' + @companyFiscalCode + '-999' + SPACE(17)
	
	SET @FIRSTROW_PART_2 =   '020130883250200085877'		-- Account
							+ @today 
							+ SPACE(20 - LEN(@today))
	
	SET @FIRSTROW_PART_3 =	  '2013'						-- Bank Code
							+ @year 
							+ CASE WHEN LEN(@month) = 1 THEN '0' + @month ELSE @month END 
							+ CASE WHEN LEN(@day)   = 1 THEN '0' + @day   ELSE @day   END 
							+ 'E'							-- Currency
							+ 'I'							-- Bank Transaction Type
							+ @year 
							+ CASE WHEN LEN(@month) = 1 THEN '0' + @month ELSE @month END 
							+ CASE WHEN LEN(@day)   = 1 THEN '0' + @day   ELSE @day   END 
							+ 'I'							-- Cash in Bank (Yes;No)
							+ 'R'							-- File Type (R: process; T: Test)
							+ '01'							-- Version 
							+ SPACE(155)
	
	
	SET @FIRSTROW = @FIRSTROW_PART_1 + @FIRSTROW_PART_2 + @FIRSTROW_PART_3
	
	INSERT INTO @TABLEFILE VALUES (@FIRSTROW)
	
	-- BODY OF THE FILE (ONE OR MORE ROWS)
	---------------------------------------------------------------------------------------
	
	DECLARE @SUMTOTAL MONEY
	SET  @SUMTOTAL = (SELECT SUM(CONVERT(FLOAT,RegTaxAmount)) FROM @TABLE_OUTPUT)
	
	
	UPDATE @TABLE_OUTPUT SET Total = @SUMTOTAL
		
		
	UPDATE @TABLE_OUTPUT SET RegTaxAmount =
		CASE WHEN CHARINDEX('.' ,RegTaxAmount) = 0 
		THEN RegTaxAmount + '.00' 
		ELSE 
			CASE WHEN LEN(RegTaxAmount) - CHARINDEX('.' ,RegTaxAmount) = 1
			THEN
				RegTaxAmount + '0'
			ELSE
				RegTaxAmount
			END
		END
	UPDATE @TABLE_OUTPUT SET RegTaxAmount = REPLACE(RegTaxAmount,'.','')
	UPDATE @TABLE_OUTPUT SET RegTaxAmount = STUFF(RegTaxAmount,1,0,REPLICATE('0' , 12 - LEN(RegTaxAmount)))
	UPDATE @TABLE_OUTPUT SET RegTaxAmount = '28600' + RegTaxAmount
	
	
	INSERT INTO @TABLEFILE
	
	SELECT 
	'05' 
	+ STUFF(CONVERT(VARCHAR,pkid),1,0,REPLICATE('0' , 5 - LEN(CONVERT(VARCHAR,pkid))))
	+ '576'
	+ @year
	+ '0A'						-- PERIOD
	+ 'E'						-- CURRENCY
	+ 'I'						-- PAYMENT TYPE
	+ @companyFiscalCode
	+ @companyName
	+ SPACE(38 - LEN(RegTaxAmount))
	+ RegTaxAmount
	+ SPACE(12)
	+ '1'						-- FRACTION
	+ '20130883250200085877'	-- ACCOUNT
	+ SPACE(48)
	+ serial
	+ SPACE(71)
	FROM @TABLE_OUTPUT
	
	-- FOOTER OF THE FILE (ONE ROW)
	---------------------------------------------------------------------------------------
	UPDATE @TABLE_OUTPUT SET Total =
		CASE WHEN CHARINDEX('.' ,Total) = 0 
		THEN Total + '.00' 
		ELSE 
			CASE WHEN LEN(Total) - CHARINDEX('.' ,Total) = 1
			THEN
				Total + '0'
			ELSE
				Total
			END
		END
	UPDATE @TABLE_OUTPUT SET Total = REPLACE(Total,'.','')
	UPDATE @TABLE_OUTPUT SET Total = STUFF(Total,1,0,REPLICATE('0' , 12 - LEN(Total)))
	
	DECLARE @SUM VARCHAR(12)
	SET @SUM =(SELECT TOP 1 Total FROM @TABLE_OUTPUT)
	
	
	SET @SUMTOTAL = CASE WHEN CHARINDEX('.' ,@SUMTOTAL) = 0 THEN @SUMTOTAL + '.00' ELSE 
						CASE WHEN	LEN(@SUMTOTAL) - CHARINDEX('.' ,@SUMTOTAL) = 1 THEN	@SUMTOTAL + '0' ELSE
							@SUMTOTAL
						END END
						
	

	
	SET @SUM = (select convert(varchar,@SUMTOTAL))	
	SET @SUM = REPLACE(@SUM,'.','')	
	SET @SUM = STUFF(@SUM,1,0,REPLICATE('0' , 12 - LEN(@SUM)))
	
	
	INSERT INTO @TABLEFILE
	
	SELECT '08' 
	+ STUFF(CONVERT(VARCHAR,MAX(pkid) + 2),1,0,REPLICATE('0' , 5 - LEN(CONVERT(VARCHAR,MAX(pkid) + 2)))) 
	+ STUFF(CONVERT(VARCHAR,MAX(pkid)),1,0,REPLICATE('0' , 5 - LEN(CONVERT(VARCHAR,MAX(pkid)))))
	+ @SUM
	+ SPACE(17)
	+ SPACE(214)
	FROM @TABLE_OUTPUT
	
	
	-- OUTPUT
	---------------------------------------------------------------------------------------
	UPDATE @TABLEFILE SET ROW = '' WHERE ROW IS NULL
	
	UPDATE [Fact.FleetTaxReport] SET NRCDate = GETDATE() WHERE CONVERT(VARCHAR(11),FileDate,103) = @fileDate
	
	SELECT ROW FROM @TABLEFILE

	
END