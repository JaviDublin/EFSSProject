-- =============================================
-- Author:		Javier
-- Create date: July 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spDocumentTypesCheckName]
	
	@documentSubType	VARCHAR(50) = NULL,
	@result				INT	OUTPUT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @finder INT
	SET @finder = (SELECT COUNT(*) FROM [Dimension.DocumentTypes]
					WHERE DocSubType = @documentSubType)
	IF 	@finder = 0
	BEGIN
		SET @result = 0
	END	
	ELSE
	BEGIN
		SET @result = @finder
	END
			

    
END