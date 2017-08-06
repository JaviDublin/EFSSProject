-- =============================================
-- Author:		Javier
-- Create date: May 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spSalesOverViewByFileDate]
		@sortExpression		VARCHAR(50)=NULL,
		@maximumRows		INT=NULL,
		@startRowIndex		INT=NULL,
		@fileDate			VARCHAR(50)=NULL,
		@invoiceDate		VARCHAR(50)=NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	IF @fileDate	= 'ALL' BEGIN SET @fileDate		= NULL END
	IF @invoiceDate = 'ALL' BEGIN SET @invoiceDate	= NULL END

	SELECT 
	t.[count] as 'Count', t.CountryId ,  t.CountryName ,  
	t.FileDate,t.TotalInvoices,t.FleetCo, 
	t.OpCo,t.Original,t.CreditNotes,t.BuyBack , t.WholeSale ,t.Wreck 
	FROM
	(
	SELECT 
	COUNT(u.CountryId) OVER() AS 'Count',
	ROW_NUMBER() OVER
	(ORDER BY
		CASE WHEN @sortExpression = 'CountryName' THEN u.CountryName END ASC,
		CASE WHEN @sortExpression = 'CountryName DESC' THEN u.CountryName END DESC,
		CASE WHEN @sortExpression = 'FileDate' THEN u.FileDate END ASC,
		CASE WHEN @sortExpression = 'FileDate DESC' THEN u.FileDate END DESC,
		CASE WHEN @sortExpression = 'TotalInvoices' THEN u.TotalInvoices END ASC,
		CASE WHEN @sortExpression = 'TotalInvoices DESC' THEN u.TotalInvoices END DESC,
		CASE WHEN @sortExpression = 'FleetCo' THEN u.FleetCo END ASC,
		CASE WHEN @sortExpression = 'FleetCo DESC' THEN u.FleetCo END DESC,
		CASE WHEN @sortExpression = 'OpCo' THEN u.OpCo END ASC,
		CASE WHEN @sortExpression = 'OpCo DESC' THEN u.OpCo END DESC,
		CASE WHEN @sortExpression = 'Original' THEN u.Original END ASC,
		CASE WHEN @sortExpression = 'Original DESC' THEN u.Original END DESC,
		CASE WHEN @sortExpression = 'CreditNotes' THEN u.CreditNotes END ASC,
		CASE WHEN @sortExpression = 'CreditNotes DESC' THEN u.CreditNotes END DESC,
		CASE WHEN @sortExpression = 'BuyBack' THEN u.BuyBack END ASC,
		CASE WHEN @sortExpression = 'BuyBack DESC' THEN u.BuyBack END DESC,
		CASE WHEN @sortExpression = 'WholeSale' THEN u.WholeSale END ASC,
		CASE WHEN @sortExpression = 'WholeSale DESC' THEN u.WholeSale END DESC,
		CASE WHEN @sortExpression = 'Wreck' THEN u.Wreck END ASC,
		CASE WHEN @sortExpression = 'Wreck DESC' THEN u.Wreck END DESC
		
	) AS ROW,
	
		
	
	u.CountryId , u.CountryName , u.FileDate , u.TotalInvoices , u.FleetCo , u.OpCo , u.Original,
	u.CreditNotes , u.BuyBack , u.WholeSale , u.Wreck 
	FROM dbo.fnListViewSalesCountry(@fileDate,@invoiceDate) u
	GROUP BY u.CountryId , u.CountryName , u.FileDate , u.TotalInvoices , u.FleetCo , 
	u.OpCo , u.Original,
	u.CreditNotes, u.BuyBack , u.WholeSale , u.Wreck 
	
	
	
	) AS t
	WHERE (t.ROW BETWEEN @startRowIndex AND @maximumRows)
END