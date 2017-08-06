-- =============================================
-- Author:		Javier
-- Create date: July 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spDBImportSales]
	
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @FileId				INT			,
			@FileName			VARCHAR(255),
			@FilePath			VARCHAR(4000),
			@FileFormat			VARCHAR(255),
			@FileFormatPath		VARCHAR(4000),
			@DocTypeId			INT,
			@DescriptionTypeId  INT
	SET @FileId			= (SELECT FileId			FROM [Application.Files] WHERE FileCode = 'FSROR')
	SET @FileName		= (SELECT [FileName]		FROM [Application.Files] WHERE FileCode = 'FSROR')
	SET @FilePath		= (SELECT FilePath			FROM [Application.Files] WHERE FileCode = 'FSROR')
	SET @FileFormat		= (SELECT FileFormat		FROM [Application.Files] WHERE FileCode = 'FSROR')
	SET @FileFormatPath = (SELECT FileFormatPath	FROM [Application.Files] WHERE FileCode = 'FSROR')
	
	SET @FilePath		= @FilePath + @FileName
	SET @FileFormatPath = @FileFormatPath + @FileFormat
	
	
	
	TRUNCATE TABLE [Import.SalesOR]
		
	BEGIN TRY
		DECLARE @cmd VARCHAR(2000)
		SET @cmd = 'SELECT * FROM OPENROWSET (BULK ''' + @FilePath + ''', FORMATFILE = ''' 
					+ @FileFormatPath + ''' ) AS FSROR'
		INSERT INTO [Import.SalesOR]
		EXEC (@cmd)
	END TRY
	BEGIN CATCH
		INSERT INTO [Application.FileLogError] 
					(FileId,DateError,ErrorNumber,ErrorMessage,ErrorSeverity,
					ErrorState,ErrorLine,ErrorProcedure)
		SELECT @FileId,GETDATE(),CAST(ERROR_NUMBER() AS VARCHAR(255)),ERROR_MESSAGE() ,
				CAST(ERROR_SEVERITY() AS VARCHAR(255)),CAST(ERROR_STATE() AS VARCHAR(255)),
				CAST(ERROR_LINE()  AS VARCHAR(255)),'spDBImportSales'
	END CATCH
	
	--IF dbo.FileExists(@FileFormatPath) = 0
	--BEGIN
	--	INSERT INTO [Application.FileLogError](FileId,DateError,ErrorMessage,ErrorProcedure)
	--	SELECT @FileId,GETDATE(),'Format File doesnt exists','spDBImportSales'
	--END
	--ELSE
	--BEGIN
		
	--END
END