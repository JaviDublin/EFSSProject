
namespace APP.Data
{
    public class StoredProcedures
    {
        #region "Settings : Document Types"

        public const string Select_Documents_SubTypes_Manual = @"spDocumentsSubTypeSelect";
        public const string Select_Documents_Types_Manual = @"spDocumentsTypeSelect";
        public const string Select_Document_Types_Accounts = @"spDocumentTypesSelectDetails";
        public const string Update_Document_Types_Accounts = @"spDocumentTypesUpdate";
        public const string Insert_Document_Type = @"spDocumentTypesInsert";
        public const string Select_Document_Types_Check = @"spDocumentTypesCheckName";

        #endregion

        #region "Settings : Currencies"

        public const string Select_Currencies_Details = @"spCurrenciesSelectDetails";
        public const string Update_Currencies_Rate = @"spCurrenciesUpdate";
        public const string Select_Currency_Codes = @"spCurrenciesSelectCode";

        #endregion

        #region "Settings: Companies"

        public const string Select_CompanyId = @"spCompaniesIdSelect";
        public const string Select_Companies_Overview = @"spCompaniesOverViewSelect";
        
        public const string Select_Companies_ById = @"spCompaniesSelectDetailsById";
        public const string Companies_Update = @"spCompaniesUpdate";
        public const string Select_Companies_Emails = @"spCompaniesEmailsView";
        public const string Select_Companies_Emails_Details = @"spCompaniesEmailsMessageView";
        public const string Select_Companies_Emails_Update = @"spCompaniesEmailsUpdate";
        public const string Select_Companies_GroupId = @"spCompaniesSelectGroupId";
        public const string Select_Companies_EmailId = @"spCompaniesSelectEmailId";

        public const string Select_Companies_Types = @"spCompaniesSelectType";

        #endregion

        #region "Settings: Buyers"

        //Buyers
        // Display Buyers on the ListView [Settings -> Buyers (SettingsListVendors.ascx)] + SearchBuyersOverView [class]
        public const string select_Buyers_OverView = @"spBuyersOverView";

        //Display Buyer Details in the Form [Settingg -> SettingsFormBuyers.ascx]  + BuyerDetails [class]
        public const string Select_BuyerDetails_ById = @"spBuyersSelectDetailsById";
        public const string Select_BuyerDetails_ByCode = @"spBuyersSelectDetailsByCode";

        //Display the Address and the Contact Details
        public const string Select_BuyerDetails = @"spBuyersDetails";


        public const string Update_BuyerType = @"spBuyersUpdateBuyerType";
        public const string Update_BuyerContact = @"spBuyersUpdateContact";
        
        public const string Select_BuyerName = @"spBuyersSelectName";
        public const string Select_BuyerTypes = @"spBuyersTypeSelect";
        public const string select_BuyerAddress_ById = @"spBuyersSelectAddressById";
        public const string Select_BuyerContacts_ById = @"spBuyersSelectContactsById";
        public const string Select_BuyerManufacturers_ById = @"spBuyersSelectManufacturersById";


        public const string GetUserRole = @"spUsersGetRole";

        public const string BuyersSelectNameListing = @"spBuyersSelectNameListing";


        #endregion

        #region "Invoices: Sales"

        public const string Select_SalesOverView_ByBuyerId = @"spSalesOverViewByBuyerId";
        public const string Select_SearchEngine = @"spSalesSearchEngine";
        public const string Select_SearchEngine_ToExcel = @"spSalesSearchEngineToExcel";
        public const string Select_SearchEngine_ToExcelByBuyer = @"spSalesSearchEngineToExcelByBuyer";
        public const string Select_SearchEngine_ToExcelByDocItemId = @"spSalesSearchEngineToExcelByDocItemId";
        public const string Select_SalesOverView_ByFileDate = @"spSalesOverViewByFileDate";
        public const string Select_SalesOverView_ByFileDateAndCountry = @"spSalesOverViewByFileDateAndCountry";

        #endregion

        #region "Dashboard Report"

        public const string DashBoard_OverView = @"spReportsDashboardSelect";
        public const string DashBoard_Update = @"spReportsDashboardUpdate";
        public const string DashboardListing = @"spReportsDashboardListing";
        public const string ExportDashboardFileToExcel = @"spReportsDashboardTextFileToExcel";
        public const string DashBoardSelectGroupName = @"spCompaniesSelectGroupName";

        #endregion

        #region "Import Excel File Fleet Spain

        public const string TruncateFleetSP = @"spDBImportSPFleetTruncate";
        public const string UploadFleetSP = @"spDBImportSPFleet";
        public const string TransferDataFleetSP = @"spDBImportSPFleetTransfer";
        public const string ParseDataFleetSP = @"spDBImportSPFleetParse";

        #endregion

        #region "Reports: Tax File Spain"

        public const string TaxFileNRCBank = @"spTaxFileNRCBank";
        public const string TaxFileNRCBankImport = @"spTaxFileNRCBankImport";
        public const string TaxFileNRCBankTruncate = @"spTaxFileNRCBankTruncate";
        public const string TaxFileNRCBankParse = @"spTaxFileNRCBankParse";
        public const string TaxFileNRCOutput = @"spTaxFileNRCOutput";
        public const string TaxFileAEATOutput = @"spTaxFileAEATOutput";
        
        public const string spSpainSelectBuyers = @"spReportsTaxFileSpainSelectBuyers";
        public const string TaxFileOverView = @"spReportsTaxFileSpainSelect";
        public const string TaxFilePricesOverView = @"spReportsTaxFileSpainPrices";
        public const string TaxFilePricesOverViewById = @"spReportsTaxFileSpainPricesById";

