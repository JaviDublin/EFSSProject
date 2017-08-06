CREATE TABLE [dbo].[Controls] (
    [ControlId]          INT           NULL,
    [ParentId]           INT           NULL,
    [ControlUrl]         INT           NOT NULL,
    [Position]           INT           NULL,
    [IsActive]           BIT           NULL,
    [HelpEnabled]        BIT           NULL,
    [PermissionsEnabled] BIT           NULL,
    [Name]               VARCHAR (25)  NULL,
    [Description]        VARCHAR (100) NULL,
    [ImageUrl]           VARCHAR (100) NULL,
    [IsCSR]              BIT           NULL,
    PRIMARY KEY CLUSTERED ([ControlUrl] ASC)
);

