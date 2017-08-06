CREATE TABLE [dbo].[WWTest_FileReport_IT] (
    [RowId]         INT            IDENTITY (1, 1) NOT NULL,
    [CountryId]     INT            NULL,
    [CompanyId]     INT            NULL,
    [BuyerId]       INT            NULL,
    [LogId]         INT            NULL,
    [FileDate]      DATETIME       NULL,
    [InvoiceDate]   DATETIME       NULL,
    [TotalInvoices] INT            NULL,
    [FleetCo]       INT            NULL,
    [OpCo]          INT            NULL,
    [Original]      INT            NULL,
    [CreditNotes]   INT            NULL,
    [BuyBack]       INT            NULL,
    [WholeSale]     INT            NULL,
    [Wreck]         INT            NULL,
    [Notes]         VARCHAR (1000) NULL
);

