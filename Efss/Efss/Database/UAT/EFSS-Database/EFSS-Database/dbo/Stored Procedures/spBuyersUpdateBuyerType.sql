-- =============================================
-- Author:		Javier
-- Create date: June 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE spBuyersUpdateBuyerType
		@buyerId		INT ,
		@buyerTypeId	INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    UPDATE [Dimension.Buyers] SET
    BuyerTypeId = @buyerTypeId
    WHERE BuyerId = @buyerId
   
   
END