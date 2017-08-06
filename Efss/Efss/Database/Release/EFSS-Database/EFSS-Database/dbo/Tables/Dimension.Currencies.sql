CREATE TABLE [dbo].[Dimension.Currencies] (
    [CurrencyId]   SMALLINT        IDENTITY (1, 1) NOT NULL,
    [CurrencyCode] VARCHAR (5)     NULL,
    [CurrencyName] VARCHAR (100)   NULL,
    [Rate]         DECIMAL (12, 5) NULL,
    PRIMARY KEY CLUSTERED ([CurrencyId] ASC)
);

