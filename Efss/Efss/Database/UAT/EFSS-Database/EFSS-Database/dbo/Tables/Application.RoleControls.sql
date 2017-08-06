CREATE TABLE [dbo].[Application.RoleControls] (
    [PKID]         INT      IDENTITY (1, 1) NOT NULL,
    [RoleId]       SMALLINT NULL,
    [PermissionId] SMALLINT NULL,
    [ControlId]    INT      NULL,
    PRIMARY KEY CLUSTERED ([PKID] ASC)
);

