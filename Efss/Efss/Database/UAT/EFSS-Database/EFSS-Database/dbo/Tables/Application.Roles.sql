CREATE TABLE [dbo].[Application.Roles] (
    [RoleId]   SMALLINT     IDENTITY (1, 1) NOT NULL,
    [RoleName] VARCHAR (50) NULL,
    PRIMARY KEY CLUSTERED ([RoleId] ASC)
);

