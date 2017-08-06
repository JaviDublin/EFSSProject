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
    public class SerialsOverView
    {
        public static List<SerialsOverView> SelectSerialsOverView(int? currentPageNumber, int? pageSize, string sortExpression)
        {
            try
            {
                //Initialise Command
                SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = ConnectionManager.CreateProcedure(StoredProcedures.Select_Serials_OverView, con);

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

                //Execute Command
                var results = new List<SerialsOverView>();
                using (con)
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        results.Add(new SerialsOverView(reader));
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
        private string _companyCode;
        private string _invoiceType;
        private string _serial;
        private string _amount;
        private string _invoiceDate;
        private string _buyerName;
        private string _manufacturerName;
        private string _invoiceNumber;


        //private string _vehicleStatus;
        //private string _plate;
        //private string _unit;
        //private DateTime? _invoiceDate;
        //private bool _isValid;
        //private bool _isDuplicate;

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

        public string CompanyCode
        {
            get { return _companyCode; }
        }

        public string InvoiceType
        {
            get { return _invoiceType; }
        }

        public string Serial
        {
            get { return _serial; }
        }

        public string Amount
        {
            get { return _amount; }
        }

        public string InvoiceDate
        {
            get { return _invoiceDate; }
            //get { return (_invoiceDate != null) ? string.Format("{0:dd/MM/yyyy HH:mm:ss}", _invoiceDate) : ""; }
            //get { return (_invoiceDate != null) ? string.Format("{0:dd/MM/yyyy}", _invoiceDate) : ""; }
        }

        public string BuyerName
        {
            get { return _buyerName; }
        }

        public string ManufacturerName
        {
            get { return _manufacturerName; }
        }

        public string InvoiceNumber
        {
            get { return _invoiceNumber; }
        }

        

       

        //public string IsValid
        //{
        //    get { return (_isValid == true) ? "~/App_Images/yes.gif" : "~/App_Images/no.gif"; }
        //}

        //public string IsDuplicate
        //{
        //    get { return (_isDuplicate == true) ? "~/App_Images/error.png" : "~/App_Images/yes.gif"; }
        //}

        #endregion

        #region "Constructor"

        public SerialsOverView(SqlDataReader reader)
        {
            if (reader["count"] != DBNull.Value)
                _count = Convert.ToInt32(reader["count"]);
            if (reader["RowId"] != DBNull.Value)
                _rowId = Convert.ToInt32(reader["RowId"]);
            if (reader["CompanyCode"] != DBNull.Value)
                _companyCode = (string)reader["CompanyCode"];
            if (reader["InvoiceType"] != DBNull.Value)
                _invoiceType = (string)reader["InvoiceType"];
            if (reader["Serial"] != DBNull.Value)
                _serial = (string)reader["Serial"];
            if (reader["Amount"] != DBNull.Value)
                _amount = (string)reader["Amount"];
            //if (reader["DateCreated"] != DBNull.Value)
            //    _invoiceDate = Convert.ToDateTime(reader["DateCreated"]);
            if (reader["InvoiceDate"] != DBNull.Value)
                _invoiceDate = (string)reader["InvoiceDate"];
            if (reader["BuyerName"] != DBNull.Value)
                _buyerName = (string)reader["BuyerName"];
            if (reader["ManufacturerName"] != DBNull.Value)
                _manufacturerName = (string)reader["ManufacturerName"];
            if (reader["InvoiceNumber"] != DBNull.Value)
                _invoiceNumber = (string)reader["InvoiceNumber"];
            
            
            //if (reader["IsValid"] != DBNull.Value)
            //    _isValid = Convert.ToBoolean(reader["IsValid"]);
            //if (reader["IsDuplicate"] != DBNull.Value)
            //    _isDuplicate = Convert.ToBoolean(reader["IsDuplicate"]);

        }

        #endregion
    }
}