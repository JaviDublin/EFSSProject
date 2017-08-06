CREATE TABLE [dbo].[Fact.FleetCashTargetDay] (
    [PKID]             INT            IDENTITY (1, 1) NOT NULL,
    [RowId]            INT            NULL,
    [DateUpdated]      DATETIME       NULL,
    [Mtd]              MONEY          NULL,
    [Expected]         MONEY          NULL,
    [Remaining]        MONEY          NULL,
    [CollectionTarget] MONEY          NULL,
    [GroupId]          INT            NULL,
    [ReportTypeId]     INT            NULL,
    [NoteExpected]     VARCHAR (1000) NULL,
    [Note]             VARCHAR (1000) NULL,
    PRIMARY KEY CLUSTERED ([PKID] ASC)
);

