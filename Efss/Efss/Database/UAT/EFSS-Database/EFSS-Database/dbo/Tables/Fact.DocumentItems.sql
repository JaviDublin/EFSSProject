CREATE TABLE [dbo].[Fact.DocumentItems] (
    [DocItemId]  BIGINT IDENTITY (1, 1) NOT NULL,
    [DocumentId] BIGINT NULL,
    [ItemId]     BIGINT NULL,
    [CompanyId]  INT    NULL,
    PRIMARY KEY CLUSTERED ([DocItemId] ASC)
);

