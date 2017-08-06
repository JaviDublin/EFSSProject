CREATE TABLE [dbo].[Dimension.ReportTypes] (
    [ReportTypeId] INT          IDENTITY (1, 1) NOT NULL,
    [ReportType]   VARCHAR (50) NULL,
    PRIMARY KEY CLUSTERED ([ReportTypeId] ASC)
);

