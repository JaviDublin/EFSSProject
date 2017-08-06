-- =============================================
-- Author:		Javier
-- Create date: June 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spReportsLTSCFileFrance]
			@companyId  INT			= NULL,
			@docType    VARCHAR(20) = NULL,
			@docSubType VARCHAR(20) = NULL,
			@dateFrom	VARCHAR(20) = NULL,
			@dateTo     VARCHAR(20) = NULL,
			@fileDate   VARCHAR(20) = NULL
AS
BEGIN
	
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
	

	DECLARE @CountryId INT
	SET @CountryId = (SELECT CountryId FROM [Dimension.Countries] WHERE CountryName = 'FRANCE') 

	SELECT 
	s.CompanyCode 
	+ ';' + 
	CONVERT(VARCHAR,CONVERT(INT,s.Unit))  
	+ ';' + 
	s.Serial 
	+ ';' +
	s.SaleDocumentNumber 
	+ ';' +
	s.VehicleType 
	+ ';' +
	s.SaleType 
	+ ';' +
	CONVERT(VARCHAR(11),s.InServiceDate,103) + ' 00:00:00' 
	+ ';' +
	CONVERT(VARCHAR(11),s.SaleDate,103)  + ' 00:00:00' 
	+ ';' +
	CONVERT(VARCHAR,s.CapitalCost) 
	+ ';' +
	CONVERT(VARCHAR,s.Depreciation)  
	+ ';' +
	CONVERT(VARCHAR,s.BookValue) 
	+ ';' +
	CONVERT(VARCHAR,s.InvoiceTotal) 
	+ ';' +
	CONVERT(VARCHAR(11),s.MSODate,103)  + ' 00:00:00' 
	+ ';' +
	s.ManufacturerCode 
	+ ';' +
	s.BuyerName	
	+ ';' +
	s.Amount7
	+ ';' +
	s.AreaCode 
	+ ';' +
	CONVERT(VARCHAR,CONVERT(INT,s.ModelYear)) 
	+ ';' +
	s.ModelCode 
	+ ';' +
	s.ModelDescription 
	+ ';' +
	s.Plate 
	+ ';' +
	s.Mileage 
	+ ';' +
	CONVERT(VARCHAR,s.MileCharge) 
	+ ';' +
	CONVERT(VARCHAR,s.FuelCharge)  -- PENDING OF REVIEW
	+ ';' +
	s.InvoiceNumber 
	+ ';' +
	CONVERT(VARCHAR,s.InvoiceNet) 
	+ ';' +
	CONVERT(VARCHAR,s.InvoiceVat) 
	+ ';' +
	--s.BuyerCode  -- Code Vendeur 
	''
	+ ';' +
	s.PurchaseOrder 
	+ ';' +
	m.FuelType 
	+ ';' +
	
	CASE WHEN DATENAME(dw, [Application.FileLog].DateLog) = 'Monday' THEN
		CONVERT(VARCHAR(11),[Application.FileLog].DateLog - 3,103)  + ' 00:00:00'
	ELSE
		CONVERT(VARCHAR(11),[Application.FileLog].DateLog - 1,103)  + ' 00:00:00'
	END
	
	
	--CONVERT(VARCHAR,s.SaleDate)(TO DEFINE)	-- Sale Process Date
	+ ';' +
	
	'30/' + 
			CASE WHEN LEN(CONVERT(varchar,MONTH(getdate()))) = 1 THEN '0' + CONVERT(varchar,MONTH(getdate()))
				ELSE
				CONVERT(varchar,MONTH(getdate())) 
					END

			+ '/' + CONVERT(varchar,YEAR(getdate())) + ' 00:00:00'
			
	--AccountingMonthEnd (TO DEFINE)			-- AccountingMonthEnd
	+ ';' +
	CASE WHEN s.OutServiceDate IS NULL		THEN '' 
		ELSE CONVERT(VARCHAR(11),s.OutServiceDate,103) + ' 00:00:00'  END 
	+ ';' +
	s.VehicleClass  
	+ ';' +
	
	--CASE WHEN s.OutServiceDate IS NULL		THEN '' ELSE
	--	CONVERT(VARCHAR,datediff(DAY,s.InServiceDate,s.OutServiceDate))			END  
	
	CONVERT(VARCHAR,
	DATEDIFF(MONTH, s.InServiceDate, s.OutServiceDate) * 30 
	   + DAY(s.OutServiceDate) 
	   - DAY(s.InServiceDate)
	   - case when day(s.InServiceDate)>=30 AND day(s.OutServiceDate) = 31 then 1 else 0 end
	)
	
	+ ';' +
	
	'30/' + 
			CASE WHEN LEN(CONVERT(varchar,MONTH(getdate()))) = 1 THEN '0' + CONVERT(varchar,MONTH(getdate()))
				ELSE
				CONVERT(varchar,MONTH(getdate())) 
					END

			+ '/' + CONVERT(varchar,YEAR(getdate())) + ' 00:00:00'
	
	--AccountingMonthEnd2 (TO DEFINE)
	
	+ ';' +
	CASE WHEN  s.BuyerCode		  IS NULL	THEN '' ELSE CONVERT(VARCHAR,CONVERT(INT,s.BuyerCode))	END 
	+ ';' +
	CASE WHEN  s.BuyerAddress1    IS NULL	THEN '' ELSE s.BuyerAddress1	END 
	+ ';' +
	CASE WHEN  s.BuyerAddress2    IS NULL	THEN '' ELSE s.BuyerAddress2	END	
	+ ';' +
	CASE WHEN  s.BuyerAddress3    IS NULL	THEN '' ELSE s.BuyerAddress3	END	
	+ ';' +
	CASE WHEN  s.ExportTo		  IS NULL	THEN '' ELSE s.ExportTo			END 
	+ ';' +
	CASE WHEN  s.TaxDescription1  IS NULL	THEN '' ELSE s.TaxDescription1	END 
	+ ';' +
	CASE WHEN  s.ManufacturerName IS NULL	THEN '' ELSE s.ManufacturerName END 
	+ ';' +
	CASE WHEN s.MSODate			  IS NULL	THEN '' 
		ELSE CONVERT(VARCHAR(11),s.MSODate,103) + ' 00:00:00'  END 
	+ ';' +
	----GENRE (TO DEFINE)
	''
	+ ';' +
	----Carrosserie (TO DEFINE)
	''
	+ ';' +
	----Puissance (TO DEFINE)
	''
	+ ';' +
	----Rectification (TO DEFINE)
	''
	+ ';' +
	
	
	--s.SaleType   -- Type Vente 'BB , EX , IC , VO'
	
	CASE WHEN s.SaleType = 'B' THEN
		'VO'
	ELSE
		CASE WHEN s.SaleType = 'P' THEN
			'BB'
		ELSE
			CASE WHEN s.SaleType = 'F' THEN
				'BB'
			ELSE
				CASE WHEN s.SaleType = 'W' THEN
					CASE WHEN  s.ExportTo IS NULL THEN
						'IC'
					ELSE
						'EX'
					END
				ELSE
					s.SaleType
				END
		
			END
		END
	END
	
	+ ';' +
	CONVERT(VARCHAR(11),[Application.FileLog].DateLog,103)  + ' 00:00:00'
	
	FROM [Archive.Sales] s
	INNER JOIN [Dimension.ModelDetails] AS m ON s.ModelDetailId = m.ModelDetailId							
	INNER JOIN [Dimension.DocumentTypes]	ON s.DocumentTypeId	= [Dimension.DocumentTypes].DocumentTypeId
	INNER JOIN [Application.FileLog]		ON s.LogId			= [Application.FileLog].LogId
	WHERE 
		s.CountryId = @CountryId AND
	((@companyId	IS NULL)	OR (s.CompanyId = @companyId)) AND
	((@docType		IS NULL)	OR ([Dimension.DocumentTypes].DocType = @docType)) AND
	((@docSubType	IS NULL)	OR ([Dimension.DocumentTypes].DocSubType = @docSubType)) AND
	((@fileDate		IS null)	OR (CONVERT(VARCHAR(11),[Application.FileLog].DateLog,103) = @fileDate))
	AND 
		((@dateFrom	IS NULL) OR ((s.InvoiceDate   >= @df AND  s.InvoiceDate   <= @dt))) 
		
	
		--s.CompanyId in (@fr,@f3)
		
		--AND s.DocumentTypeId in 
		--(
		--	SELECT t.DocumentTypeId
		--	FROM [Dimension.DocumentTypes] t
		--	WHERE 
		--		((@docType		IS NULL) OR (t.docType	  = @docType   ))
		--	AND ((@docSubType	IS NULL) OR (t.DocSubType = @docSubType))
		--	AND   t.IsManual = 0 AND t.IsActive = 1
		--)
		--AND ((@invoiceDateFrom IS NULL) OR(s.InvoiceDate between @invoiceDateFrom and @invoiceDateTo))
		--AND ((@fileDate		   IS NULL) OR(s.LogId in
		--									(select LogId from [Application.FileLog] where 
		--										convert(varchar(11),DateLog,103) = @fileDate)
		--										))
	
	
	
END