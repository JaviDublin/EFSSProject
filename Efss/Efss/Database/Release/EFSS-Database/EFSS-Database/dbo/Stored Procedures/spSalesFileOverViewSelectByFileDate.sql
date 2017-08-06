-- =============================================
-- Author:		Javier
-- Create date: May 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spSalesFileOverViewSelectByFileDate]
		@sortExpression		VARCHAR(50)=NULL,
		@maximumRows		INT=NULL,
		@startRowIndex		INT=NULL,
		@startDate			DATETIME=NULL,
		@endDate			DATETIME=NULL,
		@countryName		VARCHAR(50)=NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

   SELECT 
	t.[count] as 'Count', t.LogId, t.FileDate,t.TotalInvoices,t.FleetCo, 
	t.OpCo,t.Original,t.CreditNotes,t.BuyBack , t.WholeSale ,t.Wreck,t.Errors
	FROM
	(
	SELECT 
	COUNT(u.LogId) OVER() AS 'Count',
	ROW_NUMBER() OVER
	(ORDER BY
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
		CASE WHEN @sortExpression = 'Wreck DESC' THEN u.Wreck END DESC,
		CASE WHEN @sortExpression = 'Errors' THEN u.Errors END ASC,
		CASE WHEN @sortExpression = 'Errors DESC' THEN u.Errors END DESC
		
	) AS ROW,
	u.LogId , u.FileDate , u.TotalInvoices , u.FleetCo , u.OpCo , u.Original,
	u.CreditNotes , u.BuyBack , u.WholeSale , u.Wreck , u.Errors
	FROM dbo.fnSalesFileByCountry(@countryName) u
	WHERE (convert(datetime,u.FileDate,103) BETWEEN @startDate AND @endDate)
	GROUP BY u.LogId , u.FileDate , u.TotalInvoices , u.FleetCo , u.OpCo , u.Original,
	u.CreditNotes, u.BuyBack , u.WholeSale , u.Wreck , u.Errors
	) AS t
	WHERE (t.ROW BETWEEN @startRowIndex AND @maximumRows)
	
	
END