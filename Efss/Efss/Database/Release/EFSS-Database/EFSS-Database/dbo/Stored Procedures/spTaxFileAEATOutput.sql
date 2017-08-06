-- =============================================
-- Author:		Javier
-- Create date: April 2012
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spTaxFileAEATOutput]

		@fileDate			VARCHAR(20)	= NULL,
		@InvoiceFrom		INT			= NULL,
		@invoiceTo			INT			= NULL,
		@taxFilter			INT			= NULL,
		@mileage			INT			= NULL,
		@saleDate			INT         = NULL,
		@manufacturerName	VARCHAR(200)= NULL,
		@aeatType			VARCHAR(2)  = NULL
	
AS
BEGIN
	
	-- Search the Cars to include in the file
	--==================================================================================================
	-- 1 Create the table
	-----------------------------------
	DECLARE @table_output TABLE
	(
		Serial				VARCHAR(50)	, Plate		  VARCHAR(50), ManufacturerName  VARCHAR(100), 
		ModelDescription	VARCHAR(255), FuelType	  VARCHAR(10), Mileage			 VARCHAR(10)	, 
		CO2					VARCHAR(10)	, EngineSize  VARCHAR(20), ITVSerial		 VARCHAR(50)	, 
		RegTaxAmount		VARCHAR(50)	, TaxCode	  VARCHAR(10), TaxPCT			 VARCHAR(50)	,
		InvoiceNet			VARCHAR(20)	, InvoiceBOE  VARCHAR(20), MsoDate			 VARCHAR(20)	,
		TaxAmt				VARCHAR(10)	, VehicleCode VARCHAR(4)
	)
	
	IF @manufacturerName = 'ALL' BEGIN SET @manufacturerName = null END
	
	-- 2 Set the searching filters
	-----------------------------------
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
	

	-- 3 Select the data
	-----------------------------------
	IF @aeatType = '1'
	BEGIN
		INSERT INTO @table_output
		
		SELECT 
			ft.Serial  , ft.Plate , mf.ManufacturerName , md.ModelDescription , ft.FuelType ,
			ft.Mileage , ft.CO2 , ft.EngineSize , ft.ITVSerial , ft.RegTaxAmount ,
			ft.TaxCode , ft.TaxPCT , ft.invoiceNet ,
			CASE WHEN ft.TaxPCT = '0' THEN '0' ELSE
				ROUND( ft.RegTaxAmount / (CONVERT(FLOAT,ft.TaxPCT) / 100) , 2)
			END,
			CONVERT(varchar(11),ft.MSODate, 103) , 
			
			CASE WHEN ft.TaxPCT = '0' THEN '0' ELSE
				CASE WHEN ft.invoiceNet <=  ROUND( ft.RegTaxAmount / 
					(CONVERT(FLOAT,ft.TaxPCT) / 100) , 2) THEN 'NET'
				ELSE 'TAX' END
			END ,
			ft.VehicleCode
			
		FROM  [Fact.FleetTaxReport] ft
		INNER JOIN [Dimension.Manufacturer] AS mf ON 
				ft.ManufacturerId	= mf.ManufacturerId
		INNER JOIN [Dimension.ModelDetails] AS md ON 
				ft.ModelDetailId	= md.ModelDetailId
		INNER JOIN [Dimension.Models]		AS ml ON
				md.ModelId			= ml.ModelId
		INNER JOIN [Dimension.Buyers]		AS bu ON
				ft.BuyerId			= bu.BuyerId
		
		WHERE
			ft.IsCorrect = 1
		AND
			ft.IsExported = 1
		AND
			ft.RegTaxAmount > 0  
			
		AND 
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
		
		ORDER BY ft.InvoiceNumber
	
	END
	ELSE
	BEGIN
		INSERT INTO @table_output
		
		SELECT 
			ft.Serial  , ft.Plate , mf.ManufacturerName , md.ModelDescription , ft.FuelType ,
			ft.Mileage , ft.CO2 , ft.EngineSize , ft.ITVSerial , ft.RegTaxAmount ,
			ft.TaxCode , ft.TaxPCT , ft.invoiceNet ,
			
			CASE WHEN ft.TaxPCT = '0' THEN '0' ELSE
				ROUND( ft.RegTaxAmount / (CONVERT(FLOAT,ft.TaxPCT) / 100) , 2)
			END,
			
			CONVERT(varchar(11),ft.MSODate, 103) , 
			
			CASE WHEN ft.TaxPCT = '0' THEN '0' ELSE
				CASE WHEN ft.invoiceNet <=  ROUND( ft.RegTaxAmount / 
					(CONVERT(FLOAT,ft.TaxPCT) / 100) , 2) THEN 'NET'
				ELSE 'TAX' END
			END ,
			ft.VehicleCode
			
			
		FROM  [Fact.FleetTaxReport] ft
		INNER JOIN [Dimension.Manufacturer] AS mf ON 
				ft.ManufacturerId	= mf.ManufacturerId
		INNER JOIN [Dimension.ModelDetails] AS md ON 
				ft.ModelDetailId	= md.ModelDetailId
		INNER JOIN [Dimension.Models]		AS ml ON
				md.ModelId			= ml.ModelId
		INNER JOIN [Dimension.Buyers]		AS bu ON
				ft.BuyerId			= bu.BuyerId
		
		WHERE
			ft.IsCorrect = 1
		AND
			ft.IsExported = 1
		AND
			ft.RegTaxAmount = 0  
		AND 
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
		ORDER BY ft.InvoiceNumber
	
	END
	
	-- 4 Update some values
	-----------------------------------
		UPDATE @table_output SET
			RegTaxAmount = RegTaxAmount + '.00'
		WHERE PATINDEX('%.%',RegTaxAmount) = 0
		
		UPDATE @table_output SET
			RegTaxAmount = RegTaxAmount + '0'
		WHERE LEN(RegTaxAmount) - PATINDEX('%.%',RegTaxAmount) = 1
		
		UPDATE @table_output SET
			InvoiceNet = InvoiceNet + '.00'
		WHERE PATINDEX('%.%',InvoiceNet) = 0
		
		UPDATE @table_output SET
			InvoiceNet = InvoiceNet + '0'
		WHERE LEN(InvoiceNet) - PATINDEX('%.%',InvoiceNet) = 1
		
		UPDATE @table_output SET
			InvoiceBOE = InvoiceBOE + '.00'
		WHERE PATINDEX('%.%',InvoiceBOE) = 0
		
		UPDATE @table_output SET
			InvoiceBOE = InvoiceBOE + '0'
		WHERE LEN(InvoiceBOE) - PATINDEX('%.%',InvoiceBOE) = 1
		
		UPDATE @table_output SET
			TaxPCT = TaxPCT + '.00'
		WHERE PATINDEX('%.%',TaxPCT) = 0
		
		UPDATE @table_output SET
			TaxPCT = TaxPCT + '0'
		WHERE LEN(TaxPCT) - PATINDEX('%.%',TaxPCT) = 1	
		
		UPDATE @table_output SET 
			InvoiceNet		= REPLACE(InvoiceNet,'.','') ,
			TaxPCT			= REPLACE(TaxPCT,'.','') , 
			RegTaxAmount	= REPLACE(RegTaxAmount,'.',''),
			InvoiceBOE		= REPLACE(InvoiceBOE,'.','')
		
		UPDATE @table_output SET
			--InvoiceNet = STUFF(InvoiceNet,1,0,REPLICATE('0',11 - LEN(InvoiceNet))),
			--InvoiceBOE = STUFF(InvoiceBOE,1,0,REPLICATE('0',11 - LEN(InvoiceBOE))),
			
			InvoiceNet = STUFF(InvoiceNet,1,0,REPLICATE('0',13 - LEN(InvoiceNet))),
			InvoiceBOE = STUFF(InvoiceBOE,1,0,REPLICATE('0',13 - LEN(InvoiceBOE))),
			TaxPCT     = STUFF(TaxPCT,1,0,REPLICATE('0',18 - LEN(TaxPCT)))	
			--TaxPCT     = STUFF(TaxPCT,1,0,REPLICATE('0',20 - LEN(TaxPCT)))	
		
		UPDATE @table_output SET
			ITVSerial = STUFF(ITVSerial,1,0,REPLICATE('0',8 - LEN(ITVSerial)))	
	

	DECLARE @table_lines TABLE (line NCHAR(1517))

	-- Item 1 , Position 1 , Lenght 8
	-------------------------------------------
	DECLARE @InitLabel NCHAR(8)
	SET @InitLabel = '<T57601>'
	
	-- Item 2 , Position 9 , Lenght 3
	-------------------------------------------
	DECLARE @ModelId NCHAR(3)
	SET @ModelId = '576'
	
	-- Item 3 , Position 12 , Lenght 1
	-------------------------------------------
	DECLARE @TaxType NCHAR(1)
	IF @aeatType = '1'
	BEGIN
		SET @TaxType = 'I'
	END
	ELSE
	BEGIN
		SET @TaxType = 'N'
	END
	
	-- Item 4 , Position 13 , Lenght 9
	-------------------------------------------
	DECLARE @FiscalNumberAEAT NCHAR(9)
	SET @FiscalNumberAEAT = '         '
	
	-- Item 5 , Position 22 , Lenght 4
	-------------------------------------------
	DECLARE @year  NCHAR(4)
	SET @year = CONVERT(NCHAR(4),YEAR (GETDATE()))	
	
	-- Item 6 , Position 26 , Lenght 4
	-------------------------------------------
	DECLARE @LabelLetters NCHAR(4)
	SET @LabelLetters = '    '
	
	-- Item 7 , Position 30 , Lenght 2
	-------------------------------------------
	DECLARE @Period NCHAR(2)
	SET @Period = '0A'
	
	-- Item 8 , Position 32 , Lenght 1 (V , E , A)
	-------------------------------------------
	DECLARE @VehicleType NCHAR(1)
	SET @VehicleType = 'V'
	
	-- Item 9 , Position 33 , Lenght 9 
	-------------------------------------------
	DECLARE @FiscalNumber NCHAR(9)
	SET @FiscalNumber = 'B28121549'
	
	-- Item 10 , Position 42 , Lenght 40 
	-------------------------------------------
	DECLARE @CompanyName NCHAR(40)
	SET @CompanyName = 'HERTZ DE ESPAÑA, S.L.'
	
	-- Item 11 , Position 82 , Lenght 10 
	-------------------------------------------
	DECLARE @StreetType NCHAR(10)
	SET @StreetType = 'Calle'
	
	-- Item 12 , Position 92 , Lenght 25 
	-------------------------------------------
	DECLARE @StreetName NCHAR(25)
	SET @StreetName = 'JOSE ECHEGARAY'
	
	-- Item 13 , Position 117 , Lenght 10 
	-------------------------------------------
	DECLARE @StreetNumber NCHAR(10)
	SET @StreetNumber = '6'
	
	-- Item 14 , Position 127 , Lenght 5 
	-------------------------------------------
	DECLARE @BuildingName NCHAR(5)
	SET @BuildingName = 'EdifB'
	
	-- Item 15 , Position 132 , Lenght 5 
	-------------------------------------------
	DECLARE @Floor NCHAR(5)
	SET @Floor = '     '
	
	-- Item 16 , Position 137 , Lenght 5 
	-------------------------------------------
	DECLARE @Door NCHAR(5)
	SET @Door = '     '
	
	-- Item 17 , Position 142 , Lenght 10 
	-------------------------------------------
	DECLARE @Telephone NCHAR(10)
	SET @Telephone = '915097300'
	
	-- Item 18 , Position 152 , Lenght 5 
	-------------------------------------------
	DECLARE @PostalCode NCHAR(5)
	SET @PostalCode = '28230'
	
	-- Item 19 , Position 157 , Lenght 25 
	-------------------------------------------
	DECLARE @City NCHAR(25)
	SET @City = 'LAS ROZAS'
	
	-- Item 20 , Position 182 , Lenght 15 
	-------------------------------------------
	DECLARE @Province NCHAR(15)
	SET @Province = 'MADRID'
	
	-- Item 21 , Position 197 , Lenght 9 
	-------------------------------------------
	DECLARE @FiscalNumber_Rep NCHAR(9)
	SET @FiscalNumber_Rep = '50095291A'
	
	-- Item 22 , Position 206 , Lenght 40 
	-------------------------------------------
	DECLARE @Name_Rep NCHAR(40)
	SET @Name_Rep = 'ESTEO DIAZ JOSE MANUEL'
	
	
	-- Item 23-32 , Position 246 - 346(start) , Lenght 115 
	-- This are the details of the Representant
	-- * Not Needed
	-----------------------------------------------------------------------
	
	-- Item 33 , Position 361 , Lenght 1 
	-------------------------------------------
	DECLARE @car_new_used NCHAR(1)
	SET @car_new_used = '2'
	
	-- Item 34 , Position 362 , Lenght 1 
	-------------------------------------------
	DECLARE @sale_national_international NCHAR(1)
	SET @sale_national_international = '1'
	
	-- Item 35 , Position 363 , Lenght 1 
	-------------------------------------------
	DECLARE @Area NCHAR(1)
	SET @Area = ' '
	
	-- Item 36-40 Car Details
	-------------------------------------------
	
	INSERT INTO @table_lines
	
	SELECT 
		@InitLabel			+
		@ModelId			+
		@TaxType			+
		@FiscalNumberAEAT	+
		@year				+
		@LabelLetters		+
		@Period				+
		@VehicleType		+
		@FiscalNumber		+
		@CompanyName		+
		@StreetType			+
		@StreetName			+
		@StreetNumber		+
		@BuildingName		+
		@Floor				+
		@Door				+
		@Telephone			+
		@PostalCode			+
		@City				+
		@Province			+
		@FiscalNumber_Rep	+
		@Name_Rep			+
		SPACE(115)			+
		@car_new_used		+
		@sale_national_international +
		@Area				
		
		--Item 36 (8  characters)
		--------------------------------------------------
		+ REPLACE(SUBSTRING(tout.MSODate,1,10),'/','')   

		--Item 37 (40 characters)
		--------------------------------------------------
		+ tout.ManufacturerName							 
		+ SPACE(40 - LEN(tout.ManufacturerName))
		
		--Item 38 (80 characters)
		--------------------------------------------------
		+ tout.ManufacturerName							 
		+ '-'
		+ LTRIM(RTRIM(tout.ModelDescription))
		+ SPACE(1)
		+ 'Mat: '
		+ tout.Plate
		+ SPACE(80 - (LEN(LTRIM(RTRIM(tout.ModelDescription))) + 1 +  
			LEN(tout.ManufacturerName) + 2 + 
			LEN('Mat: ') + LEN(tout.Plate)))
		
		--Item 39 (22 characters)
		--------------------------------------------------
		+ tout.Serial									 
		+ SPACE(22 - LEN(tout.Serial))
		
		--Item 40 (40 characters)
		--------------------------------------------------
		-- 40.1 (4 characters)
		+ tout.VehicleCode	
		-- 40.2 (2 characters)							 
		+ 'M1'
		-- 40.3 (8 characters)
		+ SPACE(8)
		--+ tout.ITVSerial
		-- 40.4 (5 characters)
		+ STUFF(tout.CO2 , 1 , 0 , REPLICATE('0' , 5 - LEN(tout.CO2)))
		-- 40.5 (2 characters)
		+ SUBSTRING(tout.TaxCode,1,2)
		-- + tout.TaxCode
		-- 40.6 (6 characters)
		+ STUFF(tout.Mileage , 1 , 0 , REPLICATE('0' , 6 - LEN(tout.Mileage)))
		
		-- 40.7 (12 characters)
		 + STUFF(tout.ITVSerial , 1 , 0 , REPLICATE('0' , 12 - LEN(tout.ITVSerial)))
		-- 40.8 (1 character)
		+ 'B'
		
		--Item 41 (1 character)
		--------------------------------------------------
		--+ CASE WHEN tout.FuelType = 'D' THEN '1' ELSE '2' END
		+ CASE WHEN tout.FuelType = 'D' THEN '2' ELSE '1' END
		
		--Item 42 (5 characters)
		--------------------------------------------------
		+ STUFF(tout.EngineSize , 1 , 0 , REPLICATE('0' , 5 - LEN(tout.EngineSize)))
		
		
		
		+ SPACE(473)
		
		+ SPACE(62)
		
		
		+ 
			CASE WHEN TaxAmt = 'TAX' THEN tout.InvoiceBOE ELSE tout.InvoiceNet END
		
		+ tout.TaxPCT
		
		--+ STUFF(tout.RegTaxAmount,1,0,REPLICATE('0',13 - LEN(tout.RegTaxAmount)))
		
		+ STUFF(tout.RegTaxAmount,1,0,REPLICATE('0',13 - LEN(tout.RegTaxAmount)))
		
		+ STUFF(tout.RegTaxAmount,1,0,REPLICATE('0',26 - LEN(tout.RegTaxAmount)))
		
		+ STUFF(tout.RegTaxAmount,1,0,REPLICATE('0',26 - LEN(tout.RegTaxAmount)))
		
		-- + '0'
		
		+ SPACE(149)
		
		+ '3'
		
		+ SPACE(141)
		
		+ '0000'
		
		+ SPACE(40)
		
		FROM 
			@table_output tout			
		
		
		
	
	
	
	SELECT line FROM @table_lines
    
END