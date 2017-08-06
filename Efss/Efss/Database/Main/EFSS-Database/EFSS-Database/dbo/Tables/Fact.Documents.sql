CREATE TABLE [dbo].[Fact.Documents] (
    [DocumentId]     BIGINT        IDENTITY (1, 1) NOT NULL,
    [DocumentTypeId] INT           NULL,
    [CompanyId]      INT           NULL,
    [BuyerId]        INT           NULL,
    [DocumentNumber] VARCHAR (100) NULL,
    [LogId]          INT           NULL,
    [DateCreated]    DATETIME      NULL,
    [RacfId]         VARCHAR (20)  NULL,
    PRIMARY KEY CLUSTERED ([DocumentId] ASC)
);

