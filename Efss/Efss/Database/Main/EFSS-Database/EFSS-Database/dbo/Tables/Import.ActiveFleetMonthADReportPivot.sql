CREATE TABLE [dbo].[Import.ActiveFleetMonthADReportPivot] (
    [RowId]          INT IDENTITY (1, 1) NOT NULL,
    [CountryId]      INT NULL,
    [ManufacturerId] INT NULL,
    [FileId]         INT NULL,
    [DateYear]       INT NULL,
    [DateMonth]      INT NULL,
    [DateDay]        INT NULL,
    [IsEnabled]      BIT NULL,
    [VehiclesCount]  INT NULL,
    [Position]       INT NULL,
    PRIMARY KEY CLUSTERED ([RowId] ASC)
);

