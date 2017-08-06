﻿CREATE TABLE [dbo].[GEFleet] (
    [Serial]                       CHAR (17)     NOT NULL,
    [cVinCheckDigit]               VARCHAR (2)   NULL,
    [Unit]                         CHAR (7)      NULL,
    [Plate]                        VARCHAR (10)  NULL,
    [cPlatePrev]                   VARCHAR (10)  NULL,
    [cPlateDummy]                  VARCHAR (10)  NULL,
    [ModelCode]                    CHAR (4)      NULL,
    [DeliveryDate_Planned]         DATETIME      NULL,
    [DeliveryDate_Vision]          DATETIME      NULL,
    [StartDatePayment]             DATETIME      NULL,
    [cCarportCode]                 CHAR (7)      NULL,
    [CarportInDate]                DATETIME      NULL,
    [CarportRecDate]               DATETIME      NULL,
    [CarportNotifDate]             DATETIME      NULL,
    [PdiDate]                      DATETIME      NULL,
    [RfrDate]                      DATETIME      NULL,
    [CarportOutDate]               DATETIME      NULL,
    [cTitleNo]                     CHAR (8)      NULL,
    [TitleInDate]                  DATETIME      NULL,
    [InServiceDate]                DATETIME      NULL,
    [cRegType]                     CHAR (1)      NULL,
    [RegDate]                      DATETIME      NULL,
    [RegDateDummy]                 DATETIME      NULL,
    [ReRegDate]                    DATETIME      NULL,
    [SaleDateCalc]                 DATETIME      NULL,
    [SaleDateReal]                 DATETIME      NULL,
    [SaleDate_Fix]                 BIT           NULL,
    [StationOutDate]               DATETIME      NULL,
    [ReturnDate]                   DATETIME      NULL,
    [InActiveDate_Vision]          DATETIME      NULL,
    [OrVenCode_Ordered]            INT           NULL,
    [OrVenCode_Vision]             INT           NULL,
    [OrVenCode_Ext]                INT           NULL,
    [Po]                           NUMERIC (18)  NULL,
    [PoArea]                       NUMERIC (18)  NULL,
    [cOrderRefManuf]               VARCHAR (50)  NULL,
    [CapCost]                      FLOAT (53)    NULL,
    [BaseOpt]                      FLOAT (53)    NULL,
    [BookValue]                    FLOAT (53)    NULL,
    [DeprRate]                     FLOAT (53)    NULL,
    [cKbaTsn]                      CHAR (3)      NULL,
    [cKbaHsn]                      CHAR (4)      NULL,
    [cKbaTypeKey]                  VARCHAR (10)  NULL,
    [ContractYear]                 INT           NULL,
    [cContractType]                VARCHAR (3)   NULL,
    [cContractType_Source]         VARCHAR (20)  NULL,
    [cContractType_Order]          VARCHAR (3)   NULL,
    [cContractType_Title]          VARCHAR (3)   NULL,
    [cContractType_Vision]         VARCHAR (3)   NULL,
    [cContractType_Vision_FleetCo] VARCHAR (3)   NULL,
    [cContractType_Vision_OpCo]    VARCHAR (3)   NULL,
    [Area_FleetCo]                 INT           NULL,
    [Area_OpCo]                    INT           NULL,
    [cSaleType]                    VARCHAR (2)   NULL,
    [cKeyCode]                     VARCHAR (12)  NULL,
    [KeyNumber]                    INT           NULL,
    [KmStart]                      INT           NULL,
    [Radio]                        BIT           NULL,
    [cRadioCode]                   VARCHAR (12)  NULL,
    [cCarCode]                     VARCHAR (20)  NULL,
    [cCarCode_Make]                VARCHAR (3)   NULL,
    [MinHpDays]                    INT           NULL,
    [MaxHpDays]                    INT           NULL,
    [HpGraceDays]                  INT           NULL,
    [DeprMode]                     INT           NULL,
    [MaxMileageTotal]              FLOAT (53)    NULL,
    [MaxMileagePerMonth]           FLOAT (53)    NULL,
    [MileagePenaltyPerKm]          FLOAT (53)    NULL,
    [MileageCreditPerKm]           FLOAT (53)    NULL,
    [cTyreSize]                    VARCHAR (50)  NULL,
    [Ccm_Title]                    INT           NULL,
    [Kw_Title]                     INT           NULL,
    [cColourCode_Title]            VARCHAR (2)   NULL,
    [cColourManuf]                 VARCHAR (250) NULL,
    [cFuelType_Title]              VARCHAR (2)   NULL,
    [InFleetMonth]                 DATETIME      NULL,
    [DeFleetMonth]                 DATETIME      NULL,
    [TransferInMonth]              DATETIME      NULL,
    [TransferOutMonth]             DATETIME      NULL,
    [MonthEnd_Update]              DATETIME      NULL,
    [cMonthEnd_Comment]            VARCHAR (200) NULL,
    [DeletionStatus]               BIT           NULL,
    [cDeletionStatusComment]       VARCHAR (250) NULL,
    [DeletionDate]                 DATETIME      NULL,
    [BlockDate]                    DATETIME      NULL,
    [BlockMileage]                 INT           NULL,
    [cBlockStatus]                 VARCHAR (3)   NULL,
    [FltLoadFlag]                  BIT           NULL,
    [FltLoadDate]                  DATETIME      NULL,
    [ImportDate_Ext]               DATETIME      NULL,
    [UpdateDate_Ext]               DATETIME      NULL,
    [UpdateDate_Hertz]             DATETIME      NULL,
    [cUpdateSource_Hertz]          VARCHAR (20)  NULL,
    [CO2]                          FLOAT (53)    NULL
);

