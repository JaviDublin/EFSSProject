-- =============================================
-- Author:		Javier
-- Create date: September 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spReportsFleetCashTargetsCreateReport]
		@yearNumber INT
AS
BEGIN

	DECLARE @counter INT
	SET @counter = (SELECT COUNT(*) FROM [Fact.FleetCashTarget] WHERE YearNumber = @yearNumber)
	
	IF @counter = 0
	BEGIN
		DECLARE @monthText	VARCHAR(2),
				@date		DATETIME,
				@days		INT,
				@monthdays  INT
			
		SET @counter = 1
		
		WHILE @counter <= 12
		BEGIN
		
			SET @monthdays = 0
			
			SET @monthText = CONVERT(VARCHAR,@counter)
			SET @monthText = CASE WHEN LEN(@monthText) = 1 THEN '0' + @monthText ELSE @monthText END
			
			SET @date = CONVERT(DATETIME,@monthText + '/01/' + CONVERT(VARCHAR,@yearNumber))
			
			SET @days = DATEPART(dd,DATEADD(dd,-1,DATEADD(mm,1,CAST(CAST(YEAR(@date) as varchar)+
					'-'+CAST(MONTH(@date) as varchar)+'-01' as datetime))))
		
			INSERT INTO [Fact.FleetCashTarget]
			(GroupId , ReportTypeId , MonthNumber , YearNumber , DateUpdated , DateCreated , CurrencyId)
	
			SELECT 
				[Dimension.Companies].GroupId , [Dimension.ReportTypes].ReportTypeId , @counter , @yearNumber ,
				@date , @date ,
				4
			FROM [Dimension.Companies] , [Dimension.ReportTypes]
			GROUP BY 
				[Dimension.Companies].GroupId , [Dimension.ReportTypes].ReportTypeId
				
				
			WHILE @monthdays < @days
			BEGIN
				INSERT INTO [Fact.FleetCashTargetDay] (GroupId , ReportTypeId , DateUpdated)
				SELECT 
					[Dimension.Companies].GroupId , [Dimension.ReportTypes].ReportTypeId , @date + @monthdays
				FROM [Dimension.Companies] , [Dimension.ReportTypes]
				GROUP BY 
					[Dimension.Companies].GroupId , [Dimension.ReportTypes].ReportTypeId
					
				SET @monthdays = @monthdays + 1
			END
					
			SET @counter = @counter + 1
			
		END
		
		
		UPDATE [Fact.FleetCashTarget] SET
			[Fact.FleetCashTarget].RegionId = [Dimension.Countries].RegionId
		FROM [Fact.FleetCashTarget]
		INNER JOIN [Dimension.Companies] ON 
			[Fact.FleetCashTarget].GroupId	= [Dimension.Companies].GroupId
		INNER JOIN [Dimension.Countries] ON 
			[Dimension.Companies].CountryId = [Dimension.Countries].CountryId
		
		
		UPDATE [Fact.FleetCashTarget] SET BalanceInit		= 0 WHERE BalanceInit	IS NULL
		UPDATE [Fact.FleetCashTarget] SET BalanceVat		= 0 WHERE BalanceVat	IS NULL
		UPDATE [Fact.FleetCashTarget] SET BalanceEnd		= 0 WHERE BalanceEnd	IS NULL
		UPDATE [Fact.FleetCashTarget] SET TargetAmt			= 0 WHERE TargetAmt		IS NULL
		
		UPDATE [Fact.FleetCashTargetDay] SET
			[Fact.FleetCashTargetDay].RowId = [Fact.FleetCashTarget].RowId
		FROM [Fact.FleetCashTargetDay]
		INNER JOIN  [Fact.FleetCashTarget] ON
			[Fact.FleetCashTargetDay].GroupId				= [Fact.FleetCashTarget].GroupId		AND
			[Fact.FleetCashTargetDay].ReportTypeId			= [Fact.FleetCashTarget].ReportTypeId	AND
			MONTH([Fact.FleetCashTargetDay].DateUpdated)	= [Fact.FleetCashTarget].MonthNumber	AND
			YEAR([Fact.FleetCashTargetDay].DateUpdated)		= [Fact.FleetCashTarget].YearNumber
			
		
		UPDATE [Fact.FleetCashTargetDay] SET Mtd				= 0 WHERE Mtd				IS NULL
		UPDATE [Fact.FleetCashTargetDay] SET Expected			= 0 WHERE Expected			IS NULL
		UPDATE [Fact.FleetCashTargetDay] SET Remaining			= 0 WHERE Remaining			IS NULL
		UPDATE [Fact.FleetCashTargetDay] SET CollectionTarget	= 0 WHERE CollectionTarget	IS NULL
	
	END

END