-- =============================================
-- Author:		Javier
-- Create date: July 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spReportsFleetCashTargetsSelectTotal]
		@regionId	  INT			= NULL,
		@reportTypeId INT			= NULL,
		@dateUpdated  VARCHAR(20)	= NULL 
AS
BEGIN
	
	SET NOCOUNT ON;
	
	IF @regionId = 0
	BEGIN
	
		SELECT 
			REPLACE(CONVERT(VARCHAR,SUM(fct.BalanceInit),1),'.00','') as "BalanceInit"		,
			REPLACE(CONVERT(VARCHAR,SUM(fct.BalanceVat),1),'.00','') as "BalanceVat"	,	
			REPLACE(CONVERT(VARCHAR,SUM(fct.BalanceEnd),1),'.00','') as "BalanceEnd"	,	
			REPLACE(CONVERT(VARCHAR,SUM(fct.TargetAmt),1),'.00','') as "TargetAmt"	,	
			REPLACE(CONVERT(VARCHAR,SUM(fctd.CollectionTarget),1),'.00','') as "CollectionTarget"	,
			REPLACE(CONVERT(VARCHAR,SUM(fctd.Mtd),1),'.00','') as "Mtd"	,	
			REPLACE(CONVERT(VARCHAR,SUM(fctd.Expected),1),'.00','') as "Expected"	,	
			REPLACE(CONVERT(VARCHAR,SUM(fctd.Remaining),1),'.00','') as "Remaining"	
		FROM  
			[Fact.FleetCashTarget] fct
		INNER JOIN [Fact.FleetCashTargetDay] AS fctd ON
					fct.RowId = fctd.RowId
		WHERE 
			fctd.DateUpdated = CONVERT(datetime,@dateUpdated,103)
		AND fct.ReportTypeId = @reportTypeId
	
	END
	ELSE
	BEGIN
	
		SELECT 
			REPLACE(CONVERT(VARCHAR,SUM(fct.BalanceInit),1),'.00','') as "BalanceInit"		,
			REPLACE(CONVERT(VARCHAR,SUM(fct.BalanceVat),1),'.00','') as "BalanceVat"	,	
			REPLACE(CONVERT(VARCHAR,SUM(fct.BalanceEnd),1),'.00','') as "BalanceEnd"	,	
			REPLACE(CONVERT(VARCHAR,SUM(fct.TargetAmt),1),'.00','') as "TargetAmt"	,	
			REPLACE(CONVERT(VARCHAR,SUM(fctd.CollectionTarget),1),'.00','') as "CollectionTarget"	,
			REPLACE(CONVERT(VARCHAR,SUM(fctd.Mtd),1),'.00','') as "Mtd"	,	
			REPLACE(CONVERT(VARCHAR,SUM(fctd.Expected),1),'.00','') as "Expected"	,	
			REPLACE(CONVERT(VARCHAR,SUM(fctd.Remaining),1),'.00','') as "Remaining"	
		FROM  
			[Fact.FleetCashTarget] fct
		INNER JOIN [Fact.FleetCashTargetDay] AS fctd ON
					fct.RowId = fctd.RowId
		WHERE 
			fctd.DateUpdated = CONVERT(datetime,@dateUpdated,103)
		AND fct.RegionId	 = @regionId
		AND fct.ReportTypeId = @reportTypeId
	
	END
	
	

   
END