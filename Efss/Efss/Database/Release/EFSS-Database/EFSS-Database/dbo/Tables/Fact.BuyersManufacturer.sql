CREATE TABLE [dbo].[Fact.BuyersManufacturer] (
    [BuyerManufacturerId] INT IDENTITY (1, 1) NOT NULL,
    [BuyerId]             INT NULL,
    [ManufacturerId]      INT NULL,
    PRIMARY KEY CLUSTERED ([BuyerManufacturerId] ASC)
);

