CREATE TABLE [dbo].[Fact.BuyerExceptions] (
    [ExceptionId]  INT           IDENTITY (1, 1) NOT NULL,
    [BuyerId]      INT           NULL,
    [ReportValue1] VARCHAR (255) NULL,
    [ReportValue2] VARCHAR (255) NULL,
    PRIMARY KEY CLUSTERED ([ExceptionId] ASC)
);

