CREATE TABLE [dbo].[Dimension.Companies] (
    [CompanyId]         INT           IDENTITY (1, 1) NOT NULL,
    [CompanyTypeId]     SMALLINT      NULL,
    [CountryId]         INT           NULL,
    [CompanyCode]       VARCHAR (5)   NULL,
    [CompanyName]       VARCHAR (255) NULL,
    [CompanyFiscalCode] VARCHAR (100) NULL,
    [ShortFiscalCode]   VARCHAR (50)  NULL,
    [OracleCode]        VARCHAR (10)  NULL,
    [GroupId]           INT           NULL,
    [GroupName]         VARCHAR (50)  NULL,
    [EmailDublin]       VARCHAR (100) NULL,
    [EmailId]           INT           NULL,
    PRIMARY KEY CLUSTERED ([CompanyId] ASC)
);

