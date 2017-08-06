CREATE TABLE [dbo].[Application.FileLogError] (
    [LogErrorId]     INT           IDENTITY (1, 1) NOT NULL,
    [FileId]         INT           NULL,
    [DateError]      DATETIME      NULL,
    [ErrorNumber]    VARCHAR (255) NULL,
    [ErrorMessage]   VARCHAR (255) NULL,
    [ErrorSeverity]  VARCHAR (255) NULL,
    [ErrorState]     VARCHAR (255) NULL,
    [ErrorLine]      VARCHAR (255) NULL,
    [ErrorProcedure] VARCHAR (255) NULL,
    PRIMARY KEY CLUSTERED ([LogErrorId] ASC)
);

