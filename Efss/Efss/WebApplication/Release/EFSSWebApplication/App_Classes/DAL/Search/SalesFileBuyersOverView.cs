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
    public class SalesFileBuyersOverView
    {
        public static List<SalesFileBuyersOverView> SelectSalesFileOverViewByFileDateAndCountry(int? currentPageNumber, int? pageSize, string sortExpression, string FileDate, string invoiceDate, int CountryId)
        {
            try
            {
                //Initialise Command
                SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = ConnectionManager.CreateProcedure(StoredProcedures.Select_SalesOverView_ByFileDateAndCountry, con);

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
                Parameters.CreateParameter(cmd, "@countryId", CountryId);

                //Execute Command
                var results = new List<SalesFileBuyersOverView>();
                using (con)
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        results.Add(new SalesFileBuyersOverView(reader));
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
        private int _buyerId;
        private string _buyerCode;
        private string _buyerName;
        private string _fileDate;
        private int _totalInvoices;
        private int _fleetCo;
        private int _opCo;
        private int _original;
        private int _creditNotes;
        private int _buyback;
        private int _wholesale;
        private int _wreck;
        private string _email;

        #endregion

        #region "Properties"

        public int Count
        {
            get { return _count; }
        }

        public int BuyerId
        {
            get { return _buyerId; }
        }

        public string BuyerCode
        {
            get { return _buyerCode; }
        }

        public string BuyerName
        {
            get { return _buyerName; }
        }

        public string FileDate
        {
            get { return _fileDate; }
        }

        public int TotalInvoices
        {
            get { return _totalInvoices; }
        }
        public int FleetCo
        {
            get { return _fleetCo; }
        }
        public int OpCo
        {
            get { return _opCo; }
        }
        public int Original
        {
            get { return _original; }
        }
        public int CreditNotes
        {
            get { return _creditNotes; }
        }

        public int BuyBack
        {
            get { return _buyback; }
        }

        public int WholeSale
        {
            get { return _wholesale; }
        }

        public int Wreck
        {
            get { return _wreck; }
        }
        public string Email
        {
            get { return _email; }
        }


        #endregion

        #region "Constructor"

        public SalesFileBuyersOverView(SqlDataReader reader)
        {
            if (reader["count"] != DBNull.Value)
                _count = Convert.ToInt32(reader["count"]);
            if (reader["BuyerId"] != DBNull.Value)
                _buyerId = Convert.ToInt32(reader["BuyerId"]);
            if (reader["BuyerCode"] != DBNull.Value)
                _buyerCode = (string)reader["BuyerCode"];
            if (reader["BuyerName"] != DBNull.Value)
                _buyerName = (string)reader["BuyerName"];
            if (reader["FileDate"] != DBNull.Value)
                _fileDate = (string)reader["FileDate"];
            if (reader["TotalInvoices"] != DBNull.Value)
                _totalInvoices = Convert.ToInt32(reader["TotalInvoices"]);
            if (reader["FleetCo"] != DBNull.Value)
                _fleetCo = Convert.ToInt32(reader["FleetCo"]);
            if (reader["OpCo"] != DBNull.Value)
                _opCo = Convert.ToInt32(reader["OpCo"]);
            if (reader["Original"] != DBNull.Value)
                _original = Convert.ToInt32(reader["Original"]);
            if (reader["CreditNotes"] != DBNull.Value)
                _creditNotes = Convert.ToInt32(reader["CreditNotes"]);
            if (reader["BuyBack"] != DBNull.Value)
                _buyback = Convert.ToInt32(reader["BuyBack"]);
            if (reader["WholeSale"] != DBNull.Value)
                _wholesale = Convert.ToInt32(reader["WholeSale"]);
            if (reader["Wreck"] != DBNull.Value)
                _wreck = Convert.ToInt32(reader["Wreck"]);
            if (reader["Email"] != DBNull.Value)
                _email = (string)reader["Email"];

        }

        #endregion
    }
}