-- =============================================
-- Author:		Javier
-- Create date: July 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spDBImportSalesReportFile]
		@logId INT = null
AS
BEGIN
	
	SET NOCOUNT ON;
	
	--DECLARE @counter INT
	--SET @counter = (SELECT COUNT(*) FROM [Fact.FileReport] WHERE LogId = @logId)
	
	--DECLARE @fileDate DATETIME
	--SET @fileDate = (SELECT DateLog FROM [Application.FileLog] WHERE LogId = @logId)
	
	
	--IF @counter = 0
	--BEGIN
		-- UK (CountryId  = 1)
		--------------------------------------------------------------------------------------------------
		INSERT INTO [Fact.FileReport] 
		(
			CountryId , CompanyId , LogId	, BuyerId	, InvoiceDate , TotalInvoices ,
			FleetCo   , OpCo      , BuyBack , WholeSale , Wreck
		)
		
		SELECT
			CountryId , CompanyId , LogId , BuyerId , InvoiceDate , COUNT(*) ,
			0         , COUNT(*)  , COUNT(*) , 0 , 0
		FROM 
			[Staging.SalesOR]
		WHERE
			CountryId = 1
		AND
			IsReport = 1
		AND
			IsDuplicate = 0
		GROUP BY 
			CountryId , CompanyId , LogId , BuyerId , InvoiceDate
		ORDER BY
			CountryId , CompanyId , LogId , BuyerId , InvoiceDate
		
		-- GERMANY (CountryId  = 4)
		--------------------------------------------------------------------------------------------------
		INSERT INTO [Fact.FileReport] 
		(
			CountryId , CompanyId , LogId	, BuyerId	, InvoiceDate , TotalInvoices ,
			BuyBack , WholeSale , Wreck
		)
		SELECT
			CountryId , CompanyId , LogId , BuyerId , InvoiceDate , COUNT(*) ,
			 COUNT(*) , 0 , 0
		FROM 
			[Staging.SalesOR]
		WHERE
			CountryId = 4
		AND
			IsReport = 1
		AND
			IsDuplicate = 0
		GROUP BY 
			CountryId , CompanyId , LogId , BuyerId , InvoiceDate 
		ORDER BY
			CountryId , CompanyId , LogId , BuyerId , InvoiceDate 
	
		-- SPAIN (CountryId  = 8)
		--------------------------------------------------------------------------------------------------
		INSERT INTO [Fact.FileReport] 
		(
			CountryId , CompanyId , LogId	, BuyerId	, InvoiceDate , TotalInvoices ,
			FleetCo   , OpCo      
		)

		SELECT
			CountryId , CompanyId , LogId , BuyerId , InvoiceDate , COUNT(*) ,
			0         , COUNT(*)
		FROM 
			[Staging.SalesOR]
		WHERE
			CountryId = 8
		AND
			IsReport = 1
		AND
			IsDuplicate = 0
		GROUP BY 
			CountryId , CompanyId , LogId , BuyerId , InvoiceDate
		ORDER BY
			CountryId , CompanyId , LogId , BuyerId , InvoiceDate
		
		-- SWITZERLAND (CountryId  = 3)
		--------------------------------------------------------------------------------------------------
		INSERT INTO [Fact.FileReport] 
		(
			CountryId , CompanyId , LogId	, BuyerId	, InvoiceDate , TotalInvoices ,
			FleetCo   , OpCo      , BuyBack , WholeSale , Wreck
		)
		
		SELECT
			CountryId , CompanyId , LogId , BuyerId , InvoiceDate , COUNT(*) ,
			0         , COUNT(*)  , COUNT(*) , 0 , 0
		FROM 
			[Staging.SalesOR]
		WHERE
			CountryId = 3
		AND
			IsReport = 1
		AND
			IsDuplicate = 0
		GROUP BY 
			CountryId , CompanyId , LogId , BuyerId , InvoiceDate
		ORDER BY
			CountryId , CompanyId , LogId , BuyerId , InvoiceDate
		
		-- NETHERLANDS (CountryId  = 5)
		--------------------------------------------------------------------------------------------------
		INSERT INTO [Fact.FileReport] 
		(
			CountryId , CompanyId , LogId	, BuyerId	, InvoiceDate , TotalInvoices ,
			BuyBack , WholeSale , Wreck
		)
		
		SELECT
			CountryId , CompanyId , LogId , BuyerId , InvoiceDate , COUNT(*) ,
			COUNT(*) , 0 , 0
		FROM 
			[Staging.SalesOR]
		WHERE
			CountryId = 5
		AND
			IsReport = 1
		AND
			IsDuplicate = 0
		GROUP BY 
			CountryId , CompanyId , LogId , BuyerId , InvoiceDate
		ORDER BY
			CountryId , CompanyId , LogId , BuyerId , InvoiceDate
		
		-- ITALY (CountryId  = 9)
		--------------------------------------------------------------------------------------------------
		INSERT INTO [Fact.FileReport] 
		(
			CountryId , CompanyId , LogId	, BuyerId	, InvoiceDate , TotalInvoices
		)
		
		SELECT
			CountryId , CompanyId , LogId , BuyerId , InvoiceDate , COUNT(*) 
		FROM 
			[Staging.SalesOR]
		WHERE
			CountryId = 9
		AND
			IsReport = 1
		AND
			IsDuplicate = 0
		GROUP BY 
			CountryId , CompanyId , LogId , BuyerId , InvoiceDate
		ORDER BY
			CountryId , CompanyId , LogId , BuyerId , InvoiceDate
		
		-- FRANCE (CountryId  = 6)
		--------------------------------------------------------------------------------------------------
		INSERT INTO [Fact.FileReport] 
		(
			CountryId , CompanyId , LogId	, BuyerId	, InvoiceDate , TotalInvoices
		)
		
		SELECT
			CountryId , CompanyId , LogId , BuyerId , InvoiceDate , COUNT(*)
			
		FROM 
			[Staging.SalesOR]
		WHERE
			CountryId = 6
		AND
			IsReport = 1
		AND
			IsDuplicate = 0
		GROUP BY 
			CountryId , CompanyId , LogId , BuyerId , InvoiceDate
		ORDER BY
			CountryId , CompanyId , LogId , BuyerId , InvoiceDate
		
		-- BELGIUM (CountryId  = 2)
		--------------------------------------------------------------------------------------------------
		INSERT INTO [Fact.FileReport] 
		(
			CountryId , CompanyId , LogId	, BuyerId	, InvoiceDate , TotalInvoices ,
			FleetCo   , OpCo      
		)

		SELECT
			CountryId , CompanyId , LogId , BuyerId , InvoiceDate , COUNT(*) ,
			0         , COUNT(*)
		FROM 
			[Staging.SalesOR]
		WHERE
			CountryId = 2
		AND
			IsReport = 1
		AND
			IsDuplicate = 0
		GROUP BY 
			CountryId , CompanyId , LogId , BuyerId , InvoiceDate
		ORDER BY
			CountryId , CompanyId , LogId , BuyerId , InvoiceDate
		
		-- LUXEMBOURG (CountryId  = 7)
		--------------------------------------------------------------------------------------------------
		INSERT INTO [Fact.FileReport] 
		(
			CountryId , CompanyId , LogId	, BuyerId	, InvoiceDate , TotalInvoices ,
			FleetCo   , OpCo      
		)

		SELECT
			CountryId , CompanyId , LogId , BuyerId , InvoiceDate , COUNT(*) ,
			0         , COUNT(*)
		FROM 
			[Staging.SalesOR]
		WHERE
			CountryId = 7
		AND
			IsReport = 1
		AND
			IsDuplicate = 0
		GROUP BY 
			CountryId , CompanyId , LogId , BuyerId , InvoiceDate
		ORDER BY
			CountryId , CompanyId , LogId , BuyerId , InvoiceDate
		
		-- TOTAL ORIGINAL INVOICES
		--------------------------------------------------------------------------------------------------
		UPDATE [Fact.FileReport] SET
			Original = TotalInvoices
		FROM 
			[Fact.FileReport]
		WHERE 
			LogId IN (SELECT LogId FROM [Staging.SalesOR])
		AND 
			Original IS NULL
			
		UPDATE [Fact.FileReport] SET
			Original = 0 
		WHERE 
			Original IS NULL 
		
		-- TOTAL CREDIT NOTES
		--------------------------------------------------------------------------------------------------
		UPDATE [Fact.FileReport] SET
			CreditNotes = 0
		FROM 
			[Fact.FileReport]
		WHERE 
			LogId IN (SELECT LogId FROM [Staging.SalesCN])
		AND 
			CreditNotes IS NULL
			
		UPDATE [Fact.FileReport] SET
			CreditNotes = 0 
		WHERE 
			CreditNotes IS NULL
			
		-- TOTAL FLEETCO
		--------------------------------------------------------------------------------------------------
		UPDATE [Fact.FileReport] SET
			FleetCo = TotalInvoices
		WHERE 
			CompanyId IN 
				(
					SELECT CompanyId FROM [Dimension.Companies] WHERE CompanyTypeId IN
					(
						SELECT CompanyTypeId FROM [Dimension.CompanyTypes] WHERE CompanyType = 'FLEETCO'
					)
				)
		AND FleetCo IS NULL 

		UPDATE [Fact.FileReport] SET 
			FleetCo = 0
		WHERE 
			FleetCo IS NULL
		
		-- TOTAL OPCO
		--------------------------------------------------------------------------------------------------
		UPDATE [Fact.FileReport] SET
			OpCo = TotalInvoices
		WHERE CompanyId IN 
				(
					SELECT CompanyId FROM [Dimension.Companies] WHERE CompanyTypeId IN
					(
						SELECT CompanyTypeId FROM [Dimension.CompanyTypes] WHERE CompanyType = 'OPCO'
					)
				)
		AND OpCo IS NULL

		UPDATE [Fact.FileReport] SET 
			OpCo = 0
		WHERE 
			OpCo IS NULL 
		
		-- TOTAL BUYBACK
		--------------------------------------------------------------------------------------------------	
		UPDATE [Fact.FileReport] SET
			[Fact.FileReport].BuyBack = AOR.Count
		FROM [Fact.FileReport] FR
		INNER JOIN
			(
				SELECT CountryId , CompanyId , BuyerId , LogId , InvoiceDate , COUNT(*) AS "Count" 
				FROM [Staging.SalesOR]
				WHERE IsReport = 1 AND IsDuplicate = 0 AND SaleType IN ('P','F','D')
				GROUP BY CountryId , CompanyId , BuyerId , LogId , InvoiceDate
			) 
		AS AOR 
		ON FR.CountryId		= AOR.CountryId 
		AND FR.CompanyId	= AOR.CompanyId 
		AND FR.BuyerId		= AOR.BuyerId 
		AND FR.LogId		= AOR.LogId 
		AND FR.InvoiceDate	= AOR.InvoiceDate 
		AND FR.BuyBack IS NULL
		
		-- TOTAL WHOLESALE
		--------------------------------------------------------------------------------------------------	
		UPDATE [Fact.FileReport] SET
			[Fact.FileReport].WholeSale = AOR.Count
		FROM [Fact.FileReport] FR
		INNER JOIN
			(
				SELECT CountryId , CompanyId , BuyerId , LogId , InvoiceDate , COUNT(*) AS "Count" 
				FROM [Staging.SalesOR]
				WHERE IsReport = 1 AND IsDuplicate = 0 AND SaleType IN ('W','R')
				GROUP BY CountryId , CompanyId , BuyerId , LogId , InvoiceDate
			) 
		AS AOR 
		ON FR.CountryId		= AOR.CountryId 
		AND FR.CompanyId	= AOR.CompanyId 
		AND FR.BuyerId		= AOR.BuyerId 
		AND FR.LogId		= AOR.LogId 
		AND FR.InvoiceDate	= AOR.InvoiceDate 
		AND FR.WholeSale IS NULL
		
		-- TOTAL WRECK / SAVAGE
		--------------------------------------------------------------------------------------------------	
		UPDATE [Fact.FileReport] SET
			[Fact.FileReport].Wreck = AOR.Count
		FROM [Fact.FileReport] FR
		INNER JOIN
			(
				SELECT CountryId , CompanyId , BuyerId , LogId , InvoiceDate , COUNT(*) AS "Count" 
				FROM [Staging.SalesOR]
				WHERE IsReport = 1 AND IsDuplicate = 0 AND SaleType IN ('S')
				GROUP BY CountryId , CompanyId , BuyerId , LogId , InvoiceDate
			) 
		AS AOR 
		ON FR.CountryId		= AOR.CountryId 
		AND FR.CompanyId	= AOR.CompanyId 
		AND FR.BuyerId		= AOR.BuyerId 
		AND FR.LogId		= AOR.LogId 
		AND FR.InvoiceDate	= AOR.InvoiceDate 
		AND FR.Wreck IS NULL
		
		
		UPDATE [Fact.FileReport] SET BuyBack	= 0 WHERE BuyBack IS NULL
		UPDATE [Fact.FileReport] SET WholeSale	= 0 WHERE WholeSale IS NULL
		UPDATE [Fact.FileReport] SET Wreck		= 0 WHERE Wreck IS NULL
				
		-- FILE DATE
		--------------------------------------------------------------------------------------------------
		UPDATE [Fact.FileReport] SET
			[Fact.FileReport].FileDate = [Application.FileLog].DateLog
		FROM [Fact.FileReport]
		INNER JOIN [Application.FileLog] ON
			[Fact.FileReport].LogId = [Application.FileLog].LogId
		WHERE 
			[Fact.FileReport].FileDate IS NULL
		
	--END
	

  
END