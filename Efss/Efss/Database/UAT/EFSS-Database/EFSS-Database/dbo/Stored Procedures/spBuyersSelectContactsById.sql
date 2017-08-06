-- =============================================
-- Author:		Javier
-- Create date: June 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spBuyersSelectContactsById]
			@buyerId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @counter INT
	SET @counter = (SELECT COUNT(*) FROM [Fact.BuyersContact] WHERE BuyerId = @buyerId)

	IF @counter = 0
	BEGIN
		SELECT 
		0 AS "ContactId" ,
		@buyerId AS "BuyerId",
		'' AS "ContactTypeName",
		'No Contact Available' AS "ContactName",
		'' AS "ContactEmail",
		'' AS "ContactPhone",
		'' AS "ContactFax",
		1  AS "Position"
	END
	ELSE
	BEGIN
		SELECT 
		[Fact.BuyersContact].ContactId ,
		[Fact.BuyersContact].BuyerId,
		[Dimension.ContactTypes].ContactTypeName ,
		[Fact.BuyersContact].ContactName,
		[Fact.BuyersContact].ContactEmail,
		[Fact.BuyersContact].ContactPhone,
		[Fact.BuyersContact].ContactFax,
		[Fact.BuyersContact].Position
		FROM [Fact.BuyersContact]
		inner join [Dimension.ContactTypes] ON 
				[Fact.BuyersContact].ContactTypeId = [Dimension.ContactTypes].ContactTypeId
		WHERE [Fact.BuyersContact].BuyerId = @buyerId
	END

	
   
END