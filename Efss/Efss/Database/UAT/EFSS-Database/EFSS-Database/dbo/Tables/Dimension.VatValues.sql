CREATE TABLE [dbo].[Dimension.VatValues] (
    [ValueId]    INT        NOT NULL,
    [CountryId]  INT        NULL,
    [CountryVat] FLOAT (53) NULL,
    [StartDate]  DATETIME   NULL,
    [EndDate]    DATETIME   NULL,
    PRIMARY KEY CLUSTERED ([ValueId] ASC)
);

