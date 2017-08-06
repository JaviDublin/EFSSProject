-- =============================================
-- Author:		Javier
-- Create date: July 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spReportsFleetCashTargetExcel]
		@monthNumber INT = NULL,
		@yearNumber  INT = NULL,
		@dateUpdated  VARCHAR(20) = NULL 
AS
BEGIN
	
	SET NOCOUNT ON;
	
		IF @dateUpdated IS NULL
		BEGIN
			SET @dateUpdated = CONVERT(VARCHAR(11),GETDATE(),103)
		END
	
		UPDATE [Fact.FleetCashTarget] SET BalanceInit	= 0 WHERE BalanceInit	IS NULL
		UPDATE [Fact.FleetCashTarget] SET BalanceVat	= 0 WHERE BalanceVat	IS NULL
		UPDATE [Fact.FleetCashTarget] SET BalanceEnd	= 0 WHERE BalanceEnd	IS NULL
		UPDATE [Fact.FleetCashTarget] SET TargetAmt		= 0 WHERE TargetAmt		IS NULL

		
		
		
		DECLARE @tableOutput TABLE
		(
			pk int primary key identity, RowId int , GroupName varchar(20),
			RegionName varchar(10),ReportType varchar(20),
			BalanceInit varchar(30),BalanceVat varchar(30),BalanceEnd varchar(30),
			TargetAmt varchar(30),CollectionTarget varchar(30),
			Mtd varchar(30),Expected varchar(30),Remaining varchar(30),
			Note varchar(2000),Today varchar(20),MonthReport varchar(3)
		)
		
			-- North Receivables
			--=========================================================
			INSERT INTO @tableOutput
			
			SELECT 
			fct.RowId,
			cp.GroupName,
			rg.RegionName,
			rt.ReportType,

			CASE WHEN SUBSTRING(REPLACE(CONVERT(VARCHAR,fct.BalanceInit,1),'.00','') , 1 , 1) = '-'
			THEN
				'(' + REPLACE(REPLACE(CONVERT(VARCHAR,fct.BalanceInit,1),'.00',''),'-','')  + ')'
			ELSE
				REPLACE(CONVERT(VARCHAR,fct.BalanceInit,1),'.00','')
			END AS "BalanceInit",

			CASE WHEN SUBSTRING(REPLACE(CONVERT(VARCHAR,fct.BalanceVat,1),'.00','') , 1 , 1) = '-'
			THEN
				'(' + REPLACE(REPLACE(CONVERT(VARCHAR,fct.BalanceVat,1),'.00',''),'-','')  + ')'
			ELSE
				REPLACE(CONVERT(VARCHAR,fct.BalanceVat,1),'.00','')
			END AS "BalanceVat",

			CASE WHEN SUBSTRING(REPLACE(CONVERT(VARCHAR,fct.BalanceEnd,1),'.00','') , 1 , 1) = '-'
			THEN
				'(' + REPLACE(REPLACE(CONVERT(VARCHAR,fct.BalanceEnd,1),'.00',''),'-','')  + ')'
			ELSE
				REPLACE(CONVERT(VARCHAR,fct.BalanceEnd,1),'.00','')
			END AS "BalanceEnd",

			CASE WHEN SUBSTRING(REPLACE(CONVERT(VARCHAR,fct.TargetAmt,1),'.00','') , 1 , 1) = '-'
			THEN
				'(' + REPLACE(REPLACE(CONVERT(VARCHAR,fct.TargetAmt,1),'.00',''),'-','')  + ')'
			ELSE
				REPLACE(CONVERT(VARCHAR,fct.TargetAmt,1),'.00','')
			END AS "TargetAmt",

			CASE WHEN SUBSTRING(REPLACE(CONVERT(VARCHAR,fctd.CollectionTarget,1),'.00','') , 1 , 1) = '-'
			THEN
				'(' + REPLACE(REPLACE(CONVERT(VARCHAR,fctd.CollectionTarget,1),'.00',''),'-','')  + ')'
			ELSE
				REPLACE(CONVERT(VARCHAR,fctd.CollectionTarget,1),'.00','')
			END AS "CollectionTarget",

			CASE WHEN SUBSTRING(REPLACE(CONVERT(VARCHAR,fctd.Mtd,1),'.00','') , 1 , 1) = '-'
			THEN
				'(' + REPLACE(REPLACE(CONVERT(VARCHAR,fctd.Mtd,1),'.00',''),'-','')  + ')'
			ELSE
				REPLACE(CONVERT(VARCHAR,fctd.Mtd,1),'.00','')
			END AS "Mtd",

			CASE WHEN SUBSTRING(REPLACE(CONVERT(VARCHAR,fctd.Expected,1),'.00','') , 1 , 1) = '-'
			THEN
				'(' + REPLACE(REPLACE(CONVERT(VARCHAR,fctd.Expected,1),'.00',''),'-','')  + ')'
			ELSE
				REPLACE(CONVERT(VARCHAR,fctd.Expected,1),'.00','')
			END AS "Expected",

			CASE WHEN SUBSTRING(REPLACE(CONVERT(VARCHAR,fctd.Remaining,1),'.00','') , 1 , 1) = '-'
			THEN
				'(' + REPLACE(REPLACE(CONVERT(VARCHAR,fctd.Remaining,1),'.00',''),'-','')  + ')'
			ELSE
				REPLACE(CONVERT(VARCHAR,fctd.Remaining,1),'.00','')
			END AS "Remaining",
			fctd.Note , 
			CONVERT(VARCHAR(11),GETDATE(),103) as "Today" , 
			SUBSTRING(UPPER(DATENAME(MONTH,'2011-' +  
			CONVERT(VARCHAR,@monthNumber)
			+ '-01 10:00:00.000')),1,3) AS "Month"

			FROM [Fact.FleetCashTarget] fct
			INNER JOIN [Dimension.Companies]	 AS cp ON  fct.GroupId		= cp.GroupId
			INNER JOIN [Dimension.ReportTypes]	 AS rt ON  fct.ReportTypeId	= rt.ReportTypeId
			INNER JOIN [Dimension.Regions]       AS rg ON  fct.RegionId		= rg.RegionId
			INNER JOIN [Dimension.Currencies]    AS cc ON  fct.CurrencyId	= cc.CurrencyId
			INNER JOIN [Fact.FleetCashTargetDay] AS fctd ON
				fct.RowId = fctd.RowId
			WHERE
				rg.RegionName   = 'NORTH'	    and
				rt.ReportType   = 'RECEIVABLES' and
				CONVERT(VARCHAR(11),fctd.DateUpdated,103) = @dateUpdated
			GROUP BY 
			fct.RowId , cp.GroupName , rg.RegionName , rt.ReportType,
			fct.BalanceInit , fct.BalanceVat , fct.BalanceEnd , fct.TargetAmt ,
			fctd.CollectionTarget , fctd.Mtd , fctd.Expected , fctd.Remaining , fctd.Note 
			
			-- North Receivables Total
			--=========================================================
			INSERT INTO @tableOutput
			
			SELECT 
			0,
			'Region North',
			'NORTH',
			'RECEIVABLES',

			CASE WHEN SUBSTRING(REPLACE(CONVERT(VARCHAR,SUM(fct.BalanceInit),1),'.00','') , 1 , 1) = '-'
			THEN
				'(' + REPLACE(REPLACE(CONVERT(VARCHAR,SUM(fct.BalanceInit),1),'.00',''),'-','')  + ')'
			ELSE
				REPLACE(CONVERT(VARCHAR,SUM(fct.BalanceInit),1),'.00','')
			END AS "BalanceInit",

			CASE WHEN SUBSTRING(REPLACE(CONVERT(VARCHAR,SUM(fct.BalanceVat),1),'.00','') , 1 , 1) = '-'
			THEN
				'(' + REPLACE(REPLACE(CONVERT(VARCHAR,SUM(fct.BalanceVat),1),'.00',''),'-','')  + ')'
			ELSE
				REPLACE(CONVERT(VARCHAR,SUM(fct.BalanceVat),1),'.00','')
			END AS "BalanceVat",

			CASE WHEN SUBSTRING(REPLACE(CONVERT(VARCHAR,SUM(fct.BalanceEnd),1),'.00','') , 1 , 1) = '-'
			THEN
				'(' + REPLACE(REPLACE(CONVERT(VARCHAR,SUM(fct.BalanceEnd),1),'.00',''),'-','')  + ')'
			ELSE
				REPLACE(CONVERT(VARCHAR,SUM(fct.BalanceEnd),1),'.00','')
			END AS "BalanceEnd",

			CASE WHEN SUBSTRING(REPLACE(CONVERT(VARCHAR,SUM(fct.TargetAmt),1),'.00','') , 1 , 1) = '-'
			THEN
				'(' + REPLACE(REPLACE(CONVERT(VARCHAR,SUM(fct.TargetAmt),1),'.00',''),'-','')  + ')'
			ELSE
				REPLACE(CONVERT(VARCHAR,SUM(fct.TargetAmt),1),'.00','')
			END AS "TargetAmt",

			CASE WHEN SUBSTRING(REPLACE(CONVERT(VARCHAR,SUM(fctd.CollectionTarget),1),'.00','') , 1 , 1) = '-'
			THEN
				'(' + REPLACE(REPLACE(CONVERT(VARCHAR,SUM(fctd.CollectionTarget),1),'.00',''),'-','')  + ')'
			ELSE
				REPLACE(CONVERT(VARCHAR,SUM(fctd.CollectionTarget),1),'.00','')
			END AS "CollectionTarget",

			CASE WHEN SUBSTRING(REPLACE(CONVERT(VARCHAR,SUM(fctd.Mtd),1),'.00','') , 1 , 1) = '-'
			THEN
				'(' + REPLACE(REPLACE(CONVERT(VARCHAR,SUM(fctd.Mtd),1),'.00',''),'-','')  + ')'
			ELSE
				REPLACE(CONVERT(VARCHAR,SUM(fctd.Mtd),1),'.00','')
			END AS "Mtd",

			CASE WHEN SUBSTRING(REPLACE(CONVERT(VARCHAR,SUM(fctd.Expected),1),'.00','') , 1 , 1) = '-'
			THEN
				'(' + REPLACE(REPLACE(CONVERT(VARCHAR,SUM(fctd.Expected),1),'.00',''),'-','')  + ')'
			ELSE
				REPLACE(CONVERT(VARCHAR,SUM(fctd.Expected),1),'.00','')
			END AS "Expected",

			CASE WHEN SUBSTRING(REPLACE(CONVERT(VARCHAR,SUM(fctd.Remaining),1),'.00','') , 1 , 1) = '-'
			THEN
				'(' + REPLACE(REPLACE(CONVERT(VARCHAR,SUM(fctd.Remaining),1),'.00',''),'-','')  + ')'
			ELSE
				REPLACE(CONVERT(VARCHAR,SUM(fctd.Remaining),1),'.00','')
			END AS "Remaining",
			'' , 
			CONVERT(VARCHAR(11),GETDATE(),103) as "Today" , 
			SUBSTRING(UPPER(DATENAME(MONTH,'2011-' +  
			CONVERT(VARCHAR,@monthNumber)
			+ '-01 10:00:00.000')),1,3) AS "Month"

			FROM [Fact.FleetCashTarget] fct
			
			INNER JOIN [Dimension.ReportTypes]	AS rt ON  fct.ReportTypeId	= rt.ReportTypeId
			INNER JOIN [Dimension.Regions]      AS rg ON  fct.RegionId		= rg.RegionId
			INNER JOIN [Dimension.Currencies]   AS cc ON  fct.CurrencyId	= cc.CurrencyId
			INNER JOIN [Fact.FleetCashTargetDay] AS fctd ON
				fct.RowId = fctd.RowId
			WHERE
				rg.RegionName   = 'NORTH'	   and
				rt.ReportType   = 'RECEIVABLES' and
				CONVERT(VARCHAR(11),fctd.DateUpdated,103) = @dateUpdated

			-- South Receivables
			--=========================================================
			INSERT INTO @tableOutput
			
			SELECT 
			fct.RowId,
			cp.GroupName,
			rg.RegionName,
			rt.ReportType,

			CASE WHEN SUBSTRING(REPLACE(CONVERT(VARCHAR,fct.BalanceInit,1),'.00','') , 1 , 1) = '-'
			THEN
				'(' + REPLACE(REPLACE(CONVERT(VARCHAR,fct.BalanceInit,1),'.00',''),'-','')  + ')'
			ELSE
				REPLACE(CONVERT(VARCHAR,fct.BalanceInit,1),'.00','')
			END AS "BalanceInit",

			CASE WHEN SUBSTRING(REPLACE(CONVERT(VARCHAR,fct.BalanceVat,1),'.00','') , 1 , 1) = '-'
			THEN
				'(' + REPLACE(REPLACE(CONVERT(VARCHAR,fct.BalanceVat,1),'.00',''),'-','')  + ')'
			ELSE
				REPLACE(CONVERT(VARCHAR,fct.BalanceVat,1),'.00','')
			END AS "BalanceVat",

			CASE WHEN SUBSTRING(REPLACE(CONVERT(VARCHAR,fct.BalanceEnd,1),'.00','') , 1 , 1) = '-'
			THEN
				'(' + REPLACE(REPLACE(CONVERT(VARCHAR,fct.BalanceEnd,1),'.00',''),'-','')  + ')'
			ELSE
				REPLACE(CONVERT(VARCHAR,fct.BalanceEnd,1),'.00','')
			END AS "BalanceEnd",

			CASE WHEN SUBSTRING(REPLACE(CONVERT(VARCHAR,fct.TargetAmt,1),'.00','') , 1 , 1) = '-'
			THEN
				'(' + REPLACE(REPLACE(CONVERT(VARCHAR,fct.TargetAmt,1),'.00',''),'-','')  + ')'
			ELSE
				REPLACE(CONVERT(VARCHAR,fct.TargetAmt,1),'.00','')
			END AS "TargetAmt",

			CASE WHEN SUBSTRING(REPLACE(CONVERT(VARCHAR,fctd.CollectionTarget,1),'.00','') , 1 , 1) = '-'
			THEN
				'(' + REPLACE(REPLACE(CONVERT(VARCHAR,fctd.CollectionTarget,1),'.00',''),'-','')  + ')'
			ELSE
				REPLACE(CONVERT(VARCHAR,fctd.CollectionTarget,1),'.00','')
			END AS "CollectionTarget",

			CASE WHEN SUBSTRING(REPLACE(CONVERT(VARCHAR,fctd.Mtd,1),'.00','') , 1 , 1) = '-'
			THEN
				'(' + REPLACE(REPLACE(CONVERT(VARCHAR,fctd.Mtd,1),'.00',''),'-','')  + ')'
			ELSE
				REPLACE(CONVERT(VARCHAR,fctd.Mtd,1),'.00','')
			END AS "Mtd",

			CASE WHEN SUBSTRING(REPLACE(CONVERT(VARCHAR,fctd.Expected,1),'.00','') , 1 , 1) = '-'
			THEN
				'(' + REPLACE(REPLACE(CONVERT(VARCHAR,fctd.Expected,1),'.00',''),'-','')  + ')'
			ELSE
				REPLACE(CONVERT(VARCHAR,fctd.Expected,1),'.00','')
			END AS "Expected",

			CASE WHEN SUBSTRING(REPLACE(CONVERT(VARCHAR,fctd.Remaining,1),'.00','') , 1 , 1) = '-'
			THEN
				'(' + REPLACE(REPLACE(CONVERT(VARCHAR,fctd.Remaining,1),'.00',''),'-','')  + ')'
			ELSE
				REPLACE(CONVERT(VARCHAR,fctd.Remaining,1),'.00','')
			END AS "Remaining",
			fctd.Note , 
			CONVERT(VARCHAR(11),GETDATE(),103) as "Today" , 
			SUBSTRING(UPPER(DATENAME(MONTH,'2011-' +  
			CONVERT(VARCHAR,@monthNumber)
			+ '-01 10:00:00.000')),1,3) AS "Month"

			FROM [Fact.FleetCashTarget] fct
			INNER JOIN [Dimension.Companies]	 AS cp ON  fct.GroupId		= cp.GroupId
			INNER JOIN [Dimension.ReportTypes]	 AS rt ON  fct.ReportTypeId	= rt.ReportTypeId
			INNER JOIN [Dimension.Regions]       AS rg ON  fct.RegionId		= rg.RegionId
			INNER JOIN [Dimension.Currencies]    AS cc ON  fct.CurrencyId	= cc.CurrencyId
			INNER JOIN [Fact.FleetCashTargetDay] AS fctd ON
				fct.RowId = fctd.RowId
			WHERE
				rg.RegionName   = 'SOUTH'	   and
				rt.ReportType   = 'RECEIVABLES' and
				CONVERT(VARCHAR(11),fctd.DateUpdated,103) = @dateUpdated
			GROUP BY 
			fct.RowId , cp.GroupName , rg.RegionName , rt.ReportType,
			fct.BalanceInit , fct.BalanceVat , fct.BalanceEnd , fct.TargetAmt ,
			fctd.CollectionTarget , fctd.Mtd , fctd.Expected , fctd.Remaining , fctd.Note
			
			-- South Receivables Total
			--=========================================================
			INSERT INTO @tableOutput
			
			SELECT 
			0,
			'Region South',
			'SOUTH',
			'RECEIVABLES',

			CASE WHEN SUBSTRING(REPLACE(CONVERT(VARCHAR,SUM(fct.BalanceInit),1),'.00','') , 1 , 1) = '-'
			THEN
				'(' + REPLACE(REPLACE(CONVERT(VARCHAR,SUM(fct.BalanceInit),1),'.00',''),'-','')  + ')'
			ELSE
				REPLACE(CONVERT(VARCHAR,SUM(fct.BalanceInit),1),'.00','')
			END AS "BalanceInit",

			CASE WHEN SUBSTRING(REPLACE(CONVERT(VARCHAR,SUM(fct.BalanceVat),1),'.00','') , 1 , 1) = '-'
			THEN
				'(' + REPLACE(REPLACE(CONVERT(VARCHAR,SUM(fct.BalanceVat),1),'.00',''),'-','')  + ')'
			ELSE
				REPLACE(CONVERT(VARCHAR,SUM(fct.BalanceVat),1),'.00','')
			END AS "BalanceVat",

			CASE WHEN SUBSTRING(REPLACE(CONVERT(VARCHAR,SUM(fct.BalanceEnd),1),'.00','') , 1 , 1) = '-'
			THEN
				'(' + REPLACE(REPLACE(CONVERT(VARCHAR,SUM(fct.BalanceEnd),1),'.00',''),'-','')  + ')'
			ELSE
				REPLACE(CONVERT(VARCHAR,SUM(fct.BalanceEnd),1),'.00','')
			END AS "BalanceEnd",

			CASE WHEN SUBSTRING(REPLACE(CONVERT(VARCHAR,SUM(fct.TargetAmt),1),'.00','') , 1 , 1) = '-'
			THEN
				'(' + REPLACE(REPLACE(CONVERT(VARCHAR,SUM(fct.TargetAmt),1),'.00',''),'-','')  + ')'
			ELSE
				REPLACE(CONVERT(VARCHAR,SUM(fct.TargetAmt),1),'.00','')
			END AS "TargetAmt",

			CASE WHEN SUBSTRING(REPLACE(CONVERT(VARCHAR,SUM(fctd.CollectionTarget),1),'.00','') , 1 , 1) = '-'
			THEN
				'(' + REPLACE(REPLACE(CONVERT(VARCHAR,SUM(fctd.CollectionTarget),1),'.00',''),'-','')  + ')'
			ELSE
				REPLACE(CONVERT(VARCHAR,SUM(fctd.CollectionTarget),1),'.00','')
			END AS "CollectionTarget",

			CASE WHEN SUBSTRING(REPLACE(CONVERT(VARCHAR,SUM(fctd.Mtd),1),'.00','') , 1 , 1) = '-'
			THEN
				'(' + REPLACE(REPLACE(CONVERT(VARCHAR,SUM(fctd.Mtd),1),'.00',''),'-','')  + ')'
			ELSE
				REPLACE(CONVERT(VARCHAR,SUM(fctd.Mtd),1),'.00','')
			END AS "Mtd",

			CASE WHEN SUBSTRING(REPLACE(CONVERT(VARCHAR,SUM(fctd.Expected),1),'.00','') , 1 , 1) = '-'
			THEN
				'(' + REPLACE(REPLACE(CONVERT(VARCHAR,SUM(fctd.Expected),1),'.00',''),'-','')  + ')'
			ELSE
				REPLACE(CONVERT(VARCHAR,SUM(fctd.Expected),1),'.00','')
			END AS "Expected",

			CASE WHEN SUBSTRING(REPLACE(CONVERT(VARCHAR,SUM(fctd.Remaining),1),'.00','') , 1 , 1) = '-'
			THEN
				'(' + REPLACE(REPLACE(CONVERT(VARCHAR,SUM(fctd.Remaining),1),'.00',''),'-','')  + ')'
			ELSE
				REPLACE(CONVERT(VARCHAR,SUM(fctd.Remaining),1),'.00','')
			END AS "Remaining",
			'' , 
			CONVERT(VARCHAR(11),GETDATE(),103) as "Today" , 
			SUBSTRING(UPPER(DATENAME(MONTH,'2011-' +  
			CONVERT(VARCHAR,@monthNumber)
			+ '-01 10:00:00.000')),1,3) AS "Month"

			FROM [Fact.FleetCashTarget] fct
			INNER JOIN [Dimension.ReportTypes]	AS rt ON  fct.ReportTypeId	= rt.ReportTypeId
			INNER JOIN [Dimension.Regions]      AS rg ON  fct.RegionId		= rg.RegionId
			INNER JOIN [Dimension.Currencies]   AS cc ON  fct.CurrencyId	= cc.CurrencyId
			INNER JOIN [Fact.FleetCashTargetDay] AS fctd ON
				fct.RowId = fctd.RowId
			WHERE
				rg.RegionName   = 'SOUTH'	   and
				rt.ReportType   = 'RECEIVABLES' and
				CONVERT(VARCHAR(11),fctd.DateUpdated,103) = @dateUpdated
			
			-- Receivables Total
			--=========================================================
			INSERT INTO @tableOutput
			
			SELECT 
			0,
			'Total',
			'TOTAL',
			'RECEIVABLES',

			CASE WHEN SUBSTRING(REPLACE(CONVERT(VARCHAR,SUM(fct.BalanceInit),1),'.00','') , 1 , 1) = '-'
			THEN
				'(' + REPLACE(REPLACE(CONVERT(VARCHAR,SUM(fct.BalanceInit),1),'.00',''),'-','')  + ')'
			ELSE
				REPLACE(CONVERT(VARCHAR,SUM(fct.BalanceInit),1),'.00','')
			END AS "BalanceInit",

			CASE WHEN SUBSTRING(REPLACE(CONVERT(VARCHAR,SUM(fct.BalanceVat),1),'.00','') , 1 , 1) = '-'
			THEN
				'(' + REPLACE(REPLACE(CONVERT(VARCHAR,SUM(fct.BalanceVat),1),'.00',''),'-','')  + ')'
			ELSE
				REPLACE(CONVERT(VARCHAR,SUM(fct.BalanceVat),1),'.00','')
			END AS "BalanceVat",

			CASE WHEN SUBSTRING(REPLACE(CONVERT(VARCHAR,SUM(fct.BalanceEnd),1),'.00','') , 1 , 1) = '-'
			THEN
				'(' + REPLACE(REPLACE(CONVERT(VARCHAR,SUM(fct.BalanceEnd),1),'.00',''),'-','')  + ')'
			ELSE
				REPLACE(CONVERT(VARCHAR,SUM(fct.BalanceEnd),1),'.00','')
			END AS "BalanceEnd",

			CASE WHEN SUBSTRING(REPLACE(CONVERT(VARCHAR,SUM(fct.TargetAmt),1),'.00','') , 1 , 1) = '-'
			THEN
				'(' + REPLACE(REPLACE(CONVERT(VARCHAR,SUM(fct.TargetAmt),1),'.00',''),'-','')  + ')'
			ELSE
				REPLACE(CONVERT(VARCHAR,SUM(fct.TargetAmt),1),'.00','')
			END AS "TargetAmt",

			CASE WHEN SUBSTRING(REPLACE(CONVERT(VARCHAR,SUM(fctd.CollectionTarget),1),'.00','') , 1 , 1) = '-'
			THEN
				'(' + REPLACE(REPLACE(CONVERT(VARCHAR,SUM(fctd.CollectionTarget),1),'.00',''),'-','')  + ')'
			ELSE
				REPLACE(CONVERT(VARCHAR,SUM(fctd.CollectionTarget),1),'.00','')
			END AS "CollectionTarget",

			CASE WHEN SUBSTRING(REPLACE(CONVERT(VARCHAR,SUM(fctd.Mtd),1),'.00','') , 1 , 1) = '-'
			THEN
				'(' + REPLACE(REPLACE(CONVERT(VARCHAR,SUM(fctd.Mtd),1),'.00',''),'-','')  + ')'
			ELSE
				REPLACE(CONVERT(VARCHAR,SUM(fctd.Mtd),1),'.00','')
			END AS "Mtd",

			CASE WHEN SUBSTRING(REPLACE(CONVERT(VARCHAR,SUM(fctd.Expected),1),'.00','') , 1 , 1) = '-'
			THEN
				'(' + REPLACE(REPLACE(CONVERT(VARCHAR,SUM(fctd.Expected),1),'.00',''),'-','')  + ')'
			ELSE
				REPLACE(CONVERT(VARCHAR,SUM(fctd.Expected),1),'.00','')
			END AS "Expected",

			CASE WHEN SUBSTRING(REPLACE(CONVERT(VARCHAR,SUM(fctd.Remaining),1),'.00','') , 1 , 1) = '-'
			THEN
				'(' + REPLACE(REPLACE(CONVERT(VARCHAR,SUM(fctd.Remaining),1),'.00',''),'-','')  + ')'
			ELSE
				REPLACE(CONVERT(VARCHAR,SUM(fctd.Remaining),1),'.00','')
			END AS "Remaining",
			'' , 
			CONVERT(VARCHAR(11),GETDATE(),103) as "Today" , 
			SUBSTRING(UPPER(DATENAME(MONTH,'2011-' +  
			CONVERT(VARCHAR,@monthNumber)
			+ '-01 10:00:00.000')),1,3) AS "Month"

			FROM [Fact.FleetCashTarget] fct
			INNER JOIN [Dimension.ReportTypes]	AS rt ON  fct.ReportTypeId	= rt.ReportTypeId
			INNER JOIN [Dimension.Regions]      AS rg ON  fct.RegionId		= rg.RegionId
			INNER JOIN [Dimension.Currencies]   AS cc ON  fct.CurrencyId	= cc.CurrencyId
			INNER JOIN [Fact.FleetCashTargetDay] AS fctd ON
				fct.RowId = fctd.RowId
			WHERE
				rt.ReportType   = 'RECEIVABLES' and
				CONVERT(VARCHAR(11),fctd.DateUpdated,103) = @dateUpdated
			
			-- North Payables
			--=========================================================
			INSERT INTO @tableOutput
			
			SELECT 
			fct.RowId,
			cp.GroupName,
			rg.RegionName,
			rt.ReportType,

			CASE WHEN SUBSTRING(REPLACE(CONVERT(VARCHAR,fct.BalanceInit,1),'.00','') , 1 , 1) = '-'
			THEN
				'(' + REPLACE(REPLACE(CONVERT(VARCHAR,fct.BalanceInit,1),'.00',''),'-','')  + ')'
			ELSE
				REPLACE(CONVERT(VARCHAR,fct.BalanceInit,1),'.00','')
			END AS "BalanceInit",

			CASE WHEN SUBSTRING(REPLACE(CONVERT(VARCHAR,fct.BalanceVat,1),'.00','') , 1 , 1) = '-'
			THEN
				'(' + REPLACE(REPLACE(CONVERT(VARCHAR,fct.BalanceVat,1),'.00',''),'-','')  + ')'
			ELSE
				REPLACE(CONVERT(VARCHAR,fct.BalanceVat,1),'.00','')
			END AS "BalanceVat",

			CASE WHEN SUBSTRING(REPLACE(CONVERT(VARCHAR,fct.BalanceEnd,1),'.00','') , 1 , 1) = '-'
			THEN
				'(' + REPLACE(REPLACE(CONVERT(VARCHAR,fct.BalanceEnd,1),'.00',''),'-','')  + ')'
			ELSE
				REPLACE(CONVERT(VARCHAR,fct.BalanceEnd,1),'.00','')
			END AS "BalanceEnd",

			CASE WHEN SUBSTRING(REPLACE(CONVERT(VARCHAR,fct.TargetAmt,1),'.00','') , 1 , 1) = '-'
			THEN
				'(' + REPLACE(REPLACE(CONVERT(VARCHAR,fct.TargetAmt,1),'.00',''),'-','')  + ')'
			ELSE
				REPLACE(CONVERT(VARCHAR,fct.TargetAmt,1),'.00','')
			END AS "TargetAmt",

			CASE WHEN SUBSTRING(REPLACE(CONVERT(VARCHAR,fctd.CollectionTarget,1),'.00','') , 1 , 1) = '-'
			THEN
				'(' + REPLACE(REPLACE(CONVERT(VARCHAR,fctd.CollectionTarget,1),'.00',''),'-','')  + ')'
			ELSE
				REPLACE(CONVERT(VARCHAR,fctd.CollectionTarget,1),'.00','')
			END AS "CollectionTarget",

			CASE WHEN SUBSTRING(REPLACE(CONVERT(VARCHAR,fctd.Mtd,1),'.00','') , 1 , 1) = '-'
			THEN
				'(' + REPLACE(REPLACE(CONVERT(VARCHAR,fctd.Mtd,1),'.00',''),'-','')  + ')'
			ELSE
				REPLACE(CONVERT(VARCHAR,fctd.Mtd,1),'.00','')
			END AS "Mtd",

			CASE WHEN SUBSTRING(REPLACE(CONVERT(VARCHAR,fctd.Expected,1),'.00','') , 1 , 1) = '-'
			THEN
				'(' + REPLACE(REPLACE(CONVERT(VARCHAR,fctd.Expected,1),'.00',''),'-','')  + ')'
			ELSE
				REPLACE(CONVERT(VARCHAR,fctd.Expected,1),'.00','')
			END AS "Expected",

			CASE WHEN SUBSTRING(REPLACE(CONVERT(VARCHAR,fctd.Remaining,1),'.00','') , 1 , 1) = '-'
			THEN
				'(' + REPLACE(REPLACE(CONVERT(VARCHAR,fctd.Remaining,1),'.00',''),'-','')  + ')'
			ELSE
				REPLACE(CONVERT(VARCHAR,fctd.Remaining,1),'.00','')
			END AS "Remaining",
			fctd.Note , 
			CONVERT(VARCHAR(11),GETDATE(),103) as "Today" , 
			SUBSTRING(UPPER(DATENAME(MONTH,'2011-' +  
			CONVERT(VARCHAR,@monthNumber)
			+ '-01 10:00:00.000')),1,3) AS "Month"

			FROM [Fact.FleetCashTarget] fct
			INNER JOIN [Dimension.Companies]	AS cp ON  fct.GroupId		= cp.GroupId
			INNER JOIN [Dimension.ReportTypes]	AS rt ON  fct.ReportTypeId	= rt.ReportTypeId
			INNER JOIN [Dimension.Regions]      AS rg ON  fct.RegionId		= rg.RegionId
			INNER JOIN [Dimension.Currencies]   AS cc ON  fct.CurrencyId	= cc.CurrencyId
			INNER JOIN [Fact.FleetCashTargetDay] AS fctd ON
				fct.RowId = fctd.RowId
			WHERE
				rg.RegionName   = 'NORTH'	   and
				rt.ReportType   = 'PAYABLES' and
				CONVERT(VARCHAR(11),fctd.DateUpdated,103) = @dateUpdated
			GROUP BY 
			fct.RowId , cp.GroupName , rg.RegionName , rt.ReportType,
			fct.BalanceInit , fct.BalanceVat , fct.BalanceEnd , fct.TargetAmt ,
			fctd.CollectionTarget , fctd.Mtd , fctd.Expected , fctd.Remaining , fctd.Note 
			
			-- North Payables Total
			--=========================================================
			INSERT INTO @tableOutput
			
			SELECT 
			0,
			'Region North',
			'NORTH',
			'PAYABLES',

			CASE WHEN SUBSTRING(REPLACE(CONVERT(VARCHAR,SUM(fct.BalanceInit),1),'.00','') , 1 , 1) = '-'
			THEN
				'(' + REPLACE(REPLACE(CONVERT(VARCHAR,SUM(fct.BalanceInit),1),'.00',''),'-','')  + ')'
			ELSE
				REPLACE(CONVERT(VARCHAR,SUM(fct.BalanceInit),1),'.00','')
			END AS "BalanceInit",

			CASE WHEN SUBSTRING(REPLACE(CONVERT(VARCHAR,SUM(fct.BalanceVat),1),'.00','') , 1 , 1) = '-'
			THEN
				'(' + REPLACE(REPLACE(CONVERT(VARCHAR,SUM(fct.BalanceVat),1),'.00',''),'-','')  + ')'
			ELSE
				REPLACE(CONVERT(VARCHAR,SUM(fct.BalanceVat),1),'.00','')
			END AS "BalanceVat",

			CASE WHEN SUBSTRING(REPLACE(CONVERT(VARCHAR,SUM(fct.BalanceEnd),1),'.00','') , 1 , 1) = '-'
			THEN
				'(' + REPLACE(REPLACE(CONVERT(VARCHAR,SUM(fct.BalanceEnd),1),'.00',''),'-','')  + ')'
			ELSE
				REPLACE(CONVERT(VARCHAR,SUM(fct.BalanceEnd),1),'.00','')
			END AS "BalanceEnd",

			CASE WHEN SUBSTRING(REPLACE(CONVERT(VARCHAR,SUM(fct.TargetAmt),1),'.00','') , 1 , 1) = '-'
			THEN
				'(' + REPLACE(REPLACE(CONVERT(VARCHAR,SUM(fct.TargetAmt),1),'.00',''),'-','')  + ')'
			ELSE
				REPLACE(CONVERT(VARCHAR,SUM(fct.TargetAmt),1),'.00','')
			END AS "TargetAmt",

			CASE WHEN SUBSTRING(REPLACE(CONVERT(VARCHAR,SUM(fctd.CollectionTarget),1),'.00','') , 1 , 1) = '-'
			THEN
				'(' + REPLACE(REPLACE(CONVERT(VARCHAR,SUM(fctd.CollectionTarget),1),'.00',''),'-','')  + ')'
			ELSE
				REPLACE(CONVERT(VARCHAR,SUM(fctd.CollectionTarget),1),'.00','')
			END AS "CollectionTarget",

			CASE WHEN SUBSTRING(REPLACE(CONVERT(VARCHAR,SUM(fctd.Mtd),1),'.00','') , 1 , 1) = '-'
			THEN
				'(' + REPLACE(REPLACE(CONVERT(VARCHAR,SUM(fctd.Mtd),1),'.00',''),'-','')  + ')'
			ELSE
				REPLACE(CONVERT(VARCHAR,SUM(fctd.Mtd),1),'.00','')
			END AS "Mtd",

			CASE WHEN SUBSTRING(REPLACE(CONVERT(VARCHAR,SUM(fctd.Expected),1),'.00','') , 1 , 1) = '-'
			THEN
				'(' + REPLACE(REPLACE(CONVERT(VARCHAR,SUM(fctd.Expected),1),'.00',''),'-','')  + ')'
			ELSE
				REPLACE(CONVERT(VARCHAR,SUM(fctd.Expected),1),'.00','')
			END AS "Expected",

			CASE WHEN SUBSTRING(REPLACE(CONVERT(VARCHAR,SUM(fctd.Remaining),1),'.00','') , 1 , 1) = '-'
			THEN
				'(' + REPLACE(REPLACE(CONVERT(VARCHAR,SUM(fctd.Remaining),1),'.00',''),'-','')  + ')'
			ELSE
				REPLACE(CONVERT(VARCHAR,SUM(fctd.Remaining),1),'.00','')
			END AS "Remaining",
			'' , 
			CONVERT(VARCHAR(11),GETDATE(),103) as "Today" , 
			SUBSTRING(UPPER(DATENAME(MONTH,'2011-' +  
			CONVERT(VARCHAR,@monthNumber)
			+ '-01 10:00:00.000')),1,3) AS "Month"

			FROM [Fact.FleetCashTarget] fct
			INNER JOIN [Dimension.ReportTypes]	AS rt ON  fct.ReportTypeId	= rt.ReportTypeId
			INNER JOIN [Dimension.Regions]      AS rg ON  fct.RegionId		= rg.RegionId
			INNER JOIN [Dimension.Currencies]   AS cc ON  fct.CurrencyId	= cc.CurrencyId
			INNER JOIN [Fact.FleetCashTargetDay] AS fctd ON
				fct.RowId = fctd.RowId
			WHERE
				rg.RegionName   = 'NORTH'	   and
				rt.ReportType   = 'PAYABLES' and
				CONVERT(VARCHAR(11),fctd.DateUpdated,103) = @dateUpdated

			-- South Payables
			--=========================================================
			INSERT INTO @tableOutput
			
			SELECT 
			fct.RowId,
			cp.GroupName,
			rg.RegionName,
			rt.ReportType,

			CASE WHEN SUBSTRING(REPLACE(CONVERT(VARCHAR,fct.BalanceInit,1),'.00','') , 1 , 1) = '-'
			THEN
				'(' + REPLACE(REPLACE(CONVERT(VARCHAR,fct.BalanceInit,1),'.00',''),'-','')  + ')'
			ELSE
				REPLACE(CONVERT(VARCHAR,fct.BalanceInit,1),'.00','')
			END AS "BalanceInit",

			CASE WHEN SUBSTRING(REPLACE(CONVERT(VARCHAR,fct.BalanceVat,1),'.00','') , 1 , 1) = '-'
			THEN
				'(' + REPLACE(REPLACE(CONVERT(VARCHAR,fct.BalanceVat,1),'.00',''),'-','')  + ')'
			ELSE
				REPLACE(CONVERT(VARCHAR,fct.BalanceVat,1),'.00','')
			END AS "BalanceVat",

			CASE WHEN SUBSTRING(REPLACE(CONVERT(VARCHAR,fct.BalanceEnd,1),'.00','') , 1 , 1) = '-'
			THEN
				'(' + REPLACE(REPLACE(CONVERT(VARCHAR,fct.BalanceEnd,1),'.00',''),'-','')  + ')'
			ELSE
				REPLACE(CONVERT(VARCHAR,fct.BalanceEnd,1),'.00','')
			END AS "BalanceEnd",

			CASE WHEN SUBSTRING(REPLACE(CONVERT(VARCHAR,fct.TargetAmt,1),'.00','') , 1 , 1) = '-'
			THEN
				'(' + REPLACE(REPLACE(CONVERT(VARCHAR,fct.TargetAmt,1),'.00',''),'-','')  + ')'
			ELSE
				REPLACE(CONVERT(VARCHAR,fct.TargetAmt,1),'.00','')
			END AS "TargetAmt",

			CASE WHEN SUBSTRING(REPLACE(CONVERT(VARCHAR,fctd.CollectionTarget,1),'.00','') , 1 , 1) = '-'
			THEN
				'(' + REPLACE(REPLACE(CONVERT(VARCHAR,fctd.CollectionTarget,1),'.00',''),'-','')  + ')'
			ELSE
				REPLACE(CONVERT(VARCHAR,fctd.CollectionTarget,1),'.00','')
			END AS "CollectionTarget",

			CASE WHEN SUBSTRING(REPLACE(CONVERT(VARCHAR,fctd.Mtd,1),'.00','') , 1 , 1) = '-'
			THEN
				'(' + REPLACE(REPLACE(CONVERT(VARCHAR,fctd.Mtd,1),'.00',''),'-','')  + ')'
			ELSE
				REPLACE(CONVERT(VARCHAR,fctd.Mtd,1),'.00','')
			END AS "Mtd",

			CASE WHEN SUBSTRING(REPLACE(CONVERT(VARCHAR,fctd.Expected,1),'.00','') , 1 , 1) = '-'
			THEN
				'(' + REPLACE(REPLACE(CONVERT(VARCHAR,fctd.Expected,1),'.00',''),'-','')  + ')'
			ELSE
				REPLACE(CONVERT(VARCHAR,fctd.Expected,1),'.00','')
			END AS "Expected",

			CASE WHEN SUBSTRING(REPLACE(CONVERT(VARCHAR,fctd.Remaining,1),'.00','') , 1 , 1) = '-'
			THEN
				'(' + REPLACE(REPLACE(CONVERT(VARCHAR,fctd.Remaining,1),'.00',''),'-','')  + ')'
			ELSE
				REPLACE(CONVERT(VARCHAR,fctd.Remaining,1),'.00','')
			END AS "Remaining",
			fctd.Note , 
			CONVERT(VARCHAR(11),GETDATE(),103) as "Today" , 
			SUBSTRING(UPPER(DATENAME(MONTH,'2011-' +  
			CONVERT(VARCHAR,@monthNumber)
			+ '-01 10:00:00.000')),1,3) AS "Month"

			FROM [Fact.FleetCashTarget] fct
			INNER JOIN [Dimension.Companies]	AS cp ON  fct.GroupId		= cp.GroupId
			INNER JOIN [Dimension.ReportTypes]	AS rt ON  fct.ReportTypeId	= rt.ReportTypeId
			INNER JOIN [Dimension.Regions]      AS rg ON  fct.RegionId		= rg.RegionId
			INNER JOIN [Dimension.Currencies]   AS cc ON  fct.CurrencyId	= cc.CurrencyId
			INNER JOIN [Fact.FleetCashTargetDay] AS fctd ON
				fct.RowId = fctd.RowId
			WHERE
				rg.RegionName   = 'SOUTH'	   and
				rt.ReportType   = 'PAYABLES' and
				CONVERT(VARCHAR(11),fctd.DateUpdated,103) = @dateUpdated
			GROUP BY 
			fct.RowId , cp.GroupName , rg.RegionName , rt.ReportType,
			fct.BalanceInit , fct.BalanceVat , fct.BalanceEnd , fct.TargetAmt ,
			fctd.CollectionTarget , fctd.Mtd , fctd.Expected , fctd.Remaining , fctd.Note
			
			-- South Payables Total
			--=========================================================
			INSERT INTO @tableOutput
			
			SELECT 
			0,
			'Region South',
			'SOUTH',
			'PAYABLES',

			CASE WHEN SUBSTRING(REPLACE(CONVERT(VARCHAR,SUM(fct.BalanceInit),1),'.00','') , 1 , 1) = '-'
			THEN
				'(' + REPLACE(REPLACE(CONVERT(VARCHAR,SUM(fct.BalanceInit),1),'.00',''),'-','')  + ')'
			ELSE
				REPLACE(CONVERT(VARCHAR,SUM(fct.BalanceInit),1),'.00','')
			END AS "BalanceInit",

			CASE WHEN SUBSTRING(REPLACE(CONVERT(VARCHAR,SUM(fct.BalanceVat),1),'.00','') , 1 , 1) = '-'
			THEN
				'(' + REPLACE(REPLACE(CONVERT(VARCHAR,SUM(fct.BalanceVat),1),'.00',''),'-','')  + ')'
			ELSE
				REPLACE(CONVERT(VARCHAR,SUM(fct.BalanceVat),1),'.00','')
			END AS "BalanceVat",

			CASE WHEN SUBSTRING(REPLACE(CONVERT(VARCHAR,SUM(fct.BalanceEnd),1),'.00','') , 1 , 1) = '-'
			THEN
				'(' + REPLACE(REPLACE(CONVERT(VARCHAR,SUM(fct.BalanceEnd),1),'.00',''),'-','')  + ')'
			ELSE
				REPLACE(CONVERT(VARCHAR,SUM(fct.BalanceEnd),1),'.00','')
			END AS "BalanceEnd",

			CASE WHEN SUBSTRING(REPLACE(CONVERT(VARCHAR,SUM(fct.TargetAmt),1),'.00','') , 1 , 1) = '-'
			THEN
				'(' + REPLACE(REPLACE(CONVERT(VARCHAR,SUM(fct.TargetAmt),1),'.00',''),'-','')  + ')'
			ELSE
				REPLACE(CONVERT(VARCHAR,SUM(fct.TargetAmt),1),'.00','')
			END AS "TargetAmt",

			CASE WHEN SUBSTRING(REPLACE(CONVERT(VARCHAR,SUM(fctd.CollectionTarget),1),'.00','') , 1 , 1) = '-'
			THEN
				'(' + REPLACE(REPLACE(CONVERT(VARCHAR,SUM(fctd.CollectionTarget),1),'.00',''),'-','')  + ')'
			ELSE
				REPLACE(CONVERT(VARCHAR,SUM(fctd.CollectionTarget),1),'.00','')
			END AS "CollectionTarget",

			CASE WHEN SUBSTRING(REPLACE(CONVERT(VARCHAR,SUM(fctd.Mtd),1),'.00','') , 1 , 1) = '-'
			THEN
				'(' + REPLACE(REPLACE(CONVERT(VARCHAR,SUM(fctd.Mtd),1),'.00',''),'-','')  + ')'
			ELSE
				REPLACE(CONVERT(VARCHAR,SUM(fctd.Mtd),1),'.00','')
			END AS "Mtd",

			CASE WHEN SUBSTRING(REPLACE(CONVERT(VARCHAR,SUM(fctd.Expected),1),'.00','') , 1 , 1) = '-'
			THEN
				'(' + REPLACE(REPLACE(CONVERT(VARCHAR,SUM(fctd.Expected),1),'.00',''),'-','')  + ')'
			ELSE
				REPLACE(CONVERT(VARCHAR,SUM(fctd.Expected),1),'.00','')
			END AS "Expected",

			CASE WHEN SUBSTRING(REPLACE(CONVERT(VARCHAR,SUM(fctd.Remaining),1),'.00','') , 1 , 1) = '-'
			THEN
				'(' + REPLACE(REPLACE(CONVERT(VARCHAR,SUM(fctd.Remaining),1),'.00',''),'-','')  + ')'
			ELSE
				REPLACE(CONVERT(VARCHAR,SUM(fctd.Remaining),1),'.00','')
			END AS "Remaining",
			'' , 
			CONVERT(VARCHAR(11),GETDATE(),103) as "Today" , 
			SUBSTRING(UPPER(DATENAME(MONTH,'2011-' +  
			CONVERT(VARCHAR,@monthNumber)
			+ '-01 10:00:00.000')),1,3) AS "Month"

			FROM [Fact.FleetCashTarget] fct
			INNER JOIN [Dimension.ReportTypes]	AS rt ON  fct.ReportTypeId	= rt.ReportTypeId
			INNER JOIN [Dimension.Regions]      AS rg ON  fct.RegionId		= rg.RegionId
			INNER JOIN [Dimension.Currencies]   AS cc ON  fct.CurrencyId	= cc.CurrencyId
			INNER JOIN [Fact.FleetCashTargetDay] AS fctd ON
				fct.RowId = fctd.RowId
			WHERE
				rg.RegionName   = 'SOUTH'	   and
				rt.ReportType   = 'PAYABLES' and
				CONVERT(VARCHAR(11),fctd.DateUpdated,103) = @dateUpdated
			
			-- Payables Total
			--=========================================================
			INSERT INTO @tableOutput
			
			SELECT 
			0,
			'Total',
			'TOTAL',
			'PAYABLES',

			CASE WHEN SUBSTRING(REPLACE(CONVERT(VARCHAR,SUM(fct.BalanceInit),1),'.00','') , 1 , 1) = '-'
			THEN
				'(' + REPLACE(REPLACE(CONVERT(VARCHAR,SUM(fct.BalanceInit),1),'.00',''),'-','')  + ')'
			ELSE
				REPLACE(CONVERT(VARCHAR,SUM(fct.BalanceInit),1),'.00','')
			END AS "BalanceInit",

			CASE WHEN SUBSTRING(REPLACE(CONVERT(VARCHAR,SUM(fct.BalanceVat),1),'.00','') , 1 , 1) = '-'
			THEN
				'(' + REPLACE(REPLACE(CONVERT(VARCHAR,SUM(fct.BalanceVat),1),'.00',''),'-','')  + ')'
			ELSE
				REPLACE(CONVERT(VARCHAR,SUM(fct.BalanceVat),1),'.00','')
			END AS "BalanceVat",

			CASE WHEN SUBSTRING(REPLACE(CONVERT(VARCHAR,SUM(fct.BalanceEnd),1),'.00','') , 1 , 1) = '-'
			THEN
				'(' + REPLACE(REPLACE(CONVERT(VARCHAR,SUM(fct.BalanceEnd),1),'.00',''),'-','')  + ')'
			ELSE
				REPLACE(CONVERT(VARCHAR,SUM(fct.BalanceEnd),1),'.00','')
			END AS "BalanceEnd",

			CASE WHEN SUBSTRING(REPLACE(CONVERT(VARCHAR,SUM(fct.TargetAmt),1),'.00','') , 1 , 1) = '-'
			THEN
				'(' + REPLACE(REPLACE(CONVERT(VARCHAR,SUM(fct.TargetAmt),1),'.00',''),'-','')  + ')'
			ELSE
				REPLACE(CONVERT(VARCHAR,SUM(fct.TargetAmt),1),'.00','')
			END AS "TargetAmt",

			CASE WHEN SUBSTRING(REPLACE(CONVERT(VARCHAR,SUM(fctd.CollectionTarget),1),'.00','') , 1 , 1) = '-'
			THEN
				'(' + REPLACE(REPLACE(CONVERT(VARCHAR,SUM(fctd.CollectionTarget),1),'.00',''),'-','')  + ')'
			ELSE
				REPLACE(CONVERT(VARCHAR,SUM(fctd.CollectionTarget),1),'.00','')
			END AS "CollectionTarget",

			CASE WHEN SUBSTRING(REPLACE(CONVERT(VARCHAR,SUM(fctd.Mtd),1),'.00','') , 1 , 1) = '-'
			THEN
				'(' + REPLACE(REPLACE(CONVERT(VARCHAR,SUM(fctd.Mtd),1),'.00',''),'-','')  + ')'
			ELSE
				REPLACE(CONVERT(VARCHAR,SUM(fctd.Mtd),1),'.00','')
			END AS "Mtd",

			CASE WHEN SUBSTRING(REPLACE(CONVERT(VARCHAR,SUM(fctd.Expected),1),'.00','') , 1 , 1) = '-'
			THEN
				'(' + REPLACE(REPLACE(CONVERT(VARCHAR,SUM(fctd.Expected),1),'.00',''),'-','')  + ')'
			ELSE
				REPLACE(CONVERT(VARCHAR,SUM(fctd.Expected),1),'.00','')
			END AS "Expected",

			CASE WHEN SUBSTRING(REPLACE(CONVERT(VARCHAR,SUM(fctd.Remaining),1),'.00','') , 1 , 1) = '-'
			THEN
				'(' + REPLACE(REPLACE(CONVERT(VARCHAR,SUM(fctd.Remaining),1),'.00',''),'-','')  + ')'
			ELSE
				REPLACE(CONVERT(VARCHAR,SUM(fctd.Remaining),1),'.00','')
			END AS "Remaining",
			'' , 
			CONVERT(VARCHAR(11),GETDATE(),103) as "Today" , 
			SUBSTRING(UPPER(DATENAME(MONTH,'2011-' +  
			CONVERT(VARCHAR,@monthNumber)
			+ '-01 10:00:00.000')),1,3) AS "Month"

			FROM [Fact.FleetCashTarget] fct
			INNER JOIN [Dimension.ReportTypes]	AS rt ON  fct.ReportTypeId	= rt.ReportTypeId
			INNER JOIN [Dimension.Regions]      AS rg ON  fct.RegionId		= rg.RegionId
			INNER JOIN [Dimension.Currencies]   AS cc ON  fct.CurrencyId	= cc.CurrencyId
			INNER JOIN [Fact.FleetCashTargetDay] AS fctd ON 
				fct.RowId = fctd.RowId
			WHERE
				rt.ReportType   = 'PAYABLES'	and
				CONVERT(VARCHAR(11),fctd.DateUpdated,103) = @dateUpdated
	

		
		SELECT 
		RowId  , GroupName , RegionName , 
		ReportType,
		BalanceInit , BalanceVat , BalanceEnd , TargetAmt , 
		CollectionTarget ,
		Mtd , Expected , Remaining ,Note , Today , 
		MonthReport 
		FROM @tableOutput
	
	

    
END