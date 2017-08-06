CREATE TABLE [dbo].[Import.ManualInvoice] (
    [RowId]            INT            IDENTITY (1, 1) NOT NULL,
    [CountryName]      VARCHAR (100)  NULL,
    [CompanyName]      VARCHAR (255)  NULL,
    [DocumentType]     VARCHAR (50)   NULL,
    [InvoiceType]      VARCHAR (50)   NULL,
    [InvoiceDate]      VARCHAR (50)   NULL,
    [BuyerName]        VARCHAR (255)  NULL,
    [BuyerCode]        VARCHAR (255)  NULL,
    [Serial]           VARCHAR (50)   NULL,
    [Amount]           VARCHAR (50)   NULL,
    [TaxCode]          VARCHAR (50)   NULL,
    [DescriptionName]  VARCHAR (2000) NULL,
    [ManufacturerCode] VARCHAR (10)   NULL,
    [BuyerAddress]     VARCHAR (100)  NULL,
    PRIMARY KEY CLUSTERED ([RowId] ASC)
);

