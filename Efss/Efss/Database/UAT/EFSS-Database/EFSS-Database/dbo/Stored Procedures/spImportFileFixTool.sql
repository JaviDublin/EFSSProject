-- =============================================
-- Author:		Javier
-- Create date: April 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spImportFileFixTool]
			@fixtype INT

AS
BEGIN
	
		IF @fixtype = 3
		BEGIN
				UPDATE [Dimension.Buyers] SET
				BuyerCode		= LTRIM(RTRIM(BuyerCode)),
				BuyerName		= LTRIM(RTRIM(BuyerName)),
				BuyerTaxCode	= LTRIM(RTRIM(BuyerTaxCode)),
				BuyerFiscalCode = LTRIM(RTRIM(BuyerFiscalCode))

				UPDATE [Fact.BuyersAddress] SET
				BuyerAddress1 = LTRIM(RTRIM(BuyerAddress1)),
				BuyerAddress2 = LTRIM(RTRIM(BuyerAddress2)),
				BuyerAddress3 = LTRIM(RTRIM(BuyerAddress3)),
				BuyerAddress4 = LTRIM(RTRIM(BuyerAddress4)),
				BuyerAddress5 = LTRIM(RTRIM(BuyerAddress5)),
				BuyerAddress6 = LTRIM(RTRIM(BuyerAddress6))

				UPDATE [Fact.BuyersContact] SET
				ContactEmail= LTRIM(RTRIM(ContactEmail)),
				ContactFax	= LTRIM(RTRIM(ContactFax)),
				ContactName	= LTRIM(RTRIM(ContactName)),
				ContactPhone= LTRIM(RTRIM(ContactPhone))
		END
		ELSE IF @fixtype = 4
		BEGIN
			DELETE FROM dbo.[Fact.BuyersContact] WHERE
					ContactEmail IS NULL AND ContactName IS NULL AND ContactPhone IS NULL AND ContactFax IS NULL
		END
		
END