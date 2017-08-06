-- =============================================
-- Author:		Javier
-- Create date: October 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE spDBImportSalesIsReport
	
AS
BEGIN
	
	SET NOCOUNT ON;
	-- 7 REPORTS
	--------------------------------------------------------------------------------------------------------
	--------------------------------------------------------------------------------------------------------
	
	-- Is Report (only the BuyBacks) UK
	--------------------------------------------------------------------
	UPDATE 	[Staging.SalesOR] SET 
		IsReport = 1
	WHERE
		[Staging.SalesOR].CountryId = 1 
	AND [Staging.SalesOR].SaleType = 'F'
	AND [Staging.SalesOR].InvoiceNet > 1
	--AND [Staging.SalesOR].ManufacturerCode NOT IN ('F','K')
	AND [Staging.SalesOR].ManufacturerCode IN
		(
				'15',
				--'16',
				'17',
				'9',
				--'F',
				'I',
				--'K',
				--'N',
				'R',
				'U',
				'V',
				'W',
				'Y',
				'Z'				
				)

	UPDATE 	[Staging.SalesOR] SET 
		IsReport = 1
	WHERE
		[Staging.SalesOR].CountryId = 1 
	AND [Staging.SalesOR].SaleType IN ('P','D')
	AND [Staging.SalesOR].ManufacturerCode NOT IN ('F','K')
	AND [Staging.SalesOR].IsReport IS NULL
	
	UPDATE 	[Staging.SalesOR] SET 
		IsReport = 0
	WHERE
		[Staging.SalesOR].CountryId = 1 
	AND [Staging.SalesOR].IsReport IS NULL
	
	UPDATE [Staging.SalesOR] SET 
		IsError = 1 
	WHERE
		[Staging.SalesOR].CountryId = 1 
	AND [Staging.SalesOR].IsReport = 1
	AND [Staging.SalesOR].HasBuyer = 0
	
	-- GE VENDORS [CountryId = 4]
	--------------------------------------------------------------------------------------------------------
	-------------------------------------------------------------------------------------------------------
			
	-- Is Report (only the BuyBacks)
	--------------------------------------------------------------------
	UPDATE 	[Staging.SalesOR] SET 
		IsReport = 1
	WHERE
		[Staging.SalesOR].CountryId = 4 
	AND [Staging.SalesOR].SaleType = 'F'
	AND [Staging.SalesOR].InvoiceNet > 1
		
	UPDATE 	[Staging.SalesOR] SET 
		IsReport = 1
	WHERE
		[Staging.SalesOR].CountryId = 4 
	AND [Staging.SalesOR].SaleType IN ('P','D')
	AND [Staging.SalesOR].IsReport IS NULL
		
	UPDATE 	[Staging.SalesOR] SET 
		IsReport = 0
	WHERE
		[Staging.SalesOR].CountryId = 4 
	AND [Staging.SalesOR].IsReport IS NULL
		
	UPDATE [Staging.SalesOR] SET 
		IsError = 1 
	WHERE
		[Staging.SalesOR].CountryId = 4 
	AND [Staging.SalesOR].IsReport = 1
	AND [Staging.SalesOR].HasBuyer = 0
	
	-- SP VENDORS [CountryId = 8]
	--------------------------------------------------------------------------------------------------------
	--------------------------------------------------------------------------------------------------------
		
	-- Is Report (all sale types)
	--------------------------------------------------------------------
		
	UPDATE 	[Staging.SalesOR] SET 
		IsReport = 1
	WHERE
		[Staging.SalesOR].CountryId = 8 
	AND [Staging.SalesOR].SaleType = 'F'
	AND [Staging.SalesOR].InvoiceNet > 1
		
	UPDATE 	[Staging.SalesOR] SET 
		IsReport = 1
	WHERE
		[Staging.SalesOR].CountryId = 8 
	AND [Staging.SalesOR].SaleType IN ('P','D','W','R','S')
	AND [Staging.SalesOR].IsReport IS NULL
		
	UPDATE 	[Staging.SalesOR] SET 
		IsReport = 0
	WHERE
		[Staging.SalesOR].CountryId = 8
	AND [Staging.SalesOR].IsReport IS NULL
		
	UPDATE [Staging.SalesOR] SET 
		IsError = 1 
	WHERE
		[Staging.SalesOR].CountryId = 8 
	AND [Staging.SalesOR].IsReport = 1
	AND [Staging.SalesOR].HasBuyer = 0
	
	-- SZ VENDORS [CountryId = 3]
	--------------------------------------------------------------------------------------------------------
	--------------------------------------------------------------------------------------------------------
		
	-- Is Report (only the BuyBacks)
	--------------------------------------------------------------------
		
	UPDATE 	[Staging.SalesOR] SET 
		IsReport = 1
	WHERE
		[Staging.SalesOR].CountryId = 3
	AND [Staging.SalesOR].SaleType = 'F'
	AND [Staging.SalesOR].InvoiceNet > 1
		
	UPDATE 	[Staging.SalesOR] SET 
		IsReport = 1
	WHERE
		[Staging.SalesOR].CountryId = 3 
	AND [Staging.SalesOR].SaleType IN ('P','D')
	AND [Staging.SalesOR].IsReport IS NULL
		
	UPDATE 	[Staging.SalesOR] SET 
		IsReport = 0
	WHERE
		[Staging.SalesOR].CountryId = 3
	AND [Staging.SalesOR].IsReport IS NULL
		
	UPDATE [Staging.SalesOR] SET 
		IsError = 1 
	WHERE
		[Staging.SalesOR].CountryId = 3
	AND [Staging.SalesOR].IsReport = 1
	AND [Staging.SalesOR].HasBuyer = 0	
	
	
	-- NE VENDORS [CountryId = 5]
	--------------------------------------------------------------------------------------------------------
	--------------------------------------------------------------------------------------------------------
		
	-- Is Report (only the BuyBacks)
	--------------------------------------------------------------------
		
	UPDATE 	[Staging.SalesOR] SET 
		IsReport = 1
	WHERE
		[Staging.SalesOR].CountryId = 5
	AND [Staging.SalesOR].SaleType = 'F'
	AND [Staging.SalesOR].InvoiceNet > 1
		
	UPDATE 	[Staging.SalesOR] SET	
		IsReport = 1
	WHERE
		[Staging.SalesOR].CountryId = 5
	AND [Staging.SalesOR].SaleType IN ('P','D')
	AND [Staging.SalesOR].IsReport IS NULL
		
	UPDATE 	[Staging.SalesOR] SET 
		IsReport = 0
	WHERE
		[Staging.SalesOR].CountryId = 5
	AND [Staging.SalesOR].IsReport IS NULL
	
	UPDATE [Staging.SalesOR] SET 
		IsError = 1 
	WHERE
		[Staging.SalesOR].CountryId = 5
	AND [Staging.SalesOR].IsReport = 1
	AND [Staging.SalesOR].HasBuyer = 0	
	
	-- IT VENDORS [CountryId = 9]
	--------------------------------------------------------------------------------------------------------
	--------------------------------------------------------------------------------------------------------
		
	-- Is Report (all sale types)
	--------------------------------------------------------------------
		
	UPDATE 	[Staging.SalesOR] SET 
		IsReport = 1
	WHERE
		[Staging.SalesOR].CountryId = 9 
	AND [Staging.SalesOR].SaleType = 'F'
	AND [Staging.SalesOR].InvoiceNet > 1
		
	UPDATE 	[Staging.SalesOR] SET 
		IsReport = 1
	WHERE
		[Staging.SalesOR].CountryId = 9 
	AND [Staging.SalesOR].SaleType IN ('P','D','W','R','S')
	AND [Staging.SalesOR].IsReport IS NULL
		
	UPDATE 	[Staging.SalesOR] SET 
		IsReport = 0
	WHERE
		[Staging.SalesOR].CountryId = 9
	AND [Staging.SalesOR].IsReport IS NULL
		
	UPDATE [Staging.SalesOR] SET 
		IsError = 1 
	WHERE
		[Staging.SalesOR].CountryId = 9 
	AND [Staging.SalesOR].IsReport = 1
	AND [Staging.SalesOR].HasBuyer = 0
	AND [Staging.SalesOR].SaleType not in ('W','R','S')
			
	-- FR VENDORS [CountryId = 6]
	--------------------------------------------------------------------------------------------------------
	--------------------------------------------------------------------------------------------------------
		
	-- Is Report (all sale types)
	---------------------------------------------------------------------
		
	UPDATE 	[Staging.SalesOR] SET 
		IsReport = 1
	WHERE
		[Staging.SalesOR].CountryId = 6 
	AND [Staging.SalesOR].SaleType = 'F'
	AND [Staging.SalesOR].InvoiceNet > 1
		
	UPDATE 	[Staging.SalesOR] SET 
		IsReport = 1
	WHERE
		[Staging.SalesOR].CountryId = 6
	AND [Staging.SalesOR].SaleType IN ('P','D','W','R','S')
	AND [Staging.SalesOR].IsReport IS NULL
		
	UPDATE 	[Staging.SalesOR] SET 
		IsReport = 0
	WHERE
		[Staging.SalesOR].CountryId = 6
	AND [Staging.SalesOR].IsReport IS NULL
		
	UPDATE [Staging.SalesOR] SET 
		IsError = 1 
	WHERE
		[Staging.SalesOR].CountryId = 6
	AND [Staging.SalesOR].IsReport = 1
	AND [Staging.SalesOR].HasBuyer = 0
	AND [Staging.SalesOR].SaleType not in ('W','R','S')
	
	-- BE VENDORS [CountryId = 2]
	--------------------------------------------------------------------------------------------------------
	--------------------------------------------------------------------------------------------------------
			
	-- Is Report (all sale types)
	---------------------------------------------------------------------
		
	UPDATE 	[Staging.SalesOR] SET 
		IsReport = 1
	WHERE
		[Staging.SalesOR].CountryId = 2 
	AND [Staging.SalesOR].SaleType = 'F'
	AND [Staging.SalesOR].InvoiceNet > 1
		
	UPDATE 	[Staging.SalesOR] SET 
		IsReport = 1
	WHERE
		[Staging.SalesOR].CountryId = 2
	AND [Staging.SalesOR].SaleType IN ('P','D','W','R','S')
	AND [Staging.SalesOR].IsReport IS NULL
		
	UPDATE 	[Staging.SalesOR] SET 
		IsReport = 0
	WHERE
		[Staging.SalesOR].CountryId = 2
	AND [Staging.SalesOR].IsReport IS NULL
		
	UPDATE [Staging.SalesOR] SET 
		IsError = 1 
	WHERE
		[Staging.SalesOR].CountryId = 2
	AND [Staging.SalesOR].IsReport = 1
	AND [Staging.SalesOR].HasBuyer = 0
	AND [Staging.SalesOR].SaleType not in ('W','R','S')
	
	-- LU VENDORS [CountryId = 7]
	--------------------------------------------------------------------------------------------------------
	--------------------------------------------------------------------------------------------------------
		
	-- Is Report (all sale types)
	----------------------------------------------------------------------
		
	UPDATE 	[Staging.SalesOR] SET 
		IsReport = 1
	WHERE
		[Staging.SalesOR].CountryId = 7 
	AND [Staging.SalesOR].SaleType = 'F'
	AND [Staging.SalesOR].InvoiceNet > 1
		
	UPDATE 	[Staging.SalesOR] SET 
		IsReport = 1
	WHERE
		[Staging.SalesOR].CountryId = 7
	AND [Staging.SalesOR].SaleType IN ('P','D','W','R','S')
	AND [Staging.SalesOR].IsReport IS NULL
		
	UPDATE 	[Staging.SalesOR] SET 
		IsReport = 0
	WHERE
		[Staging.SalesOR].CountryId = 7
	AND [Staging.SalesOR].IsReport IS NULL
		
	UPDATE [Staging.SalesOR] SET 
		IsError = 1 
	WHERE
		[Staging.SalesOR].CountryId = 7
	AND [Staging.SalesOR].IsReport = 1
	AND [Staging.SalesOR].HasBuyer = 0
	AND [Staging.SalesOR].SaleType not in ('W','R','S');

   
END