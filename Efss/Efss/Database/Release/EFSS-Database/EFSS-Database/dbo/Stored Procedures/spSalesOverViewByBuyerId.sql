-- =============================================
-- Author:		Javier
-- Create date: May 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spSalesOverViewByBuyerId]
		@sortExpression		VARCHAR(50)=NULL,
		@maximumRows		INT=NULL,
		@startRowIndex		INT=NULL,
		@fileDate			VARCHAR(50)=NULL,
		@invoiceDate		VARCHAR(50)=NULL,
		@buyerId			INT=NULL
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	IF @fileDate	= 'ALL'	BEGIN SET @fileDate		= null END
	IF @invoiceDate = 'ALL' BEGIN SET @invoiceDate	= null END
	
	
	SELECT t.[count] as 'Count' , t.DocItemId , 
	t.CompanyCode , t.Serial ,  t.Plate , t.Unit ,
	t.BuyerCode ,  t.InvoiceNumber , t.InvoiceDate ,
	convert(varchar,t.InvoiceTotal) as "InvoiceTotal" ,  t.SaleType as "InvoiceStatus"
	FROM
	(SELECT 
	COUNT(u.DocItemId) OVER() AS 'Count',
	ROW_NUMBER() OVER
	(ORDER BY
		CASE WHEN @sortExpression = 'CompanyCode' THEN u.CompanyCode END ASC,
		CASE WHEN @sortExpression = 'CompanyCode DESC' THEN u.CompanyCode END DESC,
		CASE WHEN @sortExpression = 'Serial' THEN u.Serial END ASC,
		CASE WHEN @sortExpression = 'Serial DESC' THEN u.Serial END DESC,
		CASE WHEN @sortExpression = 'Plate' THEN u.Plate END ASC,
		CASE WHEN @sortExpression = 'Plate DESC' THEN u.Plate END DESC,
		CASE WHEN @sortExpression = 'Unit' THEN u.Unit END ASC,
		CASE WHEN @sortExpression = 'Unit DESC' THEN u.Unit END DESC,
		CASE WHEN @sortExpression = 'BuyerCode' THEN u.BuyerCode END ASC,
		CASE WHEN @sortExpression = 'BuyerCode DESC' THEN u.BuyerCode END DESC,
		CASE WHEN @sortExpression = 'InvoiceNumber' THEN u.InvoiceNumber END ASC,
		CASE WHEN @sortExpression = 'InvoiceNumber DESC' THEN u.InvoiceNumber END DESC,
		CASE WHEN @sortExpression = 'InvoiceDate' THEN u.InvoiceDate END ASC,
		CASE WHEN @sortExpression = 'InvoiceDate DESC' THEN u.InvoiceDate END DESC,
		CASE WHEN @sortExpression = 'InvoiceTotal' THEN u.InvoiceTotal END ASC,
		CASE WHEN @sortExpression = 'InvoiceTotal DESC' THEN u.InvoiceTotal END DESC,
		CASE WHEN @sortExpression = 'SaleType' THEN u.SaleType END ASC,
		CASE WHEN @sortExpression = 'SaleType DESC' THEN u.SaleType END DESC
	) AS ROW,
		u.DocItemId ,
		u.CompanyCode , 
		u.Serial , u.Plate , u.Unit , 
		u.BuyerCode , u.InvoiceNumber , u.InvoiceDate , 
		u.InvoiceTotal , u.SaleType
	from 
	[Archive.Sales] u
	INNER JOIN [Application.FileLog] AS f ON
		u.LogId = f.LogId
	WHERE 	((@fileDate		IS NULL) OR (CONVERT(VARCHAR(11),f.DateLog,103) = @fileDate))
		AND ((@invoiceDate	IS NULL) OR (CONVERT(VARCHAR(11),u.InvoiceDate,103) = @invoiceDate))
		AND u.BuyerId   = @buyerid
	GROUP BY 
		u.DocItemId ,
		u.CompanyCode , 
		u.Serial , u.Plate , u.Unit , 
		u.BuyerCode , u.InvoiceNumber , u.InvoiceDate , 
		u.InvoiceTotal , u.SaleType	
	
	) as t
	WHERE (t.ROW BETWEEN @startRowIndex AND @maximumRows)
	
	
END