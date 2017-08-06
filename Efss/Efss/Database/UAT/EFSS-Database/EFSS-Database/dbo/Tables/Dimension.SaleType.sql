CREATE TABLE [dbo].[Dimension.SaleType] (
    [SaleType]     NCHAR (3)     NOT NULL,
    [SaleTypeName] VARCHAR (50)  NULL,
    [DocSubType]   VARCHAR (100) NULL,
    PRIMARY KEY CLUSTERED ([SaleType] ASC)
);

