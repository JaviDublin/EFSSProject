-- =============================================
-- Author:		Javier
-- Create date: May 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spDocumentsSubTypeSelect]
		@selectType int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

   IF @selectType = 0
   BEGIN
		SELECT DocSubType 
		FROM [Dimension.DocumentTypes]
		WHERE IsManual = 0 AND DocSubType IS NOT NULL
		GROUP BY DocSubType
		ORDER BY DocSubType
	END
	ELSE IF @selectType = 1
	BEGIN
		SELECT DocSubType 
		FROM [Dimension.DocumentTypes]
		WHERE IsManual = 1 AND DocSubType IS NOT NULL
		GROUP BY DocSubType
		ORDER BY DocSubType
	END
	ELSE IF @selectType = 2
	BEGIN
		SELECT DocSubType 
		FROM [Dimension.DocumentTypes]
		WHERE DocSubType IS NOT NULL
		GROUP BY DocSubType
		ORDER BY DocSubType
	END
	ELSE IF @selectType = 3
	BEGIN
		SELECT DocSubType 
		FROM [Dimension.DocumentTypes]
		WHERE DocSubType IN (SELECT DocSubType FROM [Dimension.ReceivableTypes])
		AND DocSubType IS NOT NULL
		GROUP BY DocSubType
		ORDER BY DocSubType
	
	END
	
END