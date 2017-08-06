using System;
using System.Collections.Generic;
using System.Globalization;
using System.Web;
using APP.Events;
using APP.Search;


namespace APP.Session
{
    public class SessionHandler
    {

        #region "Application Culture"

        private static string _ApplicationCulture = @"SV-Application-Culture";

        public static CultureInfo ApplicationCulture
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_ApplicationCulture];
                return ((sessionObject != null) ? (CultureInfo)sessionObject : null);
            }
            set
            {
                HttpContext.Current.Session[_ApplicationCulture] = value;
            }
        }

        #endregion

        #region "Application Filter Sessions"

        private static string _ApplicationFilterSecurityUsersOverview = @"SV_ApplicationFilter_SecurityUsersOverview";

        public static FilterEvents ApplicationFilterSecurityUsersOverview
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_ApplicationFilterSecurityUsersOverview];
                return ((sessionObject != null) ? (FilterEvents)sessionObject : null);
            }
            set
            {
                HttpContext.Current.Session[_ApplicationFilterSecurityUsersOverview] = value;
            }
        }

        private static string _ApplicationFilterSearchCompaniesOverview = @"SV_ApplicationFilter_SearchCompaniesOverview";

        public static FilterEvents ApplicationFilterSearchCompaniesOverview
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_ApplicationFilterSearchCompaniesOverview];
                return ((sessionObject != null) ? (FilterEvents)sessionObject : null);
            }
            set
            {
                HttpContext.Current.Session[_ApplicationFilterSearchCompaniesOverview] = value;
            }
        }

        private static string _ReceivablesActiveFleetFilter = @"SV_Receivables_Active_Fleet_Filter";

        public static FilterEvents ReceivablesActiveFleetFilter
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_ReceivablesActiveFleetFilter];
                return ((sessionObject != null) ? (FilterEvents)sessionObject : null);
            }
            set
            {
                HttpContext.Current.Session[_ReceivablesActiveFleetFilter] = value;
            }
        }

        private static string _ApplicationFilterManufacturersOverView = @"SV_ApplicationFilter_ManufacturersOverview";

        public static FilterEvents ApplicationFilterManufacturersOverview
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_ApplicationFilterManufacturersOverView];
                return ((sessionObject != null) ? (FilterEvents)sessionObject : null);
            }
            set
            {
                HttpContext.Current.Session[_ApplicationFilterManufacturersOverView] = value;
            }
        }

        private static string _ApplicationFilterModelsOverView = @"SV_ApplicationFilter_ModelsOverView";

        public static FilterEvents ApplicationFilterModelsOverView
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_ApplicationFilterModelsOverView];
                return ((sessionObject != null) ? (FilterEvents)sessionObject : null);
            }
            set
            {
                HttpContext.Current.Session[_ApplicationFilterModelsOverView] = value;
            }
        }

        private static string _ApplicationFilterSalesFileOverView = @"SV_ApplicationFilter_SalesFileOverview";

        public static FilterEvents ApplicationFilterSalesFileOverView
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_ApplicationFilterSalesFileOverView];
                return ((sessionObject != null) ? (FilterEvents)sessionObject : null);
            }
            set
            {
                HttpContext.Current.Session[_ApplicationFilterSalesFileOverView] = value;
            }
        }

        public static string _SearchFilterSales = @"SV_SearchFilter_Sales";

        public static FilterEvents SearchFilterSales
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_SearchFilterSales];
                return ((sessionObject != null) ? (FilterEvents)sessionObject : null);
            }
            set
            {
                HttpContext.Current.Session[_SearchFilterSales] = value;
            }
        }

        private static string _BuyersFilterSales = "@SV_BuyersFilter_Sales";

        public static FilterEvents BuyersFilterSales
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_BuyersFilterSales];
                return ((sessionObject != null) ? (FilterEvents)sessionObject : null);
            }
            set
            {
                HttpContext.Current.Session[_BuyersFilterSales] = value;
            }
        }

        private static string _ManualInvoicesSerialFilters = @"SV_ManualInvoicesSerialFilters";

        public static FilterEvents ManualInvoicesSerialFilters
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_ManualInvoicesSerialFilters];
                return ((sessionObject != null) ? (FilterEvents)sessionObject : null);
            }
            set
            {
                HttpContext.Current.Session[_ManualInvoicesSerialFilters] = value;
            }
        }

        private static string _ApplicationFilterBuyersOverView = @"SV_ApplicationFilter_BuyersOverView";

        public static FilterEvents ApplicationFilterBuyersOverView
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_ApplicationFilterBuyersOverView];
                return ((sessionObject != null) ? (FilterEvents)sessionObject : null);
            }
            set
            {
                HttpContext.Current.Session[_ApplicationFilterBuyersOverView] = value;
            }
        }

        private static string __ApplicationFilterFileBuyerInvoicesOverView = @"SV_ApplicationFilter_FileBuyerInvoices_OverView";

        public static FilterEvents ApplicationFilterFileBuyerInvoicesOverView
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[__ApplicationFilterFileBuyerInvoicesOverView];
                return ((sessionObject != null) ? (FilterEvents)sessionObject : null);
            }
            set
            {
                HttpContext.Current.Session[__ApplicationFilterFileBuyerInvoicesOverView] = value;
            }
        }

        private static string _ReportFilterFleetDay = @"SV_ReportFilter_FleetDay";

        public static FilterEvents ReportFilterFleetDay
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_ReportFilterFleetDay];
                return ((sessionObject != null) ? (FilterEvents)sessionObject : null);
            }
            set
            {
                HttpContext.Current.Session[_ReportFilterFleetDay] = value;
            }
        }

        private static string _ReportFilterFleetMonth = @"SV_ReportFilter_FleetMonth";

        public static FilterEvents ReportFilterFleetMonth
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_ReportFilterFleetMonth];
                return ((sessionObject != null) ? (FilterEvents)sessionObject : null);
            }
            set
            {
                HttpContext.Current.Session[_ReportFilterFleetMonth] = value;
            }
        }

        private static string _ReportFilterFleetDayTransaction = @"SV_ReportFilter_FleetDayTransactions";

        public static FilterEvents ReportFilterFleetDayTransactions
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_ReportFilterFleetDayTransaction];
                return ((sessionObject != null) ? (FilterEvents)sessionObject : null);
            }
            set
            {
                HttpContext.Current.Session[_ReportFilterFleetDayTransaction] = value;
            }
        }

        private static string _ReportFilterFleetYearTransaction = @"SV_ReportFilter_FleetYearTransactions";

        public static FilterEvents ReportFilterFleetYearTransactions
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_ReportFilterFleetYearTransaction];
                return ((sessionObject != null) ? (FilterEvents)sessionObject : null);
            }
            set
            {
                HttpContext.Current.Session[_ReportFilterFleetYearTransaction] = value;
            }
        }

        private static string _ApplicationFilterAreas = @"SV_Application_FilterAreas";

        public static FilterEvents ApplicationFilterAreas
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_ApplicationFilterAreas];
                return ((sessionObject != null) ? (FilterEvents)sessionObject : null);
            }
            set
            {
                HttpContext.Current.Session[_ApplicationFilterAreas] = value;
            }
        }

        private static string _ApplicationTaxFileFilter = @"SV_ApplicationTaxFileFilter";

        public static FilterEvents ApplicationTaxFileFilter
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_ApplicationTaxFileFilter];
                return ((sessionObject != null) ? (FilterEvents)sessionObject : null);
            }
            set
            {
                HttpContext.Current.Session[_ApplicationTaxFileFilter] = value;
            }
        }

        private static string _ApplicationTaxFileFilterPrice = @"SV_ApplicationTaxFileFilterPrice";

        public static FilterEvents ApplicationTaxFileFilterPrice
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_ApplicationTaxFileFilterPrice];
                return ((sessionObject != null) ? (FilterEvents)sessionObject : null);
            }
            set
            {
                HttpContext.Current.Session[_ApplicationTaxFileFilterPrice] = value;
            }
        }


        private static string _ApplicationFilesReport = @"SV_ApplicationFilesReport";

        public static FilterEvents ApplicationFilesReport
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_ApplicationFilesReport];
                return ((sessionObject != null) ? (FilterEvents)sessionObject : null);
            }
            set
            {
                HttpContext.Current.Session[_ApplicationFilesReport] = value;
            }
        }

        #endregion

        #region "System"

        // current Control
        public static string _ApplicationCurrentControl = @"SV-Application-CurrentControl";

        public static string ApplicationCurrentControl
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_ApplicationCurrentControl];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_ApplicationCurrentControl] = value;
            }
        }

        // Browser JavaScript
        private static string _BrowserInformationJavascriptEnabled = @"SV-BrowserInformation-JavascriptEnabled";

        public static bool BrowserInformationJavascriptEnabled
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_BrowserInformationJavascriptEnabled];
                return ((sessionObject != null) ? Convert.ToBoolean(sessionObject) : true);
            }
            set
            {
                HttpContext.Current.Session[_BrowserInformationJavascriptEnabled] = value;
            }
        }

       
        #endregion

        #region "User Sessions"

        //User Id
        private static string _AuthenticationUserId = @"SV-Authentication-UserId";

        public static int? AuthenticationUserId
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_AuthenticationUserId];
                return ((sessionObject != null) ? Convert.ToInt32(sessionObject) : (int?)null);
            }
            set
            {
                HttpContext.Current.Session[_AuthenticationUserId] = value;
            }
        }

        //RacfId
        private static string _AuthenticationRacfId = @"SV-Authentication-RacfId";

        public static string AuthenticationRacfId
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_AuthenticationRacfId];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_AuthenticationRacfId] = value;
            }
        }

        private static string _UserRacfIdSearch = @"SV_UserRacfIdSearch";

        public static string UserRacfIdSearch
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_UserRacfIdSearch];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_UserRacfIdSearch] = value;
            }
        }


        //Add or Update User Details

        private static string _UserFormAction = @"SV_UserFormAction";

        public static string UserFormAction
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_UserFormAction];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_UserFormAction] = value;
            }
        }

        //User Deatils
        private static string _AuthenticationFirstname = @"SV-Authentication-Firstname";
        private static string _AuthenticationSurname = @"SV-Authentication-Surname";
        private static string _AuthenticationLastLoggedIn = @"SV-Authentication-LastLoggedIn";

        public static string AuthenticationFirstname
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_AuthenticationFirstname];
                return ((sessionObject != null) ? sessionObject.ToString() : null);

            }
            set
            {
                HttpContext.Current.Session[_AuthenticationFirstname] = value;
            }
        }

        public static string AuthenticationSurname
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_AuthenticationSurname];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_AuthenticationSurname] = value;
            }
        }

        public static string AuthenticationLastLoggedIn
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_AuthenticationLastLoggedIn];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_AuthenticationLastLoggedIn] = value;
            }
        }

        private static string _ApplicationDataSourceUserPermissions = @"SV_ApplicationDataSource_UserPermissions";

        public static List<SecurityUserPermissions> ApplicationDataSourceUserPermissions
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_ApplicationDataSourceUserPermissions];
                return ((sessionObject != null) ? (List<SecurityUserPermissions>)sessionObject : null);
            }
            set
            {

                HttpContext.Current.Session[_ApplicationDataSourceUserPermissions] = value;
            }

        }

        public static void SetAuthenticationSessionValues(int userId, string firstname, string surname, string lastLoggedIn)
        {
            AuthenticationUserId = userId;
            AuthenticationFirstname = firstname;
            AuthenticationSurname = surname;
            AuthenticationLastLoggedIn = lastLoggedIn;
        }

        private static string _UserRole = @"SV_UserRole";

        public static string UserRole
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_UserRole];
                return ((sessionObject != null) ? sessionObject.ToString() : null);

            }
            set
            {
                HttpContext.Current.Session[_UserRole] = value;
            }
        }

        #endregion

        #region "Basic Application Settings: Country / Company / Manufacturer / Buyer"

        //Country Name
        private static string _ApplicationCountryName = @"SV-Application-CountryName";

        public static string ApplicationCountryName
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_ApplicationCountryName];
                return ((sessionObject != null) ? sessionObject.ToString() : null);

            }
            set
            {
                HttpContext.Current.Session[_ApplicationCountryName] = value;
            }
        }

        //Country Id
        private static string _ApplicationCountryId = @"SV-Application-Country-Id";

        public static int? ApplicationCountryId
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_ApplicationCountryId];
                return ((sessionObject != null) ? Convert.ToInt32(sessionObject) : (int?)null);
            }
            set
            {
                HttpContext.Current.Session[_ApplicationCountryId] = value;
            }
        }

        //Company Name
        private static string _ApplicationCompanyName = @"SV-Application-Company";

        public static string ApplicationCompanyName
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_ApplicationCompanyName];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_ApplicationCompanyName] = value;
            }
        }

        //Company Id
        private static string _ApplicationCompanyId = @"SV-Application-companyId";

        public static int? ApplicationCompanyId
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_ApplicationCompanyId];
                return ((sessionObject != null) ? Convert.ToInt32(sessionObject) : (int?)null);
            }
            set
            {
                HttpContext.Current.Session[_ApplicationCompanyId] = value;
            }
        }

        //Manufacturer Name
        private static string _ApplicationFormManufacturerName = @"SV_ApplicationForm_ManufacturerName";

        public static string ApplicationFormManufactureName
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_ApplicationFormManufacturerName];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_ApplicationFormManufacturerName] = value;
            }
        }

        //Buyer Name

        private static string _ApplicationFormBuyerName = @"SV_ApplicationForm_BuyerName";

        public static string ApplicationFormBuyerName
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_ApplicationFormBuyerName];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_ApplicationFormBuyerName] = value;
            }
        }

        private static string _ApplicationFormCountryName = @"SV_ApplicationForm_CountryName";

        public static string ApplicationFormCountryName
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_ApplicationFormCountryName];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_ApplicationFormCountryName] = value;
            }
        }

        private static string _ApplicationFormBuyerCode = @"SV_ApplicationForm_BuyerCode";

        public static string ApplicationFormBuyerCode
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_ApplicationFormBuyerCode];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_ApplicationFormBuyerCode] = value;
            }
        }

        private static string _ApplicationFormBuyerCountryId = @"SV_ApplicationFormBuyerCountryId";

        public static string ApplicationFormBuyerCountryId
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_ApplicationFormBuyerCountryId];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_ApplicationFormBuyerCountryId] = value;
            }
        }

        private static string _ApplicationFormBuyerManufacturerCode = @"SV_ApplicationFormBuyerManufacturerCode";

        public static string ApplicationFormBuyerManufacturerCode
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_ApplicationFormBuyerManufacturerCode];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_ApplicationFormBuyerManufacturerCode] = value;
            }
        }


        #endregion

        #region "Selected Id's"
        
        private static string _SelectedUserId = @"SV_Selected_UserId";

        public static string SelectedUserId
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_SelectedUserId];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_SelectedUserId] = value;
            }
        }

        private static string _SelectedCountryId = @"SV_Selected_CountryId";

        public static string SelectedCountryId
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_SelectedCountryId];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_SelectedCountryId] = value;
            }
        }

        private static string _SelectedCompanyId = @"SV_Selected_CompanyId";

        public static string SelectedCompanyId
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_SelectedCompanyId];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_SelectedCompanyId] = value;
            }
        }

        private static string _SelectedMessageId = @"SV_Selected_MessageId";

        public static string SelectedMessageId
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_SelectedMessageId];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_SelectedMessageId] = value;
            }
        }

        private static string _SelectedGroupId = @"SV_Selected_GroupId";

        public static string SelectedGroupId
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_SelectedGroupId];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_SelectedGroupId] = value;
            }
        }

        private static string _SelectedVehicleId = @"SV_Selected_VehicleId";

        public static string SelectedVehicleId
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_SelectedVehicleId];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_SelectedVehicleId] = value;
            }
        }

        private static string _SelectedManufacturerId = @"SV_Selected_ManufacturerId";

        public static string SelectedManufacturerid
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_SelectedManufacturerId];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_SelectedManufacturerId] = value;
            }
        }

        public static string _SelectedModelDetailId = @"SV_Selected_ModelDetailId";

        public static string SelectedModelDetailId
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_SelectedModelDetailId];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_SelectedModelDetailId] = value;
            }
        }

        private static string _SelectedFileId = @"SV_Selected_FileId";

        public static string SelectedFileId
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_SelectedFileId];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_SelectedFileId] = value;
            }
        }

        private static string _SelectedFileDate = @"SV_Selected_FileDate";

        public static string SelectedFileDate
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_SelectedFileDate];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_SelectedFileDate] = value;
            }
        }

        private static string _SelectedInvoiceDate = @"SV_Selected_InvoiceDate";

        public static string SelectedInvoiceDate
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_SelectedInvoiceDate];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_SelectedInvoiceDate] = value;
            }
        }

        private static string _SelectedRowId = @"SV_Selected_RowId";

        public static string SelectedRowId
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_SelectedRowId];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_SelectedRowId] = value;
            }
        }

        private static string _Selected_BuyerId = @"SV_Selected_BuyerId";

        public static string SelectedBuyerId
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_Selected_BuyerId];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_Selected_BuyerId] = value;
            }
        }

        private static string _Selected_CompanyType_Id = @"SV_Selected_CompanyType_Id";

        public static string Selected_CompanyType_Id
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_Selected_CompanyType_Id];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_Selected_CompanyType_Id] = value;
            }
        }

        private static string _Selected_ContactId = @"SV_Selected_ContacId";

        public static string Selected_ContactId
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_Selected_ContactId];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_Selected_ContactId] = value;
            }
        }

        private static string _SelectedManualSerialId = @"SV_Selected_ManualSerialId";

        public static string SelectedManualSerialId
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_SelectedManualSerialId];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_SelectedManualSerialId] = value;
            }
        }

        private static string _SelectedModelCompanyId = @"SV_Selected_ModelCompanyId";

        public static string SelectedModelCompanyId
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_SelectedModelCompanyId];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_SelectedModelCompanyId] = value;
            }
        }

        private static string _SelectedModelYear = @"SV_Selected_ModelYear";

        public static string SelectedModelYear
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_SelectedModelYear];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_SelectedModelYear] = value;
            }
        }

        private static string _SelectedAreaId = @"SV_Selected_AreaId";

        public static string SelectedAreaId
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_SelectedAreaId];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_SelectedAreaId] = value;
            }
        }

        private static string _SelectedCountryArea = @"SV_Selected_CountryArea";

        public static string SelectedCountryArea
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_SelectedCountryArea];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_SelectedCountryArea] = value;
            }
        }

        private static string _SelectedAreaCode = @"SV_Selected_AreaCode";

        public static string SelectedAreaCode
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_SelectedAreaCode];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_SelectedAreaCode] = value;
            }
        }

        private static string _SelectedFleetYearCountryId = @"SV_SelectedFleetYearCountryId";

        public static string SelectedFleetYearCountryId
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_SelectedFleetYearCountryId];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_SelectedFleetYearCountryId] = value;
            }
        }

        private static string _SelectedFleetDayCountryId = @"SV_SelectedFleetDayCountryId";

        public static string SelectedFleetDayCountryId
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_SelectedFleetDayCountryId];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_SelectedFleetDayCountryId] = value;
            }
        }

        private static string _SelectedLogId = @"SV_SelectedLogId";

        public static string SelectedLogId
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_SelectedLogId];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_SelectedLogId] = value;
            }
        }

        #endregion

        #region "Search Form"

        //Country Name
        private static string _SearchFormCountryName = @"SV-Application-CountryName";

        public static string SearchFormCountryName
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_SearchFormCountryName];
                return ((sessionObject != null) ? sessionObject.ToString() : null);

            }
            set
            {
                HttpContext.Current.Session[_SearchFormCountryName] = value;
            }
        }

        private static string _SearchFormCountryId = @"SV-Application-Country-Id";

        public static int? SearchFormCountryId
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_SearchFormCountryId];
                return ((sessionObject != null) ? Convert.ToInt32(sessionObject) : (int?)null);
            }
            set
            {
                HttpContext.Current.Session[_SearchFormCountryId] = value;
            }
        }

        //Company Name
        private static string _SearchFormCompanyName = @"SV-Application-Company";

        public static string SearchFormCompanyName
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_SearchFormCompanyName];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_SearchFormCompanyName] = value;
            }
        }

        private static string _SearchFormCompanyId = @"SV-Application-companyId";

        public static int? SearchFormCompanyId
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_SearchFormCompanyId];
                return ((sessionObject != null) ? Convert.ToInt32(sessionObject) : (int?)null);
            }
            set
            {
                HttpContext.Current.Session[_SearchFormCompanyId] = value;
            }
        }


        private static string _SearchSerial = @"SV_SearchSerial";
        private static string _SearchUnit = @"SV_SearchUnit";
        private static string _SearchPlate = @"SV_SearchPlate";
        private static string _SearchBuyerCode = @"SV_SearchBuyerCode";
        private static string _SearchBuyerName = @"SV_SearchBuyerName";
        private static string _SearchManufacturer = @"SV_SearchManufacturer";
        private static string _SearchDocType = @"SV_DocType";
        private static string _SearchDocSubType = @"SV_SearchDocSubType";
        private static string _SearchInvoiceFrom = @"SV_SearchInvoiceFrom";
        private static string _SearchInvoiceTo = @"SV_SearchInvoiceTo";
        private static string _SearchDateFrom = @"SV_SearchDateFrom";
        private static string _SearchDateTo = @"SV_SearchDateTo";
        private static string _SearchVehicleType = @"SV_SearchVehicleType";
        private static string _SearchSaleType = @"SV_SearchSaleType";
        private static string _SearchFileDate = "SV_SearchFileDate";

        public static int? SearchInvoiceFrom
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_SearchInvoiceFrom];
                return ((sessionObject != null) ? Convert.ToInt32(sessionObject) : (int?)null);
            }
            set
            {
                HttpContext.Current.Session[_SearchInvoiceFrom] = value;
            }
        }

        public static int? SearchInvoiceTo
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_SearchInvoiceTo];
                return ((sessionObject != null) ? Convert.ToInt32(sessionObject) : (int?)null);
            }
            set
            {
                HttpContext.Current.Session[_SearchInvoiceTo] = value;
            }
        }

        public static string SearchSerial
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_SearchSerial];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_SearchSerial] = value;
            }
        }

        public static string SearchUnit
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_SearchUnit];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_SearchUnit] = value;
            }
        }

        public static string SearchPlate
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_SearchPlate];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_SearchPlate] = value;
            }
        }

        public static string SearchBuyerCode
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_SearchBuyerCode];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_SearchBuyerCode] = value;
            }
        }

        public static string SearchBuyerName
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_SearchBuyerName];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_SearchBuyerName] = value;
            }
        }

        public static string SearchManufacturer
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_SearchManufacturer];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_SearchManufacturer] = value;
            }
        }

        public static string SearchDocType
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_SearchDocType];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_SearchDocType] = value;
            }
        }

        public static string SearchDocSubType
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_SearchDocSubType];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_SearchDocSubType] = value;
            }
        }

        public static string SearchDateFrom
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_SearchDateFrom];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_SearchDateFrom] = value;
            }
        }

        public static string SearchDateTo
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_SearchDateTo];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_SearchDateTo] = value;
            }
        }

        public static string SearchVehicleType
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_SearchVehicleType];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_SearchVehicleType] = value;
            }
        }

        public static string SearchSaleType
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_SearchSaleType];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_SearchSaleType] = value;
            }
        }

        public static string SearchFileDate
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_SearchFileDate];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_SearchFileDate] = value;
            }
        }

        private static string _SearchInvoiceMode = @"SV_SearchInvoiceMode";
        private static string _SearchFreeFormatText = @"SV_SearchFreeFormatText";

        public static string SearchInvoiceMode
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_SearchInvoiceMode];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_SearchInvoiceMode] = value;
            }
        }

        public static string SearchFreeFormatText
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_SearchFreeFormatText];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_SearchFreeFormatText] = value;
            }   
        }


        private static string _SearchReportFileDate = "SV_SearchReportFileDate";

        public static string SearchReportFileDate
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_SearchReportFileDate];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_SearchReportFileDate] = value;
            }
        }
        

        #endregion

        #region "Fleet Forms"

        private static string _FilterDateFleetDayReport = @"SV_FilterDateFleetDayReport";

        public static string FilterDateFleetDayReport
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_FilterDateFleetDayReport];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_FilterDateFleetDayReport] = value;
            }
        }

        private static string _FilterMonthFleetMonthReport = @"SV_FilterMonthFleetMonthReport";
        private static string _FilterYearFleetMonthReport = @"SV_FilterYearFleetMonthReport";

        public static string FilterMonthFleetMonthReport
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_FilterMonthFleetMonthReport];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_FilterMonthFleetMonthReport] = value;
            }
        }

        public static string FilterYearFleetMonthReport
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_FilterYearFleetMonthReport];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_FilterYearFleetMonthReport] = value;
            }
        }

        private static string _FilterMonthFleetDayTransReport = @"SV_FilterMonthFleetDayTransReport";
        private static string _FilterYearFleetDayTransReport = @"SV_FilterYearFleetDayTransReport";
        private static string _FilterFileIdFleetDayTransReport = @"SV_FilterFileIdFleetDayTransReport";

        public static string FilterMonthFleetDayTransReport
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_FilterMonthFleetDayTransReport];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_FilterMonthFleetDayTransReport] = value;
            }
        }

        public static string FilterYearFleetDayTransReport
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_FilterYearFleetDayTransReport];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_FilterYearFleetDayTransReport] = value;
            }
        }

        public static string FilterFileIdFleetDayTransReport
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_FilterFileIdFleetDayTransReport];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_FilterFileIdFleetDayTransReport] = value;
            }
        }

        private static string _FilterYearFleetYearTransReport = @"SV_FilterYearFleetYearTransReport";
        private static string _FilterMonthFleetYearTransReport = @"SV_FilterMonthFleetYearTransReport";
        private static string _FilterFileIdFleetYearTransReport = @"SV_FilterFileIdFleetYearTransReport";

        public static string FilterYearFleetYearTransReport
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_FilterYearFleetYearTransReport];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_FilterYearFleetYearTransReport] = value;
            }
        }

        public static string FilterMonthFleetYearTransReport
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_FilterMonthFleetYearTransReport];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_FilterMonthFleetYearTransReport] = value;
            }
        }

        public static string FilterFileIdFleetYearTransReport
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_FilterFileIdFleetYearTransReport];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_FilterFileIdFleetYearTransReport] = value;
            }
        }

        #endregion

        #region "File Sessions"

        private static string _HefsDownloadFileName = @"SV_Hefs_downloadFileName";

        public static string HefsDownloadFileName
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_HefsDownloadFileName];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_HefsDownloadFileName] = value;
            }
        }

        private static string _ManualInvoicesExcelPath = @"SV_ManualInvoices_ExcelPath";

        public static string ManualInvoicesExcelPath
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_ManualInvoicesExcelPath];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_ManualInvoicesExcelPath] = value;
            }
        }

        #endregion
       
        #region "Report Sessions"

        //France
        private static string _FRSelectedCompany = @"SV_FRSelectedCompany";

        public static string FRSelectedCompany
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_FRSelectedCompany];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_FRSelectedCompany] = value;
            }
        }

        private static string _FRSelectedDocumentType = @"SV_FRSelectedDocumentType";

        public static string FRSelectedDocumentType
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_FRSelectedDocumentType];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_FRSelectedDocumentType] = value;
            }
        }

        private static string _FRSelectedDocumentSubType = @"SV_FRSelectedDocumentSubType";

        public static string FRSelectedDocumentSubType
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_FRSelectedDocumentSubType];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_FRSelectedDocumentSubType] = value;
            }
        }

        private static string _FRSelectedFileDate = @"SV_FRSelectedFileDate";

        public static string FRSelectedFileDate
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_FRSelectedFileDate];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_FRSelectedFileDate] = value;
            }
        }

        private static string _FRSelectedInvoiceDateFrom = @"SV_FRSelectedInvoiceDateFrom";

        public static string FRSelectedInvoiceDateFrom
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_FRSelectedInvoiceDateFrom];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_FRSelectedInvoiceDateFrom] = value;
            }
        }

        private static string _FRSelectedInvoiceDateTo = @"SV_FRSelectedInvoiceDateTo";

        public static string FRSelectedInvoiceDateTo
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_FRSelectedInvoiceDateTo];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_FRSelectedInvoiceDateTo] = value;
            }
        }

        //Spain
        private static string _SPSelectedCompany = @"SV_SPSelectedCompany";

        public static string SPSelectedCompany
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_SPSelectedCompany];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_SPSelectedCompany] = value;
            }
        }

        private static string _SPSelectedDocumentType = @"SV_SPSelectedDocumentType";

        public static string SPSelectedDocumentType
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_SPSelectedDocumentType];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_SPSelectedDocumentType] = value;
            }
        }

        private static string _SPSelectedDocumentSubType = @"SV_SPSelectedDocumentSubType";

        public static string SPSelectedDocumentSubType
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_SPSelectedDocumentSubType];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_SPSelectedDocumentSubType] = value;
            }
        }

        
        
        
        private static string _SPSelectedFileDate = @"SV_SPSelectedFileDate";

        public static string SPSelectedFileDate
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_SPSelectedFileDate];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_SPSelectedFileDate] = value;
            }
        }

        private static string _SPSaleDocumentNumberFrom = @"SV_SPSaleDocumentNumberFrom";

        public static string SPSaleDocumentNumberFrom
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_SPSaleDocumentNumberFrom];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_SPSaleDocumentNumberFrom] = value;
            }
        }

        private static string _SPSaleDocumentNumberTo = @"SV_SPSaleDocumentNumberTo";

        public static string SPSaleDocumentNumberTo
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_SPSaleDocumentNumberTo];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_SPSaleDocumentNumberTo] = value;
            }
        }

        private static string _SPTaxFilter = @"SV_SPTaxFilter";

        public static string SPTaxFilter
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_SPTaxFilter];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_SPTaxFilter] = value;
            }
        }

        private static string _SPMileageFilter = @"SV_SPMileageFilter";

        public static string SPMileageFilter
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_SPMileageFilter];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_SPMileageFilter] = value;
            }
        }

        private static string _SPSaleDateFilter = @"SV_SPSaleDateFilter";

        public static string SPSaleDateFilter
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_SPSaleDateFilter];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_SPSaleDateFilter] = value;
            }
        }

        private static string _SPManufacturerFilter = @"SV_SPManufacturerFilter";

        public static string SPManufacturerFilter
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_SPManufacturerFilter];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_SPManufacturerFilter] = value;
            }
        }

        private static string _SPSelectedInvoiceDateFrom = @"SV_SPSelectedInvoiceDateFrom";

        public static string SPSelectedInvoiceDateFrom
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_SPSelectedInvoiceDateFrom];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_SPSelectedInvoiceDateFrom] = value;
            }
        }

        private static string _SPSelectedInvoiceDateTo = @"SV_SPSelectedInvoiceDateTo";

        public static string SPSelectedInvoiceDateTo
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_SPSelectedInvoiceDateTo];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_SPSelectedInvoiceDateTo] = value;
            }
        }

        private static string _SPFleetSPPlateFilter = @"SV_SPFleetSPPlateFilter";

        public static string SPFleetSPPlateFilter
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_SPFleetSPPlateFilter];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_SPFleetSPPlateFilter] = value;
            }
        }

        #endregion

        #region "Fleet Cash Report"

        private static string _FCSelectedCurrencyId = @"SV_FCSelectedCurrencyId";

        public static string FCSelectedCurrencyId
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_FCSelectedCurrencyId];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_FCSelectedCurrencyId] = value;
            }
        }

        private static string _FCSelectedWeek = @"SV_FCSelectedWeek";

        public static string FCSelectedWeek
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_FCSelectedWeek];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_FCSelectedWeek] = value;
            }
        }

        private static string _FCSelectedYear = @"SV_FCSelectedYear";

        public static string FCSelectedYear
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_FCSelectedYear];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_FCSelectedYear] = value;
            }
        }

        private static string _FCSelectedMonth = @"SV_FCSelectedMonth";

        public static string FCSelectedMonth
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_FCSelectedMonth];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_FCSelectedMonth] = value;
            }
        }

        private static string _FCSelectedDay = @"SV_FCSelectedDay";

        public static string FCSelectedDay
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_FCSelectedDay];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_FCSelectedDay] = value;
            }
        }

        private static string _FTCReportTypePayables = @"SV_FTC_ReportTypePayables";
        private static string _FTCReportTypeReceivables = @"SV_FTC_ReportTypeReceivables";

        public static string FTCReportTypePayables
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_FTCReportTypePayables];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_FTCReportTypePayables] = value;
            }
        }

        public static string FTCReportTypeReceivables
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_FTCReportTypeReceivables];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_FTCReportTypeReceivables] = value;
            }
        }


        private static string _FTCReportUKRAC = @"SV_FTCReportUKRAC";
        private static string _FTCReportNetherlands = @"SV_FTCReportNetherlands";
        private static string _FTCReportSwitzerland = @"SV_FTCReportSwitzerland";
        private static string _FTCReportBelux = @"SV_FTCReportBelux";
        private static string _FTCReportGermany = @"SV_FTCReportGermany";
        private static string _FTCReportItaly = @"SV_FTCReportItaly";
        private static string _FTCReportSpain = @"SV_FTCReportSpain";
        private static string _FTCReportFrance = @"SV_FTCReportFrance";

        public static string FTCReportUKRAC
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_FTCReportUKRAC];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_FTCReportUKRAC] = value;
            }
        }
        
        public static string FTCReportNetherlands
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_FTCReportNetherlands];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_FTCReportNetherlands] = value;
            }
        }
        
        public static string FTCReportSwitzerland
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_FTCReportSwitzerland];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_FTCReportSwitzerland] = value;
            }
        }
        
        public static string FTCReportBelux
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_FTCReportBelux];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_FTCReportBelux] = value;
            }
        }
        
        public static string FTCReportGermany
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_FTCReportGermany];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_FTCReportGermany] = value;
            }
        }
        
        public static string FTCReportItaly
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_FTCReportItaly];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_FTCReportItaly] = value;
            }
        }
        
        public static string FTCReportSpain
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_FTCReportSpain];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_FTCReportSpain] = value;
            }
        }
        
        public static string FTCReportFrance
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_FTCReportFrance];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_FTCReportFrance] = value;
            }
        }

        private static string _FTCReportRegionNorth = @"SV_FTCReportRegionNorth";
        private static string _FTCReportRegionSouth = @"SV_FTCReportRegionSouth";
        private static string _FTCReportTotal = @"SV_FTCReportTotal";

        public static string FTCReportRegionNorth
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_FTCReportRegionNorth];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_FTCReportRegionNorth] = value;
            }
        }

        public static string FTCReportRegionSouth
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_FTCReportRegionSouth];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_FTCReportRegionSouth] = value;
            }
        }

        public static string FTCReportTotal
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_FTCReportTotal];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_FTCReportTotal] = value;
            }
        }

        #endregion
        
        #region "Currencies"

        private static string _CurrencyCodeSettings = @"SV_CurrencyCodeSettings";

        public static string CurrencyCodeSettings
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_CurrencyCodeSettings];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_CurrencyCodeSettings] = value;
            }
        }

        private static string _CurrencyIdSettings = @"SV_CurrencyIdSettings";

        public static string CurrencyIdSettings
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_CurrencyIdSettings];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_CurrencyIdSettings] = value;
            }
        }


        #endregion

        #region "Document Type Sessions"

        private static string _DocumentTypeSettings = @"SV_DocumentTypeSettings";

        public static string DocumentTypeSettings
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_DocumentTypeSettings];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_DocumentTypeSettings] = value;
            }
        }

        private static string _DocumentSubTypeSettings = @"SV_DocumentSubTypeSettings";

        public static string DocumentSubTypeSettings
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_DocumentSubTypeSettings];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_DocumentSubTypeSettings] = value;
            }
        }

        private static string _DocumentTypeIdSettings = @"SV_DocumentTypeIdSettings";

        public static string DocumentTypeIdSettings
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_DocumentTypeIdSettings];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_DocumentTypeIdSettings] = value;
            }
        }



        #endregion

        #region "Areas"

        private static string _AreaCountryIdAdd = @"SV_AreaCountryIdAdd";

        public static string AreaCountryIdAdd
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_AreaCountryIdAdd];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_AreaCountryIdAdd] = value;
            }
        }

        private static string _AreaCountryIdUpdate = @"SV_AreaCountryIdUpdate";

        public static string AreaCountryIdUpdate
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_AreaCountryIdUpdate];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_AreaCountryIdUpdate] = value;
            }
        }

        private static string _AreaCodeAdd = @"SV_AreaCodeAdd";

        public static string AreaCodeAdd
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_AreaCodeAdd];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_AreaCodeAdd] = value;
            }
        }

        private static string _AreaCodeUpdate = @"SV_AreaCodeUpdate";

        public static string AreaCodeUpdate
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_AreaCodeUpdate];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_AreaCodeUpdate] = value;
            }
        }

        #endregion

        #region "Dashboard Report"

        private static string _DashBoardCountryName = @"SV_DashBoardCountryName";

        public static string DashBoardCountryName
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_DashBoardCountryName];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_DashBoardCountryName] = value;
            }
        }

        private static string _DashboardGroupName = @"SV_DashBoardGroupName";

        public static string DashBoardGroupName
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_DashboardGroupName];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_DashboardGroupName] = value;
            }
        }

        private static string _DashBoardDocSubType = @"SV_DashBoardDocSubType";

        public static string DashBoardDocSubType
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_DashBoardDocSubType];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_DashBoardDocSubType] = value;
            }
        }

        private static string _DashBoardManufacturerId = @"SV_DashBoardManufacturerId";

        public static string DashBoardManufacturerId
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_DashBoardManufacturerId];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_DashBoardManufacturerId] = value;
            }
        }

        private static string _DashBoardCompanyId = @"SV_DashBoardCompanyId";

        public static string DashBoardCompanyId
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_DashBoardCompanyId];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_DashBoardCompanyId] = value;
            }
        }

        private static string _DashBoardCountryId = @"SV_DashBoardCountryId";

        public static string DashBoardCountryId
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_DashBoardCountryId];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_DashBoardCountryId] = value;
            }
        }

        private static string _DashBoardManufacturer = @"SV_DashBoardManufacturer";

        public static string DashBoardManufacturer
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_DashBoardManufacturer];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_DashBoardManufacturer] = value;
            }
        }

        private static string _DashBoardBuyer = @"SV_DashBoardBuyer";

        public static string DashBoardBuyer
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_DashBoardBuyer];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_DashBoardBuyer] = value;
            }
        }

        private static string _DashBoardBuyBack = @"SV_DashBoardBuyBack";

        public static string DashBoardBuyBack
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_DashBoardBuyBack];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_DashBoardBuyBack] = value;
            }
        }

        private static string _DashBoardNRBonus = @"SV_DashBoardNRBonus";

        public static string DashBoardNRBonus
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_DashBoardNRBonus];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_DashBoardNRBonus] = value;
            }
        }

        private static string _DashBoardVBouns = @"SV_DashBoardVBouns";

        public static string DashBoardVBouns
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_DashBoardVBouns];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_DashBoardVBouns] = value;
            }
        }

        private static string _DashBoardStatusOpen = @"SV_DashBoardStatusOpen";
        private static string _DashBoardStatusMatched = @"SV_DashBoardStatusMatched";
        private static string _DashBoardStatusUnapplied = @"SV_DashBoardStatusUnapplied";

        public static string DashBoardStatusOpen
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_DashBoardStatusOpen];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_DashBoardStatusOpen] = value;
            }
        }

        public static string DashBoardStatusMatched
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_DashBoardStatusMatched];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_DashBoardStatusMatched] = value;
            }
        }

        public static string DashBoardStatusUnapplied
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_DashBoardStatusUnapplied];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_DashBoardStatusUnapplied] = value;
            }
        }







        private static string _DashboardFilter = @"SV_DashboardFilter";

        public static FilterEvents DashboardFilter
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_DashboardFilter];
                return ((sessionObject != null) ? (FilterEvents)sessionObject : null);
            }
            set
            {
                HttpContext.Current.Session[_DashboardFilter] = value;
            }
        }

        #endregion

        #region "TaxFile"

        private static string _TaxFileDate = @"SV_TaxFileDate";
        private static string _TaxInvoiceFrom = @"SV_TaxInvoiceFrom";
        private static string _TaxInvoiceTo = @"SV_TaxInvoiceTo";

        public static string TaxFileDate
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_TaxFileDate];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_TaxFileDate] = value;
            }
        }

        public static string TaxInvoiceFrom
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_TaxInvoiceFrom];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_TaxInvoiceFrom] = value;
            }
        }

        public static string TaxInvoiceTo
        {
            get
            {
                object sessionObject = HttpContext.Current.Session[_TaxInvoiceTo];
                return ((sessionObject != null) ? sessionObject.ToString() : null);
            }
            set
            {
                HttpContext.Current.Session[_TaxInvoiceTo] = value;
            }
        }


        #endregion

    }
}