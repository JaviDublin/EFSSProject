-- =============================================
-- Author:		Javier
-- Create date: May 2011
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[fnListViewSalesBuyers]
(	
		@fileDate VARCHAR(50)=NULL,
		@invoiceDate VARCHAR(50)=NULL,
		@countryId INT
)
RETURNS @TABLEFILE TABLE 
(BuyerId INT, BuyerCode VARCHAR(20), BuyerName VARCHAR(50), 
FileDate VARCHAR(20),TotalInvoices INT,FleetCo INT, OpCo INT, Original INT,
CreditNotes INT,BuyBack INT , WholeSale INT, Wreck INT,Email varchar(500))
AS
BEGIN


	IF @fileDate	= 'ALL'	BEGIN SET @fileDate		= null END
	IF @invoiceDate = 'ALL' BEGIN SET @invoiceDate	= null END
		
		
	INSERT INTO @TABLEFILE
	(
		BuyerId , BuyerCode ,  BuyerName , FileDate , TotalInvoices , Original ,  CreditNotes ,
		FleetCo , OpCo , BuyBack , WholeSale , Wreck , Email
	)

	SELECT 
		u.BuyerId ,
		b.BuyerCode ,
		b.BuyerName ,
		convert(varchar(11),u.FileDate,103) ,
		SUM(u.TotalInvoices),
		SUM(u.Original),
		SUM(u.CreditNotes),
		SUM(u.FleetCo),
		SUM(u.OpCo),
		SUM(u.BuyBack),
		SUM(u.WholeSale),
		SUM(u.Wreck),
		c.ContactEmail
	FROM 
		[Fact.FileReport] u
	INNER JOIN [Dimension.Buyers] AS b ON
		u.BuyerId  = b.BuyerId
	LEFT JOIN [Fact.BuyersContact] AS c ON
		u.BuyerId = c.BuyerId AND Position = 1
	WHERE
			((@fileDate		IS NULL) OR (CONVERT(varchar(11),u.FileDate,103) = @fileDate))
		AND ((@invoiceDate	IS NULL) OR (CONVERT(VARCHAR(11),u.InvoiceDate,103) = @invoiceDate))
		AND u.CountryId = @countryId
	GROUP BY 
		u.BuyerId ,
		b.BuyerCode ,
		b.BuyerName ,
		CONVERT(VARCHAR(11),u.FileDate,103)  ,
		c.ContactEmail


--SELECT  
--[Dimension.Buyers].BuyerId ,
--[Dimension.Buyers].BuyerCode ,
--[Dimension.Buyers].BuyerName , 
--CONVERT(VARCHAR(11), FR.FileDate,103) AS "FileDate" ,
--TI.TotalInvoices , FC.FleetCo , OP.OpCo , ORG.Original , CN.CreditNotes , 
--BB.BuyBack , WS.WholeSale ,WR.Wreck ,[Fact.BuyersContact].ContactEmail
--FROM [Fact.FileReport] FR
--INNER JOIN [Dimension.Buyers] ON FR.BuyerId = [Dimension.Buyers].BuyerId
--LEFT JOIN [Fact.BuyersContact] ON FR.BuyerId = [Fact.BuyersContact].BuyerId
--INNER JOIN 
--(select BuyerId , sum(TotalInvoices) as "TotalInvoices"
--from [Fact.FileReport] 
--where ((@invoiceDate is null) OR (CONVERT(varchar(11),InvoiceDate,103) = @invoiceDate))
--and ((@fileDate IS NULL) OR (CONVERT(varchar(11),FileDate,103) = @fileDate))
--and CountryId = @countryId
--group by BuyerId) as TI on FR.BuyerId = TI.BuyerId
--INNER JOIN
--(select BuyerId , sum(FleetCo) as "FleetCo"	
--from[Fact.FileReport] 
--where ((@invoiceDate is null) OR (CONVERT(varchar(11),InvoiceDate,103) = @invoiceDate))
--and ((@fileDate IS NULL) OR (CONVERT(varchar(11),FileDate,103) = @fileDate))
--and CountryId = @countryId
--group by BuyerId) as FC on FR.BuyerId = FC.BuyerId
--INNER JOIN 
--(select BuyerId , sum(OpCo) as "OpCo"		
--from [Fact.FileReport] 
--where ((@invoiceDate is null) OR (CONVERT(varchar(11),InvoiceDate,103) = @invoiceDate))
--and ((@fileDate IS NULL) OR (CONVERT(varchar(11),FileDate,103) = @fileDate))
--and CountryId = @countryId
--group by BuyerId) as OP on FR.BuyerId = OP.BuyerId
--INNER JOIN 
--(select BuyerId , sum(Original) as "Original"	
--from[Fact.FileReport]
--where ((@invoiceDate is null) OR (CONVERT(varchar(11),InvoiceDate,103) = @invoiceDate))
--and ((@fileDate IS NULL) OR (CONVERT(varchar(11),FileDate,103) = @fileDate))
--and CountryId = @countryId
--group by BuyerId) AS ORG ON FR.BuyerId = ORG.BuyerId
--INNER JOIN 
--(select BuyerId , sum(CreditNotes) as "CreditNotes"
--from [Fact.FileReport] 
--where ((@invoiceDate is null) OR (CONVERT(varchar(11),InvoiceDate,103) = @invoiceDate))
--and ((@fileDate IS NULL) OR (CONVERT(varchar(11),FileDate,103) = @fileDate))
--and CountryId = @countryId
--group by BuyerId) AS CN ON FR.BuyerId = CN.BuyerId
--INNER JOIN 
--(select BuyerId , sum(BuyBack) as "BuyBack"
--from [Fact.FileReport] 
--where ((@invoiceDate is null) OR (CONVERT(varchar(11),InvoiceDate,103) = @invoiceDate))
--and ((@fileDate IS NULL) OR (CONVERT(varchar(11),FileDate,103) = @fileDate))
--and CountryId = @countryId
--group by BuyerId) AS BB ON FR.BuyerId = BB.BuyerId
--INNER JOIN
--(select BuyerId , sum(WholeSale) as "WholeSale"	
--from[Fact.FileReport] 
--where ((@invoiceDate is null) OR (CONVERT(varchar(11),InvoiceDate,103) = @invoiceDate))
--and ((@fileDate IS NULL) OR (CONVERT(varchar(11),FileDate,103) = @fileDate))
--and CountryId = @countryId
--group by BuyerId) AS WS ON FR.BuyerId = WS.BuyerId
--INNER JOIN 
--(select BuyerId , sum(Wreck) as "Wreck"		
--from [Fact.FileReport] 
--where ((@invoiceDate is null) OR (CONVERT(varchar(11),InvoiceDate,103) = @invoiceDate))
--and ((@fileDate IS NULL) OR (CONVERT(varchar(11),FileDate,103) = @fileDate))
--and CountryId = @countryId
--group by BuyerId) AS WR ON FR.BuyerId = WR.BuyerId
--GROUP BY [Dimension.Buyers].BuyerId ,
--[Dimension.Buyers].BuyerCode ,
--[Dimension.Buyers].BuyerName , FR.FileDate , TI.TotalInvoices , FC.FleetCo , OP.OpCo ,
--ORG.Original , CN.CreditNotes , BB.BuyBack , WS.WholeSale ,WR.Wreck ,[Fact.BuyersContact].ContactEmail



	RETURN
END