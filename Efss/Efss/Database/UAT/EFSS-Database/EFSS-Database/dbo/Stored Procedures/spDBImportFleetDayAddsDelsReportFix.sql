-- =============================================
-- Author:		Javier
-- Create date: February 2012
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spDBImportFleetDayAddsDelsReportFix]
	
		@year	int,
		@fileId int
AS
BEGIN
	
	SET NOCOUNT ON;
	
	DECLARE @Countries TABLE (CountryId INT)
	INSERT INTO @Countries
	SELECT 
		CountryId 
	FROM [Import.ActiveFleetMonthADReportCumul] 
	GROUP BY 
		CountryId 
	ORDER BY 
		CountryId
	
	DECLARE @Manufacturers TABLE (ManufacturerId INT)
	INSERT INTO @Manufacturers
	SELECT 
		ManufacturerId 
	FROM [Import.ActiveFleetMonthADReportCumul] 
	GROUP BY 
		ManufacturerId 
	ORDER BY 
		ManufacturerId
	
	DECLARE @Min_Country		INT,
			@Max_Country		INT,
			@Min_Manufacturer	INT,
			@Max_Manufacturer	INT,
			@Min_Day			INT,
			@Max_Day			INT,
			@Min_Month			INT,
			@Max_Month			INT,
			@RowId				INT,
			@RowId_prev			INT,
			@Total				INT
	SET @Min_Country		= (SELECT MIN(CountryId)		FROM @Countries)
	SET @Max_Country		= (SELECT MAX(CountryId)		FROM @Countries)
	SET @Min_Manufacturer	= (SELECT MIN(ManufacturerId)	FROM @Manufacturers)
	SET @Max_Manufacturer	= (SELECT MAX(ManufacturerId)	FROM @Manufacturers)
	SET @Min_Day			= 1
	SET @Max_Day			= 31
	SET @Min_Month			= 3
	SET @Max_Month			= 3
	
	WHILE @Min_Month < = @Max_Month
	BEGIN
		WHILE @Min_Day <= @Max_Day
		BEGIN
			WHILE @Min_Country < = @Max_Country
			BEGIN
				WHILE @Min_Manufacturer < = @Max_Manufacturer
				BEGIN
					SET @RowId = 
						(
							SELECT
								RowId
							FROM 
								[Import.ActiveFleetMonthADReportCumul]						
							WHERE
								DateYear		= @year
							AND
								MonthNumber		= @Min_Month
							AND 
								ManufacturerId	= @Min_Manufacturer
							AND
								CountryId		= @Min_Country
							AND 
								IsCumul			= 0
							AND 
								FileId			 = @fileId
							
							
						)
					
					IF @RowId IS NOT NULL
					BEGIN
						
						IF @Min_Month = 1
						BEGIN
							UPDATE [Import.ActiveFleetMonthADReportCumul] SET
								Total = Day1
							WHERE RowId = @RowId
							
							UPDATE [Import.ActiveFleetMonthADReportCumul] SET
								Day2 = Day2 - Total ,
								Total = Total + (Day2 - Total)
							WHERE RowId = @RowId AND Day2 >= Total
							
							UPDATE [Import.ActiveFleetMonthADReportCumul] SET
								Day3 = Day3 - Total ,
								Total = Total + (Day3 - Total)
							WHERE RowId = @RowId AND Day3 >= Total
							
							UPDATE [Import.ActiveFleetMonthADReportCumul] SET
								Day4 = Day4 - Total ,
								Total = Total + (Day4 - Total)
							WHERE RowId = @RowId AND Day4 >= Total
							
							UPDATE [Import.ActiveFleetMonthADReportCumul] SET
								Day5 = Day5 - Total ,
								Total = Total + (Day5 - Total)
							WHERE RowId = @RowId AND Day5 >= Total
							
							UPDATE [Import.ActiveFleetMonthADReportCumul] SET
								Day6 = Day6 - Total ,
								Total = Total + (Day6 - Total)
							WHERE RowId = @RowId AND Day6 >= Total
							
							UPDATE [Import.ActiveFleetMonthADReportCumul] SET
								Day7 = Day7 - Total ,
								Total = Total + (Day7 - Total)
							WHERE RowId = @RowId AND Day7 >= Total
							
							UPDATE [Import.ActiveFleetMonthADReportCumul] SET
								Day8 = Day8 - Total ,
								Total = Total + (Day8 - Total)
							WHERE RowId = @RowId AND Day8 >= Total
							
							UPDATE [Import.ActiveFleetMonthADReportCumul] SET
								Day9 = Day9 - Total ,
								Total = Total + (Day9 - Total)
							WHERE RowId = @RowId AND Day9 >= Total
							
							UPDATE [Import.ActiveFleetMonthADReportCumul] SET
								Day10 = Day10 - Total ,
								Total = Total + (Day10 - Total)
							WHERE RowId = @RowId AND Day10 >= Total
							
							UPDATE [Import.ActiveFleetMonthADReportCumul] SET
								Day11 = Day11 - Total ,
								Total = Total + (Day11 - Total)
							WHERE RowId = @RowId AND Day11 >= Total
							
							UPDATE [Import.ActiveFleetMonthADReportCumul] SET
								Day12 = Day12 - Total ,
								Total = Total + (Day12 - Total)
							WHERE RowId = @RowId AND Day12 >= Total
							
							UPDATE [Import.ActiveFleetMonthADReportCumul] SET
								Day13 = Day13 - Total ,
								Total = Total + (Day13 - Total)
							WHERE RowId = @RowId AND Day13 >= Total
							
							UPDATE [Import.ActiveFleetMonthADReportCumul] SET
								Day14 = Day14 - Total ,
								Total = Total + (Day14 - Total)
							WHERE RowId = @RowId AND Day14 >= Total
							
							UPDATE [Import.ActiveFleetMonthADReportCumul] SET
								Day15 = Day15 - Total ,
								Total = Total + (Day15 - Total)
							WHERE RowId = @RowId AND Day15 >= Total
							
							UPDATE [Import.ActiveFleetMonthADReportCumul] SET
								Day16 = Day16 - Total ,
								Total = Total + (Day16 - Total)
							WHERE RowId = @RowId AND Day16 >= Total
							
							UPDATE [Import.ActiveFleetMonthADReportCumul] SET
								Day17 = Day17 - Total ,
								Total = Total + (Day17 - Total)
							WHERE RowId = @RowId AND Day17 >= Total
							
							UPDATE [Import.ActiveFleetMonthADReportCumul] SET
								Day18 = Day18 - Total ,
								Total = Total + (Day18 - Total)
							WHERE RowId = @RowId AND Day18 >= Total
							
							UPDATE [Import.ActiveFleetMonthADReportCumul] SET
								Day19 = Day19 - Total ,
								Total = Total + (Day19 - Total)
							WHERE RowId = @RowId AND Day19 >= Total
							
							UPDATE [Import.ActiveFleetMonthADReportCumul] SET
								Day20 = Day20 - Total ,
								Total = Total + (Day20 - Total)
							WHERE RowId = @RowId AND Day20 >= Total
							
							UPDATE [Import.ActiveFleetMonthADReportCumul] SET
								Day21 = Day21 - Total ,
								Total = Total + (Day21 - Total)
							WHERE RowId = @RowId AND Day21 >= Total
							
							UPDATE [Import.ActiveFleetMonthADReportCumul] SET
								Day22 = Day22 - Total ,
								Total = Total + (Day22 - Total)
							WHERE RowId = @RowId AND Day22 >= Total
							
							UPDATE [Import.ActiveFleetMonthADReportCumul] SET
								Day23 = Day23 - Total ,
								Total = Total + (Day23 - Total)
							WHERE RowId = @RowId AND Day23 >= Total
							
							UPDATE [Import.ActiveFleetMonthADReportCumul] SET
								Day24 = Day24 - Total ,
								Total = Total + (Day24 - Total)
							WHERE RowId = @RowId AND Day24 >= Total
							
							UPDATE [Import.ActiveFleetMonthADReportCumul] SET
								Day25 = Day25 - Total ,
								Total = Total + (Day25 - Total)
							WHERE RowId = @RowId AND Day25 >= Total
							
							UPDATE [Import.ActiveFleetMonthADReportCumul] SET
								Day26 = Day26 - Total ,
								Total = Total + (Day26 - Total)
							WHERE RowId = @RowId AND Day26 >= Total
							
							UPDATE [Import.ActiveFleetMonthADReportCumul] SET
								Day27 = Day27 - Total ,
								Total = Total + (Day27 - Total)
							WHERE RowId = @RowId AND Day27 >= Total
							
							UPDATE [Import.ActiveFleetMonthADReportCumul] SET
								Day28 = Day28 - Total ,
								Total = Total + (Day28 - Total)
							WHERE RowId = @RowId AND Day28 >= Total
							
							UPDATE [Import.ActiveFleetMonthADReportCumul] SET
								Day29 = Day29 - Total ,
								Total = Total + (Day29 - Total)
							WHERE RowId = @RowId AND Day29 >= Total
							
							UPDATE [Import.ActiveFleetMonthADReportCumul] SET
								Day30 = Day30 - Total ,
								Total = Total + (Day30 - Total)
							WHERE RowId = @RowId AND Day30 >= Total
							
							UPDATE [Import.ActiveFleetMonthADReportCumul] SET
								Day31 = Day31 - Total ,
								Total = Total + (Day31 - Total)
							WHERE RowId = @RowId AND Day31 >= Total
							
							UPDATE [Import.ActiveFleetMonthADReportCumul] SET
								IsCumul = 1
							WHERE RowId = @RowId 
							
						END
						ELSE
						BEGIN
							SET @RowId_prev = 
								(
									SELECT RowId 
									FROM [Import.ActiveFleetMonthADReportCumul]
									WHERE 
										CountryId		= @Min_Country 
									AND ManufacturerId	= @Min_Manufacturer
									AND MonthNumber		= @Min_Month - 1 
									AND FileId			= @fileId
								)
							IF @RowId_prev IS NOT NULL
							BEGIN
								SET @Total = 
									(
									SELECT Total 
									FROM [Import.ActiveFleetMonthADReportCumul]
									WHERE RowId = @RowId_prev
									)
							END
							ELSE
							BEGIN
								SET @Total = 0
							END
						
							UPDATE [Import.ActiveFleetMonthADReportCumul] SET
								Total = @Total
							WHERE RowId = @RowId
							
							UPDATE [Import.ActiveFleetMonthADReportCumul] SET
								Day1 = Day1 - Total,
								Total = Total - (Day1 - Total)
							WHERE RowId = @RowId and Day1 >= Total
							
							UPDATE [Import.ActiveFleetMonthADReportCumul] SET
								Day2 = Day2 - Total ,
								Total = Total + (Day2 - Total)
							WHERE RowId = @RowId AND Day2 >= Total
							
							UPDATE [Import.ActiveFleetMonthADReportCumul] SET
								Day3 = Day3 - Total ,
								Total = Total + (Day3 - Total)
							WHERE RowId = @RowId AND Day3 >= Total
							
							UPDATE [Import.ActiveFleetMonthADReportCumul] SET
								Day4 = Day4 - Total ,
								Total = Total + (Day4 - Total)
							WHERE RowId = @RowId AND Day4 >= Total
							
							UPDATE [Import.ActiveFleetMonthADReportCumul] SET
								Day5 = Day5 - Total ,
								Total = Total + (Day5 - Total)
							WHERE RowId = @RowId AND Day5 >= Total
							
							UPDATE [Import.ActiveFleetMonthADReportCumul] SET
								Day6 = Day6 - Total ,
								Total = Total + (Day6 - Total)
							WHERE RowId = @RowId AND Day6 >= Total
							
							UPDATE [Import.ActiveFleetMonthADReportCumul] SET
								Day7 = Day7 - Total ,
								Total = Total + (Day7 - Total)
							WHERE RowId = @RowId AND Day7 >= Total
							
							UPDATE [Import.ActiveFleetMonthADReportCumul] SET
								Day8 = Day8 - Total ,
								Total = Total + (Day8 - Total)
							WHERE RowId = @RowId AND Day8 >= Total
							
							UPDATE [Import.ActiveFleetMonthADReportCumul] SET
								Day9 = Day9 - Total ,
								Total = Total + (Day9 - Total)
							WHERE RowId = @RowId AND Day9 >= Total
							
							UPDATE [Import.ActiveFleetMonthADReportCumul] SET
								Day10 = Day10 - Total ,
								Total = Total + (Day10 - Total)
							WHERE RowId = @RowId AND Day10 >= Total
							
							UPDATE [Import.ActiveFleetMonthADReportCumul] SET
								Day11 = Day11 - Total ,
								Total = Total + (Day11 - Total)
							WHERE RowId = @RowId AND Day11 >= Total
							
							UPDATE [Import.ActiveFleetMonthADReportCumul] SET
								Day12 = Day12 - Total ,
								Total = Total + (Day12 - Total)
							WHERE RowId = @RowId AND Day12 >= Total
							
							UPDATE [Import.ActiveFleetMonthADReportCumul] SET
								Day13 = Day13 - Total ,
								Total = Total + (Day13 - Total)
							WHERE RowId = @RowId AND Day13 >= Total
							
							UPDATE [Import.ActiveFleetMonthADReportCumul] SET
								Day14 = Day14 - Total ,
								Total = Total + (Day14 - Total)
							WHERE RowId = @RowId AND Day14 >= Total
							
							UPDATE [Import.ActiveFleetMonthADReportCumul] SET
								Day15 = Day15 - Total ,
								Total = Total + (Day15 - Total)
							WHERE RowId = @RowId AND Day15 >= Total
							
							UPDATE [Import.ActiveFleetMonthADReportCumul] SET
								Day16 = Day16 - Total ,
								Total = Total + (Day16 - Total)
							WHERE RowId = @RowId AND Day16 >= Total
							
							UPDATE [Import.ActiveFleetMonthADReportCumul] SET
								Day17 = Day17 - Total ,
								Total = Total + (Day17 - Total)
							WHERE RowId = @RowId AND Day17 >= Total
							
							UPDATE [Import.ActiveFleetMonthADReportCumul] SET
								Day18 = Day18 - Total ,
								Total = Total + (Day18 - Total)
							WHERE RowId = @RowId AND Day18 >= Total
							
							UPDATE [Import.ActiveFleetMonthADReportCumul] SET
								Day19 = Day19 - Total ,
								Total = Total + (Day19 - Total)
							WHERE RowId = @RowId AND Day19 >= Total
							
							UPDATE [Import.ActiveFleetMonthADReportCumul] SET
								Day20 = Day20 - Total ,
								Total = Total + (Day20 - Total)
							WHERE RowId = @RowId AND Day20 >= Total
							
							UPDATE [Import.ActiveFleetMonthADReportCumul] SET
								Day21 = Day21 - Total ,
								Total = Total + (Day21 - Total)
							WHERE RowId = @RowId AND Day21 >= Total
							
							UPDATE [Import.ActiveFleetMonthADReportCumul] SET
								Day22 = Day22 - Total ,
								Total = Total + (Day22 - Total)
							WHERE RowId = @RowId AND Day22 >= Total
							
							UPDATE [Import.ActiveFleetMonthADReportCumul] SET
								Day23 = Day23 - Total ,
								Total = Total + (Day23 - Total)
							WHERE RowId = @RowId AND Day23 >= Total
							
							UPDATE [Import.ActiveFleetMonthADReportCumul] SET
								Day24 = Day24 - Total ,
								Total = Total + (Day24 - Total)
							WHERE RowId = @RowId AND Day24 >= Total
							
							UPDATE [Import.ActiveFleetMonthADReportCumul] SET
								Day25 = Day25 - Total ,
								Total = Total + (Day25 - Total)
							WHERE RowId = @RowId AND Day25 >= Total
							
							UPDATE [Import.ActiveFleetMonthADReportCumul] SET
								Day26 = Day26 - Total ,
								Total = Total + (Day26 - Total)
							WHERE RowId = @RowId AND Day26 >= Total
							
							UPDATE [Import.ActiveFleetMonthADReportCumul] SET
								Day27 = Day27 - Total ,
								Total = Total + (Day27 - Total)
							WHERE RowId = @RowId AND Day27 >= Total
							
							UPDATE [Import.ActiveFleetMonthADReportCumul] SET
								Day28 = Day28 - Total ,
								Total = Total + (Day28 - Total)
							WHERE RowId = @RowId AND Day28 >= Total
							
							UPDATE [Import.ActiveFleetMonthADReportCumul] SET
								Day29 = Day29 - Total ,
								Total = Total + (Day29 - Total)
							WHERE RowId = @RowId AND Day29 >= Total
							
							UPDATE [Import.ActiveFleetMonthADReportCumul] SET
								Day30 = Day30 - Total ,
								Total = Total + (Day30 - Total)
							WHERE RowId = @RowId AND Day30 >= Total
							
							UPDATE [Import.ActiveFleetMonthADReportCumul] SET
								Day31 = Day31 - Total ,
								Total = Total + (Day31 - Total)
							WHERE RowId = @RowId AND Day31 >= Total
							
							UPDATE [Import.ActiveFleetMonthADReportCumul] SET
								IsCumul = 1
							WHERE RowId = @RowId 
						
							PRINT 
							CONVERT(VARCHAR,@Min_Day) + '/' + 
							CONVERT(VARCHAR,@Min_Month) + '/' + 
							CONVERT(VARCHAR,@year) + ' -- Country:  ' +
							CONVERT(VARCHAR,@Min_Country) + ' -- Manufacturer: ' + 
							CONVERT(VARCHAR,@Min_Manufacturer)  + ' -- RowId:  ' + 
							CONVERT(VARCHAR,@RowId) + ' -- RowIdPREV:  ' + 
							CONVERT(VARCHAR,@RowId_prev) + ' -- Total:  ' + 
							CONVERT(VARCHAR,@Total) 
						END
						
						
					END
					
					
					SET @Min_Manufacturer = @Min_Manufacturer + 1
				END
				
				SET @Min_Manufacturer = (SELECT MIN(ManufacturerId)	FROM @Manufacturers)
				SET @Min_Country = @Min_Country + 1
			END
			
			SET @Min_Country = (SELECT MIN(CountryId) FROM @Countries)
			SET @Min_Day = @Min_Day + 1
		END
		
		SET @Min_Day = 1
		SET @Min_Month = @Min_Month + 1
	END

   
END