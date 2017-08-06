CREATE TABLE [dbo].[Fact.Items] (
    [ItemId]            BIGINT     IDENTITY (1, 1) NOT NULL,
    [DescriptionId]     INT        NULL,
    [DescriptionTypeId] INT        NULL,
    [Value]             FLOAT (53) NULL,
    [Vat]               FLOAT (53) NULL,
    [Total]             FLOAT (53) NULL,
    [ExtrasId]          BIGINT     NULL,
    PRIMARY KEY CLUSTERED ([ItemId] ASC),
    CONSTRAINT [FK_Fact.Items_Dimension.DescriptionTypes] FOREIGN KEY ([DescriptionTypeId]) REFERENCES [dbo].[Dimension.DescriptionTypes] ([DescriptionTypeId])
);

