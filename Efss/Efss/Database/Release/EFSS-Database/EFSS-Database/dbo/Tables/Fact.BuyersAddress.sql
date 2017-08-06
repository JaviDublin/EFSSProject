CREATE TABLE [dbo].[Fact.BuyersAddress] (
    [BuyerAddressId] INT            IDENTITY (1, 1) NOT NULL,
    [ContactTypeId]  INT            NULL,
    [BuyerId]        INT            NULL,
    [BuyerAddress1]  VARCHAR (1000) NULL,
    [BuyerAddress2]  VARCHAR (1000) NULL,
    [BuyerAddress3]  VARCHAR (1000) NULL,
    [BuyerAddress4]  VARCHAR (1000) NULL,
    [BuyerAddress5]  VARCHAR (1000) NULL,
    [BuyerAddress6]  VARCHAR (1000) NULL,
    [IsDeleted]      BIT            NULL,
    [Position]       INT            NULL,
    PRIMARY KEY CLUSTERED ([BuyerAddressId] ASC)
);

