CREATE TABLE [dbo].[Import.ActiveFleetMonthReport] (
    [RowId]       INT         IDENTITY (1, 1) NOT NULL,
    [CountryId]   INT         NULL,
    [CompanyId]   INT         NULL,
    [Total]       INT         NULL,
    [Active]      INT         NULL,
    [Conversion]  INT         NULL,
    [Delivered]   INT         NULL,
    [Inactive]    INT         NULL,
    [Suspend]     INT         NULL,
    [Future_ISD]  INT         NULL,
    [Other]       INT         NULL,
    [FileId]      INT         NULL,
    [LogId]       INT         NULL,
    [DateCreated] DATETIME    NULL,
    [DateYear]    VARCHAR (4) NULL,
    [DateMonth]   VARCHAR (2) NULL,
    PRIMARY KEY CLUSTERED ([RowId] ASC)
);

