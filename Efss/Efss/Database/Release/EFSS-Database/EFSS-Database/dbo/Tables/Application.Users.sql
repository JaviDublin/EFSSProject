CREATE TABLE [dbo].[Application.Users] (
    [PKID]         INT           IDENTITY (1, 1) NOT NULL,
    [RacfId]       VARCHAR (50)  NULL,
    [FirstName]    VARCHAR (255) NULL,
    [SurName]      VARCHAR (255) NULL,
    [Email]        VARCHAR (255) NULL,
    [Phone]        VARCHAR (50)  NULL,
    [Approved]     BIT           NULL,
    [LockedOut]    BIT           NULL,
    [LastLoggedIn] DATETIME      NULL,
    [LastActivity] DATETIME      NULL,
    [IsDeleted]    BIT           NULL,
    [IsLoggedIn]   BIT           NULL,
    [IsContact]    BIT           NULL,
    [FullName]     VARCHAR (500) NULL,
    PRIMARY KEY CLUSTERED ([PKID] ASC)
);

