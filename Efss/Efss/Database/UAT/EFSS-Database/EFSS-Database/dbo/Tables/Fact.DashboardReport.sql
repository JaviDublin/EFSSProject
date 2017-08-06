CREATE TABLE [dbo].[Fact.DashboardReport] (
    [RowId]            INT            IDENTITY (1, 1) NOT NULL,
    [CountryName]      VARCHAR (100)  NULL,
    [ManufacturerName] VARCHAR (100)  NULL,
    [DueDtAge]         VARCHAR (50)   NULL,
    [RecvAmt]          MONEY          NULL,
    [DocSubType]       VARCHAR (100)  NULL,
    [Notes]            VARCHAR (2000) NULL,
    [LogId]            INT            NULL,
    [DateCreated]      DATETIME       NULL,
    [ManufacturerId]   INT            NULL,
    [CNK]              VARCHAR (50)   NULL,
    [GroupName]        VARCHAR (40)   NULL,
    PRIMARY KEY CLUSTERED ([RowId] ASC)
);

