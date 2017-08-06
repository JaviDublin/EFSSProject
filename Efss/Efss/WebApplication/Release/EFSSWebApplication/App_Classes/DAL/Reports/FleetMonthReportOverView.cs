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
    public class FleetMonthReportOverView
    {
        public static List<FleetMonthReportOverView> SelectFleetMonthReport(int? currentPageNumber, int? pageSize, string sortExpression, string month, string year)
        {
            try
            {
                //Initialise Command
                SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = ConnectionManager.CreateProcedure(StoredProcedures.Select_Fleet_MonthReport, con);

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
                Parameters.CreateParameter(cmd, "@month", month);
                Parameters.CreateParameter(cmd, "@year", year);


                //Execute Command
                var results = new List<FleetMonthReportOverView>();
                using (con)
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        results.Add(new FleetMonthReportOverView(reader));
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
        private int _rowId;
        private string _countryName;
        private int _total;
        private int _active;
        private int _conversion;
        private int _delivered;
        private int _inactive;
        private int _suspend;
        private int _future;
        private int _other;
        private string _regionName;

        #endregion

        #region "Properties"

        public int Count
        {
            get { return _count; }
        }

        public int RowId
        {
            get { return _rowId; }
        }

        public string CountryName
        {
            get { return _countryName; }
        }

        public int Total
        {
            get { return _total; }
        }

        public int Active
        {
            get { return _active; }
        }

        public int Conversion
        {
            get { return _conversion; }
        }

        public int Delivered
        {
            get { return _delivered; }
        }

        public int Inactive
        {
            get { return _inactive; }
        }

        public int Suspend
        {
            get { return _suspend; }
        }

        public int Future
        {
            get { return _future; }
        }

        public int Other
        {
            get { return _other; }
        }

        public string RegionName
        {
            get { return _regionName; }
        }


        #endregion

        #region "Constructor"

        public FleetMonthReportOverView(SqlDataReader reader)
        {
            if (reader["count"] != DBNull.Value)
                _count = Convert.ToInt32(reader["count"]);
            if (reader["RowId"] != DBNull.Value)
                _rowId = Convert.ToInt32(reader["RowId"]);
            if (reader["CountryName"] != DBNull.Value)
                _countryName = (string)reader["CountryName"];
            if (reader["Total"] != DBNull.Value)
                _total = Convert.ToInt32(reader["Total"]);
            if (reader["Active"] != DBNull.Value)
                _active = Convert.ToInt32(reader["Active"]);
            if (reader["Conversion"] != DBNull.Value)
                _conversion = Convert.ToInt32(reader["Conversion"]);
            if (reader["Delivered"] != DBNull.Value)
                _delivered = Convert.ToInt32(reader["Delivered"]);
            
            if (reader["Inactive"] != DBNull.Value)
                _inactive = Convert.ToInt32(reader["Inactive"]);
            if (reader["Suspend"] != DBNull.Value)
                _suspend = Convert.ToInt32(reader["Suspend"]);
            if (reader["Future"] != DBNull.Value)
                _future = Convert.ToInt32(reader["Future"]);
            if (reader["Other"] != DBNull.Value)
                _other = Convert.ToInt32(reader["Other"]);
            if (reader["RegionName"] != DBNull.Value)
                _regionName = (string)reader["RegionName"];
        }

        #endregion
    }
}