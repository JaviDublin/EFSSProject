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
    public class TaxOverView
    {
        public static List<TaxOverView> SelectTaxFileOverView(int? currentPageNumber, int? pageSize, string sortExpression)
        {
            try
            {
                //Initialise Command
                SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = ConnectionManager.CreateProcedure(StoredProcedures.TaxFileOverView, con);

                currentPageNumber = (currentPageNumber == null) ? PagerSettings.DefaultPageNumber : currentPageNumber;
                pageSize = (pageSize == null) ? (int)DefaultPageSize.Fifteen : pageSize;

                //Set Parameters
                Parameters.CreateParameter(cmd, "@sortExpression", sortExpression);

                int? startRowIndex = PagerSettings.SetStartRowIndex(currentPageNumber, pageSize, DefaultPageSize.Fifteen);
                int? maximumRows = PagerSettings.SetMaximumRows(currentPageNumber, pageSize, DefaultPageSize.Fifteen);

                Parameters.CreateParameter(cmd, "@maximumRows", maximumRows);
                Parameters.CreateParameter(cmd, "@startRowIndex", startRowIndex);
                Parameters.CreateParameter(cmd, "@fileDate", SessionHandler.TaxFileDate);
                Parameters.CreateParameter(cmd, "@InvoiceFrom", SessionHandler.SPSaleDocumentNumberFrom);
                Parameters.CreateParameter(cmd, "@invoiceTo", SessionHandler.SPSaleDocumentNumberTo);
                Parameters.CreateParameter(cmd, "@taxFilter", SessionHandler.SPTaxFilter);
                Parameters.CreateParameter(cmd, "@mileage", SessionHandler.SPMileageFilter);
                Parameters.CreateParameter(cmd, "@saleDate", SessionHandler.SPSaleDateFilter);
                Parameters.CreateParameter(cmd, "@manufacturerName", SessionHandler.SPManufacturerFilter);

                //Execute Command
                var results = new List<TaxOverView>();
                using (con)
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        results.Add(new TaxOverView(reader));
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
        private string _plate;
        private string _mileage;
        private string _manufacturerName;
        private string _invoiceNumber;
        private string _saleDocumentNumber;
        private string _regTaxAmount;
        private string _fileDate;


        private string _fuelType;
        private string _co2;
        private string _itvSerial;
        private string _vehicleCode;
        private bool _isCorrect;


        private string _nrcDate;
        private bool _processed;
        private bool _isExported;
  
        
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

        public string Plate
        {
            get { return _plate; }
        }

        public string Mileage
        {
            get { return _mileage; }
        }

        public string ManufacturerName
        {
            get { return _manufacturerName; }
        }

        public string InvoiceNumber
        {
            get { return _invoiceNumber; }
        }

        public string SaleDocumentNumber
        {
            get { return _saleDocumentNumber; }
        }

        public string RegTaxAmount
        {
            get { return _regTaxAmount; }
        }

        public string FileDate
        {
            get { return _fileDate; }
        }

        public string FuelType
        {
            get { return _fuelType; }
        }

        public string CO2
        {
            get { return _co2; }
        }

        public string ITVSerial
        {
            get { return _itvSerial; }
        }

        public string VehicleCode
        {
            get { return _vehicleCode; }
        }

        public string IsCorrect
        {
            get { return (_isCorrect == true) ? "~/App_Images/yes.gif" : "~/App_Images/no.gif"; }
        }

        public string NrcDate
        {
            get { return _nrcDate; }
        }

        public string Processed
        {
            get { return (_processed == true) ? "~/App_Images/yes.gif" : "~/App_Images/no.gif"; }
        }
        
        public string IsExported
        {
            get { return (_isExported == true) ? "~/App_Images/yes.gif" : "~/App_Images/no.gif"; }
        }

        
        #endregion

        #region "Constructor"

        public TaxOverView(SqlDataReader reader)
        {
            if (reader["count"] != DBNull.Value)
                _count = Convert.ToInt32(reader["count"]);
            if (reader["RowId"] != DBNull.Value)
                _rowid = Convert.ToInt32(reader["RowId"]);
            if (reader["Serial"] != DBNull.Value)
                _serial = (string)reader["Serial"];
            if (reader["Plate"] != DBNull.Value)
                _plate = (string)reader["Plate"];
            if (reader["Mileage"] != DBNull.Value)
                _mileage = (string)reader["Mileage"];
            if (reader["ManufacturerName"] != DBNull.Value)
                _manufacturerName = (string)reader["ManufacturerName"];
            if (reader["InvoiceNumber"] != DBNull.Value)
                _invoiceNumber = (string)reader["InvoiceNumber"];
            if (reader["SaleDocumentNumber"] != DBNull.Value)
                _saleDocumentNumber = (string)reader["SaleDocumentNumber"];
            if (reader["RegTaxAmount"] != DBNull.Value)
                _regTaxAmount = (string)reader["RegTaxAmount"];
            if (reader["FileDate"] != DBNull.Value)
                _fileDate = (string)reader["FileDate"];
            if (reader["FuelType"] != DBNull.Value)
                _fuelType = (string)reader["FuelType"];
            if (reader["CO2"] != DBNull.Value)
                _co2 = (string)reader["CO2"];
            if (reader["ITVSerial"] != DBNull.Value)
                _itvSerial = (string)reader["ITVSerial"];
            if (reader["VehicleCode"] != DBNull.Value)
                _vehicleCode = (string)reader["VehicleCode"];
            if (reader["IsCorrect"] != DBNull.Value)
                _isCorrect = Convert.ToBoolean(reader["IsCorrect"]);           
            if (reader["NRCDate"] != DBNull.Value)
                _nrcDate = (string)reader["NRCDate"];
            if (reader["Processed"] != DBNull.Value)
                _processed = Convert.ToBoolean(reader["Processed"]);
             if (reader["IsExported"] != DBNull.Value)
                 _isExported = Convert.ToBoolean(reader["IsExported"]);
        
        }

        #endregion

    }
}