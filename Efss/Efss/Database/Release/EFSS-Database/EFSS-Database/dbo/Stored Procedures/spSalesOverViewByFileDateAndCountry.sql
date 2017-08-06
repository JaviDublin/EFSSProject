-- =============================================
-- Author:		Javier
-- Create date: May 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spSalesOverViewByFileDateAndCountry]
		@sortExpression		VARCHAR(50)=NULL,
		@maximumRows		INT=NULL,
		@startRowIndex		INT=NULL,
		@fileDate			VARCHAR(50)=NULL,
		@invoiceDate		VARCHAR(50)=NULL,
		@countryId			INT=NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT 
	t.[count] as 'Count', t.BuyerId ,  t.BuyerCode ,  t.BuyerName , 
	t.FileDate,t.TotalInvoices,t.FleetCo, 
	t.OpCo,t.Original,t.CreditNotes,t.BuyBack , t.WholeSale ,t.Wreck ,
	 t.Email
	FROM
	(
	SELECT 
	COUNT(u.BuyerId) OVER() AS 'Count',
	ROW_NUMBER() OVER
	(ORDER BY
		CASE WHEN @sortExpression = 'BuyerCode' THEN u.BuyerCode END ASC,
		CASE WHEN @sortExpression = 'BuyerCode DESC' THEN u.BuyerCode END DESC,
		CASE WHEN @sortExpression = 'BuyerName' THEN u.BuyerName END ASC,
		CASE WHEN @sortExpression = 'BuyerName DESC' THEN u.BuyerName END DESC,
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
		CASE WHEN @sortExpression = 'Email' THEN u.Email END ASC,
		CASE WHEN @sortExpression = 'Email DESC' THEN u.Email END DESC
		
	) AS ROW,
	u.BuyerId , u.BuyerCode , u.BuyerName ,
	u.FileDate , u.TotalInvoices , u.FleetCo , u.OpCo , u.Original,
	u.CreditNotes , u.BuyBack , u.WholeSale , u.Wreck , u.Email
	FROM dbo.fnListViewSalesBuyers(@fileDate,@invoiceDate,@countryId) u
	GROUP BY u.BuyerId , u.BuyerCode , u.BuyerName ,
	u.FileDate , u.TotalInvoices , u.FleetCo , u.OpCo , u.Original,
	u.CreditNotes , u.BuyBack , u.WholeSale , u.Wreck , u.Email
	) AS t
	WHERE (t.ROW BETWEEN @startRowIndex AND @maximumRows)
END