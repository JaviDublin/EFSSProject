CREATE TABLE [dbo].[Import.ActiveFleetDayReport] (
    [RowId]        INT        IDENTITY (1, 1) NOT NULL,
    [CountryId]    INT        NULL,
    [Total]        INT        NULL,
    [FileId]       INT        NULL,
    [LogId]        INT        NULL,
    [DateCreated]  DATETIME   NULL,
    [BuyBack]      INT        NULL,
    [BuyBackPCT]   FLOAT (53) NULL,
    [WholeSale]    INT        NULL,
    [WholeSalePCT] FLOAT (53) NULL,
    [Lease]        INT        NULL,
    [LeasePCT]     FLOAT (53) NULL,
    PRIMARY KEY CLUSTERED ([RowId] ASC)
);

