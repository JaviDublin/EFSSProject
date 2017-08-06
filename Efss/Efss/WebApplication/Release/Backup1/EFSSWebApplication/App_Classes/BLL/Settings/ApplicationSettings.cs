using System;
using System.Diagnostics;
using System.Linq;
using APP.Search;
using RAD.Diagnostics;

namespace APP.Settings
{
    public class ApplicationSettings
    {
        public static string GetApplicationEmailAddress()
        {

            return (APP.Properties.Settings.Default.ApplicationEmailAddress);
        }

        public static int GetApplicationStartYear()
        {
            return (APP.Properties.Settings.Default.ApplicationStartYear);
        }

        public static string GetApplicationName()
        {
            return (APP.Properties.Settings.Default.ApplicationName);
        }

        public static string GetApplicationReportServerFolder()
        {
            return (APP.Properties.Settings.Default.ApplicationReportServerFolder);
        }

        public static string GetApplicationSupportEmail()
        {
            return (APP.Properties.Settings.Default.SupportEmailAddress);
        }

        public static string GetHelpDesk()
        {
            return (APP.Properties.Settings.Default.HelpDesk);
        }

        public static int GetCountryId(string CountryName)
        {
            try
            {
                var countryid = SearchCountries.SelectCountryId(CountryName).Select(c => (int)c.CountryId);
                return Convert.ToInt32(countryid.Single());
            }
            catch (Exception ex)
            {
                StackTrace errorStackTrace = new StackTrace(true);
                Logs.LogError(errorStackTrace, ex);
                return 0;
            }
        }

        public static int GetCompanyId(string CompanyName)
        {
            try
            {
                var companyid = SearchCompanies.SelectCompanyId(CompanyName).Select(c => (int)c.CompanyId);
                return Convert.ToInt32(companyid.Single());
            }
            catch (Exception ex)
            {
                StackTrace errorStackTrace = new StackTrace(true);
                Logs.LogError(errorStackTrace, ex);
                return 0;
            }
        }

        public static string getManufaturerName(int manufacturerId)
        {
            try
            {
                var manufacturerName = SearchManufacturers.SelectManufaturersById(manufacturerId).Select(n => n.ManufacturerName);
                return (string)manufacturerName.Single();
            }
            catch (Exception ex)
            {
                StackTrace errorStackTrace = new StackTrace(true);
                Logs.LogError(errorStackTrace, ex);
                return String.Empty;
            }
        }

        public static string getBuyerName(int buyerId)
        {
            try
            {
                var buyerName = BuyerDetails.SelectBuyerDetails(buyerId).Select(n => n.BuyerName);
                return (string)buyerName.Single();
            }
            catch (Exception ex)
            {
                StackTrace errorStackTrace = new StackTrace(true);
                Logs.LogError(errorStackTrace, ex);
                return String.Empty;
            }
        }

        public static int GetBuyerId(string buyerCode, int CountryId)
        {
            try
            {
                var buyerId = BuyerDetails.SelectBuyerDetailsByCode(buyerCode, CountryId).Select(i => (int)i.BuyerId);
                return Convert.ToInt32(buyerId.Single());
            }
            catch (Exception ex)
            {
                StackTrace errorStackTrace = new StackTrace(true);
                Logs.LogError(errorStackTrace, ex);
                return 0;
            }
        }

        public static int GetGroupId(int countryid)
        {
            try
            {
                var groupid = CompanyGroup.SelectCompanyGroupId(countryid).Select(g => (int)g.GroupId);
                return Convert.ToInt32(groupid.Single());
            }
            catch (Exception ex)
            {
                StackTrace errorStackTrace = new StackTrace(true);
                Logs.LogError(errorStackTrace, ex);
                return 0;
            }
        }

        public static int GetEmailId(int countryid)
        {
            try
            {
                var emailid = CompanyEmailId.SelectCompanyEmailId(countryid).Select(g => (int)g.EmailId);
                return Convert.ToInt32(emailid.Single());
            }
            catch (Exception ex)
            {
                StackTrace errorStackTrace = new StackTrace(true);
                Logs.LogError(errorStackTrace, ex);
                return 0;
            }
        }

        public static string GetReportFolderName()
        {
            return (APP.Properties.Settings.Default.ReportFolder);
        }

    }
}