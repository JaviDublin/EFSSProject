CREATE TABLE [dbo].[Dimension.Countries] (
    [CountryId]   INT           IDENTITY (1, 1) NOT NULL,
    [CountryCode] VARCHAR (10)  NULL,
    [CountryName] VARCHAR (100) NULL,
    [CountryVat]  FLOAT (53)    NULL,
    [RegionId]    SMALLINT      NULL,
    [CurrencyId]  SMALLINT      NULL,
    PRIMARY KEY CLUSTERED ([CountryId] ASC)
);

