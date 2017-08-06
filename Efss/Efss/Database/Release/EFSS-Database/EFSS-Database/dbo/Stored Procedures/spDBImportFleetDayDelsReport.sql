-- =============================================
-- Author:		Javier
-- Create date: July 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spDBImportFleetDayDelsReport]
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @month INT , @day INT , @year INT ,@dayName	VARCHAR(20)
	
	SET @dayName = DATENAME(DW,GETDATE())
	
	IF @dayName = 'Monday'
	BEGIN
		SET @day   =  DAY(GETDATE()) - 3
		SET @month = MONTH(GETDATE() - 3)
		SET @year  = YEAR(GETDATE() - 3)
	END
	ELSE
	BEGIN
		SET @day   =  DAY(GETDATE()) - 1
		SET @month = MONTH(GETDATE() - 1)
		SET @year  = YEAR(GETDATE() - 3)
	END	
	
	IF @day = 1
	BEGIN
		MERGE 	[Import.ActiveFleetMonthADReport] AS TARGET
		USING	
		(
			SELECT
			CountryId , ManufacturerId , LogId , FileId , 
			@month				AS "MonthNumber", 
			@year				AS "DateYear", 
			GETDATE()			AS "DateCreated",
			COUNT(*)			AS "Total"
			FROM  [Staging.ActiveFleetMonthDeletes]
			GROUP BY CountryId , ManufacturerId , LogId , FileId
		)	AS SOURCE
		ON 
			(
							TARGET.DateYear			= SOURCE.DateYear 
						AND TARGET.FileId			= SOURCE.FileId
						AND TARGET.CountryId		= SOURCE.CountryId 
						AND TARGET.ManufacturerId	= SOURCE.ManufacturerId
						AND TARGET.MonthNumber      = SOURCE.MonthNumber
			)	
		WHEN MATCHED THEN
				UPDATE SET
					TARGET.Day1 = 
					CASE WHEN SIGN(SOURCE.Total - TARGET.Total) = -1 THEN 0 ELSE
						SOURCE.Total - TARGET.Total							END
		WHEN NOT MATCHED BY TARGET THEN
			INSERT (CountryId , Day1 , ManufacturerId , FileId , LogId ,DateCreated , DateYear, MonthNumber)				
			VALUES (SOURCE.CountryId , SOURCE.Total , SOURCE.ManufacturerId , SOURCE.FileId , SOURCE.LogId ,
			SOURCE.DateCreated , SOURCE.DateYear, SOURCE.MonthNumber);
	END
	ELSE IF @day = 2
	BEGIN
		MERGE 	[Import.ActiveFleetMonthADReport] AS TARGET
		USING	
		(
			SELECT
			CountryId , ManufacturerId , LogId , FileId , 
			@month				AS "MonthNumber", 
			@year				AS "DateYear", 
			GETDATE()			AS "DateCreated",
			COUNT(*)			AS "Total"
			FROM  [Staging.ActiveFleetMonthDeletes]
			GROUP BY CountryId , ManufacturerId , LogId , FileId
		)	AS SOURCE
		ON 
			(
							TARGET.DateYear			= SOURCE.DateYear 
						AND TARGET.FileId			= SOURCE.FileId
						AND TARGET.CountryId		= SOURCE.CountryId 
						AND TARGET.ManufacturerId	= SOURCE.ManufacturerId
						AND TARGET.MonthNumber      = SOURCE.MonthNumber
			)	
		WHEN MATCHED THEN
				UPDATE SET
					TARGET.Day2 = 
					CASE WHEN SIGN(SOURCE.Total - TARGET.Total) = -1 THEN 0 ELSE
						SOURCE.Total - TARGET.Total							END
					
		WHEN NOT MATCHED BY TARGET THEN
			INSERT (CountryId , Day2 , ManufacturerId , FileId , LogId ,DateCreated , DateYear, MonthNumber)				
			VALUES (SOURCE.CountryId , SOURCE.Total , SOURCE.ManufacturerId , SOURCE.FileId , SOURCE.LogId ,
			SOURCE.DateCreated , SOURCE.DateYear, SOURCE.MonthNumber);
	END
	ELSE IF @day = 3
	BEGIN
		MERGE 	[Import.ActiveFleetMonthADReport] AS TARGET
		USING	
		(
			SELECT
			CountryId , ManufacturerId , LogId , FileId , 
			@month				AS "MonthNumber", 
			@year				AS "DateYear", 
			GETDATE()			AS "DateCreated",
			COUNT(*)			AS "Total"
			FROM  [Staging.ActiveFleetMonthDeletes]
			GROUP BY CountryId , ManufacturerId , LogId , FileId
		)	AS SOURCE
		ON 
			(
							TARGET.DateYear			= SOURCE.DateYear 
						AND TARGET.FileId			= SOURCE.FileId
						AND TARGET.CountryId		= SOURCE.CountryId 
						AND TARGET.ManufacturerId	= SOURCE.ManufacturerId
						AND TARGET.MonthNumber      = SOURCE.MonthNumber
			)	
		WHEN MATCHED THEN
				UPDATE SET
					TARGET.Day3 = 
					CASE WHEN SIGN(SOURCE.Total - TARGET.Total) = -1 THEN 0 ELSE
						SOURCE.Total - TARGET.Total							END
		WHEN NOT MATCHED BY TARGET THEN
			INSERT (CountryId , Day3 , ManufacturerId , FileId , LogId ,DateCreated , DateYear, MonthNumber)				
			VALUES (SOURCE.CountryId , SOURCE.Total , SOURCE.ManufacturerId , SOURCE.FileId , SOURCE.LogId ,
			SOURCE.DateCreated , SOURCE.DateYear, SOURCE.MonthNumber);
	END
	ELSE IF @day = 4
	BEGIN
		MERGE 	[Import.ActiveFleetMonthADReport] AS TARGET
		USING	
		(
			SELECT
			CountryId , ManufacturerId , LogId , FileId , 
			@month				AS "MonthNumber", 
			@year				AS "DateYear", 
			GETDATE()			AS "DateCreated",
			COUNT(*)			AS "Total"
			FROM  [Staging.ActiveFleetMonthDeletes]
			GROUP BY CountryId , ManufacturerId , LogId , FileId
		)	AS SOURCE
		ON 
			(
							TARGET.DateYear			= SOURCE.DateYear 
						AND TARGET.FileId			= SOURCE.FileId
						AND TARGET.CountryId		= SOURCE.CountryId 
						AND TARGET.ManufacturerId	= SOURCE.ManufacturerId
						AND TARGET.MonthNumber      = SOURCE.MonthNumber
			)	
		WHEN MATCHED THEN
				UPDATE SET
					TARGET.Day4 = 
					CASE WHEN SIGN(SOURCE.Total - TARGET.Total) = -1 THEN 0 ELSE
						SOURCE.Total - TARGET.Total							END
		WHEN NOT MATCHED BY TARGET THEN
			INSERT (CountryId , Day4 , ManufacturerId , FileId , LogId ,DateCreated , DateYear, MonthNumber)				
			VALUES (SOURCE.CountryId , SOURCE.Total , SOURCE.ManufacturerId , SOURCE.FileId , SOURCE.LogId ,
			SOURCE.DateCreated , SOURCE.DateYear, SOURCE.MonthNumber);
	END
	ELSE IF @day = 5
	BEGIN
		MERGE 	[Import.ActiveFleetMonthADReport] AS TARGET
		USING	
		(
			SELECT
			CountryId , ManufacturerId , LogId , FileId , 
			@month				AS "MonthNumber", 
			@year				AS "DateYear", 
			GETDATE()			AS "DateCreated",
			COUNT(*)			AS "Total"
			FROM  [Staging.ActiveFleetMonthDeletes]
			GROUP BY CountryId , ManufacturerId , LogId , FileId
		)	AS SOURCE
		ON 
			(
							TARGET.DateYear			= SOURCE.DateYear 
						AND TARGET.FileId			= SOURCE.FileId
						AND TARGET.CountryId		= SOURCE.CountryId 
						AND TARGET.ManufacturerId	= SOURCE.ManufacturerId
						AND TARGET.MonthNumber      = SOURCE.MonthNumber
			)	
		WHEN MATCHED THEN
				UPDATE SET
					TARGET.Day5 = 
					CASE WHEN SIGN(SOURCE.Total - TARGET.Total) = -1 THEN 0 ELSE
						SOURCE.Total - TARGET.Total							END
		WHEN NOT MATCHED BY TARGET THEN
			INSERT (CountryId , Day5 , ManufacturerId , FileId , LogId ,DateCreated , DateYear, MonthNumber)				
			VALUES (SOURCE.CountryId , SOURCE.Total , SOURCE.ManufacturerId , SOURCE.FileId , SOURCE.LogId ,
			SOURCE.DateCreated , SOURCE.DateYear, SOURCE.MonthNumber);
	END
	ELSE IF @day = 6
	BEGIN
		MERGE 	[Import.ActiveFleetMonthADReport] AS TARGET
		USING	
		(
			SELECT
			CountryId , ManufacturerId , LogId , FileId , 
			@month				AS "MonthNumber", 
			@year				AS "DateYear", 
			GETDATE()			AS "DateCreated",
			COUNT(*)			AS "Total"
			FROM  [Staging.ActiveFleetMonthDeletes]
			GROUP BY CountryId , ManufacturerId , LogId , FileId
		)	AS SOURCE
		ON 
			(
							TARGET.DateYear			= SOURCE.DateYear 
						AND TARGET.FileId			= SOURCE.FileId
						AND TARGET.CountryId		= SOURCE.CountryId 
						AND TARGET.ManufacturerId	= SOURCE.ManufacturerId
						AND TARGET.MonthNumber      = SOURCE.MonthNumber
			)	
		WHEN MATCHED THEN
				UPDATE SET
					TARGET.Day6 = 
					CASE WHEN SIGN(SOURCE.Total - TARGET.Total) = -1 THEN 0 ELSE
						SOURCE.Total - TARGET.Total							END
		WHEN NOT MATCHED BY TARGET THEN
			INSERT (CountryId , Day6 , ManufacturerId , FileId , LogId ,DateCreated , DateYear, MonthNumber)				
			VALUES (SOURCE.CountryId , SOURCE.Total , SOURCE.ManufacturerId , SOURCE.FileId , SOURCE.LogId ,
			SOURCE.DateCreated , SOURCE.DateYear, SOURCE.MonthNumber);
	END
	ELSE IF @day = 7
	BEGIN
		MERGE 	[Import.ActiveFleetMonthADReport] AS TARGET
		USING	
		(
			SELECT
			CountryId , ManufacturerId , LogId , FileId , 
			@month				AS "MonthNumber", 
			@year				AS "DateYear", 
			GETDATE()			AS "DateCreated",
			COUNT(*)			AS "Total"
			FROM  [Staging.ActiveFleetMonthDeletes]
			GROUP BY CountryId , ManufacturerId , LogId , FileId
		)	AS SOURCE
		ON 
			(
							TARGET.DateYear			= SOURCE.DateYear 
						AND TARGET.FileId			= SOURCE.FileId
						AND TARGET.CountryId		= SOURCE.CountryId 
						AND TARGET.ManufacturerId	= SOURCE.ManufacturerId
						AND TARGET.MonthNumber      = SOURCE.MonthNumber
			)	
		WHEN MATCHED THEN
				UPDATE SET
					TARGET.Day7 = 
					CASE WHEN SIGN(SOURCE.Total - TARGET.Total) = -1 THEN 0 ELSE
						SOURCE.Total - TARGET.Total							END
		WHEN NOT MATCHED BY TARGET THEN
			INSERT (CountryId , Day7 , ManufacturerId , FileId , LogId ,DateCreated , DateYear, MonthNumber)				
			VALUES (SOURCE.CountryId , SOURCE.Total , SOURCE.ManufacturerId , SOURCE.FileId , SOURCE.LogId ,
			SOURCE.DateCreated , SOURCE.DateYear, SOURCE.MonthNumber);
	END
	ELSE IF @day = 8
	BEGIN
		MERGE 	[Import.ActiveFleetMonthADReport] AS TARGET
		USING	
		(
			SELECT
			CountryId , ManufacturerId , LogId , FileId , 
			@month				AS "MonthNumber", 
			@year				AS "DateYear", 
			GETDATE()			AS "DateCreated",
			COUNT(*)			AS "Total"
			FROM  [Staging.ActiveFleetMonthDeletes]
			GROUP BY CountryId , ManufacturerId , LogId , FileId
		)	AS SOURCE
		ON 
			(
							TARGET.DateYear			= SOURCE.DateYear 
						AND TARGET.FileId			= SOURCE.FileId
						AND TARGET.CountryId		= SOURCE.CountryId 
						AND TARGET.ManufacturerId	= SOURCE.ManufacturerId
						AND TARGET.MonthNumber      = SOURCE.MonthNumber
			)	
		WHEN MATCHED THEN
				UPDATE SET
					TARGET.Day8 = 
					CASE WHEN SIGN(SOURCE.Total - TARGET.Total) = -1 THEN 0 ELSE
						SOURCE.Total - TARGET.Total							END	
		WHEN NOT MATCHED BY TARGET THEN
			INSERT (CountryId , Day8 , ManufacturerId , FileId , LogId ,DateCreated , DateYear, MonthNumber)				
			VALUES (SOURCE.CountryId , SOURCE.Total , SOURCE.ManufacturerId , SOURCE.FileId , SOURCE.LogId ,
			SOURCE.DateCreated , SOURCE.DateYear, SOURCE.MonthNumber);
	END
	ELSE IF @day = 9
	BEGIN
		MERGE 	[Import.ActiveFleetMonthADReport] AS TARGET
		USING	
		(
			SELECT
			CountryId , ManufacturerId , LogId , FileId , 
			@month				AS "MonthNumber", 
			@year				AS "DateYear", 
			GETDATE()			AS "DateCreated",
			COUNT(*)			AS "Total"
			FROM  [Staging.ActiveFleetMonthDeletes]
			GROUP BY CountryId , ManufacturerId , LogId , FileId
		)	AS SOURCE
		ON 
			(
							TARGET.DateYear			= SOURCE.DateYear 
						AND TARGET.FileId			= SOURCE.FileId
						AND TARGET.CountryId		= SOURCE.CountryId 
						AND TARGET.ManufacturerId	= SOURCE.ManufacturerId
						AND TARGET.MonthNumber      = SOURCE.MonthNumber
			)	
		WHEN MATCHED THEN
				UPDATE SET
					TARGET.Day9 = 
					CASE WHEN SIGN(SOURCE.Total - TARGET.Total) = -1 THEN 0 ELSE
						SOURCE.Total - TARGET.Total							END
		WHEN NOT MATCHED BY TARGET THEN
			INSERT (CountryId , Day9 , ManufacturerId , FileId , LogId ,DateCreated , DateYear, MonthNumber)				
			VALUES (SOURCE.CountryId , SOURCE.Total , SOURCE.ManufacturerId , SOURCE.FileId , SOURCE.LogId ,
			SOURCE.DateCreated , SOURCE.DateYear, SOURCE.MonthNumber);
	END
	ELSE IF @day = 10
	BEGIN
		MERGE 	[Import.ActiveFleetMonthADReport] AS TARGET
		USING	
		(
			SELECT
			CountryId , ManufacturerId , LogId , FileId , 
			@month				AS "MonthNumber", 
			@year				AS "DateYear", 
			GETDATE()			AS "DateCreated",
			COUNT(*)			AS "Total"
			FROM  [Staging.ActiveFleetMonthDeletes]
			GROUP BY CountryId , ManufacturerId , LogId , FileId
		)	AS SOURCE
		ON 
			(
							TARGET.DateYear			= SOURCE.DateYear 
						AND TARGET.FileId			= SOURCE.FileId
						AND TARGET.CountryId		= SOURCE.CountryId 
						AND TARGET.ManufacturerId	= SOURCE.ManufacturerId
						AND TARGET.MonthNumber      = SOURCE.MonthNumber
			)	
		WHEN MATCHED THEN
				UPDATE SET
					TARGET.Day10 = 
					CASE WHEN SIGN(SOURCE.Total - TARGET.Total) = -1 THEN 0 ELSE
						SOURCE.Total - TARGET.Total							END
		WHEN NOT MATCHED BY TARGET THEN
			INSERT (CountryId , Day10 , ManufacturerId , FileId , LogId ,DateCreated , DateYear, MonthNumber)				
			VALUES (SOURCE.CountryId , SOURCE.Total , SOURCE.ManufacturerId , SOURCE.FileId , SOURCE.LogId ,
			SOURCE.DateCreated , SOURCE.DateYear, SOURCE.MonthNumber);
	END
	ELSE IF @day = 11
	BEGIN
		MERGE 	[Import.ActiveFleetMonthADReport] AS TARGET
		USING	
		(
			SELECT
			CountryId , ManufacturerId , LogId , FileId , 
			@month				AS "MonthNumber", 
			@year				AS "DateYear", 
			GETDATE()			AS "DateCreated",
			COUNT(*)			AS "Total"
			FROM  [Staging.ActiveFleetMonthDeletes]
			GROUP BY CountryId , ManufacturerId , LogId , FileId
		)	AS SOURCE
		ON 
			(
							TARGET.DateYear			= SOURCE.DateYear 
						AND TARGET.FileId			= SOURCE.FileId
						AND TARGET.CountryId		= SOURCE.CountryId 
						AND TARGET.ManufacturerId	= SOURCE.ManufacturerId
						AND TARGET.MonthNumber      = SOURCE.MonthNumber
			)	
		WHEN MATCHED THEN
				UPDATE SET
					TARGET.Day11 = 
					CASE WHEN SIGN(SOURCE.Total - TARGET.Total) = -1 THEN 0 ELSE
						SOURCE.Total - TARGET.Total							END
		WHEN NOT MATCHED BY TARGET THEN
			INSERT (CountryId , Day11 , ManufacturerId , FileId , LogId ,DateCreated , DateYear, MonthNumber)				
			VALUES (SOURCE.CountryId , SOURCE.Total , SOURCE.ManufacturerId , SOURCE.FileId , SOURCE.LogId ,
			SOURCE.DateCreated , SOURCE.DateYear, SOURCE.MonthNumber);
	END
	ELSE IF @day = 12
	BEGIN
		MERGE 	[Import.ActiveFleetMonthADReport] AS TARGET
		USING	
		(
			SELECT
			CountryId , ManufacturerId , LogId , FileId , 
			@month				AS "MonthNumber", 
			@year				AS "DateYear", 
			GETDATE()			AS "DateCreated",
			COUNT(*)			AS "Total"
			FROM  [Staging.ActiveFleetMonthDeletes]
			GROUP BY CountryId , ManufacturerId , LogId , FileId
		)	AS SOURCE
		ON 
			(
							TARGET.DateYear			= SOURCE.DateYear 
						AND TARGET.FileId			= SOURCE.FileId
						AND TARGET.CountryId		= SOURCE.CountryId 
						AND TARGET.ManufacturerId	= SOURCE.ManufacturerId
						AND TARGET.MonthNumber      = SOURCE.MonthNumber
			)	
		WHEN MATCHED THEN
				UPDATE SET
					TARGET.Day12 = 
					CASE WHEN SIGN(SOURCE.Total - TARGET.Total) = -1 THEN 0 ELSE
						SOURCE.Total - TARGET.Total							END
		WHEN NOT MATCHED BY TARGET THEN
			INSERT (CountryId , Day12 , ManufacturerId , FileId , LogId ,DateCreated , DateYear, MonthNumber)				
			VALUES (SOURCE.CountryId , SOURCE.Total , SOURCE.ManufacturerId , SOURCE.FileId , SOURCE.LogId ,
			SOURCE.DateCreated , SOURCE.DateYear, SOURCE.MonthNumber);
	END
	ELSE IF @day = 13
	BEGIN
		MERGE 	[Import.ActiveFleetMonthADReport] AS TARGET
		USING	
		(
			SELECT
			CountryId , ManufacturerId , LogId , FileId , 
			@month				AS "MonthNumber", 
			@year				AS "DateYear", 
			GETDATE()			AS "DateCreated",
			COUNT(*)			AS "Total"
			FROM  [Staging.ActiveFleetMonthDeletes]
			GROUP BY CountryId , ManufacturerId , LogId , FileId
		)	AS SOURCE
		ON 
			(
							TARGET.DateYear			= SOURCE.DateYear 
						AND TARGET.FileId			= SOURCE.FileId
						AND TARGET.CountryId		= SOURCE.CountryId 
						AND TARGET.ManufacturerId	= SOURCE.ManufacturerId
						AND TARGET.MonthNumber      = SOURCE.MonthNumber
			)	
		WHEN MATCHED THEN
				UPDATE SET
					TARGET.Day13 = 
					CASE WHEN SIGN(SOURCE.Total - TARGET.Total) = -1 THEN 0 ELSE
						SOURCE.Total - TARGET.Total							END
		WHEN NOT MATCHED BY TARGET THEN
			INSERT (CountryId , Day13 , ManufacturerId , FileId , LogId ,DateCreated , DateYear, MonthNumber)				
			VALUES (SOURCE.CountryId , SOURCE.Total , SOURCE.ManufacturerId , SOURCE.FileId , SOURCE.LogId ,
			SOURCE.DateCreated , SOURCE.DateYear, SOURCE.MonthNumber);
	END
	ELSE IF @day = 14
	BEGIN
		MERGE 	[Import.ActiveFleetMonthADReport] AS TARGET
		USING	
		(
			SELECT
			CountryId , ManufacturerId , LogId , FileId , 
			@month				AS "MonthNumber", 
			@year				AS "DateYear", 
			GETDATE()			AS "DateCreated",
			COUNT(*)			AS "Total"
			FROM  [Staging.ActiveFleetMonthDeletes]
			GROUP BY CountryId , ManufacturerId , LogId , FileId
		)	AS SOURCE
		ON 
			(
							TARGET.DateYear			= SOURCE.DateYear 
						AND TARGET.FileId			= SOURCE.FileId
						AND TARGET.CountryId		= SOURCE.CountryId 
						AND TARGET.ManufacturerId	= SOURCE.ManufacturerId
						AND TARGET.MonthNumber      = SOURCE.MonthNumber
			)	
		WHEN MATCHED THEN
				UPDATE SET
					TARGET.Day14 = 
					CASE WHEN SIGN(SOURCE.Total - TARGET.Total) = -1 THEN 0 ELSE
						SOURCE.Total - TARGET.Total							END
		WHEN NOT MATCHED BY TARGET THEN
			INSERT (CountryId , Day14 , ManufacturerId , FileId , LogId ,DateCreated , DateYear, MonthNumber)				
			VALUES (SOURCE.CountryId , SOURCE.Total , SOURCE.ManufacturerId , SOURCE.FileId , SOURCE.LogId ,
			SOURCE.DateCreated , SOURCE.DateYear, SOURCE.MonthNumber);
	END
	ELSE IF @day = 15
	BEGIN
		MERGE 	[Import.ActiveFleetMonthADReport] AS TARGET
		USING	
		(
			SELECT
			CountryId , ManufacturerId , LogId , FileId , 
			@month				AS "MonthNumber", 
			@year				AS "DateYear", 
			GETDATE()			AS "DateCreated",
			COUNT(*)			AS "Total"
			FROM  [Staging.ActiveFleetMonthDeletes]
			GROUP BY CountryId , ManufacturerId , LogId , FileId
		)	AS SOURCE
		ON 
			(
							TARGET.DateYear			= SOURCE.DateYear 
						AND TARGET.FileId			= SOURCE.FileId
						AND TARGET.CountryId		= SOURCE.CountryId 
						AND TARGET.ManufacturerId	= SOURCE.ManufacturerId
						AND TARGET.MonthNumber      = SOURCE.MonthNumber
			)	
		WHEN MATCHED THEN
				UPDATE SET
					TARGET.Day15 = 
					CASE WHEN SIGN(SOURCE.Total - TARGET.Total) = -1 THEN 0 ELSE
						SOURCE.Total - TARGET.Total							END
		WHEN NOT MATCHED BY TARGET THEN
			INSERT (CountryId , Day15 , ManufacturerId , FileId , LogId ,DateCreated , DateYear, MonthNumber)				
			VALUES (SOURCE.CountryId , SOURCE.Total , SOURCE.ManufacturerId , SOURCE.FileId , SOURCE.LogId ,
			SOURCE.DateCreated , SOURCE.DateYear, SOURCE.MonthNumber);
	END
	ELSE IF @day = 16
	BEGIN
		MERGE 	[Import.ActiveFleetMonthADReport] AS TARGET
		USING	
		(
			SELECT
			CountryId , ManufacturerId , LogId , FileId , 
			@month				AS "MonthNumber", 
			@year				AS "DateYear", 
			GETDATE()			AS "DateCreated",
			COUNT(*)			AS "Total"
			FROM  [Staging.ActiveFleetMonthDeletes]
			GROUP BY CountryId , ManufacturerId , LogId , FileId
		)	AS SOURCE
		ON 
			(
							TARGET.DateYear			= SOURCE.DateYear 
						AND TARGET.FileId			= SOURCE.FileId
						AND TARGET.CountryId		= SOURCE.CountryId 
						AND TARGET.ManufacturerId	= SOURCE.ManufacturerId
						AND TARGET.MonthNumber      = SOURCE.MonthNumber
			)	
		WHEN MATCHED THEN
				UPDATE SET
					TARGET.Day16 = 
					CASE WHEN SIGN(SOURCE.Total - TARGET.Total) = -1 THEN 0 ELSE
						SOURCE.Total - TARGET.Total							END
		WHEN NOT MATCHED BY TARGET THEN
			INSERT (CountryId , Day16 , ManufacturerId , FileId , LogId ,DateCreated , DateYear, MonthNumber)				
			VALUES (SOURCE.CountryId , SOURCE.Total , SOURCE.ManufacturerId , SOURCE.FileId , SOURCE.LogId ,
			SOURCE.DateCreated , SOURCE.DateYear, SOURCE.MonthNumber);
	END
	ELSE IF @day = 17
	BEGIN
		MERGE 	[Import.ActiveFleetMonthADReport] AS TARGET
		USING	
		(
			SELECT
			CountryId , ManufacturerId , LogId , FileId , 
			@month				AS "MonthNumber", 
			@year				AS "DateYear", 
			GETDATE()			AS "DateCreated",
			COUNT(*)			AS "Total"
			FROM  [Staging.ActiveFleetMonthDeletes]
			GROUP BY CountryId , ManufacturerId , LogId , FileId
		)	AS SOURCE
		ON 
			(
							TARGET.DateYear			= SOURCE.DateYear 
						AND TARGET.FileId			= SOURCE.FileId
						AND TARGET.CountryId		= SOURCE.CountryId 
						AND TARGET.ManufacturerId	= SOURCE.ManufacturerId
						AND TARGET.MonthNumber      = SOURCE.MonthNumber
			)	
		WHEN MATCHED THEN
				UPDATE SET
					TARGET.Day17 = 
					CASE WHEN SIGN(SOURCE.Total - TARGET.Total) = -1 THEN 0 ELSE
						SOURCE.Total - TARGET.Total							END
		WHEN NOT MATCHED BY TARGET THEN
			INSERT (CountryId , Day17 , ManufacturerId , FileId , LogId ,DateCreated , DateYear, MonthNumber)				
			VALUES (SOURCE.CountryId , SOURCE.Total , SOURCE.ManufacturerId , SOURCE.FileId , SOURCE.LogId ,
			SOURCE.DateCreated , SOURCE.DateYear, SOURCE.MonthNumber);
	END
	ELSE IF @day = 18
	BEGIN
		MERGE 	[Import.ActiveFleetMonthADReport] AS TARGET
		USING	
		(
			SELECT
			CountryId , ManufacturerId , LogId , FileId , 
			@month				AS "MonthNumber", 
			@year				AS "DateYear", 
			GETDATE()			AS "DateCreated",
			COUNT(*)			AS "Total"
			FROM  [Staging.ActiveFleetMonthDeletes]
			GROUP BY CountryId , ManufacturerId , LogId , FileId
		)	AS SOURCE
		ON 
			(
							TARGET.DateYear			= SOURCE.DateYear 
						AND TARGET.FileId			= SOURCE.FileId
						AND TARGET.CountryId		= SOURCE.CountryId 
						AND TARGET.ManufacturerId	= SOURCE.ManufacturerId
						AND TARGET.MonthNumber      = SOURCE.MonthNumber
			)	
		WHEN MATCHED THEN
				UPDATE SET
					TARGET.Day18 = 
					CASE WHEN SIGN(SOURCE.Total - TARGET.Total) = -1 THEN 0 ELSE
						SOURCE.Total - TARGET.Total							END
		WHEN NOT MATCHED BY TARGET THEN
			INSERT (CountryId , Day18 , ManufacturerId , FileId , LogId ,DateCreated , DateYear, MonthNumber)				
			VALUES (SOURCE.CountryId , SOURCE.Total , SOURCE.ManufacturerId , SOURCE.FileId , SOURCE.LogId ,
			SOURCE.DateCreated , SOURCE.DateYear, SOURCE.MonthNumber);
	END
	ELSE IF @day = 19
	BEGIN
		MERGE 	[Import.ActiveFleetMonthADReport] AS TARGET
		USING	
		(
			SELECT
			CountryId , ManufacturerId , LogId , FileId , 
			@month				AS "MonthNumber", 
			@year				AS "DateYear", 
			GETDATE()			AS "DateCreated",
			COUNT(*)			AS "Total"
			FROM  [Staging.ActiveFleetMonthDeletes]
			GROUP BY CountryId , ManufacturerId , LogId , FileId
		)	AS SOURCE
		ON 
			(
							TARGET.DateYear			= SOURCE.DateYear 
						AND TARGET.FileId			= SOURCE.FileId
						AND TARGET.CountryId		= SOURCE.CountryId 
						AND TARGET.ManufacturerId	= SOURCE.ManufacturerId
						AND TARGET.MonthNumber      = SOURCE.MonthNumber
			)	
		WHEN MATCHED THEN
				UPDATE SET
					TARGET.Day19 = 
					CASE WHEN SIGN(SOURCE.Total - TARGET.Total) = -1 THEN 0 ELSE
						SOURCE.Total - TARGET.Total							END
		WHEN NOT MATCHED BY TARGET THEN
			INSERT (CountryId , Day19 , ManufacturerId , FileId , LogId ,DateCreated , DateYear, MonthNumber)				
			VALUES (SOURCE.CountryId , SOURCE.Total , SOURCE.ManufacturerId , SOURCE.FileId , SOURCE.LogId ,
			SOURCE.DateCreated , SOURCE.DateYear, SOURCE.MonthNumber);
	END
	ELSE IF @day = 20
	BEGIN
		MERGE 	[Import.ActiveFleetMonthADReport] AS TARGET
		USING	
		(
			SELECT
			CountryId , ManufacturerId , LogId , FileId , 
			@month				AS "MonthNumber", 
			@year				AS "DateYear", 
			GETDATE()			AS "DateCreated",
			COUNT(*)			AS "Total"
			FROM  [Staging.ActiveFleetMonthDeletes]
			GROUP BY CountryId , ManufacturerId , LogId , FileId
		)	AS SOURCE
		ON 
			(
							TARGET.DateYear			= SOURCE.DateYear 
						AND TARGET.FileId			= SOURCE.FileId
						AND TARGET.CountryId		= SOURCE.CountryId 
						AND TARGET.ManufacturerId	= SOURCE.ManufacturerId
						AND TARGET.MonthNumber      = SOURCE.MonthNumber
			)	
		WHEN MATCHED THEN
				UPDATE SET
					TARGET.Day20 = 
					CASE WHEN SIGN(SOURCE.Total - TARGET.Total) = -1 THEN 0 ELSE
						SOURCE.Total - TARGET.Total							END
		WHEN NOT MATCHED BY TARGET THEN
			INSERT (CountryId , Day20 , ManufacturerId , FileId , LogId ,DateCreated , DateYear, MonthNumber)				
			VALUES (SOURCE.CountryId , SOURCE.Total , SOURCE.ManufacturerId , SOURCE.FileId , SOURCE.LogId ,
			SOURCE.DateCreated , SOURCE.DateYear, SOURCE.MonthNumber);
	END
	ELSE IF @day = 21
	BEGIN
		MERGE 	[Import.ActiveFleetMonthADReport] AS TARGET
		USING	
		(
			SELECT
			CountryId , ManufacturerId , LogId , FileId , 
			@month				AS "MonthNumber", 
			@year				AS "DateYear", 
			GETDATE()			AS "DateCreated",
			COUNT(*)			AS "Total"
			FROM  [Staging.ActiveFleetMonthDeletes]
			GROUP BY CountryId , ManufacturerId , LogId , FileId
		)	AS SOURCE
		ON 
			(
							TARGET.DateYear			= SOURCE.DateYear 
						AND TARGET.FileId			= SOURCE.FileId
						AND TARGET.CountryId		= SOURCE.CountryId 
						AND TARGET.ManufacturerId	= SOURCE.ManufacturerId
						AND TARGET.MonthNumber      = SOURCE.MonthNumber
			)	
		WHEN MATCHED THEN
				UPDATE SET
					TARGET.Day21 = 
					CASE WHEN SIGN(SOURCE.Total - TARGET.Total) = -1 THEN 0 ELSE
						SOURCE.Total - TARGET.Total							END	
		WHEN NOT MATCHED BY TARGET THEN
			INSERT (CountryId , Day21 , ManufacturerId , FileId , LogId ,DateCreated , DateYear, MonthNumber)				
			VALUES (SOURCE.CountryId , SOURCE.Total , SOURCE.ManufacturerId , SOURCE.FileId , SOURCE.LogId ,
			SOURCE.DateCreated , SOURCE.DateYear, SOURCE.MonthNumber);
	END
	ELSE IF @day = 22
	BEGIN
		MERGE 	[Import.ActiveFleetMonthADReport] AS TARGET
		USING	
		(
			SELECT
			CountryId , ManufacturerId , LogId , FileId , 
			@month				AS "MonthNumber", 
			@year				AS "DateYear", 
			GETDATE()			AS "DateCreated",
			COUNT(*)			AS "Total"
			FROM  [Staging.ActiveFleetMonthDeletes]
			GROUP BY CountryId , ManufacturerId , LogId , FileId
		)	AS SOURCE
		ON 
			(
							TARGET.DateYear			= SOURCE.DateYear 
						AND TARGET.FileId			= SOURCE.FileId
						AND TARGET.CountryId		= SOURCE.CountryId 
						AND TARGET.ManufacturerId	= SOURCE.ManufacturerId
						AND TARGET.MonthNumber      = SOURCE.MonthNumber
			)	
		WHEN MATCHED THEN
				UPDATE SET
					TARGET.Day22 = 
					CASE WHEN SIGN(SOURCE.Total - TARGET.Total) = -1 THEN 0 ELSE
						SOURCE.Total - TARGET.Total							END
		WHEN NOT MATCHED BY TARGET THEN
			INSERT (CountryId , Day22 , ManufacturerId , FileId , LogId ,DateCreated , DateYear, MonthNumber)				
			VALUES (SOURCE.CountryId , SOURCE.Total , SOURCE.ManufacturerId , SOURCE.FileId , SOURCE.LogId ,
			SOURCE.DateCreated , SOURCE.DateYear, SOURCE.MonthNumber);
	END
	ELSE IF @day = 23
	BEGIN
		MERGE 	[Import.ActiveFleetMonthADReport] AS TARGET
		USING	
		(
			SELECT
			CountryId , ManufacturerId , LogId , FileId , 
			@month				AS "MonthNumber", 
			@year				AS "DateYear", 
			GETDATE()			AS "DateCreated",
			COUNT(*)			AS "Total"
			FROM  [Staging.ActiveFleetMonthDeletes]
			GROUP BY CountryId , ManufacturerId , LogId , FileId
		)	AS SOURCE
		ON 
			(
							TARGET.DateYear			= SOURCE.DateYear 
						AND TARGET.FileId			= SOURCE.FileId
						AND TARGET.CountryId		= SOURCE.CountryId 
						AND TARGET.ManufacturerId	= SOURCE.ManufacturerId
						AND TARGET.MonthNumber      = SOURCE.MonthNumber
			)	
		WHEN MATCHED THEN
				UPDATE SET
					TARGET.Day23 = 
					CASE WHEN SIGN(SOURCE.Total - TARGET.Total) = -1 THEN 0 ELSE
						SOURCE.Total - TARGET.Total							END
		WHEN NOT MATCHED BY TARGET THEN
			INSERT (CountryId , Day23 , ManufacturerId , FileId , LogId ,DateCreated , DateYear, MonthNumber)				
			VALUES (SOURCE.CountryId , SOURCE.Total , SOURCE.ManufacturerId , SOURCE.FileId , SOURCE.LogId ,
			SOURCE.DateCreated , SOURCE.DateYear, SOURCE.MonthNumber);
	END
	ELSE IF @day = 24
	BEGIN
		MERGE 	[Import.ActiveFleetMonthADReport] AS TARGET
		USING	
		(
			SELECT
			CountryId , ManufacturerId , LogId , FileId , 
			@month				AS "MonthNumber", 
			@year				AS "DateYear", 
			GETDATE()			AS "DateCreated",
			COUNT(*)			AS "Total"
			FROM  [Staging.ActiveFleetMonthDeletes]
			GROUP BY CountryId , ManufacturerId , LogId , FileId
		)	AS SOURCE
		ON 
			(
							TARGET.DateYear			= SOURCE.DateYear 
						AND TARGET.FileId			= SOURCE.FileId
						AND TARGET.CountryId		= SOURCE.CountryId 
						AND TARGET.ManufacturerId	= SOURCE.ManufacturerId
						AND TARGET.MonthNumber      = SOURCE.MonthNumber
			)	
		WHEN MATCHED THEN
				UPDATE SET
					TARGET.Day24 = 
					CASE WHEN SIGN(SOURCE.Total - TARGET.Total) = -1 THEN 0 ELSE
						SOURCE.Total - TARGET.Total							END
		WHEN NOT MATCHED BY TARGET THEN
			INSERT (CountryId , Day24 , ManufacturerId , FileId , LogId ,DateCreated , DateYear, MonthNumber)				
			VALUES (SOURCE.CountryId , SOURCE.Total , SOURCE.ManufacturerId , SOURCE.FileId , SOURCE.LogId ,
			SOURCE.DateCreated , SOURCE.DateYear, SOURCE.MonthNumber);
	END
	ELSE IF @day = 25
	BEGIN
		MERGE 	[Import.ActiveFleetMonthADReport] AS TARGET
		USING	
		(
			SELECT
			CountryId , ManufacturerId , LogId , FileId , 
			@month				AS "MonthNumber", 
			@year				AS "DateYear", 
			GETDATE()			AS "DateCreated",
			COUNT(*)			AS "Total"
			FROM  [Staging.ActiveFleetMonthDeletes]
			GROUP BY CountryId , ManufacturerId , LogId , FileId
		)	AS SOURCE
		ON 
			(
							TARGET.DateYear			= SOURCE.DateYear 
						AND TARGET.FileId			= SOURCE.FileId
						AND TARGET.CountryId		= SOURCE.CountryId 
						AND TARGET.ManufacturerId	= SOURCE.ManufacturerId
						AND TARGET.MonthNumber      = SOURCE.MonthNumber
			)	
		WHEN MATCHED THEN
				UPDATE SET
					TARGET.Day25 = 
					CASE WHEN SIGN(SOURCE.Total - TARGET.Total) = -1 THEN 0 ELSE
						SOURCE.Total - TARGET.Total							END
		WHEN NOT MATCHED BY TARGET THEN
			INSERT (CountryId , Day25 , ManufacturerId , FileId , LogId ,DateCreated , DateYear, MonthNumber)				
			VALUES (SOURCE.CountryId , SOURCE.Total , SOURCE.ManufacturerId , SOURCE.FileId , SOURCE.LogId ,
			SOURCE.DateCreated , SOURCE.DateYear, SOURCE.MonthNumber);
	END
	ELSE IF @day = 26
	BEGIN
		MERGE 	[Import.ActiveFleetMonthADReport] AS TARGET
		USING	
		(
			SELECT
			CountryId , ManufacturerId , LogId , FileId , 
			@month				AS "MonthNumber", 
			@year				AS "DateYear",  
			GETDATE()			AS "DateCreated",
			COUNT(*)			AS "Total"
			FROM  [Staging.ActiveFleetMonthDeletes]
			GROUP BY CountryId , ManufacturerId , LogId , FileId
		)	AS SOURCE
		ON 
			(
							TARGET.DateYear			= SOURCE.DateYear 
						AND TARGET.FileId			= SOURCE.FileId
						AND TARGET.CountryId		= SOURCE.CountryId 
						AND TARGET.ManufacturerId	= SOURCE.ManufacturerId
						AND TARGET.MonthNumber      = SOURCE.MonthNumber
			)	
		WHEN MATCHED THEN
				UPDATE SET
					TARGET.Day26 = 
					CASE WHEN SIGN(SOURCE.Total - TARGET.Total) = -1 THEN 0 ELSE
						SOURCE.Total - TARGET.Total							END
		WHEN NOT MATCHED BY TARGET THEN
			INSERT (CountryId , Day26 , ManufacturerId , FileId , LogId ,DateCreated , DateYear, MonthNumber)				
			VALUES (SOURCE.CountryId , SOURCE.Total , SOURCE.ManufacturerId , SOURCE.FileId , SOURCE.LogId ,
			SOURCE.DateCreated , SOURCE.DateYear, SOURCE.MonthNumber);
	END
	ELSE IF @day = 27
	BEGIN
		MERGE 	[Import.ActiveFleetMonthADReport] AS TARGET
		USING	
		(
			SELECT
			CountryId , ManufacturerId , LogId , FileId , 
			@month				AS "MonthNumber", 
			@year				AS "DateYear", 
			GETDATE()			AS "DateCreated",
			COUNT(*)			AS "Total"
			FROM  [Staging.ActiveFleetMonthDeletes]
			GROUP BY CountryId , ManufacturerId , LogId , FileId
		)	AS SOURCE
		ON 
			(
							TARGET.DateYear			= SOURCE.DateYear 
						AND TARGET.FileId			= SOURCE.FileId
						AND TARGET.CountryId		= SOURCE.CountryId 
						AND TARGET.ManufacturerId	= SOURCE.ManufacturerId
						AND TARGET.MonthNumber      = SOURCE.MonthNumber
			)	
		WHEN MATCHED THEN
				UPDATE SET
					TARGET.Day27 = 
					CASE WHEN SIGN(SOURCE.Total - TARGET.Total) = -1 THEN 0 ELSE
						SOURCE.Total - TARGET.Total							END
		WHEN NOT MATCHED BY TARGET THEN
			INSERT (CountryId , Day27 , ManufacturerId , FileId , LogId ,DateCreated , DateYear, MonthNumber)				
			VALUES (SOURCE.CountryId , SOURCE.Total , SOURCE.ManufacturerId , SOURCE.FileId , SOURCE.LogId ,
			SOURCE.DateCreated , SOURCE.DateYear, SOURCE.MonthNumber);
	END
	ELSE IF @day = 28
	BEGIN
		MERGE 	[Import.ActiveFleetMonthADReport] AS TARGET
		USING	
		(
			SELECT
			CountryId , ManufacturerId , LogId , FileId , 
			@month				AS "MonthNumber", 
			@year				AS "DateYear", 
			GETDATE()			AS "DateCreated",
			COUNT(*)			AS "Total"
			FROM  [Staging.ActiveFleetMonthDeletes]
			GROUP BY CountryId , ManufacturerId , LogId , FileId
		)	AS SOURCE
		ON 
			(
							TARGET.DateYear			= SOURCE.DateYear 
						AND TARGET.FileId			= SOURCE.FileId
						AND TARGET.CountryId		= SOURCE.CountryId 
						AND TARGET.ManufacturerId	= SOURCE.ManufacturerId
						AND TARGET.MonthNumber      = SOURCE.MonthNumber
			)	
		WHEN MATCHED THEN
				UPDATE SET
					TARGET.Day28 = 
					CASE WHEN SIGN(SOURCE.Total - TARGET.Total) = -1 THEN 0 ELSE
						SOURCE.Total - TARGET.Total							END
		WHEN NOT MATCHED BY TARGET THEN
			INSERT (CountryId , Day28 , ManufacturerId , FileId , LogId ,DateCreated , DateYear, MonthNumber)				
			VALUES (SOURCE.CountryId , SOURCE.Total , SOURCE.ManufacturerId , SOURCE.FileId , SOURCE.LogId ,
			SOURCE.DateCreated , SOURCE.DateYear, SOURCE.MonthNumber);
	END
	ELSE IF @day = 29
	BEGIN
		MERGE 	[Import.ActiveFleetMonthADReport] AS TARGET
		USING	
		(
			SELECT
			CountryId , ManufacturerId , LogId , FileId , 
			@month				AS "MonthNumber", 
			@year				AS "DateYear", 
			GETDATE()			AS "DateCreated",
			COUNT(*)			AS "Total"
			FROM  [Staging.ActiveFleetMonthDeletes]
			GROUP BY CountryId , ManufacturerId , LogId , FileId
		)	AS SOURCE
		ON 
			(
							TARGET.DateYear			= SOURCE.DateYear 
						AND TARGET.FileId			= SOURCE.FileId
						AND TARGET.CountryId		= SOURCE.CountryId 
						AND TARGET.ManufacturerId	= SOURCE.ManufacturerId
						AND TARGET.MonthNumber      = SOURCE.MonthNumber
			)	
		WHEN MATCHED THEN
				UPDATE SET
					TARGET.Day29 = 
					CASE WHEN SIGN(SOURCE.Total - TARGET.Total) = -1 THEN 0 ELSE
						SOURCE.Total - TARGET.Total							END
		WHEN NOT MATCHED BY TARGET THEN
			INSERT (CountryId , Day29 , ManufacturerId , FileId , LogId ,DateCreated , DateYear, MonthNumber)				
			VALUES (SOURCE.CountryId , SOURCE.Total , SOURCE.ManufacturerId , SOURCE.FileId , SOURCE.LogId ,
			SOURCE.DateCreated , SOURCE.DateYear, SOURCE.MonthNumber);
	END
	ELSE IF @day = 30
	BEGIN
		MERGE 	[Import.ActiveFleetMonthADReport] AS TARGET
		USING	
		(
			SELECT
			CountryId , ManufacturerId , LogId , FileId , 
			@month				AS "MonthNumber", 
			@year				AS "DateYear", 
			GETDATE()			AS "DateCreated",
			COUNT(*)			AS "Total"
			FROM  [Staging.ActiveFleetMonthDeletes]
			GROUP BY CountryId , ManufacturerId , LogId , FileId
		)	AS SOURCE
		ON 
			(
							TARGET.DateYear			= SOURCE.DateYear 
						AND TARGET.FileId			= SOURCE.FileId
						AND TARGET.CountryId		= SOURCE.CountryId 
						AND TARGET.ManufacturerId	= SOURCE.ManufacturerId
						AND TARGET.MonthNumber      = SOURCE.MonthNumber
			)	
		WHEN MATCHED THEN
				UPDATE SET
					TARGET.Day30 = 
					CASE WHEN SIGN(SOURCE.Total - TARGET.Total) = -1 THEN 0 ELSE
						SOURCE.Total - TARGET.Total							END	
		WHEN NOT MATCHED BY TARGET THEN
			INSERT (CountryId , Day30 , ManufacturerId , FileId , LogId ,DateCreated , DateYear, MonthNumber)				
			VALUES (SOURCE.CountryId , SOURCE.Total , SOURCE.ManufacturerId , SOURCE.FileId , SOURCE.LogId ,
			SOURCE.DateCreated , SOURCE.DateYear, SOURCE.MonthNumber);
	END
	ELSE IF @day = 31
	BEGIN
		MERGE 	[Import.ActiveFleetMonthADReport] AS TARGET
		USING	
		(
			SELECT
			CountryId , ManufacturerId , LogId , FileId , 
			@month				AS "MonthNumber", 
			@year				AS "DateYear", 
			GETDATE()			AS "DateCreated",
			COUNT(*)			AS "Total"
			FROM  [Staging.ActiveFleetMonthDeletes]
			GROUP BY CountryId , ManufacturerId , LogId , FileId
		)	AS SOURCE
		ON 
			(
							TARGET.DateYear			= SOURCE.DateYear 
						AND TARGET.FileId			= SOURCE.FileId
						AND TARGET.CountryId		= SOURCE.CountryId 
						AND TARGET.ManufacturerId	= SOURCE.ManufacturerId
						AND TARGET.MonthNumber      = SOURCE.MonthNumber
			)	
		WHEN MATCHED THEN
				UPDATE SET
					TARGET.Day31 = 
					CASE WHEN SIGN(SOURCE.Total - TARGET.Total) = -1 THEN 0 ELSE
						SOURCE.Total - TARGET.Total							END
		WHEN NOT MATCHED BY TARGET THEN
			INSERT (CountryId , Day31 , ManufacturerId , FileId , LogId ,DateCreated , DateYear, MonthNumber)				
			VALUES (SOURCE.CountryId , SOURCE.Total , SOURCE.ManufacturerId , SOURCE.FileId , SOURCE.LogId ,
			SOURCE.DateCreated , SOURCE.DateYear, SOURCE.MonthNumber);
	END
	
	UPDATE [Import.ActiveFleetMonthADReport] SET Day1 = 0 WHERE Day1 IS NULL
	UPDATE [Import.ActiveFleetMonthADReport] SET Day2 = 0 WHERE Day2 IS NULL
	UPDATE [Import.ActiveFleetMonthADReport] SET Day3 = 0 WHERE Day3 IS NULL
	UPDATE [Import.ActiveFleetMonthADReport] SET Day4 = 0 WHERE Day4 IS NULL
	UPDATE [Import.ActiveFleetMonthADReport] SET Day5 = 0 WHERE Day5 IS NULL
	UPDATE [Import.ActiveFleetMonthADReport] SET Day6 = 0 WHERE Day6 IS NULL
	UPDATE [Import.ActiveFleetMonthADReport] SET Day7 = 0 WHERE Day7 IS NULL
	UPDATE [Import.ActiveFleetMonthADReport] SET Day8 = 0 WHERE Day8 IS NULL
	UPDATE [Import.ActiveFleetMonthADReport] SET Day9 = 0 WHERE Day9 IS NULL 	
	UPDATE [Import.ActiveFleetMonthADReport] SET Day10 = 0 WHERE Day10 IS NULL
	UPDATE [Import.ActiveFleetMonthADReport] SET Day11 = 0 WHERE Day11 IS NULL
	UPDATE [Import.ActiveFleetMonthADReport] SET Day12 = 0 WHERE Day12 IS NULL
	UPDATE [Import.ActiveFleetMonthADReport] SET Day13 = 0 WHERE Day13 IS NULL
	UPDATE [Import.ActiveFleetMonthADReport] SET Day14 = 0 WHERE Day14 IS NULL
	UPDATE [Import.ActiveFleetMonthADReport] SET Day15 = 0 WHERE Day15 IS NULL
	UPDATE [Import.ActiveFleetMonthADReport] SET Day16 = 0 WHERE Day16 IS NULL
	UPDATE [Import.ActiveFleetMonthADReport] SET Day17 = 0 WHERE Day17 IS NULL
	UPDATE [Import.ActiveFleetMonthADReport] SET Day18 = 0 WHERE Day18 IS NULL
	UPDATE [Import.ActiveFleetMonthADReport] SET Day19 = 0 WHERE Day19 IS NULL
	UPDATE [Import.ActiveFleetMonthADReport] SET Day20 = 0 WHERE Day20 IS NULL
	UPDATE [Import.ActiveFleetMonthADReport] SET Day21 = 0 WHERE Day21 IS NULL
	UPDATE [Import.ActiveFleetMonthADReport] SET Day22 = 0 WHERE Day22 IS NULL
	UPDATE [Import.ActiveFleetMonthADReport] SET Day23 = 0 WHERE Day23 IS NULL
	UPDATE [Import.ActiveFleetMonthADReport] SET Day24 = 0 WHERE Day24 IS NULL
	UPDATE [Import.ActiveFleetMonthADReport] SET Day25 = 0 WHERE Day25 IS NULL
	UPDATE [Import.ActiveFleetMonthADReport] SET Day26 = 0 WHERE Day26 IS NULL
	UPDATE [Import.ActiveFleetMonthADReport] SET Day27 = 0 WHERE Day27 IS NULL
	UPDATE [Import.ActiveFleetMonthADReport] SET Day28 = 0 WHERE Day28 IS NULL
	UPDATE [Import.ActiveFleetMonthADReport] SET Day29 = 0 WHERE Day29 IS NULL
	UPDATE [Import.ActiveFleetMonthADReport] SET Day30 = 0 WHERE Day30 IS NULL
	UPDATE [Import.ActiveFleetMonthADReport] SET Day31 = 0 WHERE Day31 IS NULL
			
			UPDATE [Import.ActiveFleetMonthADReport] SET 
			Total =Day1  + Day2  + Day3  + Day4  + Day5  + Day6  +
			Day7  + Day8  + Day9  + Day10 + Day11 + Day12 + Day13 + Day14 + 
			Day15 + Day16 + Day17 + Day18 + Day19 +
			Day20 + Day21 + Day22 + Day23 + Day24 + Day25 + Day26 + Day27 + 
			Day28 + Day29 + Day30 + Day31
			
		UPDATE [Import.ActiveFleetMonthADReport] SET IsCumul = 0 WHERE IsCumul IS NULL
  
END