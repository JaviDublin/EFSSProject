﻿CREATE TABLE [dbo].[Staging.ActiveFleetMonthAdds] (
    [VehicleId]               INT             IDENTITY (1, 1) NOT NULL,
    [CompanyCode]             VARCHAR (10)    NULL,
    [AreaCode]                VARCHAR (20)    NULL,
    [Serial]                  VARCHAR (50)    NULL,
    [Plate]                   VARCHAR (20)    NULL,
    [Unit]                    VARCHAR (50)    NULL,
    [TasModelCode]            VARCHAR (50)    NULL,
    [ModelCode]               VARCHAR (50)    NULL,
    [ModelDescription]        VARCHAR (255)   NULL,
    [ModelGroup]              VARCHAR (100)   NULL,
    [ModelYear]               VARCHAR (5)     NULL,
    [ManufacturerName]        VARCHAR (100)   NULL,
    [VehicleClass]            VARCHAR (5)     NULL,
    [VehicleType]             VARCHAR (5)     NULL,
    [VehicleStatus]           VARCHAR (5)     NULL,
    [InvoiceStatus]           VARCHAR (5)     NULL,
    [SaleType]                VARCHAR (5)     NULL,
    [InvoiceNumber]           VARCHAR (20)    NULL,
    [InServiceDate]           DATETIME        NULL,
    [OutServiceDate]          DATETIME        NULL,
    [MSODate]                 DATETIME        NULL,
    [DeliveryDate]            DATETIME        NULL,
    [SaleDate]                DATETIME        NULL,
    [DaysInService]           INT             NULL,
    [BuyerCode]               VARCHAR (10)    NULL,
    [BuyerName]               VARCHAR (255)   NULL,
    [RateClass]               VARCHAR (20)    NULL,
    [CapitalCost]             FLOAT (53)      NULL,
    [Depreciation]            FLOAT (53)      NULL,
    [DepreciationRate]        FLOAT (53)      NULL,
    [DepreciationPCT]         NUMERIC (18, 5) NULL,
    [SalePrice]               FLOAT (53)      NULL,
    [BookValue]               FLOAT (53)      NULL,
    [BuyBackCap]              FLOAT (53)      NULL,
    [Mileage]                 FLOAT (53)      NULL,
    [PaymentMethod]           VARCHAR (30)    NULL,
    [SpecialProgramIndicator] VARCHAR (50)    NULL,
    [VisionCode]              VARCHAR (50)    NULL,
    [PL]                      FLOAT (53)      NULL,
    [LessOr]                  VARCHAR (20)    NULL,
    [BaseAndOptions]          FLOAT (53)      NULL,
    [PDepreciationRate]       FLOAT (53)      NULL,
    [PDepreciationRatePCT]    FLOAT (53)      NULL,
    [SubType]                 VARCHAR (20)    NULL,
    [SaleDocumentNumber]      VARCHAR (50)    NULL,
    [ProgramCap]              FLOAT (53)      NULL,
    [ProgramAcumDepreciation] FLOAT (53)      NULL,
    [Reference]               VARCHAR (50)    NULL,
    [AdjReceivable]           FLOAT (53)      NULL,
    [ReceivableType]          VARCHAR (20)    NULL,
    [AmortizedId]             VARCHAR (20)    NULL,
    [FirstRA]                 VARCHAR (20)    NULL,
    [RADate]                  DATETIME        NULL,
    [DeliveryDate_2]          DATETIME        NULL,
    [OutServiceDate_2]        DATETIME        NULL,
    [CapitalCostFleetCo]      FLOAT (53)      NULL,
    [CountryId]               INT             NULL,
    [CompanyId]               INT             NULL,
    [BuyerId]                 INT             NULL,
    [ManufacturerId]          INT             NULL,
    [ModelCodeId]             INT             NULL,
    [ModelId]                 INT             NULL,
    [ModelDetailId]           INT             NULL,
    [DocumentId]              INT             NULL,
    [FileId]                  INT             NULL,
    [AppVehicleId]            INT             NULL,
    [LogId]                   INT             NULL,
    PRIMARY KEY CLUSTERED ([VehicleId] ASC)
);
