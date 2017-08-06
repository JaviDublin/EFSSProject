-- =============================================
-- Author:		Javier
-- Create date: September 2011
-- Description:	Change to allow checkin
-- =============================================
CREATE PROCEDURE [dbo].[spTaxFileAEATOutput_Old] 
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
	
	SET NOCOUNT ON;
	
	IF @manufacturerName = 'ALL' BEGIN SET @manufacturerName = null END
	
	DECLARE @table_lines TABLE (line NCHAR(1517))
	
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

	DECLARE @initLine		VARCHAR(10),
			@nif			VARCHAR(50),
			@nif_rep		VARCHAR(50),
			@companyName	VARCHAR(50),
			@contactName	VARCHAR(50),
			@streetType		VARCHAR(10),
			@streetName		VARCHAR(50),
			@streetNumber	VARCHAR(3) ,
			@building		VARCHAR(10),
			@phone			VARCHAR(20),
			@postalCode		VARCHAR(10),
			@town			VARCHAR(20),
			@city			VARCHAR(20),
			@midLine		VARCHAR(2) ,
			@blank			VARCHAR(1),
			@space			VARCHAR(1)
	
	
	SET @nif			= '0AVB28121549'            -- Old: A28121549
	SET @nif_rep		= '50095291A'
	SET @companyName	= 'HERTZ DE ESPAÑA, S.L.'	-- Old: HERTZ DE ESPAÑA SA
	SET @contactName	= 'ESTEO DIAZ JOSE MANUEL'
	SET @streetType		= 'Calle'
	SET @streetName		= 'JOSE ECHEGARAY'
	SET @streetNumber	= '6'
	SET @building		= 'EdifB'
	SET @phone			= '915097300'
	SET @postalCode		= '28230'
	SET @town			= 'LAS ROZAS'
	SET @city			= 'MADRID'
	SET @midLine		= '21'						-- Old: 15
	SET @blank			= ''
	SET @space			= ' ' 
	
	DECLARE @year  VARCHAR(4)  ,
			@month VARCHAR(2)  ,
			@day   VARCHAR(2)  ,
			@today VARCHAR(50)	
			
	SET @year				= CONVERT(varchar,YEAR (GETDATE())) 
	SET @month				= CONVERT(varchar,MONTH(GETDATE()))
	SET @day				= CONVERT(varchar,DAY  (GETDATE()))
	SET @today				= @year + @month + @day
	
	DECLARE @plateTitle			VARCHAR(20)	,
			@vehicleTypeText	VARCHAR(10)	,
			@engineSizeText     VARCHAR(3)  
		
			
	
	SET @plateTitle			= 'Mat: '
	SET @vehicleTypeText	= 'M1'
	SET @engineSizeText     = 'B'

	DECLARE @table_output TABLE
	(
		Serial				VARCHAR(50)	, Plate		  VARCHAR(50), ManufacturerName  VARCHAR(100), 
		ModelDescription	VARCHAR(255), FuelType	  VARCHAR(10), Mileage			 VARCHAR(10)	, 
		CO2					VARCHAR(10)	, EngineSize  VARCHAR(20), ITVSerial		 VARCHAR(50)	, 
		RegTaxAmount		VARCHAR(50)	, TaxCode	  VARCHAR(10), TaxPCT			 VARCHAR(50)	,
		InvoiceNet			VARCHAR(20)	, InvoiceBOE  VARCHAR(20), MsoDate			 VARCHAR(20)	,
		TaxAmt				VARCHAR(10)	, VehicleCode VARCHAR(4)
	)
	

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
	
	IF @aeatType = '1'
	BEGIN
		SET @initLine		= '576I'
		
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
			InvoiceNet = STUFF(InvoiceNet,1,0,REPLICATE('0',13 - LEN(InvoiceNet))),
			InvoiceBOE = STUFF(InvoiceBOE,1,0,REPLICATE('0',13 - LEN(InvoiceBOE))),
			TaxPCT     = STUFF(TaxPCT,1,0,REPLICATE('0',18 - LEN(TaxPCT)))
		
		UPDATE @table_output SET
			ITVSerial = STUFF(ITVSerial,1,0,REPLICATE('0',8 - LEN(ITVSerial)))		
			
		
		INSERT INTO @table_lines (line)
			
		SELECT
		@initLine 
		+ SPACE(9)	
		+ @year
		+ SPACE(4)	
		+ @nif
		+ @companyName
		+ SPACE(40 - LEN(@companyName))
		
		+ SPACE(115)
		
		+ @nif_rep
		+ @contactName
		+ SPACE(40 - LEN(@contactName))
		+ @streetType
		+ SPACE(10 - LEN(@streetType))
		+ @streetName
		+ SPACE(25 - LEN(@streetName))
		+ @streetNumber
		+ SPACE(10 - LEN(@streetNumber))
		+ @building
		+ SPACE(5 - LEN(@building))
		+ @blank
		+ SPACE(5 - LEN(@blank))
		+ @blank
		+ SPACE(5 - LEN(@blank))
		+ @phone
		+ SPACE(10 - LEN(@phone))
		+ @postalCode
		+ SPACE(5 - LEN(@postalCode))
		+ @town
		+ SPACE(25 - LEN(@town))
		+ @city
		+ SPACE(15 - LEN(@city))
		+ @midLine
		+ SPACE(1)
		+ REPLACE(SUBSTRING(tout.MSODate,1,10),'/','')
		+ tout.ManufacturerName
		+ SPACE(40 - LEN(tout.ManufacturerName))
		
		+ tout.ManufacturerName
		+ '-'
		+ LTRIM(RTRIM(tout.ModelDescription))
		+ SPACE(1)
		+ @plateTitle
		+ tout.Plate
		+ SPACE(80 - (LEN(LTRIM(RTRIM(tout.ModelDescription))) + 1 +  
			LEN(tout.ManufacturerName) + 2 + 
			LEN(@plateTitle) + LEN(tout.Plate)))
		
		+ tout.Serial 
		+ SPACE(5)
		
		+ tout.VehicleCode
		+ @vehicleTypeText
			
		+ SPACE(8)
		
		+ '00'
		+ STUFF(tout.CO2 , 1 , 0 , REPLICATE('0' , 3 - LEN(tout.CO2)))
		+ tout.TaxCode   -- TO CHECK
		+ 
		STUFF(tout.Mileage , 1 , 0 , REPLICATE('0' , 5 - LEN(tout.Mileage)))
		+ tout.ITVSerial
		
		+ SPACE(4)
		
		+ @engineSizeText
		+ CASE WHEN tout.FuelType = 'D' THEN '1' ELSE '2' END
		+ '0'
		+ STUFF(tout.EngineSize , 1 , 0 , REPLICATE('0' , 4 - LEN(tout.EngineSize)))
		
		+ SPACE(473)
		
		+ SPACE(62)
		
		
		+ 
			CASE WHEN TaxAmt = 'TAX' THEN tout.InvoiceBOE ELSE tout.InvoiceNet END
		
		+ tout.TaxPCT
		
		+ STUFF(tout.RegTaxAmount,1,0,REPLICATE('0',13 - LEN(tout.RegTaxAmount)))
		
		+ STUFF(tout.RegTaxAmount,1,0,REPLICATE('0',26 - LEN(tout.RegTaxAmount)))
		
		+ STUFF(tout.RegTaxAmount,1,0,REPLICATE('0',26 - LEN(tout.RegTaxAmount)))
		
		-- + '0'
		
		+ SPACE(149)
		
		+ '1'
		
		+ SPACE(141)
		
		+ '0000'
		
		+ SPACE(40)
	FROM 
		@table_output tout
		
		
		SELECT line FROM @table_lines
		
	END
	ELSE
	BEGIN
	
		SET @initLine		= '576N'
		
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
			InvoiceNet = STUFF(InvoiceNet,1,0,REPLICATE('0',11 - LEN(InvoiceNet))),
			InvoiceBOE = STUFF(InvoiceBOE,1,0,REPLICATE('0',11 - LEN(InvoiceBOE))),
			TaxPCT     = STUFF(TaxPCT,1,0,REPLICATE('0',20 - LEN(TaxPCT)))	
		
		UPDATE @table_output SET
			ITVSerial = STUFF(ITVSerial,1,0,REPLICATE('0',8 - LEN(ITVSerial)))	
			
			
			
		INSERT INTO @table_lines (line)
		SELECT
		@initLine 
		+ SPACE(9)	
		+ @year
		+ SPACE(4)	
		+ @nif
		+ @companyName
		+ SPACE(40 - LEN(@companyName))
		+ SPACE(115)
		+ @nif_rep
		+ @contactName
		+ SPACE(40 - LEN(@contactName))
		+ @streetType
		+ SPACE(10 - LEN(@streetType))
		+ @streetName
		+ SPACE(25 - LEN(@streetName))
		+ @streetNumber
		+ SPACE(10 - LEN(@streetNumber))
		+ @building
		+ SPACE(5 - LEN(@building))
		+ @blank
		+ SPACE(5 - LEN(@blank))
		+ @blank
		+ SPACE(5 - LEN(@blank))
		+ @phone
		+ SPACE(10 - LEN(@phone))
		+ @postalCode
		+ SPACE(5 - LEN(@postalCode))
		+ @town
		+ SPACE(25 - LEN(@town))
		+ @city
		+ SPACE(15 - LEN(@city))
		+ @midLine
		+ SPACE(1)
		+ REPLACE(SUBSTRING(tout.MSODate,1,10),'/','')
		
		+ tout.ManufacturerName
		
		+ SPACE(40 - LEN(tout.ManufacturerName))
		
		+ tout.ManufacturerName
		
		+ '-'
		
		+ LTRIM(RTRIM(tout.ModelDescription))
		+ SPACE(1)
		+ @plateTitle
		+ tout.Plate
		
		+ SPACE(80 - (LEN(LTRIM(RTRIM(tout.ModelDescription))) + 1 +  LEN(tout.ManufacturerName) + 2 + 
		   LEN(@plateTitle) + LEN(tout.Plate)))
		
		
		+ tout.Serial 
		+ SPACE(5)
		+ tout.VehicleCode
		+ @vehicleTypeText
		
		+ SPACE(8)
		
		+ '00'
		+ STUFF(tout.CO2 , 1 , 0 , REPLICATE('0' , 3 - LEN(tout.CO2)))
		+ tout.TaxCode   -- TO CHECK
		+ 
		STUFF(
		tout.Mileage , 1 , 0 , REPLICATE('0' , 5 - LEN(tout.Mileage)))
		+ tout.ITVSerial
		+ SPACE(4)
		
		
		
		+ @engineSizeText
		+ CASE WHEN tout.FuelType = 'D' THEN '1' ELSE '2' END
		+ '0'
		+ STUFF(tout.EngineSize , 1 , 0 , REPLICATE('0' , 4 - LEN(tout.EngineSize)))
		
		+ SPACE(473)
		
		+ SPACE(62)
		+ '00'
		+ 
			CASE WHEN TaxAmt = 'TAX' THEN tout.InvoiceBOE ELSE tout.InvoiceNet END
		
		--+ tout.TaxPCT
		
		+ '00000000000000000000000000000000000000000000000000000000000000000000000000000000000'

		+ SPACE(149)
		
		+ '1'
		+ SPACE(141)
		+ '0000'
		+ SPACE(40)
		
	FROM 
		@table_output tout
				
		
		
		SELECT line
		FROM @table_lines
		
		
		
	END
	
	
	

END