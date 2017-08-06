-- =============================================
-- Author:		Javier
-- Create date: July 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spDBImportFleetYearAddsReport]
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @month INT
	SET @month = MONTH(GETDATE())
	
	IF @month = 1
	BEGIN
			MERGE 	[Import.ActiveFleetYearADReport] AS TARGET
			USING										
				(
					SELECT
							afya.CountryId , afya.ManufacturerId , afya.LogId , afya.FileId , 
							MONTH(GETDATE())			AS "MonthNumber", 
							YEAR(GETDATE())				AS "DateYear", 
							GETDATE()					AS "DateCreated",
							COUNT(*)					AS "Total",
							COALESCE(afydrp.Total,0)	AS "ReportTotal",
							CASE WHEN afya.ManufacturerId = 45	THEN 
								COUNT(*)						ELSE
							COUNT(*) - COALESCE(afydrp.Total,0) END AS "NewTotal"
						FROM  [Staging.ActiveFleetYearAdds] afya
						LEFT JOIN [Import.ActiveFleetYearADReport] AS afydrp ON
								afydrp.DateYear			= YEAR(GETDATE()) 
							AND afydrp.FileId			= afya.FileId
							AND afydrp.CountryId		= afya.CountryId 
							AND afydrp.ManufacturerId	= afya.ManufacturerId
						GROUP BY 
							afya.CountryId , afya.ManufacturerId , afya.LogId , 
							afya.FileId , afydrp.Total
			) AS SOURCE
			ON 
			(
							TARGET.DateYear			= SOURCE.DateYear 
						AND TARGET.FileId			= SOURCE.FileId
						AND TARGET.CountryId		= SOURCE.CountryId 
						AND TARGET.ManufacturerId	= SOURCE.ManufacturerId
			)
			WHEN MATCHED THEN
				UPDATE SET
					TARGET.Month1 = SOURCE.NewTotal
			WHEN NOT MATCHED BY TARGET THEN
			INSERT (CountryId , Month1 , ManufacturerId , FileId , LogId ,DateCreated , DateYear)
			VALUES (SOURCE.CountryId , SOURCE.NewTotal , SOURCE.ManufacturerId , SOURCE.FileId , SOURCE.LogId ,
			SOURCE.DateCreated , SOURCE.DateYear);
	END
	ELSE IF @month = 2
	BEGIN  
				MERGE 	[Import.ActiveFleetYearADReport] AS TARGET
				USING										
					(
						SELECT
							afya.CountryId , afya.ManufacturerId , afya.LogId , afya.FileId , 
							MONTH(GETDATE())			AS "MonthNumber", 
							YEAR(GETDATE())				AS "DateYear", 
							GETDATE()					AS "DateCreated",
							COUNT(*)					AS "Total",
							COALESCE(afydrp.Total,0)	AS "ReportTotal",
							CASE WHEN afya.ManufacturerId = 45	THEN 
								COUNT(*)						ELSE
							COUNT(*) - COALESCE(afydrp.Total,0) END AS "NewTotal"
						FROM  [Staging.ActiveFleetYearAdds] afya
						LEFT JOIN [Import.ActiveFleetYearADReport] AS afydrp ON
								afydrp.DateYear			= YEAR(GETDATE()) 
							AND afydrp.FileId			= afya.FileId
							AND afydrp.CountryId		= afya.CountryId 
							AND afydrp.ManufacturerId	= afya.ManufacturerId
						GROUP BY 
							afya.CountryId , afya.ManufacturerId , afya.LogId , 
							afya.FileId , afydrp.Total
				) AS SOURCE
				ON 
				(
								TARGET.DateYear			= SOURCE.DateYear 
							AND TARGET.FileId			= SOURCE.FileId
							AND TARGET.CountryId		= SOURCE.CountryId 
							AND TARGET.ManufacturerId	= SOURCE.ManufacturerId
				)
				WHEN MATCHED THEN
					UPDATE SET
						TARGET.Month2 = SOURCE.NewTotal
				WHEN NOT MATCHED BY TARGET THEN
				INSERT (CountryId , Month2 , ManufacturerId , FileId , LogId ,DateCreated , DateYear)
				VALUES (SOURCE.CountryId , SOURCE.NewTotal , SOURCE.ManufacturerId , SOURCE.FileId , SOURCE.LogId ,
				SOURCE.DateCreated , SOURCE.DateYear);
	END
	ELSE IF @month = 3
	BEGIN
				MERGE 	[Import.ActiveFleetYearADReport] AS TARGET
				USING										
					(
						SELECT
							afya.CountryId , afya.ManufacturerId , afya.LogId , afya.FileId , 
							MONTH(GETDATE())			AS "MonthNumber", 
							YEAR(GETDATE())				AS "DateYear", 
							GETDATE()					AS "DateCreated",
							COUNT(*)					AS "Total",
							COALESCE(afydrp.Total,0)	AS "ReportTotal",
							CASE WHEN afya.ManufacturerId = 45	THEN 
								COUNT(*)						ELSE
							COUNT(*) - COALESCE(afydrp.Total,0) END AS "NewTotal"
						FROM  [Staging.ActiveFleetYearAdds] afya
						LEFT JOIN [Import.ActiveFleetYearADReport] AS afydrp ON
								afydrp.DateYear			= YEAR(GETDATE()) 
							AND afydrp.FileId			= afya.FileId
							AND afydrp.CountryId		= afya.CountryId 
							AND afydrp.ManufacturerId	= afya.ManufacturerId
						GROUP BY 
							afya.CountryId , afya.ManufacturerId , afya.LogId , 
							afya.FileId , afydrp.Total
				) AS SOURCE
				ON 
				(
								TARGET.DateYear			= SOURCE.DateYear 
							AND TARGET.FileId			= SOURCE.FileId
							AND TARGET.CountryId		= SOURCE.CountryId 
							AND TARGET.ManufacturerId	= SOURCE.ManufacturerId
				)
				WHEN MATCHED THEN
					UPDATE SET
						TARGET.Month3 = SOURCE.NewTotal
				WHEN NOT MATCHED BY TARGET THEN
				INSERT (CountryId , Month3 , ManufacturerId , FileId , LogId ,DateCreated , DateYear)
				VALUES (SOURCE.CountryId , SOURCE.NewTotal , SOURCE.ManufacturerId , SOURCE.FileId , SOURCE.LogId ,
				SOURCE.DateCreated , SOURCE.DateYear);
	END
	ELSE IF @month = 4
	BEGIN
				MERGE 	[Import.ActiveFleetYearADReport] AS TARGET
				USING										
					(
						SELECT
							afya.CountryId , afya.ManufacturerId , afya.LogId , afya.FileId , 
							MONTH(GETDATE())			AS "MonthNumber", 
							YEAR(GETDATE())				AS "DateYear", 
							GETDATE()					AS "DateCreated",
							COUNT(*)					AS "Total",
							COALESCE(afydrp.Total,0)	AS "ReportTotal",
							CASE WHEN afya.ManufacturerId = 45	THEN 
								COUNT(*)						ELSE
							COUNT(*) - COALESCE(afydrp.Total,0) END AS "NewTotal"
						FROM  [Staging.ActiveFleetYearAdds] afya
						LEFT JOIN [Import.ActiveFleetYearADReport] AS afydrp ON
								afydrp.DateYear			= YEAR(GETDATE()) 
							AND afydrp.FileId			= afya.FileId
							AND afydrp.CountryId		= afya.CountryId 
							AND afydrp.ManufacturerId	= afya.ManufacturerId
						GROUP BY 
							afya.CountryId , afya.ManufacturerId , afya.LogId , 
							afya.FileId , afydrp.Total
				) AS SOURCE
				ON 
				(
								TARGET.DateYear			= SOURCE.DateYear 
							AND TARGET.FileId			= SOURCE.FileId
							AND TARGET.CountryId		= SOURCE.CountryId 
							AND TARGET.ManufacturerId	= SOURCE.ManufacturerId
				)
				WHEN MATCHED THEN
					UPDATE SET
						TARGET.Month4 = SOURCE.NewTotal
				WHEN NOT MATCHED BY TARGET THEN
				INSERT (CountryId , Month4 , ManufacturerId , FileId , LogId ,DateCreated , DateYear)
				VALUES (SOURCE.CountryId , SOURCE.NewTotal , SOURCE.ManufacturerId , SOURCE.FileId , SOURCE.LogId ,
				SOURCE.DateCreated , SOURCE.DateYear);
	END
	ELSE IF @month = 5
	BEGIN
				MERGE 	[Import.ActiveFleetYearADReport] AS TARGET
				USING										
					(
						SELECT
							afya.CountryId , afya.ManufacturerId , afya.LogId , afya.FileId , 
							MONTH(GETDATE())			AS "MonthNumber", 
							YEAR(GETDATE())				AS "DateYear", 
							GETDATE()					AS "DateCreated",
							COUNT(*)					AS "Total",
							COALESCE(afydrp.Total,0)	AS "ReportTotal",
							CASE WHEN afya.ManufacturerId = 45	THEN 
								COUNT(*)						ELSE
							COUNT(*) - COALESCE(afydrp.Total,0) END AS "NewTotal"
						FROM  [Staging.ActiveFleetYearAdds] afya
						LEFT JOIN [Import.ActiveFleetYearADReport] AS afydrp ON
								afydrp.DateYear			= YEAR(GETDATE()) 
							AND afydrp.FileId			= afya.FileId
							AND afydrp.CountryId		= afya.CountryId 
							AND afydrp.ManufacturerId	= afya.ManufacturerId
						GROUP BY 
							afya.CountryId , afya.ManufacturerId , afya.LogId , 
							afya.FileId , afydrp.Total
				) AS SOURCE
				ON 
				(
								TARGET.DateYear			= SOURCE.DateYear 
							AND TARGET.FileId			= SOURCE.FileId
							AND TARGET.CountryId		= SOURCE.CountryId 
							AND TARGET.ManufacturerId	= SOURCE.ManufacturerId
				)
				WHEN MATCHED THEN
					UPDATE SET
						TARGET.Month5 = SOURCE.NewTotal
				WHEN NOT MATCHED BY TARGET THEN
				INSERT (CountryId , Month5 , ManufacturerId , FileId , LogId ,DateCreated , DateYear)
				VALUES (SOURCE.CountryId , SOURCE.NewTotal , SOURCE.ManufacturerId , SOURCE.FileId , SOURCE.LogId ,
				SOURCE.DateCreated , SOURCE.DateYear);
	END
	ELSE IF @month = 6
	BEGIN
				MERGE 	[Import.ActiveFleetYearADReport] AS TARGET
				USING										
					(
						SELECT
							afya.CountryId , afya.ManufacturerId , afya.LogId , afya.FileId , 
							MONTH(GETDATE())			AS "MonthNumber", 
							YEAR(GETDATE())				AS "DateYear", 
							GETDATE()					AS "DateCreated",
							COUNT(*)					AS "Total",
							COALESCE(afydrp.Total,0)	AS "ReportTotal",
							CASE WHEN afya.ManufacturerId = 45	THEN 
								COUNT(*)						ELSE
							COUNT(*) - COALESCE(afydrp.Total,0) END AS "NewTotal"
						FROM  [Staging.ActiveFleetYearAdds] afya
						LEFT JOIN [Import.ActiveFleetYearADReport] AS afydrp ON
								afydrp.DateYear			= YEAR(GETDATE()) 
							AND afydrp.FileId			= afya.FileId
							AND afydrp.CountryId		= afya.CountryId 
							AND afydrp.ManufacturerId	= afya.ManufacturerId
						GROUP BY 
							afya.CountryId , afya.ManufacturerId , afya.LogId , 
							afya.FileId , afydrp.Total
				) AS SOURCE
				ON 
				(
								TARGET.DateYear			= SOURCE.DateYear 
							AND TARGET.FileId			= SOURCE.FileId
							AND TARGET.CountryId		= SOURCE.CountryId 
							AND TARGET.ManufacturerId	= SOURCE.ManufacturerId
				)
				WHEN MATCHED THEN
					UPDATE SET
						TARGET.Month6 = SOURCE.NewTotal
				WHEN NOT MATCHED BY TARGET THEN
				INSERT (CountryId , Month6 , ManufacturerId , FileId , LogId ,DateCreated , DateYear)
				VALUES (SOURCE.CountryId , SOURCE.NewTotal , SOURCE.ManufacturerId , SOURCE.FileId , SOURCE.LogId ,
				SOURCE.DateCreated , SOURCE.DateYear);
	END
	ELSE IF @month = 7
	BEGIN
				MERGE 	[Import.ActiveFleetYearADReport] AS TARGET
				USING										
					(
						SELECT
							afya.CountryId , afya.ManufacturerId , afya.LogId , afya.FileId , 
							MONTH(GETDATE())			AS "MonthNumber", 
							YEAR(GETDATE())				AS "DateYear", 
							GETDATE()					AS "DateCreated",
							COUNT(*)					AS "Total",
							COALESCE(afydrp.Total,0)	AS "ReportTotal",
							CASE WHEN afya.ManufacturerId = 45	THEN 
								COUNT(*)						ELSE
							COUNT(*) - COALESCE(afydrp.Total,0) END AS "NewTotal"
						FROM  [Staging.ActiveFleetYearAdds] afya
						LEFT JOIN [Import.ActiveFleetYearADReport] AS afydrp ON
								afydrp.DateYear			= YEAR(GETDATE()) 
							AND afydrp.FileId			= afya.FileId
							AND afydrp.CountryId		= afya.CountryId 
							AND afydrp.ManufacturerId	= afya.ManufacturerId
						GROUP BY 
							afya.CountryId , afya.ManufacturerId , afya.LogId , 
							afya.FileId , afydrp.Total
				) AS SOURCE
				ON 
				(
								TARGET.DateYear			= SOURCE.DateYear 
							AND TARGET.FileId			= SOURCE.FileId
							AND TARGET.CountryId		= SOURCE.CountryId 
							AND TARGET.ManufacturerId	= SOURCE.ManufacturerId
				)
				WHEN MATCHED THEN
					UPDATE SET
						TARGET.Month7 = SOURCE.NewTotal
				WHEN NOT MATCHED BY TARGET THEN
				INSERT (CountryId , Month7 , ManufacturerId , FileId , LogId ,DateCreated , DateYear)
				VALUES (SOURCE.CountryId , SOURCE.NewTotal , SOURCE.ManufacturerId , SOURCE.FileId , SOURCE.LogId ,
				SOURCE.DateCreated , SOURCE.DateYear);
	END
	ELSE IF @month = 8
	BEGIN
				MERGE 	[Import.ActiveFleetYearADReport] AS TARGET
				USING										
					(
						SELECT
							afya.CountryId , afya.ManufacturerId , afya.LogId , afya.FileId , 
							MONTH(GETDATE())			AS "MonthNumber", 
							YEAR(GETDATE())				AS "DateYear", 
							GETDATE()					AS "DateCreated",
							COUNT(*)					AS "Total",
							COALESCE(afydrp.Total,0)	AS "ReportTotal",
							CASE WHEN afya.ManufacturerId = 45	THEN 
								COUNT(*)						ELSE
							COUNT(*) - COALESCE(afydrp.Total,0) END AS "NewTotal"
						FROM  [Staging.ActiveFleetYearAdds] afya
						LEFT JOIN [Import.ActiveFleetYearADReport] AS afydrp ON
								afydrp.DateYear			= YEAR(GETDATE()) 
							AND afydrp.FileId			= afya.FileId
							AND afydrp.CountryId		= afya.CountryId 
							AND afydrp.ManufacturerId	= afya.ManufacturerId
						GROUP BY 
							afya.CountryId , afya.ManufacturerId , afya.LogId , 
							afya.FileId , afydrp.Total
				) AS SOURCE
				ON 
				(
								TARGET.DateYear			= SOURCE.DateYear 
							AND TARGET.FileId			= SOURCE.FileId
							AND TARGET.CountryId		= SOURCE.CountryId 
							AND TARGET.ManufacturerId	= SOURCE.ManufacturerId
				)
				WHEN MATCHED THEN
					UPDATE SET
						TARGET.Month8 = SOURCE.NewTotal
				WHEN NOT MATCHED BY TARGET THEN
				INSERT (CountryId , Month8 , ManufacturerId , FileId , LogId ,DateCreated , DateYear)
				VALUES (SOURCE.CountryId , SOURCE.NewTotal , SOURCE.ManufacturerId , SOURCE.FileId , SOURCE.LogId ,
				SOURCE.DateCreated , SOURCE.DateYear);
	END
	ELSE IF @month = 9
	BEGIN
				MERGE 	[Import.ActiveFleetYearADReport] AS TARGET
				USING										
					(
						SELECT
							afya.CountryId , afya.ManufacturerId , afya.LogId , afya.FileId , 
							MONTH(GETDATE())			AS "MonthNumber", 
							YEAR(GETDATE())				AS "DateYear", 
							GETDATE()					AS "DateCreated",
							COUNT(*)					AS "Total",
							COALESCE(afydrp.Total,0)	AS "ReportTotal",
							CASE WHEN afya.ManufacturerId = 45	THEN 
								COUNT(*)						ELSE
							COUNT(*) - COALESCE(afydrp.Total,0) END AS "NewTotal"
						FROM  [Staging.ActiveFleetYearAdds] afya
						LEFT JOIN [Import.ActiveFleetYearADReport] AS afydrp ON
								afydrp.DateYear			= YEAR(GETDATE()) 
							AND afydrp.FileId			= afya.FileId
							AND afydrp.CountryId		= afya.CountryId 
							AND afydrp.ManufacturerId	= afya.ManufacturerId
						GROUP BY 
							afya.CountryId , afya.ManufacturerId , afya.LogId , 
							afya.FileId , afydrp.Total
				) AS SOURCE
				ON 
				(
								TARGET.DateYear			= SOURCE.DateYear 
							AND TARGET.FileId			= SOURCE.FileId
							AND TARGET.CountryId		= SOURCE.CountryId 
							AND TARGET.ManufacturerId	= SOURCE.ManufacturerId
				)
				WHEN MATCHED THEN
					UPDATE SET
						TARGET.Month9 = SOURCE.NewTotal
				WHEN NOT MATCHED BY TARGET THEN
				INSERT (CountryId , Month9 , ManufacturerId , FileId , LogId ,DateCreated , DateYear)
				VALUES (SOURCE.CountryId , SOURCE.NewTotal , SOURCE.ManufacturerId , SOURCE.FileId , SOURCE.LogId ,
				SOURCE.DateCreated , SOURCE.DateYear);
	END
	ELSE IF @month = 10
	BEGIN
				MERGE 	[Import.ActiveFleetYearADReport] AS TARGET
				USING										
					(
						SELECT
							afya.CountryId , afya.ManufacturerId , afya.LogId , afya.FileId , 
							MONTH(GETDATE())			AS "MonthNumber", 
							YEAR(GETDATE())				AS "DateYear", 
							GETDATE()					AS "DateCreated",
							COUNT(*)					AS "Total",
							COALESCE(afydrp.Total,0)	AS "ReportTotal",
							CASE WHEN afya.ManufacturerId = 45	THEN 
								COUNT(*)						ELSE
							COUNT(*) - COALESCE(afydrp.Total,0) END AS "NewTotal"
						FROM  [Staging.ActiveFleetYearAdds] afya
						LEFT JOIN [Import.ActiveFleetYearADReport] AS afydrp ON
								afydrp.DateYear			= YEAR(GETDATE()) 
							AND afydrp.FileId			= afya.FileId
							AND afydrp.CountryId		= afya.CountryId 
							AND afydrp.ManufacturerId	= afya.ManufacturerId
						GROUP BY 
							afya.CountryId , afya.ManufacturerId , afya.LogId , 
							afya.FileId , afydrp.Total
				) AS SOURCE
				ON 
				(
								TARGET.DateYear			= SOURCE.DateYear 
							AND TARGET.FileId			= SOURCE.FileId
							AND TARGET.CountryId		= SOURCE.CountryId 
							AND TARGET.ManufacturerId	= SOURCE.ManufacturerId
				)
				WHEN MATCHED THEN
					UPDATE SET
						TARGET.Month10 = SOURCE.NewTotal
				WHEN NOT MATCHED BY TARGET THEN
				INSERT (CountryId , Month10 , ManufacturerId , FileId , LogId ,DateCreated , DateYear)
				VALUES (SOURCE.CountryId , SOURCE.NewTotal , SOURCE.ManufacturerId , SOURCE.FileId , SOURCE.LogId ,
				SOURCE.DateCreated , SOURCE.DateYear);
	END
	ELSE IF @month = 11
	BEGIN
				MERGE 	[Import.ActiveFleetYearADReport] AS TARGET
				USING										
					(
						SELECT
							afya.CountryId , afya.ManufacturerId , afya.LogId , afya.FileId , 
							MONTH(GETDATE())			AS "MonthNumber", 
							YEAR(GETDATE())				AS "DateYear", 
							GETDATE()					AS "DateCreated",
							COUNT(*)					AS "Total",
							COALESCE(afydrp.Total,0)	AS "ReportTotal",
							CASE WHEN afya.ManufacturerId = 45	THEN 
								COUNT(*)						ELSE
							COUNT(*) - COALESCE(afydrp.Total,0) END AS "NewTotal"
						FROM  [Staging.ActiveFleetYearAdds] afya
						LEFT JOIN [Import.ActiveFleetYearADReport] AS afydrp ON
								afydrp.DateYear			= YEAR(GETDATE()) 
							AND afydrp.FileId			= afya.FileId
							AND afydrp.CountryId		= afya.CountryId 
							AND afydrp.ManufacturerId	= afya.ManufacturerId
						GROUP BY 
							afya.CountryId , afya.ManufacturerId , afya.LogId , 
							afya.FileId , afydrp.Total
				) AS SOURCE
				ON 
				(
								TARGET.DateYear			= SOURCE.DateYear 
							AND TARGET.FileId			= SOURCE.FileId
							AND TARGET.CountryId		= SOURCE.CountryId 
							AND TARGET.ManufacturerId	= SOURCE.ManufacturerId
				)
				WHEN MATCHED THEN
					UPDATE SET
						TARGET.Month11 = SOURCE.NewTotal
				WHEN NOT MATCHED BY TARGET THEN
				INSERT (CountryId , Month11 , ManufacturerId , FileId , LogId ,DateCreated , DateYear)
				VALUES (SOURCE.CountryId , SOURCE.NewTotal , SOURCE.ManufacturerId , SOURCE.FileId , SOURCE.LogId ,
				SOURCE.DateCreated , SOURCE.DateYear);
	END
	ELSE IF @month = 12
	BEGIN
				MERGE 	[Import.ActiveFleetYearADReport] AS TARGET
				USING										
					(
						SELECT
							afya.CountryId , afya.ManufacturerId , afya.LogId , afya.FileId , 
							MONTH(GETDATE())			AS "MonthNumber", 
							YEAR(GETDATE())				AS "DateYear", 
							GETDATE()					AS "DateCreated",
							COUNT(*)					AS "Total",
							COALESCE(afydrp.Total,0)	AS "ReportTotal",
							CASE WHEN afya.ManufacturerId = 45	THEN 
								COUNT(*)						ELSE
							COUNT(*) - COALESCE(afydrp.Total,0) END AS "NewTotal"
						FROM  [Staging.ActiveFleetYearAdds] afya
						LEFT JOIN [Import.ActiveFleetYearADReport] AS afydrp ON
								afydrp.DateYear			= YEAR(GETDATE()) 
							AND afydrp.FileId			= afya.FileId
							AND afydrp.CountryId		= afya.CountryId 
							AND afydrp.ManufacturerId	= afya.ManufacturerId
						GROUP BY 
							afya.CountryId , afya.ManufacturerId , afya.LogId , 
							afya.FileId , afydrp.Total
				) AS SOURCE
				ON 
				(
								TARGET.DateYear			= SOURCE.DateYear 
							AND TARGET.FileId			= SOURCE.FileId
							AND TARGET.CountryId		= SOURCE.CountryId 
							AND TARGET.ManufacturerId	= SOURCE.ManufacturerId
				)
				WHEN MATCHED THEN
					UPDATE SET
						TARGET.Month12 = SOURCE.NewTotal
				WHEN NOT MATCHED BY TARGET THEN
				INSERT (CountryId , Month12 , ManufacturerId , FileId , LogId ,DateCreated , DateYear)
				VALUES (SOURCE.CountryId , SOURCE.NewTotal , SOURCE.ManufacturerId , SOURCE.FileId , SOURCE.LogId ,
				SOURCE.DateCreated , SOURCE.DateYear);
	END
		
	
	
	UPDATE [Import.ActiveFleetYearADReport] SET Month1  = 0 WHERE Month1 IS NULL 
	UPDATE [Import.ActiveFleetYearADReport] SET Month2  = 0 WHERE Month2 IS NULL 
	UPDATE [Import.ActiveFleetYearADReport] SET Month3  = 0 WHERE Month3 IS NULL 
	UPDATE [Import.ActiveFleetYearADReport] SET Month4  = 0 WHERE Month4 IS NULL 
	UPDATE [Import.ActiveFleetYearADReport] SET Month5  = 0 WHERE Month5 IS NULL 
	UPDATE [Import.ActiveFleetYearADReport] SET Month6  = 0 WHERE Month6 IS NULL 
	UPDATE [Import.ActiveFleetYearADReport] SET Month7  = 0 WHERE Month7 IS NULL 
	UPDATE [Import.ActiveFleetYearADReport] SET Month8  = 0 WHERE Month8 IS NULL 
	UPDATE [Import.ActiveFleetYearADReport] SET Month9  = 0 WHERE Month9 IS NULL 
	UPDATE [Import.ActiveFleetYearADReport] SET Month10 = 0 WHERE Month10 IS NULL 
	UPDATE [Import.ActiveFleetYearADReport] SET Month11 = 0 WHERE Month11 IS NULL 
	UPDATE [Import.ActiveFleetYearADReport] SET Month12 = 0 WHERE Month12 IS NULL 
			
			
	UPDATE [Import.ActiveFleetYearADReport] SET 
		Total =Month1  + Month2  + Month3  + Month4  + Month5  + Month6  +
		Month7  + Month8  + Month9  + Month10 + Month11 + Month12
	
	
	  
END