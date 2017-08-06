-- =============================================
-- Author:		Javier
-- Create date: July 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spDBImportActiveFleetDayReport]
	
AS
BEGIN
	
	SET NOCOUNT ON;
	
	DECLARE @Counter INT
	SET @Counter = (SELECT COUNT(*) FROM [Import.ActiveFleetDayReport] WHERE 
						CONVERT(VARCHAR(11),DateCreated , 103) = CONVERT(VARCHAR(11),GETDATE() , 103))
	IF @Counter = 0
	BEGIN
		DECLARE @FileId	INT	
		SET @FileId	= (SELECT FileId FROM [Application.Files] WHERE FileCode = 'FAFRD')
		
		INSERT INTO [Import.ActiveFleetDayReport] (CountryId , Total , FileId , LogId , DateCreated)
		
		SELECT 
			[Staging.ActiveFleetDay].CountryId ,COUNT(*) , @FileId , 
			[Staging.ActiveFleetDay].LogId , [Application.FileLog].DateLog
		FROM [Staging.ActiveFleetDay]
		INNER JOIN [Application.FileLog] ON 
			 [Staging.ActiveFleetDay].LogId = [Application.FileLog].LogId
		GROUP BY 
			[Staging.ActiveFleetDay].CountryId , [Staging.ActiveFleetDay].LogId ,
			[Application.FileLog].DateLog
		ORDER BY 
			[Staging.ActiveFleetDay].CountryId , [Staging.ActiveFleetDay].LogId
			
			
			
		-- BuyBack	
		UPDATE [Import.ActiveFleetDayReport] SET 
		[Import.ActiveFleetDayReport].BuyBack = bb.BuyBack
		FROM [Import.ActiveFleetDayReport]
		INNER JOIN
		(
			SELECT CountryId , Count(*) AS "BuyBack" , LogId
			FROM [Staging.ActiveFleetDay]
			WHERE VehicleType in ('A','D')
			GROUP BY CountryId, LogId
		) AS bb
		ON [Import.ActiveFleetDayReport].CountryId = bb.CountryId and 
			[Import.ActiveFleetDayReport].LogId = bb.LogId

		UPDATE [Import.ActiveFleetDayReport] SET BuyBack = 0 WHERE BuyBack IS NULL

		-- Wholesale
		UPDATE [Import.ActiveFleetDayReport] SET 
		[Import.ActiveFleetDayReport].WholeSale = ws.WholeSale
		FROM [Import.ActiveFleetDayReport]
		INNER JOIN
		(
			SELECT CountryId , Count(*) AS "WholeSale", LogId 
			FROM [Staging.ActiveFleetDay]
			WHERE VehicleType in ('O')
			GROUP BY CountryId, LogId
		) AS ws
		ON [Import.ActiveFleetDayReport].CountryId = ws.CountryId and 
			[Import.ActiveFleetDayReport].LogId = ws.LogId
			
		UPDATE [Import.ActiveFleetDayReport] SET WholeSale = 0 WHERE WholeSale IS NULL

		-- Lease
		UPDATE [Import.ActiveFleetDayReport] SET 
		[Import.ActiveFleetDayReport].Lease = ls.Lease
		FROM [Import.ActiveFleetDayReport]
		INNER JOIN
		(
			SELECT CountryId , Count(*) AS "Lease" , LogId
			FROM [Staging.ActiveFleetDay]
			WHERE VehicleType in ('L')
			GROUP BY CountryId, LogId
		) AS ls
		ON [Import.ActiveFleetDayReport].CountryId = ls.CountryId and 
			[Import.ActiveFleetDayReport].LogId = ls.LogId
			
		UPDATE [Import.ActiveFleetDayReport] SET Lease = 0 WHERE Lease IS NULL
		
		
		
		UPDATE [Import.ActiveFleetDayReport] SET 
			BuyBackPCT	= CONVERT(NUMERIC(5,2),ROUND(Buyback * 100.00 / Total,2))
		WHERE BuyBackPCT IS NULL

		UPDATE [Import.ActiveFleetDayReport] SET 
			WholeSalePCT	= CONVERT(NUMERIC(5,2),ROUND(WholeSale * 100.00 / Total,2))
		WHERE WholeSalePCT IS NULL
		
		UPDATE [Import.ActiveFleetDayReport] SET 
			LeasePCT	= CONVERT(NUMERIC(5,2),ROUND(Lease * 100.00 / Total,2))	
		WHERE LeasePCT IS NULL	
		
	END
	  
END