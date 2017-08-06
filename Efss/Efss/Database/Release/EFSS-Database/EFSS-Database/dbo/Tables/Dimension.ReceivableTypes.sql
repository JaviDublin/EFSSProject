CREATE TABLE [dbo].[Dimension.ReceivableTypes] (
    [RecvTypeId] INT           IDENTITY (1, 1) NOT NULL,
    [RecvType]   VARCHAR (20)  NULL,
    [DocSubType] VARCHAR (100) NULL,
    PRIMARY KEY CLUSTERED ([RecvTypeId] ASC)
);

