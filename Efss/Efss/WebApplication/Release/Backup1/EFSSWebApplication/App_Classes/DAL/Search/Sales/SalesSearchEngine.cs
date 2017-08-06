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
    public class SalesSearchEngine
    {
        public static List<SalesSearchEngine> SearchInvoices(int? currentPageNumber, int? pageSize, string sortExpression, int companyId, string plate, string serial, string unit, string dateFrom, string dateTo, int invoiceFrom, int invoiceTo, string buyerCode, string buyerName, string invoiceType, string invoiceSubType, string manufacturer, string vehicletype,string saleType)
        {
            try
            {
                //Initialise Command
                SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = ConnectionManager.CreateProcedure(StoredProcedures.Select_SearchEngine, con);

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
                Parameters.CreateParameter(cmd, "@companyId", companyId);
                Parameters.CreateParameter(cmd, "@plate", plate);
                Parameters.CreateParameter(cmd, "@unit", unit);
                Parameters.CreateParameter(cmd, "@serial", serial);
                Parameters.CreateParameter(cmd, "@dateFrom", dateFrom);
                Parameters.CreateParameter(cmd, "@dateTo", dateTo);
                Parameters.CreateParameter(cmd, "@invoiceFrom", invoiceFrom);
                Parameters.CreateParameter(cmd, "@invoiceTo", invoiceTo);
                Parameters.CreateParameter(cmd, "@buyerCode", buyerCode);
                Parameters.CreateParameter(cmd, "@buyerName", buyerName);
                Parameters.CreateParameter(cmd, "@invoiceType", invoiceType);
                Parameters.CreateParameter(cmd, "@invoiceSubType", invoiceSubType);
                Parameters.CreateParameter(cmd, "@manufacturer", manufacturer);
                Parameters.CreateParameter(cmd, "@vehicleType", vehicletype);
                Parameters.CreateParameter(cmd, "@saleType", saleType);


                //Execute Command
                var results = new List<SalesSearchEngine>();
                using (con)
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        results.Add(new SalesSearchEngine(reader));
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
        private int _docItemId;
        private string _serial;
        private string _plate;
        private string _unit;
        private string _manufacturer;
        private int _documentNumber;
        //private DateTime? _invoiceDate;
        private string _invoiceDate;
        private string _buyerCode;
        private string _buyerName;
        private string _docType;
        private string _docSubType;
        private string _modelCode;
        private string _vehicleType;

        #endregion

        #region "Properties"

        public int Count
        {
            get { return _count; }
        }

        public int DocItemId
        {
            get { return _docItemId; }
        }

        public string Serial
        {
            get { return _serial; }
        }

        public string Plate
        {
            get { return _plate; }
        }

        public string Unit
        {
            get { return _unit; }
        }

        public int DocumentNumber
        {
            get { return _documentNumber; }
        }

        public string InvoiceDate
        {
            get { return _invoiceDate; }
            //get { return (_invoiceDate != null) ? string.Format("{0:dd/MM/yyyy HH:mm:ss}", _invoiceDate) : ""; }
        }

        public string DocType
        {
            get { return _docType; }
        }

        public string DocSubType
        {
            get { return _docSubType; }

        }

        public string BuyerCode
        {
            get { return _buyerCode; }
        }

        public string BuyerName
        {
            get { return _buyerName; }
        }

        public string ModelCode
        {
            get { return _modelCode; }
        }

        public string ManufacturerName
        {
            get { return _manufacturer; }
        }

        public string VehicleType
        {
            get { return _vehicleType; }
        }

        #endregion

        #region "Constructor"

        public SalesSearchEngine(SqlDataReader reader)
        {
            if (reader["count"] != DBNull.Value)
                _count = Convert.ToInt32(reader["count"]);
            if (reader["DocItemId"] != DBNull.Value)
                _docItemId = Convert.ToInt32(reader["DocItemId"]);
            if (reader["Serial"] != DBNull.Value)
                _serial = (string)reader["Serial"];
            if (reader["Plate"] != DBNull.Value)
                _plate = (string)reader["Plate"];
            if (reader["Unit"] != DBNull.Value)
                _unit = (string)reader["Unit"];
            if (reader["DocumentNumber"] != DBNull.Value)
                _documentNumber = Convert.ToInt32(reader["DocumentNumber"]);
            if (reader["InvoiceDate"] != DBNull.Value)
                _invoiceDate = (string)reader["InvoiceDate"];
            //_invoiceDate = Convert.ToDateTime(reader["InvoiceDate"]);
            if (reader["DocType"] != DBNull.Value)
                _docType = (string)reader["DocType"];
            if (reader["DocSubType"] != DBNull.Value)
                _docSubType = (string)reader["DocSubType"];
            if (reader["BuyerCode"] != DBNull.Value)
                _buyerCode = (string)reader["BuyerCode"];
            if (reader["BuyerName"] != DBNull.Value)
                _buyerName = (string)reader["BuyerName"];
            if (reader["ModelCode"] != DBNull.Value)
                _modelCode = (string)reader["ModelCode"];
            if (reader["ManufacturerName"] != DBNull.Value)
                _manufacturer = (string)reader["ManufacturerName"];
            if (reader["VehicleType"] != DBNull.Value)
                _vehicleType = (string)reader["VehicleType"];

        }

        #endregion
    }
}