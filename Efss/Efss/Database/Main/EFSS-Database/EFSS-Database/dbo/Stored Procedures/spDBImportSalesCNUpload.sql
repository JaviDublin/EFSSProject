-- =============================================
-- Author:		Javier
-- Create date: October 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spDBImportSalesCNUpload]
		@rowValue			VARCHAR(500) = NULL
AS
BEGIN
	
	SET NOCOUNT ON;
	
	INSERT INTO [Import.SalesCN]
	(
		CompanyCode,
		Serial,
		AreaCode,
		Unit,
		TaxDescription1,
		SaleDocumentNumber,
		ModelCode,
		Plate,
		BuyerCode,
		CrediNoteDate,
		CreditNoteNumber,
		Mileage,
		MSODate,
		OldInvoiceNumber,
		SaleDate
	)
	VALUES
	(
		SUBSTRING(@rowValue,1,2)    ,	 
		SUBSTRING(@rowValue,6,17)   ,
		SUBSTRING(@rowValue,24,5)   ,		 
		SUBSTRING(@rowValue,30,10)  ,
		SUBSTRING(@rowValue,41,1)   , 
		SUBSTRING(@rowValue,43,6)   ,
		SUBSTRING(@rowValue,65,4)   ,		 
		SUBSTRING(@rowValue,99,10)  ,
		SUBSTRING(@rowValue,125,5)  ,     
		SUBSTRING(@rowValue,364,8)  ,
		SUBSTRING(@rowValue,388,7)  ,
		SUBSTRING(@rowValue,396,7)  ,
		SUBSTRING(@rowValue,404,8)  ,
		SUBSTRING(@rowValue,413,7)  ,
		SUBSTRING(@rowValue,421,8)  
	)
	
	
		--SUBSTRING(@rowValue,1,2) as "CompanyCode" ,	 
		--SUBSTRING(@rowValue,6,17) as "Serial",
		--SUBSTRING(@rowValue,24,5) as "AreaCode",		 
		--SUBSTRING(@rowValue,30,10) as "Unit",
		--SUBSTRING(@rowValue,41,1) as "TaxDescription1", 
		--SUBSTRING(@rowValue,43,6) as "SaleDocumentNumber",
		--SUBSTRING(@rowValue,65,4) as "ModelCode",		 
		--SUBSTRING(@rowValue,99,10) as "Plate",
		--SUBSTRING(@rowValue,125,5) as "BuyerCode",     
		----SUBSTRING(@line4,357,6)  as "Number"  ,
		--SUBSTRING(@rowValue,364,8)  as "CreditNoteDate"  ,
		----SUBSTRING(@line4,373,14)  as "InvoiceNet"  ,
		--SUBSTRING(@rowValue,388,7)  as "CreditNoteNumber"  ,
		--SUBSTRING(@rowValue,396,7)  as "Mileage"  ,
		--SUBSTRING(@rowValue,404,8)  as "MSODate"  ,
		--SUBSTRING(@rowValue,413,7)  as "InvoiceNumber"  ,
		--SUBSTRING(@rowValue,421,8)  as "SaleDate"  


    
END