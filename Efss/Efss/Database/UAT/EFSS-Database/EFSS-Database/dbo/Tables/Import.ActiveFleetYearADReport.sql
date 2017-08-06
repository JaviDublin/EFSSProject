CREATE TABLE [dbo].[Import.ActiveFleetYearADReport] (
    [RowId]          INT         IDENTITY (1, 1) NOT NULL,
    [CountryId]      INT         NULL,
    [Total]          INT         NULL,
    [Month1]         INT         NULL,
    [Month2]         INT         NULL,
    [Month3]         INT         NULL,
    [Month4]         INT         NULL,
    [Month5]         INT         NULL,
    [Month6]         INT         NULL,
    [Month7]         INT         NULL,
    [Month8]         INT         NULL,
    [Month9]         INT         NULL,
    [Month10]        INT         NULL,
    [Month11]        INT         NULL,
    [Month12]        INT         NULL,
    [FileId]         INT         NULL,
    [LogId]          INT         NULL,
    [DateCreated]    DATETIME    NULL,
    [DateYear]       VARCHAR (4) NULL,
    [ManufacturerId] INT         NULL,
    PRIMARY KEY CLUSTERED ([RowId] ASC)
);

