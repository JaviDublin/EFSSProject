-- =============================================
-- Author:		Javier
-- Create date: June 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spFleetExportToExcel]
		@fileId		 INT,
		@columnNames VARCHAR(1000),
		@conditions  VARCHAR(1000) = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


	DECLARE @TABLE VARCHAR(50)
	SET @TABLE = (SELECT TableStaging FROM [Application.Files] WHERE FileId = @fileId)
	
	DECLARE @SQLSTATMENT VARCHAR(4000)
	
	IF @conditions IS NULL
	BEGIN
		SET @SQLSTATMENT = 'SELECT ' + @columnNames + ' FROM ' + @TABLE
		EXEC (@SQLSTATMENT)
	END
	ELSE
	BEGIN
		
		SET @SQLSTATMENT = 'SELECT ' + @columnNames + ' FROM ' + @TABLE + @conditions
		EXEC (@SQLSTATMENT)
	
	END

	
	
END