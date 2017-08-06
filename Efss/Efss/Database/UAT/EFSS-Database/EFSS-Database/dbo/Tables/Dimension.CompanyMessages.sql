CREATE TABLE [dbo].[Dimension.CompanyMessages] (
    [MessageId] INT            IDENTITY (1, 1) NOT NULL,
    [EmailId]   INT            NULL,
    [Title]     VARCHAR (255)  NULL,
    [Header]    VARCHAR (255)  NULL,
    [Body]      VARCHAR (4000) NULL,
    [Footer]    VARCHAR (1000) NULL,
    PRIMARY KEY CLUSTERED ([MessageId] ASC)
);

