-- =============================================
-- Author:		Javier
-- Create date: July 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spDocumentTypesInsert]
		
		@documentSubType VARCHAR(50) = NULL,
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

	-- INVOICE (1)
	INSERT INTO [Dimension.DocumentTypes]
	(DocType , DocSubType ,IsManual , PrimeAccount , SubAccount , CostCenter , 
	Activity , Division , IsActive)
	VALUES
	('INVOICE' , @documentSubType , 1 , @primeAccount , @subAccount , @costCenter,
	@activity , @division , 1)
	
	
	-- CREDIT NOTE (2)
	INSERT INTO [Dimension.DocumentTypes]
	(DocType , DocSubType ,IsManual , PrimeAccount , SubAccount , CostCenter , 
	Activity , Division , IsActive)
	VALUES
	('CREDIT NOTE' , @documentSubType , 1 , @primeAccount , @subAccount , @costCenter,
	@activity , @division , 1)
    
END