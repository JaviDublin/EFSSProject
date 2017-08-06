CREATE TABLE [dbo].[Dimension.Buyers] (
    [BuyerId]          INT            IDENTITY (1, 1) NOT NULL,
    [CountryId]        INT            NULL,
    [CompanyId]        INT            NULL,
    [CompanyCode]      VARCHAR (10)   NULL,
    [BuyerCode]        VARCHAR (20)   NULL,
    [ManufacturerCode] VARCHAR (20)   NULL,
    [AreaCode]         VARCHAR (20)   NULL,
    [BuyerName]        VARCHAR (1000) NULL,
    [BuyerTaxCode]     VARCHAR (50)   NULL,
    [BuyerFiscalCode]  VARCHAR (50)   NULL,
    [BuyerTypeId]      INT            NULL,
    [Rate]             INT            NULL,
    PRIMARY KEY CLUSTERED ([BuyerId] ASC)
);

