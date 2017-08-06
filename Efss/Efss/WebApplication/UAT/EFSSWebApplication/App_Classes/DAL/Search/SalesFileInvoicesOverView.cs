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
    public class SalesFileInvoicesOverView
    {
        public static List<SalesFileInvoicesOverView> SelectFileInvoicesOverView(int? currentPageNumber, int? pageSize, string sortExpression, string FileDate, string invoiceDate, int CountryId, int BuyerId)
        {
            try
            {
                //Initialise Command
                SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = ConnectionManager.CreateProcedure(StoredProcedures.Select_SalesOverView_ByBuyerId, con);

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
                Parameters.CreateParameter(cmd, "@fileDate", FileDate);
                Parameters.CreateParameter(cmd, "@invoiceDate", invoiceDate);
                Parameters.CreateParameter(cmd, "@buyerid", BuyerId);

                //Execute Command
                var results = new List<SalesFileInvoicesOverView>();
                using (con)
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        results.Add(new SalesFileInvoicesOverView(reader));
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
        private string _companyCode;
        private string _serial;
        private string _plate;
        private string _unit;
        private string _buyerCode;
        private string _invoiceNumber;
        private DateTime? _invoiceDate;
        private string _invoiceTotal;
        private string _invoiceStatus;

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

        public string CompanyCode
        {
            get { return _companyCode; }
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

        public string BuyerCode
        {
            get { return _buyerCode; }
        }

        public string InvoiceNumber
        {
            get { return _invoiceNumber; }
        }

        public string InvoiceDate
        {
            //get { return (_invoiceDate != null) ? string.Format("{0:dd/MM/yyyy HH:mm:ss}", _invoiceDate) : ""; }
            get { return (_invoiceDate != null) ? string.Format("{0:dd/MM/yyyy}", _invoiceDate) : ""; }
        }

        public string InvoiceTotal
        {
            get { return _invoiceTotal; }
        }

        public string InvoiceStatus
        {
            get { return _invoiceStatus; }
        }


        #endregion

        #region "Constructor"

        public SalesFileInvoicesOverView(SqlDataReader reader)
        {
            if (reader["count"] != DBNull.Value)
                _count = Convert.ToInt32(reader["count"]);
            if (reader["DocItemId"] != DBNull.Value)
                _docItemId = Convert.ToInt32(reader["DocItemId"]);
            if (reader["CompanyCode"] != DBNull.Value)
                _companyCode = (string)reader["CompanyCode"];
            if (reader["Serial"] != DBNull.Value)
                _serial = (string)reader["Serial"];
            if (reader["Plate"] != DBNull.Value)
                _plate = (string)reader["Plate"];
            if (reader["Unit"] != DBNull.Value)
                _unit = (string)reader["Unit"];
            if (reader["BuyerCode"] != DBNull.Value)
                _buyerCode = (string)reader["BuyerCode"];
            if (reader["InvoiceNumber"] != DBNull.Value)
                _invoiceNumber = (string)reader["InvoiceNumber"];
            if (reader["InvoiceDate"] != DBNull.Value)
                _invoiceDate = Convert.ToDateTime(reader["InvoiceDate"]);
            if (reader["InvoiceTotal"] != DBNull.Value)
                _invoiceTotal = (string)reader["InvoiceTotal"];
            if (reader["InvoiceStatus"] != DBNull.Value)
                _invoiceStatus = (string)reader["InvoiceStatus"];

        }

        #endregion
    }
}