CREATE TABLE [dbo].[Application.UserRoles] (
    [UserRoleId] INT IDENTITY (1, 1) NOT NULL,
    [UserId]     INT NULL,
    [RoleId]     INT NULL,
    PRIMARY KEY CLUSTERED ([UserRoleId] ASC)
);

