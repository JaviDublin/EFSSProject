-- =============================================
-- Author:		Javier
-- Create date: May 2011
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[fnSalesFileByDate]
(	
		@fileDate	 VARCHAR(50)=NULL,
		@invoiceDate VARCHAR(50)=NULL
)
RETURNS @TABLEFILE TABLE 
(CountryId INT,CountryName VARCHAR(50), 
FileDate VARCHAR(20),TotalInvoices INT,FleetCo INT, OpCo INT, Original INT,
CreditNotes INT,BuyBack INT , WholeSale INT, Wreck INT)
AS
BEGIN

	IF @fileDate	= 'ALL'	BEGIN SET @fileDate		= null END
	IF @invoiceDate = 'ALL' BEGIN SET @invoiceDate	= null END

	INSERT INTO @TABLEFILE
	SELECT  
	[Dimension.Countries].CountryId ,
	[Dimension.Countries].CountryName, 
	CONVERT(VARCHAR(11), FR.FileDate,103) AS "FileDate" ,
	TI.TotalInvoices , FC.FleetCo , OP.OpCo , ORG.Original , CN.CreditNotes , 
	BB.BuyBack , WS.WholeSale ,WR.Wreck
	FROM [Fact.FileReport] FR
	INNER JOIN [Dimension.Countries] ON FR.CountryId = [Dimension.Countries].CountryId
	INNER JOIN 
	(select countryid , sum(TotalInvoices) as "TotalInvoices"
	from[Fact.FileReport] 
	where ((@invoiceDate is null) OR (CONVERT(varchar(11),InvoiceDate,103) = @invoiceDate))
	and ((@fileDate IS NULL) OR (CONVERT(varchar(11),FileDate,103) = @fileDate))
	group by countryid) as TI on FR.CountryId = TI.CountryId
	INNER JOIN
	(select countryid , sum(FleetCo) as "FleetCo"	
	from[Fact.FileReport] 
	where ((@invoiceDate is null) OR (CONVERT(varchar(11),InvoiceDate,103) = @invoiceDate))
	and ((@fileDate IS NULL) OR (CONVERT(varchar(11),FileDate,103) = @fileDate))
	group by countryid) as FC on FR.CountryId = FC.CountryId
	INNER JOIN 
	(select countryid , sum(OpCo) as "OpCo"		
	from[Fact.FileReport] 
	where ((@invoiceDate is null) OR (CONVERT(varchar(11),InvoiceDate,103) = @invoiceDate))
	and ((@fileDate IS NULL) OR (CONVERT(varchar(11),FileDate,103) = @fileDate))
	group by countryid) as OP on FR.CountryId = OP.CountryId
	INNER JOIN 
	(select countryid , sum(Original) as "Original"	
	from[Fact.FileReport]
	where ((@invoiceDate is null) OR (CONVERT(varchar(11),InvoiceDate,103) = @invoiceDate))
	and ((@fileDate IS NULL) OR (CONVERT(varchar(11),FileDate,103) = @fileDate))
	group by countryid) AS ORG ON FR.CountryId = ORG.CountryId
	INNER JOIN 
	(select countryid , sum(CreditNotes) as "CreditNotes"
	from[Fact.FileReport] 
	where ((@invoiceDate is null) OR (CONVERT(varchar(11),InvoiceDate,103) = @invoiceDate))
	and ((@fileDate IS NULL) OR (CONVERT(varchar(11),FileDate,103) = @fileDate))
	group by countryid) AS CN ON FR.CountryId = CN.CountryId
	INNER JOIN 
	(select countryid , sum(BuyBack) as "BuyBack"
	from[Fact.FileReport] 
	where ((@invoiceDate is null) OR (CONVERT(varchar(11),InvoiceDate,103) = @invoiceDate))
	and ((@fileDate IS NULL) OR (CONVERT(varchar(11),FileDate,103) = @fileDate))
	group by countryid) AS BB ON FR.CountryId = BB.CountryId
	INNER JOIN
	(select countryid , sum(WholeSale) as "WholeSale"	
	from[Fact.FileReport] 
	where ((@invoiceDate is null) OR (CONVERT(varchar(11),InvoiceDate,103) = @invoiceDate))
	and ((@fileDate IS NULL) OR (CONVERT(varchar(11),FileDate,103) = @fileDate))
	group by countryid) AS WS ON FR.CountryId = WS.CountryId
	INNER JOIN 
	(select countryid , sum(Wreck) as "Wreck"		
	from[Fact.FileReport] 
	where 
		((@invoiceDate is null) OR (CONVERT(varchar(11),InvoiceDate,103) = @invoiceDate))
	and ((@fileDate IS NULL)	OR (CONVERT(varchar(11),FileDate,103) = @fileDate))
	group by countryid) AS WR ON FR.CountryId = WR.CountryId
	GROUP BY [Dimension.Countries].CountryId,
	[Dimension.Countries].CountryName , FR.FileDate , TI.TotalInvoices , FC.FleetCo , OP.OpCo ,
	ORG.Original , CN.CreditNotes , BB.BuyBack , WS.WholeSale ,WR.Wreck



	
	

	RETURN
END