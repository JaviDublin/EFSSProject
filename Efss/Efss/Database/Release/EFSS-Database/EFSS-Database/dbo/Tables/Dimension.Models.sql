CREATE TABLE [dbo].[Dimension.Models] (
    [ModelId]     INT         IDENTITY (1, 1) NOT NULL,
    [ModelCodeId] INT         NULL,
    [CompanyId]   INT         NULL,
    [ModelYear]   VARCHAR (4) NULL,
    PRIMARY KEY CLUSTERED ([ModelId] ASC)
);

