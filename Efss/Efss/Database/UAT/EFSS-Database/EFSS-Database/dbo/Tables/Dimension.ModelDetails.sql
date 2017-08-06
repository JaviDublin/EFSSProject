CREATE TABLE [dbo].[Dimension.ModelDetails] (
    [ModelDetailId]        INT           IDENTITY (1, 1) NOT NULL,
    [ModelId]              INT           NULL,
    [TasModelCode]         VARCHAR (20)  NULL,
    [ModelGroup]           VARCHAR (255) NULL,
    [ModelDescription]     VARCHAR (255) NULL,
    [ManufacturerId]       INT           NULL,
    [RateClass]            VARCHAR (20)  NULL,
    [EngineSize]           VARCHAR (20)  NULL,
    [FuelType]             VARCHAR (10)  NULL,
    [EstimatedCap]         FLOAT (53)    NULL,
    [EstimatedDeprRate]    FLOAT (53)    NULL,
    [EstimatedVolBonus]    FLOAT (53)    NULL,
    [EstimatedVBAmtPeriod] FLOAT (53)    NULL,
    [FastSpec]             VARCHAR (20)  NULL,
    [ReceivableStoreDate]  DATETIME      NULL,
    [Position]             SMALLINT      NULL,
    [LogId]                INT           NULL,
    PRIMARY KEY CLUSTERED ([ModelDetailId] ASC)
);

