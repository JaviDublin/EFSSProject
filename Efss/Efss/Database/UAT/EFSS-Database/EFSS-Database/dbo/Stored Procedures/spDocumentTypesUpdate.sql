-- =============================================
-- Author:		Javier
-- Create date: July 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spDocumentTypesUpdate]
	@documentSubType VARCHAR(50),
	@primeAccount    VARCHAR(50) = NULL,
	@subAccount		 VARCHAR(50) = NULL,
	@costCenter		 VARCHAR(50) = NULL,
	@activity		 VARCHAR(20) = NULL,
	@division		 VARCHAR(20) = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	UPDATE [Dimension.DocumentTypes]
	SET 
		PrimeAccount = @primeAccount , 
		SubAccount   = @subAccount   ,
		CostCenter   = @costCenter   ,
		Activity     = @activity     ,
		Division     = @division 
	WHERE
		DocSubType = @documentSubType
  
END