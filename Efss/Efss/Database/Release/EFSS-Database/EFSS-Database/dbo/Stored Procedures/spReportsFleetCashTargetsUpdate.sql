-- =============================================
-- Author:		Javier
-- Create date: June 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spReportsFleetCashTargetsUpdate]
		@groupId			INT				= NULL,
		@reportTypeId		INT				= NULL,
		@racfId				VARCHAR(20)		= NULL,
		@currencyId			INT				= NULL,
		@balanceInt			VARCHAR(20)		= NULL,
		@balanceVat			VARCHAR(20)		= NULL,
		@balanceEnd			VARCHAR(20)		= NULL,
		@targetAmt			VARCHAR(20)		= NULL,
		@collectionTarget	VARCHAR(20)		= NULL,
		@notes				VARCHAR(2000)	= NULL,
		@yearNumber			INT				= NULL,
		@monthNumber		INT				= NULL,
		@notesExpected		VARCHAR(2000)	= NULL,
		@mtd				VARCHAR(20)     = NULL,
		@expected			VARCHAR(20)     = NULL
AS
BEGIN
	
	SET NOCOUNT ON;
	
	-- Currencies
	-----------------------------------------------------------------------------
	-- 1) All the Amounts are stored in Dollars (CurrencyId = 4)
	-- 2) The amounts BalanceInit , BalanceVat , BalanceEnd , TargetAmount and Colletcion Target
	--	  are added by the users in Dollars at the begining of the month
	-- 3) The Amounts Mtd and Expected are added in Local Currency, therefore need to be converted into Dollars  
	
	
	
	DECLARE @rate FLOAT
	SET @rate = (SELECT Rate FROM [Dimension.Currencies] WHERE CurrencyId = @currencyId)
	
	
	
	
	-- 1 - Create Table Report (once per year)
	-----------------------------------------------------------------------------
	EXEC spReportsFleetCashTargetsCreateReport
	@yearNumber = @yearNumber
	
	
	-- 2 - Get Date Values
	-----------------------------------------------------------------------------
	DECLARE @today DATETIME
	SET @today  = CAST(FLOOR(CAST(GETDATE() AS float)) AS datetime)
	
	DECLARE @month INT,
			@year  INT,
			@day   INT,
			@monthDays INT
			
	SET @month		= MONTH(@today)
	SET @year		= YEAR(@today)
	SET @day		= DAY(@today)
	SET @monthDays	= DATEPART(dd,DATEADD(dd,-1,DATEADD(mm,1,CAST(CAST(YEAR(@today) as varchar)+
					'-'+CAST(MONTH(@today) as varchar)+'-01' as datetime))))
	


	
	-- 3 - Get Id's
	-----------------------------------------------------------------------------
	DECLARE @rowFleetId		INT,
			@rowFleetDayId	INT,
			@regionId		INT
	
	SET @rowFleetId    =  (SELECT RowId 
								FROM [Fact.FleetCashTargetDay] 
									WHERE 
										DateUpdated  = @today AND
										ReportTypeId = @reportTypeId AND
										GroupId      = @groupId)
																
	SET @rowFleetDayId =  (SELECT PKID 
									FROM [Fact.FleetCashTargetDay] 
										WHERE 
											DateUpdated  = @today AND
											ReportTypeId = @reportTypeId AND
											GroupId      = @groupId)
	
	SET @regionId		= (SELECT regionId FROM [Dimension.Countries] WHERE CountryId in
							(SELECT CountryId FROM [Dimension.Companies] WHERE GroupId = @groupId)
								GROUP BY regionId)
							
							
	IF @collectionTarget	IS NULL BEGIN SET 	@collectionTarget	= '0' END
	IF @mtd					IS NULL	BEGIN SET 	@mtd				= '0' END
	IF @expected			IS NULL BEGIN SET 	@expected			= '0' END			
	
	DECLARE @remaining MONEY
	SET @remaining =	CONVERT(MONEY,REPLACE(@collectionTarget,',','')) - 
						CONVERT(MONEY,REPLACE(@mtd,',','')) - 
						CONVERT(MONEY,REPLACE(@expected,',',''))
		
	
	UPDATE [Fact.FleetCashTarget] SET
		BalanceInit		 = CONVERT(MONEY,REPLACE(@balanceInt,',','')),
		BalanceVat		 = CONVERT(MONEY,REPLACE(@balanceVat,',','')),
		BalanceEnd		 = CONVERT(MONEY,REPLACE(@balanceEnd,',','')),
		TargetAmt		 = CONVERT(MONEY,REPLACE(@targetAmt,',','')) ,
		DateUpdated		 = @today,
		UpdatedBy		 = @racfId 
	WHERE 
		RowId = @rowFleetId
		
	
		
	UPDATE [Fact.FleetCashTargetDay] SET
		Mtd					= CONVERT(MONEY,REPLACE(@mtd,',',''))		,
		Expected			= CONVERT(MONEY,REPLACE(@expected,',',''))	,		
		Remaining			= CONVERT(MONEY,REPLACE(@remaining,',',''))	,
		Note				= @notes									,
		NoteExpected		= @notesExpected
		
	FROM 
		[Fact.FleetCashTargetDay]
	WHERE 
		PKID = @rowFleetDayId
	
	UPDATE [Fact.FleetCashTargetDay] SET
		CollectionTarget	= CONVERT(MONEY,REPLACE(@collectionTarget,',',''))
	WHERE 
		RowId = @rowFleetId
		
	
		
	update [Fact.FleetCashTarget] set CurrencyId = 4 where CurrencyId <> 4
						
    
END