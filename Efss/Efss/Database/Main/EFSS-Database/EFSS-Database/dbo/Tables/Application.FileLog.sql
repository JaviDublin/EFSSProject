CREATE TABLE [dbo].[Application.FileLog] (
    [LogId]   INT      IDENTITY (1, 1) NOT NULL,
    [FileId]  INT      NULL,
    [DateLog] DATETIME NULL,
    PRIMARY KEY CLUSTERED ([LogId] ASC)
);

