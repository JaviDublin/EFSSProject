-- =============================================
-- Author:		Javier
-- Create date: May 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE spDocumentsTypeSelect
	@selectType int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	IF @selectType = 0
   BEGIN
		SELECT DocType 
		FROM [Dimension.DocumentTypes]
		WHERE IsManual = 0
		GROUP BY DocType
		ORDER BY DocType DESC
	END
	ELSE IF @selectType = 1
	BEGIN
		SELECT DocType 
		FROM [Dimension.DocumentTypes]
		WHERE IsManual = 1
		GROUP BY DocType
		ORDER BY DocType DESC
	END
	ELSE
	BEGIN
		SELECT DocType 
		FROM [Dimension.DocumentTypes]
		GROUP BY DocType
		ORDER BY DocType DESC
	END
    
END