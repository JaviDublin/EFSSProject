CREATE TABLE [dbo].[Application.UserCountries] (
    [UserCountryId] INT IDENTITY (1, 1) NOT NULL,
    [UserId]        INT NULL,
    [CountryId]     INT NULL,
    PRIMARY KEY CLUSTERED ([UserCountryId] ASC)
);

