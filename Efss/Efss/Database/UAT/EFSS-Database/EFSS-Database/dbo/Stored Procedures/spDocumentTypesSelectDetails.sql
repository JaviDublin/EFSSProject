-- =============================================
-- Author:		Javier
-- Create date: July 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spDocumentTypesSelectDetails]
		@docSubType VARCHAR(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT 
		PrimeAccount , SubAccount ,CostCenter , Activity , Division
	FROM [Dimension.DocumentTypes]
	WHERE 
		DocSubType = @docSubType
	GROUP BY 
		PrimeAccount , SubAccount ,CostCenter , Activity , Division
  
END