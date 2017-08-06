-- =============================================
-- Author:		Javier
-- Create date: July 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spBuyersDetails]
		@buyerId		INT,
		@companyTypeId	INT = NULL
AS
BEGIN
	
	SET NOCOUNT ON;
	
	SELECT 
		vb.ContactId , vb.ContactName , vb.ContactPhone , vb.ContactEmail , 
		vb.BuyerAddress1 , vb.BuyerAddress2 , vb.BuyerAddress3 , vb.BuyerAddress4 ,
		vb.BuyerAddress5 , vb.BuyerAddress6 , cp.CompanyTypeId
	FROM ViewBuyers vb
	INNER JOIN [Dimension.ContactTypes] AS ct ON vb.ContactTypeId = ct.ContactTypeId 
	INNER JOIN [Dimension.CompanyTypes] AS cp ON ct.ContactTypeName = cp.CompanyType
	WHERE 
		vb.BuyerId = @buyerId
		AND ((@companyTypeId is null) or (cp.CompanyTypeId = @companyTypeId))
	GROUP BY 
		vb.ContactId , vb.ContactName , vb.ContactPhone , vb.ContactEmail,
		vb.BuyerAddress1 , vb.BuyerAddress2 , vb.BuyerAddress3 , vb.BuyerAddress4 ,
		vb.BuyerAddress5 , vb.BuyerAddress6 ,  cp.CompanyTypeId
  
END