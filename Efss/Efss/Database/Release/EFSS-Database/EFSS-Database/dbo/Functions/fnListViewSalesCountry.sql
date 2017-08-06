-- =============================================
-- Author:		Javier
-- Create date: Julu 2011
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[fnListViewSalesCountry]
(	
		@fileDate	 VARCHAR(20)= NULL,
		@invoiceDate VARCHAR(20)= NULL
)
RETURNS @TABLEFILE TABLE 
(CountryId INT , CountryName VARCHAR(50), 
FileDate VARCHAR(20),TotalInvoices INT,FleetCo INT, OpCo INT, Original INT,
CreditNotes INT,BuyBack INT , WholeSale INT, Wreck INT)
AS
BEGIN

	INSERT INTO @TABLEFILE 
	(
		CountryId , CountryName , FileDate , TotalInvoices , Original , CreditNotes ,
		FleetCo , OpCo , BuyBack , WholeSale , Wreck
	)
	
	SELECT 
		u.CountryId ,
		ct.CountryName ,
		convert(varchar(11),u.FileDate,103) ,
		SUM(u.TotalInvoices),
		SUM(u.Original),
		SUM(u.CreditNotes),
		SUM(u.FleetCo),
		SUM(u.OpCo),
		SUM(u.BuyBack),
		SUM(u.WholeSale),
		SUM(u.Wreck)
	FROM 
		[Fact.FileReport] u
	INNER JOIN [Dimension.Countries] AS ct ON
						u.CountryId  = ct.CountryId
	WHERE
			((@fileDate		IS NULL) OR (CONVERT(varchar(11),u.FileDate,103) = @fileDate))
		AND ((@invoiceDate	IS NULL) OR (CONVERT(VARCHAR(11),u.InvoiceDate,103) = @invoiceDate))
	GROUP BY 
		u.CountryId ,
		ct.CountryName ,
		CONVERT(VARCHAR(11),u.FileDate,103)

	RETURN
END