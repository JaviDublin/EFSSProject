-- =============================================
-- Author:		Javier
-- Create date: July 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spReportsDashboardToExcel]
	
AS
BEGIN
	SET NOCOUNT ON;
	
	-- 27/Mar/2012 Change Request (Replace Country Name by Group Name)
	
	SELECT
		ManufacturerId ,ManufacturerName , GroupName , DocSubType ,  
		REPLACE(CONVERT(VARCHAR,CONVERT(MONEY,CNK),1),'.00','') as "CNK",
		REPLACE(CONVERT(VARCHAR,FLOOR(ISNULL(P.[NOT DUE],'0.00')),1),'.00','') as "Current" , 
		REPLACE(CONVERT(VARCHAR,FLOOR(ISNULL(P.[NO INV],'0.00')),1),'.00','')  as "Payment",
		REPLACE(CONVERT(VARCHAR,FLOOR(ISNULL(P.[0-7],'0.00')),1),'.00','') as "0-7", 
		REPLACE(CONVERT(VARCHAR,FLOOR(ISNULL(P.[8-30],'0.00')),1),'.00','') as "8-30", 
		REPLACE(CONVERT(VARCHAR,FLOOR(ISNULL(P.[31-60],'0.00')),1),'.00','') as "31-60" , 
		REPLACE(CONVERT(VARCHAR,FLOOR(ISNULL(P.[61-90],'0.00')),1),'.00','') as "61-90", 
		REPLACE(CONVERT(VARCHAR,FLOOR(ISNULL(P.[91-120],'0.00')),1),'.00','') as "91-120" , 
		REPLACE(CONVERT(VARCHAR,FLOOR(ISNULL(P.[121-180],'0.00')),1),'.00','') as "121-180", 
		REPLACE(CONVERT(VARCHAR,FLOOR(ISNULL(P.[181-360],'0.00')),1),'.00','') as "181-360",
		REPLACE(CONVERT(VARCHAR,FLOOR(ISNULL(P.[360+],'0.00')),1),'.00','') as "360+"  , Notes
		FROM 
		(
			SELECT ManufacturerId , GroupName , ManufacturerName , DueDtAge ,  RecvAmt , DocSubType , Notes , CNK
				FROM [Fact.DashboardReport]
			GROUP BY ManufacturerId , GroupName , ManufacturerName , DueDtAge ,  RecvAmt , DocSubType , Notes , CNK
		)
		S
		PIVOT
		(SUM(RecvAmt) FOR DueDtAge IN 
			([0-7],[8-30],[31-60],[61-90],[91-120],[121-180],[181-360],[360+],[NO INV],[NOT DUE])) AS P
	order by GroupName , ManufacturerName , DocSubType

   
END