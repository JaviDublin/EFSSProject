using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Diagnostics;
using APP.Data;
using APP.Paging;
using RAD.Data;
using RAD.Diagnostics;
namespace APP.Search
{
    public class FleetMonthOverView
    {
        public static List<FleetMonthOverView> SelectActiveFleetMonth(int? currentPageNumber, int? pageSize, string sortExpression, int? companyId)
        {
            try
            {
                //Initialise Command
                SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = ConnectionManager.CreateProcedure(StoredProcedures.Select_Receivables_OverView_Month, con);

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
                //Parameters.CreateParameter(cmd, "@companyId", companyId);

                //Execute Command
                var results = new List<FleetMonthOverView>();
                using (con)
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        results.Add(new FleetMonthOverView(reader));
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


        #region "Fileds"

        private int _count;
        private int _vehicleId;
        private string _serial;
        private string _unit;
        private string _plate;
        private string _mileage;
        private string _model;
        private string _manufacturer;
        private string _buyerName;
        private string _vehicleType;
        private string _inservicedate;

        #endregion

        #region "Poperties"

        public int Count
        {
            get { return _count; }
        }

        public int VehicleId
        {
            get { return _vehicleId; }
        }

        public string Serial
        {
            get { return _serial; }
        }

        public string Unit
        {
            get { return _unit; }
        }

        public string Plate
        {
            get { return _plate; }
        }

        public string Mileage
        {
            get { return _mileage; }
        }

        public string Model
        {
            get { return _model; }
        }

        public string Manufacturer
        {
            get { return _manufacturer; }
        }

        public string BuyerName
        {
            get { return _buyerName; }
        }

        public string VehicleType
        {
            get { return _vehicleType; }
        }

        public string InServiceDate
        {
            get { return _inservicedate; }
        }
        //public string InServiceDate
        //{
        //    get { return (_inservicedate != null) ? string.Format("{0:dd/MM/yyyy HH:mm:ss}", _inservicedate) : ""; }
        //}

        #endregion

        #region "Constructor"

        public FleetMonthOverView(SqlDataReader reader)
        {
            if (reader["count"] != DBNull.Value)
                _count = Convert.ToInt32(reader["count"]);
            if (reader["VehicleId"] != DBNull.Value)
                _vehicleId = Convert.ToInt32(reader["VehicleId"]);
            if (reader["Serial"] != DBNull.Value)
                _serial = (string)reader["Serial"];
            if (reader["Unit"] != DBNull.Value)
                _unit = (string)reader["Unit"];
            if (reader["Plate"] != DBNull.Value)
                _plate = (string)reader["Plate"];
            if (reader["Mileage"] != DBNull.Value)
                _mileage = (string)reader["Mileage"];
            if (reader["Model"] != DBNull.Value)
                _model = (string)reader["Model"];
            if (reader["Manufacturer"] != DBNull.Value)
                _manufacturer = (string)reader["Manufacturer"];
            if (reader["BuyerName"] != DBNull.Value)
                _buyerName = (string)reader["BuyerName"];
            if (reader["VehicleType"] != DBNull.Value)
                _vehicleType = (string)reader["VehicleType"];
            if (reader["InServiceDate"] != DBNull.Value)
                _inservicedate = (string)reader["InServiceDate"];
        }

        #endregion
    }
}