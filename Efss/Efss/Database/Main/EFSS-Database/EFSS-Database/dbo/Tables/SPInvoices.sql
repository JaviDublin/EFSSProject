CREATE TABLE [dbo].[SPInvoices] (
    [TransactionType] NVARCHAR (255) NULL,
    [Plate]           NVARCHAR (255) NULL,
    [OutServiceDate]  DATETIME       NULL,
    [SentDate]        DATETIME       NULL,
    [SaleType]        NVARCHAR (255) NULL,
    [InvoiceNumber]   NVARCHAR (255) NULL,
    [RegTaxAmount]    FLOAT (53)     NULL,
    [Bank]            FLOAT (53)     NULL,
    [NumberBank]      FLOAT (53)     NULL,
    [ModelCode]       NVARCHAR (255) NULL
);

