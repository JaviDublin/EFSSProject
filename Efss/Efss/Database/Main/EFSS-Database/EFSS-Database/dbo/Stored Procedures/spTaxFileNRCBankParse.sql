-- =============================================
-- Author:		Javier
-- Create date: September 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spTaxFileNRCBankParse] 
	
AS
BEGIN
	
	SET NOCOUNT ON;

	UPDATE [Fact.FleetTaxReport] SET
		[Fact.FleetTaxReport].BankRegCode = 
			SUBSTRING([Import.TaxFileSP].RowValue , 70 , 29) + ' ' +
			SUBSTRING([Import.TaxFileSP].RowValue , 100 , 32) +
			SUBSTRING([Import.TaxFileSP].RowValue , 133 , 30)
			--SUBSTRING([Import.TaxFileSP].RowValue , 100 , 63)
		,
		[Fact.FleetTaxReport].Processed = 1
		
	FROM 
		[Fact.FleetTaxReport]
	INNER JOIN [Import.TaxFileSP] ON 
		[Fact.FleetTaxReport].Serial =  SUBSTRING([Import.TaxFileSP].RowValue , 168 , 17)
	WHERE 
		[Fact.FleetTaxReport].BankRegCode IS NULL
		
	
END