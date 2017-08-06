-- =============================================
-- Author:		Javier
-- Create date: October 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE spDBImportActiveFleetTransactionsTruncate
		@fileId		VARCHAR(1)
	
AS
BEGIN
	
	SET NOCOUNT ON;
	IF @fileId = '3'
	BEGIN
		TRUNCATE TABLE [Import.ActiveFleetMonthAdds]
	
	END
	ELSE IF @fileId = '4'
	BEGIN
		TRUNCATE TABLE [Import.ActiveFleetMonthDels]

	
	END
	ELSE IF @fileId = '5'
	BEGIN
		TRUNCATE TABLE [Import.ActiveFleetYearAdds]

	END
	ELSE IF @fileId = '6'
	BEGIN
		TRUNCATE TABLE [Import.ActiveFleetYearDels]
	END

   
END