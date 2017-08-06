CREATE TABLE [dbo].[Dimension.DocumentTypes] (
    [DocumentTypeId] INT           IDENTITY (1, 1) NOT NULL,
    [DocType]        VARCHAR (100) NULL,
    [DocSubType]     VARCHAR (100) NULL,
    [IsManual]       BIT           NULL,
    [PrimeAccount]   VARCHAR (50)  NULL,
    [SubAccount]     VARCHAR (50)  NULL,
    [CostCenter]     VARCHAR (20)  NULL,
    [Activity]       VARCHAR (10)  NULL,
    [Division]       VARCHAR (10)  NULL,
    [IsActive]       BIT           NULL,
    PRIMARY KEY CLUSTERED ([DocumentTypeId] ASC)
);

