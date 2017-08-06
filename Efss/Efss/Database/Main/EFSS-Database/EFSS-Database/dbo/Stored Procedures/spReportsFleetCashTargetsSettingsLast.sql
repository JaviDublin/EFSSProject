-- =============================================
-- Author:		Javier
-- Create date: June 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spReportsFleetCashTargetsSettingsLast]

AS
BEGIN
	
	SET NOCOUNT ON;

	DECLARE @currentWeek INT,
			@currentYear INT,
			@maxWeek     INT,
			@maxYear	 INT,
			@currencyId  INT	
			
			

	SET @currentWeek = DATEPART(WEEK,GETDATE())
	SET @currentYear = YEAR(GETDATE())
	--SET @maxWeek	 = (SELECT MAX(WeekNumber)
	--							FROM [Fact.FleetCashTarget])
	SET @maxYear     = (SELECT MAX(YEAR(DateCreated))
								FROM [Fact.FleetCashTarget])
								
	--SET @currencyId = (SELECT TOP 1 CurrencyId FROM [Fact.FleetCashTarget] WHERE WeekNumber = @maxWeek AND
	--																				YEAR(DateCreated) = @maxYear)
	

	SELECT 
		convert(varchar,@currentWeek) AS "currentWeek", 
		convert(varchar,@currentYear) AS "currentYear", 
		convert(varchar,@maxWeek)	  AS "maxWeek"	 , 
		convert(varchar,@maxYear)	  AS "maxYear"	 , 
		convert(varchar,@currencyId)  AS "currencyId"
END