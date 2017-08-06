CREATE TABLE [dbo].[Dimension.ContactTypes] (
    [ContactTypeId]   SMALLINT      IDENTITY (1, 1) NOT NULL,
    [ContactTypeName] VARCHAR (255) NULL,
    [CountryId]       INT           NULL,
    [CompanyId]       INT           NULL,
    PRIMARY KEY CLUSTERED ([ContactTypeId] ASC)
);

