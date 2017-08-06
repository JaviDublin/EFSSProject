CREATE TABLE [dbo].[Dimension.ManufacturerVision] (
    [ManufacturerVisionId] INT          IDENTITY (1, 1) NOT NULL,
    [ManufacturerId]       INT          NULL,
    [VisionCode]           VARCHAR (50) NULL,
    [Position]             INT          NULL,
    PRIMARY KEY CLUSTERED ([ManufacturerVisionId] ASC)
);

