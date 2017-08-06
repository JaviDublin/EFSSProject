using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Diagnostics;
using APP.Data;
using APP.Paging;
using RAD.Data;
using RAD.Diagnostics;
namespace APP.Reports
{
    public class FleetYearReportOverView
    {
        public static List<FleetYearReportOverView> SelectFleetYearReport(int? currentPageNumber, int? pageSize, string sortExpression, string year, int fileId)
        {
            try
            {
                //Initialise Command
                SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = ConnectionManager.CreateProcedure(StoredProcedures.Select_Fleet_YearReport_AddsDel, con);

                //Check for null values 
                //If so set default values for paging
                currentPageNumber = (currentPageNumber == null) ? ListViewPaging.DefaultPageNumber : currentPageNumber;
                pageSize = (pageSize == null) ? ListViewPaging.DefaultPageSize : pageSize;

                //Set Parameters
                Parameters.CreateParameter(cmd, "@sortExpression", sortExpression);
                int? startRowIndex = ListViewPaging.SetStartRowIndex(currentPageNumber, pageSize);
                int? maximumRows = ListViewPaging.SetMaximumRows(currentPageNumber, pageSize);
                Parameters.CreateParameter(cmd, "@maximumRows", maximumRows);
                Parameters.CreateParameter(cmd, "@startRowIndex", startRowIndex);
                Parameters.CreateParameter(cmd, "@year", year);
                Parameters.CreateParameter(cmd, "@fileId", fileId);


                //Execute Command
                var results = new List<FleetYearReportOverView>();
                using (con)
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        results.Add(new FleetYearReportOverView(reader));
                    }
                }

                con.Close();
                return results;

            }
            catch (Exception ex)
            {
                StackTrace errorStackTrace = new StackTrace(true);
                Logs.LogError(errorStackTrace, ex);
                return null;
            }

        }

        #region "Fields"

        private int _count;
        private int _countryId;
        private string _countryName;
        private int _total;
        private int _january;
        private int _february;
        private int _march;
        private int _april;
        private int _may;
        private int _june;
        private int _july;
        private int _august;
        private int _september;
        private int _october;
        private int _november;
        private int _december;

        #endregion

        #region "Properties"

        public int Count
        {
            get { return _count; }
        }

        public int CountryId
        {
            get { return _countryId; }
        }

        public string CountryName
        {
            get { return _countryName; }
        }

        public int Total
        {
            get { return _total; }
        }

        public int January
        {
            get { return _january; }
        }

        public int February
        {
            get { return _february; }
        }

        public int March
        {
            get { return _march; }
        }

        public int April
        {
            get { return _april; }
        }

        public int May
        {
            get { return _may; }
        }

        public int June
        {
            get { return _june; }
        }

        public int July
        {
            get { return _july; }
        }

        public int August
        {
            get { return _august; }
        }

        public int September
        {
            get { return _september; }
        }

        public int October
        {
            get { return _october; }
        }

        public int November
        {
            get { return _november; }
        }

        public int December
        {
            get { return _december; }
        }


        #endregion

        #region "Constructor"

        public FleetYearReportOverView(SqlDataReader reader)
        {
            if (reader["count"] != DBNull.Value)
                _count = Convert.ToInt32(reader["count"]);
            if (reader["CountryId"] != DBNull.Value)
                _countryId = Convert.ToInt32(reader["CountryId"]);
            if (reader["CountryName"] != DBNull.Value)
                _countryName = (string)reader["CountryName"];
            if (reader["Total"] != DBNull.Value)
                _total = Convert.ToInt32(reader["Total"]);
            if (reader["January"] != DBNull.Value)
                _january = Convert.ToInt32(reader["January"]);
            if (reader["February"] != DBNull.Value)
                _february = Convert.ToInt32(reader["February"]);
            if (reader["March"] != DBNull.Value)
                _march = Convert.ToInt32(reader["March"]);
            if (reader["April"] != DBNull.Value)
                _april = Convert.ToInt32(reader["April"]);
            if (reader["May"] != DBNull.Value)
                _may = Convert.ToInt32(reader["May"]);
            if (reader["June"] != DBNull.Value)
                _june = Convert.ToInt32(reader["June"]);
            if (reader["July"] != DBNull.Value)
                _july = Convert.ToInt32(reader["July"]);
            if (reader["August"] != DBNull.Value)
                _august = Convert.ToInt32(reader["August"]);
            if (reader["September"] != DBNull.Value)
                _september = Convert.ToInt32(reader["September"]);
            if (reader["October"] != DBNull.Value)
                _october = Convert.ToInt32(reader["October"]);
            if (reader["November"] != DBNull.Value)
                _november = Convert.ToInt32(reader["November"]);
            if (reader["December"] != DBNull.Value)
                _december = Convert.ToInt32(reader["December"]);

        }

        #endregion
    }
}