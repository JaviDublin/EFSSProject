CREATE TABLE [dbo].[Dimension.CompanyAddress] (
    [CompanyAddressId] INT            IDENTITY (1, 1) NOT NULL,
    [CompanyId]        INT            NULL,
    [Address1]         VARCHAR (255)  NULL,
    [Address2]         VARCHAR (255)  NULL,
    [Address3]         VARCHAR (255)  NULL,
    [Address4]         VARCHAR (255)  NULL,
    [Address5]         VARCHAR (255)  NULL,
    [Address6]         VARCHAR (255)  NULL,
    [Address7]         VARCHAR (255)  NULL,
    [Address8]         VARCHAR (255)  NULL,
    [Address9]         VARCHAR (255)  NULL,
    [Address10]        VARCHAR (255)  NULL,
    [Address11]        VARCHAR (255)  NULL,
    [Address12]        VARCHAR (255)  NULL,
    [CodeOrder]        SMALLINT       NULL,
    [TextFooter]       VARCHAR (2000) NULL,
    [StartDate]        DATETIME       NULL,
    [EndDate]          DATETIME       NULL,
    PRIMARY KEY CLUSTERED ([CompanyAddressId] ASC)
);

