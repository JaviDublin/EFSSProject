﻿CREATE TABLE [dbo].[Staging.Buyers] (
    [RowId]            INT           IDENTITY (1, 1) NOT NULL,
    [CompanyCode]      NCHAR (2)     NULL,
    [BuyerCode]        VARCHAR (10)  NULL,
    [BuyerName]        VARCHAR (255) NULL,
    [BuyerTaxCode]     VARCHAR (50)  NULL,
    [BuyerFiscalCode]  VARCHAR (50)  NULL,
    [BuyerAddress1]    VARCHAR (255) NULL,
    [BuyerAddress2]    VARCHAR (255) NULL,
    [BuyerAddress3]    VARCHAR (255) NULL,
    [BuyerAddress4]    VARCHAR (255) NULL,
    [BuyerAddress5]    VARCHAR (255) NULL,
    [BuyerAddress6]    VARCHAR (255) NULL,
    [ContactName]      VARCHAR (255) NULL,
    [ContactEmail]     VARCHAR (255) NULL,
    [ContactPhone]     VARCHAR (255) NULL,
    [ContactFax]       VARCHAR (255) NULL,
    [BuyerId]          INT           NULL,
    [BuyerAddressId]   INT           NULL,
    [ContactId]        INT           NULL,
    [ManufacturerCode] VARCHAR (20)  NULL,
    [ManufacturerId]   INT           NULL,
    [ContactTypeId]    INT           NULL,
    [ShortName]        VARCHAR (20)  NULL,
    [CountryId]        INT           NULL,
    [CompanyId]        INT           NULL,
    [LogId]            INT           NULL,
    PRIMARY KEY CLUSTERED ([RowId] ASC)
);

