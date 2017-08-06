-- =============================================
-- Author:		Javier
-- Create date: August 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spReportsDashboardTextFileToExcel]
	
AS
BEGIN
	
	SET NOCOUNT ON;

	SELECT
		SaleDocumentNumber,
		InvoiceDate,
		Serial,
		AreaCode,
		CompanyCode,
		RecvType,
		ManufacturerName,
		VehicleStatus,
		OMU,
		RMSAge,
		RecvAmt,
		OutServiceDate,
		Plate,
		InServiceDate,
		PurchaseOrder,
		PurchInvoiceNumber,
		CapitalCost,
		Depreciation,
		NetRecv,
		RecvDueInd,
		RecvDueDate,
		InvoiceNbr,
		VehicleType,
		SPI,
		ModelCodeVision,
		DueDtAge,
		ClaimDate,
		Unit,
		InvoiceNumber
	FROM [Staging.Dashboard]
  
END