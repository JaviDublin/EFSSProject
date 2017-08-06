using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Diagnostics;
using APP.Data;
using RAD.Data;
using RAD.Diagnostics;
using RAD.Controls;
using APP.Session;

namespace APP.Reports
{
    public class TaxPriceOverView
    {
        public static List<TaxPriceOverView> SelectTaxPriceOverView(int? currentPageNumber, int? pageSize, string sortExpression)
        {
            try
            {
                //Initialise Command
                SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = ConnectionManager.CreateProcedure(StoredProcedures.TaxFilePricesOverView, con);

                currentPageNumber = (currentPageNumber == null) ? PagerSettings.DefaultPageNumber : currentPageNumber;
                pageSize = (pageSize == null) ? (int)DefaultPageSize.Fifteen : pageSize;

                //Set Parameters
                Parameters.CreateParameter(cmd, "@sortExpression", sortExpression);

                int? startRowIndex = PagerSettings.SetStartRowIndex(currentPageNumber, pageSize, DefaultPageSize.Ten);
                int? maximumRows = PagerSettings.SetMaximumRows(currentPageNumber, pageSize, DefaultPageSize.Ten);

                Parameters.CreateParameter(cmd, "@maximumRows", maximumRows);
                Parameters.CreateParameter(cmd, "@startRowIndex", startRowIndex);
                Parameters.CreateParameter(cmd, "@plate", SessionHandler.SPFleetSPPlateFilter);
               

                //Execute Command
                var results = new List<TaxPriceOverView>();
                using (con)
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        results.Add(new TaxPriceOverView(reader));
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

        public static List<TaxPriceOverView> SelectTaxPriceOverViewById(int rowId)
        {
            try
            {
                //Initialise Command
                SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = ConnectionManager.CreateProcedure(StoredProcedures.TaxFilePricesOverViewById, con);

                Parameters.CreateParameter(cmd, "@rowId", rowId);

                //Execute Command
                var results = new List<TaxPriceOverView>();
                using (con)
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        results.Add(new TaxPriceOverView(reader));
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
        private int _rowid;
        private string _serial;
        private string _co2;
        private string _itvserial;
        private string _taxCode;
        private string _taxpct;
        private string _unit;
        private string _vehicleCode;
        private string _plate;
        
        #endregion

        #region "Properties"

        public int Count
        {
            get { return _count; }
        }
        
        public int RowId
        {
            get { return _rowid; }
        }
        
        public string Serial
        {
            get { return _serial; }
        }
        
        public string CO2
        {
            get { return _co2; }
        }
        
        public string ITVSerial
        {
            get { return _itvserial; }
        }
        
        public string TaxCode
        {
            get { return _taxCode; }
        }
        
        public string TaxPCT
        {
            get { return _taxpct; }
        }

        public string Unit
        {
            get { return _unit; }
        }

        public string VehicleCode
        {
            get { return _vehicleCode; }
        }

        public string Plate
        {
            get { return _plate; }
        }

        #endregion
        
        #region "Constructor"

        public TaxPriceOverView(SqlDataReader reader)
        {
            if (reader["count"] != DBNull.Value)
                _count = Convert.ToInt32(reader["count"]);
            if (reader["RowId"] != DBNull.Value)
                _rowid = Convert.ToInt32(reader["RowId"]);
            if (reader["Serial"] != DBNull.Value)
                _serial = (string)reader["Serial"];
            if (reader["CO2"] != DBNull.Value)
                _co2 = (string)reader["CO2"];
            if (reader["ITVSerial"] != DBNull.Value)
                _itvserial = (string)reader["ITVSerial"];
            if (reader["TaxCode"] != DBNull.Value)
                _taxCode = (string)reader["TaxCode"];
            if (reader["TaxPCT"] != DBNull.Value)
                _taxpct = (string)reader["TaxPCT"];
            if (reader["Unit"] != DBNull.Value)
                _unit = (string)reader["Unit"];
            if (reader["VehicleCode"] != DBNull.Value)
                _vehicleCode = (string)reader["VehicleCode"];
            if (reader["Plate"] != DBNull.Value)
                _plate = (string)reader["Plate"];
        }
        
        #endregion
    }
}