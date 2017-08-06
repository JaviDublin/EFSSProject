CREATE TABLE [dbo].[Application.Files] (
    [FileId]         INT            IDENTITY (1, 1) NOT NULL,
    [FileCode]       VARCHAR (10)   NULL,
    [FileName]       VARCHAR (255)  NULL,
    [FilePath]       VARCHAR (4000) NULL,
    [FileFormat]     VARCHAR (255)  NULL,
    [FileFormatPath] VARCHAR (4000) NULL,
    [ReportName]     VARCHAR (255)  NULL,
    [TableName]      VARCHAR (255)  NULL,
    [ArchivePath]    VARCHAR (4000) NULL,
    [Notes]          VARCHAR (4000) NULL,
    [FileGroupType]  VARCHAR (50)   NULL,
    [TableStaging]   VARCHAR (100)  NULL,
    [IsImported]     BIT            NULL,
    PRIMARY KEY CLUSTERED ([FileId] ASC)
);

