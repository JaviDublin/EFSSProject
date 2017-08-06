-- =============================================
-- Author:		Javier
-- Create date: May 2011
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[fnSalesInvoiceDateByCountry]
(	
	@countryName VARCHAR(50)=NULL
)
RETURNS @TABLEFILE TABLE 
	(LogId INT primary key identity,FileDate VARCHAR(20),TotalInvoices INT,FleetCo INT, OpCo INT, Original INT,
		 CreditNotes INT,BuyBack INT , WholeSale INT, Wreck INT, Errors INT)
AS
BEGIN
	DECLARE @CountryId INT
	SET @CountryId = (SELECT CountryId FROM [Dimension.Countries] WHERE CountryName = @countryName)
	
	
	DECLARE @TypeFleetCo INT,
			@TypeOpCO	 INT

	SET @TypeFleetCo = (SELECT CompanyTypeId FROM [Dimension.CompanyTypes] WHERE CompanyType = 'FLEETCO')
	SET @TypeOpCO	 = (SELECT CompanyTypeId FROM [Dimension.CompanyTypes] WHERE CompanyType = 'OPCO')
	
	DECLARE @IdFleetCo  INT,
			@IdOpCo		INT

	SET @IdFleetCo = (SELECT CompanyId FROM [Dimension.Companies] WHERE 
							CountryId = @CountryId AND CompanyTypeId = @TypeFleetCo)
	
	SET @IdOpCo = (SELECT CompanyId FROM [Dimension.Companies] WHERE 
							CountryId = @CountryId AND CompanyTypeId = @TypeOpCO)
							
	INSERT INTO @TABLEFILE (FileDate)
	SELECT CONVERT(VARCHAR(11),InvoiceDate,103)
	FROM [Archive.Sales]
	WHERE CountryId =   @CountryId  
	GROUP BY InvoiceDate 
	ORDER BY InvoiceDate DESC
   
    
    
    UPDATE @TABLEFILE SET Errors = 0 
    
	UPDATE @TABLEFILE SET
	TF.Original = AOR.Count
	FROM @TABLEFILE TF
	INNER JOIN 
	(SELECT InvoiceDate , CountryId , COUNT(*) AS "Count"
	FROM [Archive.Sales]
	WHERE CountryId = @CountryId
	GROUP BY InvoiceDate , CountryId )
	AS AOR ON  convert(varchar(11),TF.FileDate,103) = convert(varchar(11),AOR.InvoiceDate,103)
		 
	UPDATE @TABLEFILE SET Original = 0 WHERE Original IS NULL
	
	UPDATE @TABLEFILE SET CreditNotes = 0 WHERE CreditNotes IS NULL
	
	UPDATE @TABLEFILE SET
	TF.FleetCo = AOR.Count
	FROM @TABLEFILE TF
	INNER JOIN 
	(SELECT InvoiceDate , CompanyId , COUNT(*) AS "Count"
	FROM [Archive.Sales]
	WHERE CompanyId = @IdFleetCo
	GROUP BY InvoiceDate , CompanyId )
	AS AOR ON  convert(varchar(11),TF.FileDate,103) = convert(varchar(11),AOR.InvoiceDate,103)
	
	
	UPDATE @TABLEFILE SET
	TF.OpCo = AOR.Count
	FROM @TABLEFILE TF
	INNER JOIN 
	(SELECT InvoiceDate , CompanyId , COUNT(*) AS "Count"
	FROM [Archive.Sales]
	WHERE CompanyId = @IdOpCo
	GROUP BY InvoiceDate , CompanyId )
	AS AOR ON  convert(varchar(11),TF.FileDate,103) = convert(varchar(11),AOR.InvoiceDate,103)
	
	UPDATE @TABLEFILE SET FleetCo = 0 WHERE FleetCo IS NULL
	
	UPDATE @TABLEFILE SET OpCo = 0 WHERE OpCo IS NULL
	
	UPDATE @TABLEFILE SET TotalInvoices = Original + CreditNotes	
	
	
	UPDATE @TABLEFILE SET
	TF.BuyBack = AOR.Count
	FROM @TABLEFILE TF
	INNER JOIN
	(SELECT InvoiceDate , DocumentTypeId , Count(*) AS "Count"
	FROM [Archive.Sales]
	WHERE DocumentTypeId IN (SELECT DocumentTypeId FROM [Dimension.DocumentTypes] WHERE DocSubType = 'BUYBACK')
	AND CountryId = @CountryId
	GROUP BY  InvoiceDate , DocumentTypeId)
	AS AOR ON convert(varchar(11),TF.FileDate,103) = convert(varchar(11),AOR.InvoiceDate,103)
	
	UPDATE @TABLEFILE SET
	TF.WholeSale = AOR.Count
	FROM @TABLEFILE TF
	INNER JOIN
	(SELECT InvoiceDate , DocumentTypeId , Count(*) AS "Count"
	FROM [Archive.Sales]
	WHERE DocumentTypeId IN (SELECT DocumentTypeId FROM [Dimension.DocumentTypes] WHERE DocSubType = 'WHOLESALE')
	AND CountryId = @CountryId
	GROUP BY  InvoiceDate , DocumentTypeId)
	AS AOR ON convert(varchar(11),TF.FileDate,103) = convert(varchar(11),AOR.InvoiceDate,103)
	
	UPDATE @TABLEFILE SET
	TF.Wreck = AOR.Count
	FROM @TABLEFILE TF
	INNER JOIN
	(SELECT InvoiceDate , DocumentTypeId , Count(*) AS "Count"
	FROM [Archive.Sales]
	WHERE DocumentTypeId IN (SELECT DocumentTypeId FROM [Dimension.DocumentTypes] WHERE DocSubType = 'WRECK')
	AND CountryId = @CountryId
	GROUP BY  InvoiceDate , DocumentTypeId)
	AS AOR ON convert(varchar(11),TF.FileDate,103) = convert(varchar(11),AOR.InvoiceDate,103)
							

	UPDATE @TABLEFILE SET BuyBack	= 0 WHERE BuyBack IS NULL
	UPDATE @TABLEFILE SET WholeSale = 0 WHERE WholeSale IS NULL
	UPDATE @TABLEFILE SET Wreck		= 0 WHERE Wreck IS NULL

	-- return all controls associated with user in group
	RETURN
END