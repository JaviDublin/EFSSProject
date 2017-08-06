-- =============================================
-- Author:		Javier
-- Create date: June 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE spSalesReportSerialToPDF
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT sr.Serial , sr.Amount , 
	bu.BuyerName , bu.BuyerTaxCode , bu.BuyerFiscalCode , 
	ba.BuyerAddress1 , ba.BuyerAddress2 , ba.BuyerAddress3 , ba.BuyerAddress4 , ba.BuyerAddress5 , ba.BuyerAddress6 ,
	cp.CompanyName , ca.Address1 ,
	ca.Address2 ,  ca.Address3 ,  ca.Address4 , ca.Address5 , ca.Address6 , ca.Address7 , ca.Address8 ,
	ca.Address9 , ca.Address10 , ca.Address11 , ca.Address12 ,
	stuff(sr.InvoiceNumber, 1, 0, replicate('0', 5 - len(sr.InvoiceNumber))) as "InvoiceNumber",
	convert(varchar(11),sr.InvoiceDate,103) as "InvoiceDate"
	FROM [Import.Serial] sr
	INNER JOIN [Dimension.Buyers]			AS bu ON sr.BuyerIdForm = bu.BuyerId
	INNER JOIN [Dimension.Companies]		AS cp ON sr.CompanyId   = cp.CompanyId
	INNER JOIN [Dimension.CompanyAddress]	AS ca ON sr.CompanyId   = ca.CompanyId
	INNER JOIN [Dimension.ContactTypes]     AS ct ON cp.CompanyId	= ct.CompanyId
	INNER JOIN [Fact.BuyersAddress]         AS ba ON sr.BuyerIdForm = ba.BuyerId 
											and ct.ContactTypeId      = ba.ContactTypeId
											and ba.Position = 1
END