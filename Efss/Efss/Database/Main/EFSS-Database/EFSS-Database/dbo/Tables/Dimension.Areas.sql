CREATE TABLE [dbo].[Dimension.Areas] (
    [AreaId]    INT            IDENTITY (1, 1) NOT NULL,
    [CountryId] INT            NULL,
    [AreaCode]  VARCHAR (20)   NULL,
    [AreaName]  VARCHAR (255)  NULL,
    [AreaEmail] VARCHAR (1000) NULL,
    PRIMARY KEY CLUSTERED ([AreaId] ASC)
);

