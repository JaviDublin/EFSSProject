CREATE TABLE [dbo].[Fact.Vehicles] (
    [VehicleId] INT          IDENTITY (1, 1) NOT NULL,
    [Serial]    VARCHAR (50) NULL,
    [Unit]      VARCHAR (20) NULL,
    [CountryId] INT          NULL,
    PRIMARY KEY CLUSTERED ([VehicleId] ASC)
);

