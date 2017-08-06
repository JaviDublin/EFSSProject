CREATE TABLE [dbo].[Dimension.CompanyTypes] (
    [CompanyTypeId] SMALLINT     IDENTITY (1, 1) NOT NULL,
    [CompanyType]   VARCHAR (50) NULL,
    PRIMARY KEY CLUSTERED ([CompanyTypeId] ASC)
);

