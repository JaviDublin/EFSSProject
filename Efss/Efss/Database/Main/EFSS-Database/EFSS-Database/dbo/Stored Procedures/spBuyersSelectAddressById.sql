-- =============================================
-- Author:		Javier
-- Create date: June 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spBuyersSelectAddressById]
		@buyerId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @counter INT
	SET @counter = (SELECT COUNT(*) FROM [Fact.BuyersAddress] WHERE BuyerId = @buyerId)
	
	IF @counter = 0
	BEGIN
		SELECT @buyerId as BuyerId ,
		'' as "ContactTypeName",
		'No Address Available' as "BuyerAddress1" ,
		'' as "BuyerAddress2",
		'' as "BuyerAddress3",
		'' as "BuyerAddress4",
		'' as "BuyerAddress5",
		'' as "BuyerAddress6",
		1 as "Position"
	END
	ELSE
	BEGIN
	
		SELECT 
		--[Fact.BuyersAddress].BuyerAddressId ,
		[Fact.BuyersAddress].BuyerId,
		[Dimension.ContactTypes].ContactTypeName as "ContactTypeName",
		[Fact.BuyersAddress].BuyerAddress1 ,
		[Fact.BuyersAddress].BuyerAddress2,
		[Fact.BuyersAddress].BuyerAddress3,
		[Fact.BuyersAddress].BuyerAddress4,
		[Fact.BuyersAddress].BuyerAddress5,
		[Fact.BuyersAddress].BuyerAddress6,
		[Fact.BuyersAddress].Position
		FROM [Fact.BuyersAddress]
		inner join [Dimension.ContactTypes] on 
			[Fact.BuyersAddress].ContactTypeId = [Dimension.ContactTypes].ContactTypeId
		WHERE [Fact.BuyersAddress].BuyerId = @buyerId
	END
	
	
	
	
    
END