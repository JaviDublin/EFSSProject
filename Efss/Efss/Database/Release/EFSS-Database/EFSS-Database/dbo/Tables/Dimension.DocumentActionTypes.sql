CREATE TABLE [dbo].[Dimension.DocumentActionTypes] (
    [ActionTypeId] INT           IDENTITY (1, 1) NOT NULL,
    [ActionName]   VARCHAR (100) NULL,
    PRIMARY KEY CLUSTERED ([ActionTypeId] ASC)
);

