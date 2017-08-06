CREATE TABLE [dbo].[Dimension.Manufacturer] (
    [ManufacturerId]    INT           IDENTITY (1, 1) NOT NULL,
    [ManufacturerName]  VARCHAR (255) NULL,
    [ManufacturerCode]  VARCHAR (50)  NULL,
    [ManufacturerGroup] VARCHAR (50)  NULL,
    [ManufacturerImage] VARCHAR (255) NULL,
    PRIMARY KEY CLUSTERED ([ManufacturerId] ASC)
);

