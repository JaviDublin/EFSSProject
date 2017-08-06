CREATE TABLE [dbo].[Fact.BuyersContact] (
    [ContactId]     INT            IDENTITY (1, 1) NOT NULL,
    [ContactTypeId] INT            NULL,
    [BuyerId]       INT            NULL,
    [ContactName]   VARCHAR (1000) NULL,
    [ContactEmail]  VARCHAR (2000) NULL,
    [ContactPhone]  VARCHAR (1000) NULL,
    [ContactFax]    VARCHAR (1000) NULL,
    [IsDeleted]     BIT            NULL,
    [Position]      INT            NULL,
    PRIMARY KEY CLUSTERED ([ContactId] ASC)
);

