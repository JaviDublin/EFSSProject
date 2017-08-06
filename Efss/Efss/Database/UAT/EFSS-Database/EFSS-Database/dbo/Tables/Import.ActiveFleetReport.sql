CREATE TABLE [dbo].[Import.ActiveFleetReport] (
    [RowId]     INT           IDENTITY (1, 1) NOT NULL,
    [CompanyId] INT           NULL,
    [FileId]    INT           NULL,
    [FileName]  VARCHAR (255) NULL,
    [FileDate]  DATETIME      NULL,
    [Total]     INT           NULL,
    [Active]    INT           NULL,
    [Inactive]  INT           NULL,
    [Suspend]   INT           NULL,
    [Others]    INT           NULL,
    [BuyBack]   INT           NULL,
    [WholeSale] INT           NULL,
    [Lease]     INT           NULL,
    PRIMARY KEY CLUSTERED ([RowId] ASC)
);

