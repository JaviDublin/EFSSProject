﻿-- =============================================
-- Author:		Javier
-- Create date: October 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE spDBImportDashboardUpload
		@SaleDocumentNumber		VARCHAR(50) = NULL,
		@InvoiceDate			VARCHAR(50) = NULL,
		@Serial					VARCHAR(50) = NULL,
		@AreaCode				VARCHAR(50) = NULL,
		@CompanyCode			VARCHAR(50) = NULL,
		@RecvType				VARCHAR(50) = NULL,
		@ManufacturerName		VARCHAR(50) = NULL,
		@VehicleStatus			VARCHAR(50) = NULL,
		@OMU					VARCHAR(50) = NULL,
		@RMSAge					VARCHAR(50) = NULL,
		@RecvAmt				VARCHAR(50) = NULL,
		@OutServiceDate			VARCHAR(50) = NULL,
		@Plate					VARCHAR(50) = NULL,
		@InServiceDate			VARCHAR(50) = NULL,
		@PurchaseOrder			VARCHAR(50) = NULL,
		@PurchInvoiceNumber		VARCHAR(50) = NULL,
		@CapitalCost			VARCHAR(50) = NULL,
		@Depreciation			VARCHAR(50) = NULL,
		@NetRecv				VARCHAR(50) = NULL,
		@RecvDueInd				VARCHAR(50) = NULL,
		@RecvDueDate			VARCHAR(50) = NULL,
		@InvoiceNbr				VARCHAR(50) = NULL,
		@VehicleType			VARCHAR(50) = NULL,
		@SPI					VARCHAR(50) = NULL,
		@ModelCodeVision		VARCHAR(50) = NULL,
		@DueDtAge				VARCHAR(50) = NULL,
		@ClaimDate				VARCHAR(50) = NULL,
		@Unit					VARCHAR(50) = NULL,
		@InvoiceNumber			VARCHAR(50) = NULL
	
AS
BEGIN
	
	SET NOCOUNT ON;
	
	INSERT INTO [Import.Dashboard]
	(
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
	
	)
	VALUES
	(
		@SaleDocumentNumber,
		@InvoiceDate,
		@Serial,
		@AreaCode,
		@CompanyCode,
		@RecvType,
		@ManufacturerName,
		@VehicleStatus,
		@OMU,
		@RMSAge,
		@RecvAmt,
		@OutServiceDate,
		@Plate,
		@InServiceDate,
		@PurchaseOrder,
		@PurchInvoiceNumber,
		@CapitalCost,
		@Depreciation,
		@NetRecv,
		@RecvDueInd,
		@RecvDueDate,
		@InvoiceNbr,
		@VehicleType,
		@SPI,
		@ModelCodeVision,
		@DueDtAge,
		@ClaimDate,
		@Unit,
		@InvoiceNumber
	)

    
END