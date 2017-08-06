-- =============================================
-- Author:		Javier
-- Create date: September 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spDBManualInvoiceOverView] 
		@sortExpression		VARCHAR(50)=NULL,
		@maximumRows		INT=NULL,
		@startRowIndex		INT=NULL
AS
BEGIN

	SET NOCOUNT ON;

	SELECT 
		t.[count] as 'Count' , t.RowId , t.CompanyCode  ,  t.InvoiceType , t.Serial ,
		convert(varchar,convert(money,t.Amount),1) as "Amount" ,
		t.InvoiceDate , t.BuyerName , t.ManufacturerName , t.InvoiceNumber
	FROM
	(
	SELECT 
		COUNT(u.RowId) OVER()  as 'Count',
		ROW_NUMBER() OVER
		(
			ORDER BY
			CASE WHEN @sortExpression = 'CompanyCode' THEN c.CompanyCode END ASC,
			CASE WHEN @sortExpression = 'CompanyCode DESC' THEN c.CompanyCode END DESC,
			CASE WHEN @sortExpression = 'InvoiceType' THEN u.InvoiceType END ASC,
			CASE WHEN @sortExpression = 'InvoiceType DESC' THEN u.InvoiceType END DESC,
			CASE WHEN @sortExpression = 'Serial' THEN u.Serial END ASC,
			CASE WHEN @sortExpression = 'Serial DESC' THEN u.Serial END DESC,
			CASE WHEN @sortExpression = 'Amount' THEN u.Amount END ASC,
			CASE WHEN @sortExpression = 'Amount DESC' THEN u.Amount END DESC,
			CASE WHEN @sortExpression = 'InvoiceDate' THEN u.InvoiceDate END ASC,
			CASE WHEN @sortExpression = 'InvoiceDate DESC' THEN u.InvoiceDate END DESC,
			CASE WHEN @sortExpression = 'BuyerName' THEN u.BuyerName END ASC,
			CASE WHEN @sortExpression = 'BuyerName DESC' THEN u.BuyerName END DESC,
			CASE WHEN @sortExpression = 'ManufacturerName' THEN u.ManufacturerName END ASC,
			CASE WHEN @sortExpression = 'ManufacturerName DESC' THEN u.ManufacturerName END DESC,
			CASE WHEN @sortExpression = 'InvoiceNumber' THEN u.InvoiceNumber END ASC,
			CASE WHEN @sortExpression = 'InvoiceNumber DESC' THEN u.InvoiceNumber END DESC
			
		) AS ROW,
		u.RowId ,
		c.CompanyCode,
		u.InvoiceType , 
		u.Serial , 
		u.Amount ,
		CONVERT(VARCHAR(11),u.InvoiceDate,103) AS "InvoiceDate",
		u.BuyerName , 
		u.ManufacturerName,
		u.InvoiceNumber
	FROM [Staging.ManualInvoice] u
	INNER JOIN [Dimension.Companies] AS c ON	
		u.CompanyName = c.CompanyName
	GROUP BY 
		u.RowId ,
		c.CompanyCode,
		u.InvoiceType , 
		u.Serial , 
		u.Amount ,
		u.InvoiceDate,
		u.BuyerName , 
		u.ManufacturerName,
		u.InvoiceNumber
	)	AS t
	WHERE (t.ROW BETWEEN @startRowIndex AND @maximumRows)
		
		


END