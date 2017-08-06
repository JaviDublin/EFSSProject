-- =============================================
-- Author:		Javier
-- Create date: June 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spReportsFleetCashTargetsSelect] 
		@groupId	  INT			= NULL,
		@reportTypeId INT			= NULL,
		@dateUpdated  VARCHAR(20)	= NULL 
AS
BEGIN

	SET NOCOUNT ON;
	
	IF @dateUpdated IS NULL
	BEGIN
		SET @dateUpdated = CONVERT(VARCHAR(11),GETDATE(),103)
	END
	
	
	SELECT 
			fct.RowId		,	 
			fct.GroupId		,	
			fct.RegionId	,	
			fct.ReportTypeId,
			fct.MonthNumber	,
			CONVERT(VARCHAR(11),fct.DateUpdated,103) AS "DateUpdated" ,
			fct.CurrencyId	,	
			REPLACE(CONVERT(VARCHAR,fct.BalanceInit,1),'.00','') as "BalanceInit"		,
			REPLACE(CONVERT(VARCHAR,fct.BalanceVat,1),'.00','') as "BalanceVat"	,	
			REPLACE(CONVERT(VARCHAR,fct.BalanceEnd,1),'.00','') as "BalanceEnd"	,	
			REPLACE(CONVERT(VARCHAR,fct.TargetAmt,1),'.00','') as "TargetAmt"	,	
			REPLACE(CONVERT(VARCHAR,fctd.CollectionTarget,1),'.00','') as "CollectionTarget"	,
			REPLACE(CONVERT(VARCHAR,fctd.Mtd,1),'.00','') as "Mtd"	,	
			REPLACE(CONVERT(VARCHAR,fctd.Expected,1),'.00','') as "Expected"	,	
			REPLACE(CONVERT(VARCHAR,fctd.Remaining,1),'.00','') as "Remaining"	,	
			fctd.Note , 
			fctd.NoteExpected ,
			fct.UpdatedBy AS "RacfId"
		FROM  
			[Fact.FleetCashTarget] fct
		INNER JOIN [Fact.FleetCashTargetDay] AS fctd ON
					fct.RowId = fctd.RowId
		WHERE 
			fctd.DateUpdated = CONVERT(datetime,@dateUpdated,103)
		AND fct.GroupId		 = @groupId
		AND fct.ReportTypeId = @reportTypeId

	
	
	
END