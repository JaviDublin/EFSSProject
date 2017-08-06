CREATE TABLE [dbo].[Dimension.TaxCodes] (
    [TaxCodeId]      INT           IDENTITY (1, 1) NOT NULL,
    [CountryId]      INT           NULL,
    [TaxCode]        VARCHAR (50)  NULL,
    [TaxDescription] VARCHAR (255) NULL,
    [Notes]          VARCHAR (255) NULL,
    [CodeStatus]     BIT           NULL,
    [Vat]            FLOAT (53)    NULL,
    PRIMARY KEY CLUSTERED ([TaxCodeId] ASC)
);

