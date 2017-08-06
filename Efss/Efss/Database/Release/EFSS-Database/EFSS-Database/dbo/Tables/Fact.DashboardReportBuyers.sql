CREATE TABLE [dbo].[Fact.DashboardReportBuyers] (
    [RowId]       INT            IDENTITY (1, 1) NOT NULL,
    [CountryName] VARCHAR (100)  NULL,
    [BuyerName]   VARCHAR (255)  NULL,
    [DueDtAge]    VARCHAR (50)   NULL,
    [RecvAmt]     MONEY          NULL,
    [DocSubType]  VARCHAR (100)  NULL,
    [Notes]       VARCHAR (2000) NULL,
    [LogId]       INT            NULL,
    [DateCreated] DATETIME       NULL,
    [BuyerId]     INT            NULL,
    [CNK]         VARCHAR (50)   NULL,
    PRIMARY KEY CLUSTERED ([RowId] ASC)
);

