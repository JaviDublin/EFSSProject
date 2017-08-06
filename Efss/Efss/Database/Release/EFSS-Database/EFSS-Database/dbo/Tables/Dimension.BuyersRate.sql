CREATE TABLE [dbo].[Dimension.BuyersRate] (
    [RateId]           INT           IDENTITY (1, 1) NOT NULL,
    [CompanyCode]      VARCHAR (5)   NULL,
    [BuyerCode]        VARCHAR (10)  NULL,
    [ModelCode]        VARCHAR (20)  NULL,
    [ModelYear]        VARCHAR (2)   NULL,
    [Rate]             INT           NULL,
    [ManufacturerName] VARCHAR (100) NULL,
    PRIMARY KEY CLUSTERED ([RateId] ASC)
);

