CREATE TABLE [dbo].[Dimension.BuyerTypes] (
    [BuyerTypeId] INT           IDENTITY (1, 1) NOT NULL,
    [BuyerType]   VARCHAR (100) NULL,
    PRIMARY KEY CLUSTERED ([BuyerTypeId] ASC)
);

