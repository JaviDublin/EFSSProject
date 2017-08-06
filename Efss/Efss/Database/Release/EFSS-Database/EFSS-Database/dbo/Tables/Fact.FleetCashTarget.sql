CREATE TABLE [dbo].[Fact.FleetCashTarget] (
    [RowId]        INT          IDENTITY (1, 1) NOT NULL,
    [GroupId]      INT          NULL,
    [RegionId]     INT          NULL,
    [ReportTypeId] INT          NULL,
    [MonthNumber]  INT          NULL,
    [YearNumber]   INT          NULL,
    [DateUpdated]  DATETIME     NULL,
    [DateCreated]  DATETIME     NULL,
    [CreatedBy]    VARCHAR (20) NULL,
    [UpdatedBy]    VARCHAR (20) NULL,
    [CurrencyId]   INT          NULL,
    [BalanceInit]  MONEY        NULL,
    [BalanceVat]   MONEY        NULL,
    [BalanceEnd]   MONEY        NULL,
    [TargetAmt]    MONEY        NULL,
    PRIMARY KEY CLUSTERED ([RowId] ASC)
);

