using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using APP.Data;
using APP.Search;
using System.Diagnostics;
using RAD.Diagnostics;
using APP.Reports;

namespace APP.Settings
{
    public class ReportSettings
    {
        public static string GetLastDateTaxFileReport()
        {
            try
            {
                var lastdate = SearchLastDates.SelectRequestedDate("spReportsGetMaxDateTaxFileReport").Select(d => d.RequestDate);
                return Convert.ToString(lastdate.Single());
            }
            catch (Exception ex)
            {
                StackTrace errorStackTrace = new StackTrace(true);
                Logs.LogError(errorStackTrace, ex);
                return null;
            }
        
        }
        
        public static string GetLastDateFleetDayReport()
        {
            try
            {
                var lastdate = SearchLastDates.SelectRequestedDate("spFleetGetMaxDateFleetDayReport").Select(d => d.RequestDate);
                return Convert.ToString(lastdate.Single());
            }
            catch (Exception ex)
            {
                StackTrace errorStackTrace = new StackTrace(true);
                Logs.LogError(errorStackTrace, ex);
                return null;
            }
        }

        public static string GetLastYearFleetMonthReport()
        { 
            try
            {
                var lastyear = SearchLastDates.SelectRequestedDate("spFleetGetMaxYearMonthReport").Select(d => d.RequestDate);
                return Convert.ToString(lastyear.Single());
            }
            catch (Exception ex)
            {
                StackTrace errorStackTrace = new StackTrace(true);
                Logs.LogError(errorStackTrace, ex);
                return null;
            }
        }

        public static string GetLastMonthFleetMonthReport()
        {
            try
            {
                var lastmonth = SearchLastDates.SelectRequestedDate("spFleetGetMaxMonthMonthReport").Select(d => d.RequestDate);
                return Convert.ToString(lastmonth.Single());
            }
            catch (Exception ex)
            {
                StackTrace errorStackTrace = new StackTrace(true);
                Logs.LogError(errorStackTrace, ex);
                return null;
            }
        }

        public static string GetLastDateSalesLogFile()
        {
            try
            {
                var lastdate = SearchLastDates.SelectRequestedDate("spSalesGetMaxDateLogFile").Select(d => d.RequestDate);
                return Convert.ToString(lastdate.Single());
            }
            catch (Exception ex)
            {
                StackTrace errorStackTrace = new StackTrace(true);
                Logs.LogError(errorStackTrace, ex);
                return null;
            }
        }

        public static string GetFCTCurrentWeek()
        {
            try
            {
                var currentWeek = Reports.FCTLastSettings.GetFleetCashTargetLastSettings().Select(w => w.CurrentWeek);
                return Convert.ToString(currentWeek.Single()); 
            }
            catch (Exception ex)
            {
                StackTrace errorStackTrace = new StackTrace(true);
                Logs.LogError(errorStackTrace, ex);
                return null;
            }
        }

        public static string GetMaxWeek()
        {
            try
            {
                var maxWeek = Reports.FCTLastSettings.GetFleetCashTargetLastSettings().Select(w => w.MaxWeek);
                return Convert.ToString(maxWeek.Single());
            }
            catch (Exception ex)
            {
                StackTrace errorStackTrace = new StackTrace(true);
                Logs.LogError(errorStackTrace, ex);
                return null;
            }
        }

        public static string GetLastFCTCurrencyId()
        { 
            try
            {
                var currencyId = Reports.FCTLastSettings.GetFleetCashTargetLastSettings().Select(c => c.CurrencyId);
                return Convert.ToString(currencyId.Single());
            }
            catch (Exception ex)
            {
                StackTrace errorStackTrace = new StackTrace(true);
                Logs.LogError(errorStackTrace, ex);
                return null;
            }
        }

        public static string GetCurrentYear()
        {
            DateTime currentyear = DateTime.Now;
            return currentyear.Year.ToString();
        }

        public static string GetCurrentMonth()
        {
            DateTime currentMonth = DateTime.Now;
            return currentMonth.Month.ToString();
        }

        public static string GetLastYearFleetDayAddReport()
        {
            try
            {
                var lastyear = SearchLastDates.SelectRequestedDate("spFleetGetMaxYearDayAddReport").Select(d => d.RequestDate);
                return Convert.ToString(lastyear.Single());
            }
            catch (Exception ex)
            {
                StackTrace errorStackTrace = new StackTrace(true);
                Logs.LogError(errorStackTrace, ex);
                return null;
            }
        }

        public static string GetLastMonthFleetDayAddReport()
        {
            try
            {
                var lastmonth = SearchLastDates.SelectRequestedDate("spFleetGetMaxMonthDayAddReport").Select(d => d.RequestDate);
                return Convert.ToString(lastmonth.Single());
            }
            catch (Exception ex)
            {
                StackTrace errorStackTrace = new StackTrace(true);
                Logs.LogError(errorStackTrace, ex);
                return null;
            }
        }

        public static string GetToday()
        {
            return Convert.ToString(DateTime.Now.ToString("dd/MM/yyyy"));
        }

    }
}