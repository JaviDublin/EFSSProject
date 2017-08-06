CREATE TABLE [dbo].[Fact.Descriptions] (
    [DescriptionId]   INT            IDENTITY (1, 1) NOT NULL,
    [DescriptionText] VARCHAR (2000) NULL,
    PRIMARY KEY CLUSTERED ([DescriptionId] ASC)
);

