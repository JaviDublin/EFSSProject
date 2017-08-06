CREATE TABLE [dbo].[GEVendors] (
    [vendorId]   INT           NOT NULL,
    [AdrTyp]     VARCHAR (5)   NULL,
    [AccCode]    INT           NULL,
    [Name]       VARCHAR (255) NULL,
    [Name1]      VARCHAR (255) NULL,
    [Strasse]    VARCHAR (255) NULL,
    [plz]        VARCHAR (20)  NULL,
    [Ort]        VARCHAR (255) NULL,
    [TelNr]      VARCHAR (50)  NULL,
    [Kontakt]    VARCHAR (255) NULL,
    [HER_Code]   VARCHAR (30)  NULL,
    [Pay_Term]   FLOAT (53)    NULL,
    [vertrag_jn] VARCHAR (1)   NULL,
    [brief_jn]   VARCHAR (1)   NULL,
    [Von]        DATETIME      NULL,
    [Bis]        DATETIME      NULL
);

