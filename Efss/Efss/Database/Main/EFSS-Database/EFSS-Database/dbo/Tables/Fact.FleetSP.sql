CREATE TABLE [dbo].[Fact.FleetSP] (
    [RowId]       INT           IDENTITY (1, 1) NOT NULL,
    [Serial]      VARCHAR (50)  NULL,
    [CO2]         INT           NULL,
    [ITVSerial]   VARCHAR (50)  NULL,
    [FuelType]    VARCHAR (20)  NULL,
    [Notes]       VARCHAR (255) NULL,
    [TaxCode]     VARCHAR (5)   NULL,
    [TaxPCT]      FLOAT (53)    NULL,
    [VehicleId]   INT           NULL,
    [MSODate]     DATETIME      NULL,
    [Unit]        VARCHAR (50)  NULL,
    [VehicleCode] VARCHAR (10)  NULL,
    [EngineSize]  VARCHAR (20)  NULL,
    PRIMARY KEY CLUSTERED ([RowId] ASC)
);

