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
    public class FleetDayReportOverView
    {
        public static List<FleetDayReportOverView> SelectFleetDayReport(int? currentPageNumber, int? pageSize, string sortExpression, string date)
        {
            try
            {
                //Initialise Command
                SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = ConnectionManager.CreateProcedure(StoredProcedures.Select_Fleet_DayReport, con);

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
                Parameters.CreateParameter(cmd, "@dateCreated", date);


                //Execute Command
                var results = new List<FleetDayReportOverView>();
                using (con)
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        results.Add(new FleetDayReportOverView(reader));
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
        private string _regionName;
        private decimal _totalPCT;
        private int _buyback;
        private decimal _buybackpct;
        private int _wholesale;
        private decimal _wholesalepct;
        private int _lease;
        private decimal _leasepct;

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

        public string RegionName
        {
            get { return _regionName; }
        }

        public decimal TotalPCT
        {
            get { return _totalPCT; }
        }

        public int BuyBack
        {
            get { return _buyback; }
        }

        public decimal BuyBackPCT
        {
            get { return _buybackpct; }
        }

        public int WholeSale
        {
            get { return _wholesale; }
        }

        public decimal WholeSalePCT
        {
            get { return _wholesalepct; }
        }

        public int Lease
        {
            get { return _lease; }
        }

        public decimal LeasePCT
        {
            get { return _leasepct; }
        }

        #endregion

        #region "Constructor"

        public FleetDayReportOverView(SqlDataReader reader)
        {
            if (reader["count"] != DBNull.Value)
                _count = Convert.ToInt32(reader["count"]);
            if (reader["RowId"] != DBNull.Value)
                _rowId = Convert.ToInt32(reader["RowId"]);
            if (reader["CountryName"] != DBNull.Value)
                _countryName = (string)reader["CountryName"];
            if (reader["Total"] != DBNull.Value)
                _total = Convert.ToInt32(reader["Total"]);
            if (reader["RegionName"] != DBNull.Value)
                _regionName = (string)reader["RegionName"];
            if (reader["TotalPCT"] != DBNull.Value)
                _totalPCT = Convert.ToDecimal(reader["TotalPCT"]);
            if (reader["BuyBack"] != DBNull.Value)
                _buyback = Convert.ToInt32(reader["BuyBack"]);
            if (reader["BuyBackPCT"] != DBNull.Value)
                _buybackpct = Convert.ToDecimal(reader["BuyBackPCT"]);
            if (reader["WholeSale"] != DBNull.Value)
                _wholesale = Convert.ToInt32(reader["WholeSale"]);
            if (reader["WholeSalePCT"] != DBNull.Value)
                _wholesalepct = Convert.ToDecimal(reader["WholeSalePCT"]);
            if (reader["Lease"] != DBNull.Value)
                _lease = Convert.ToInt32(reader["Lease"]);
            if (reader["LeasePCT"] != DBNull.Value)
                _leasepct = Convert.ToDecimal(reader["LeasePCT"]);
        }

        #endregion
    }
}