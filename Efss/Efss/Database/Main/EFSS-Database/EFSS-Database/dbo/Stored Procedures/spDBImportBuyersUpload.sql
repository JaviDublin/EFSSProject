-- =============================================
-- Author:		Javier
-- Create date: October 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spDBImportBuyersUpload]
	@CompanyCode		VARCHAR(255) = NULL,
	@BuyerCode			VARCHAR(255) = NULL,
	@BuyerName			VARCHAR(255) = NULL,
	@BuyerAddress1		VARCHAR(255) = NULL,
	@BuyerAddress2		VARCHAR(255) = NULL,
	@BuyerAddress3		VARCHAR(255) = NULL,
	@BuyerAddress4		VARCHAR(255) = NULL,
	@BuyerAddress5		VARCHAR(255) = NULL,
	@BuyerAddress6		VARCHAR(255) = NULL,
	--@BuyerMFG			VARCHAR(255) = NULL,
	--@BuyerDealer		VARCHAR(255) = NULL,
	@BuyerTaxCode		VARCHAR(255) = NULL,
	@BuyerFiscalCode	VARCHAR(255) = NULL,
	@BuyerEmail			VARCHAR(1000) = NULL
		
AS
BEGIN
	
	SET NOCOUNT ON;
	
	
		INSERT INTO [Import.BuyersVNDL]
		(
			CompanyCode,
			BuyerCode,
			BuyerName,
			BuyerAddress1,
			BuyerAddress2,
			BuyerAddress3,
			BuyerAddress4,
			BuyerAddress5,
			BuyerAddress6,
			--BuyerMFG,
			--BuyerDealer,
			BuyerTaxCode,
			BuyerFiscalCode,
			BuyerEmail
		)
		VALUES
		(
			@CompanyCode,
			@BuyerCode,
			@BuyerName,
			@BuyerAddress1,
			@BuyerAddress2,
			@BuyerAddress3,
			@BuyerAddress4,
			@BuyerAddress5,
			@BuyerAddress6,
			--@BuyerMFG,
			--@BuyerDealer,
			@BuyerTaxCode,
			@BuyerFiscalCode,
			@BuyerEmail
		)


    
END