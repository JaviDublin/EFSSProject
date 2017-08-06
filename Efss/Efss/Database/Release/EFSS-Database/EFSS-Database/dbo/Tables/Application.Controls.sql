CREATE TABLE [dbo].[Application.Controls] (
    [ControlId]          INT           IDENTITY (1, 1) NOT NULL,
    [id]                 INT           NULL,
    [ParentId]           INT           NULL,
    [ControlName]        VARCHAR (25)  NULL,
    [ControlLongName]    VARCHAR (100) NULL,
    [ControlDesc]        VARCHAR (255) NULL,
    [Position]           INT           NULL,
    [IsActive]           BIT           NULL,
    [MenuEnabled]        BIT           NULL,
    [HelpEnabled]        BIT           NULL,
    [PermissionsEnabled] BIT           NULL,
    [Mis]                BIT           NULL,
    [ControlImage]       VARCHAR (255) NULL,
    PRIMARY KEY CLUSTERED ([ControlId] ASC)
);