        #endregion

        #region "Settings: Users"

        public const string Select_Users_OnlineCount = @"spUsersSelectOnlineCount";
        public const string Update_Users_IsLoggedIn = @"spUsersUpdateIsLoggedIn";
        public const string Update_Users_LastActivity = @"spUsersUpdateLastActivity";
        public const string Update_Users_LastLoggedIn = @"spUsersUpdateLastLoggedIn";
        public const string Authenticate_User = @"spSecurityUsersAuthenticate";
        public const string Select_Users_Permissions = @"spSecurityUsersSelectPermissions";
        public const string Select_User_Details = @"spSecurityUsersSelectDetails";

        public const string Select_Users_Overview = @"spUsersOverviewSelect";
        public const string UsersSelectByUserId = @"spUserDetailsByUserId";
        public const string UsersInsert = @"spUsersInsert";
        public const string UsersUpdate = @"spUsersUpdate";
        public const string UsersCheck = @"spUsersCheck";

        #endregion

        #region "General: Countries"

        public const string Select_Countries = @"spCountriesSelect";
        public const string Select_Countries_User = @"spCountriesUserSelect";
        public const string Select_Companies_Country = @"spCompaniesCountrySelect";
        public const string Select_Companies_Country_Search = @"spCompaniesCountrySelect_Search";
        public const string Select_CountryId = @"spCountriesIdSelect";

        #endregion
       
        #region "Fleet"

        //Fleet
        public const string Select_Receivables_OverView_Month = @"spFleetOverViewSelectMonth";
        public const string Select_Receivables_OverView_MonthById = @"spFleetOverViewSelectMonthById";
        public const string Select_Receivables_OverView_Day = @"spFleetOverViewSelectDay";
        public const string Select_Fleet_ExportToExcel = @"spFleetExportToExcel";


        // Fleet - Reports
        public const string Select_Fleet_DayReport = @"spFleetImportFileActiveFleetReportDay";
        public const string Select_Fleet_MonthReport = @"spFleetImportFileActiveFleetReportMonth";
        public const string Select_Fleet_DayReport_AddsDel = @"spFleetImportFileActiveFleetReportMonthAD";
        public const string Select_Fleet_DayReport_AddsDel_mfg = @"spFleetImportFileActiveFleetReportMonthADMFG";
        public const string Select_Fleet_YearReport_AddsDel = @"spFleetImportFileActiveFleetReportYearAD";
        public const string Select_Fleet_YearReport_AddsDel_mfg = @"spFleetImportFileActiveFleetReportYearADMFG";

        #endregion

        #region "Manufacturers"

        public const string Select_Manufacturers = @"spManufacturersSelect";
        public const string Select_Manufacturer_OverView = @"spManufacturerOverViewSelect";
        public const string Select_Manufacturers_ById = @"spManufacturersSelectById";
        public const string Select_Manufacturers_ByCompanyId = @"spManufacturersSelectByCompanyId";
        public const string Select_Manufacturers_ByCountryId = @"spManufacturersBuyersByCountryId";
        public const string Select_ManufacturerCode_ByCountryId = @"spManufacturerCodeByCountryId";
        public const string Select_Manufacturers_DashBoard_ByCompanyId = @"spManufacturersDashBoardByCompanyId";

        #endregion

        #region "Models"

        public const string Select_Models_OverView_ByManufacturer = @"spModelsOverViewSelectByManufacturer";
        public const string Select_Models_OverView_Filtered = @"spModelsOverViewSelectFiltered";
        public const string Select_Models_ExportToExcel = @"spModelsOverViewExportToExcel";

        #endregion

        #region "Manual Invoices"

        public const string CreateManualDocument = @"spManualInvoicesCreateDocument";
        public const string CreateManualItems = @"spManualInvoicesAddItems";
        public const string CheckManualDuplicates = @"spManualInvoicesCheckDuplicates";
        public const string TruncateTableImportManualInvoices = @"spDBManualInvoiceTruncate";
        public const string UploadTableImportManualInvoices = @"spDBManualInvoiceInsert";

        public const string ManualInvoicesSelectBuyer = @"spDBManualInvoiceSelectBuyer";
        public const string ManualInvoicesSelectBuyerManufacturer = @"spDBManualInvoiceSelectBuyerManufacturer";
        public const string ManualInvoicesSelectBuyerAddress = @"spDBManualInvoiceSelectBuyerAddress";
        public const string ManualInvoicesSelectTax = @"spDBManualInvoiceSelectTax";
        public const string ManualInvoicesParse = @"spDBManualInvoiceParse";
        public const string ManualInvoicesJournal = @"spDBManualInvoiceJournal";
        public const string Select_Serials_OverView = @"spDBManualInvoiceOverView";

        #endregion

        #region "Reports: LTSC"

        public const string ReportLtsc = @"spReportsLTSCFileFrance";

        #endregion

        #region "Reports : Fleet Cash Targets"
        
        public const string Report_FCT_SelectLastSettings = @"spReportsFleetCashTargetsSettingsLast";
        public const string Report_FleetCash_Update = @"spReportsFleetCashTargetsUpdate";
        public const string Report_FCT_Select = @"spReportsFleetCashTargetsSelect";
        public const string Report_FCT_Select_Total = @"spReportsFleetCashTargetsSelectTotal";
        
        #endregion

    }
}