-- =============================================
-- Author:		Javier
-- Create date: September 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spDBManualInvoiceInsert]
			@CountryName		VARCHAR(100) = NULL,
			@CompanyName		VARCHAR(255) = NULL,
			@DocumentType		VARCHAR(50)  = NULL,
			@InvoiceType		VARCHAR(50)  = NULL,
			@InvoiceDate		VARCHAR(50)  = NULL,
			@BuyerName			VARCHAR(255) = NULL,
			@BuyerCode			VARCHAR(50)  = NULL,
			@Serial				VARCHAR(50)  = NULL,
			@Amount				VARCHAR(50)  = NULL,
			@TaxCode			VARCHAR(50)  = NULL,
			@DescriptionName	VARCHAR(200) = NULL,
			@manufacturerCode	VARCHAR(50)  = NULL,
			@address			VARCHAR(255) = NULL
AS
BEGIN
	
	SET NOCOUNT ON;
	
	INSERT INTO [Import.ManualInvoice] 
	(
	CountryName	,	CompanyName	,
	DocumentType,	InvoiceType	,	
	InvoiceDate	,	BuyerName	,	
	BuyerCode	,	Serial		,
	Amount		,	TaxCode		,
	DescriptionName				,
	ManufacturerCode			,
	BuyerAddress

	)
	VALUES
	(
	@CountryName	,	@CompanyName	,
	@DocumentType	,	@InvoiceType	,	
	@InvoiceDate	,	@BuyerName		,	
	@BuyerCode		,	@Serial			,
	@Amount			,	@TaxCode		,
	@DescriptionName					,
	@manufacturerCode					,
	@address
	)
  
END