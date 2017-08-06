CREATE TABLE [dbo].[Application.Permissions] (
    [PermissionId]   SMALLINT      IDENTITY (1, 1) NOT NULL,
    [Permission]     VARCHAR (20)  NULL,
    [PermissionDesc] VARCHAR (255) NULL,
    PRIMARY KEY CLUSTERED ([PermissionId] ASC)
);

