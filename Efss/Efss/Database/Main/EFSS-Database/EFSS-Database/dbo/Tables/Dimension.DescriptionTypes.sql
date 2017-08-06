CREATE TABLE [dbo].[Dimension.DescriptionTypes] (
    [DescriptionTypeId] INT           IDENTITY (1, 1) NOT NULL,
    [DescriptionType]   VARCHAR (100) NULL,
    PRIMARY KEY CLUSTERED ([DescriptionTypeId] ASC)
);

