-- =============================================
-- Author:		Javier
-- Create date: June 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spBuyersUpdateContact]
	@ContactId			INT			 = NULL,
	@ContactName		VARCHAR(255) = NULL,
	@ContactEmail		VARCHAR(255) = NULL,
	@ContactPhone		VARCHAR(255) = NULL
	
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    UPDATE [Fact.BuyersContact] SET
		ContactName	 = @ContactName , 
		ContactEmail = @ContactEmail,
		ContactPhone = @ContactPhone
    WHERE 
		ContactId = @ContactId
		
		
	UPDATE [Fact.BuyersContact] SET Position = 1 WHERE Position is null
	
END