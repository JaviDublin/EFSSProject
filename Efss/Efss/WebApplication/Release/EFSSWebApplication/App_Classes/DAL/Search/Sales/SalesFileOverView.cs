using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Diagnostics;
using APP.Data;
using APP.Paging;
using RAD.Data;
using RAD.Diagnostics;
using RAD.Controls;

namespace APP.Search
{
    public class SalesFileOverView
    {
      
        public static List<SalesFileOverView> SelectSalesFileOverViewByFileDate(int? currentPageNumber, int? pageSize, string sortExpression, string FileDate, string InvoiceDate)
        {
            try
            {
                //Initialise Command
                SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = ConnectionManager.CreateProcedure(StoredProcedures.Select_SalesOverView_ByFileDate, con);

                //Check for null values 
                //If so set default values for paging
                currentPageNumber = (currentPageNumber == null) ? PagerSettings.DefaultPageNumber : currentPageNumber;
                pageSize = (pageSize == null) ? (int)DefaultPageSize.Ten : pageSize;


                //Set Parameters
                Parameters.CreateParameter(cmd, "@sortExpression", sortExpression);
                int? startRowIndex = ListViewPaging.SetStartRowIndex(currentPageNumber, pageSize);
                int? maximumRows = ListViewPaging.SetMaximumRows(currentPageNumber, pageSize);
                Parameters.CreateParameter(cmd, "@maximumRows", maximumRows);
                Parameters.CreateParameter(cmd, "@startRowIndex", startRowIndex);
                Parameters.CreateParameter(cmd, "@fileDate", FileDate);
                Parameters.CreateParameter(cmd, "@invoiceDate", InvoiceDate);

                //Execute Command
                var results = new List<SalesFileOverView>();
                using (con)
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        results.Add(new SalesFileOverView(reader));
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
        private string _fileDate;
        private int _totalInvoices;
        private int _fleetCo;
        private int _opCo;
        private int _original;
        private int _creditNotes;
        private int _buyback;
        private int _wholesale;
        private int _wreck;
        

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

        

        #endregion

        #region "Constructor"

        public SalesFileOverView(SqlDataReader reader)
        {
            if (reader["count"] != DBNull.Value)
                _count = Convert.ToInt32(reader["count"]);
            if (reader["CountryId"] != DBNull.Value)
                _countryId = Convert.ToInt32(reader["CountryId"]);
            if (reader["CountryName"] != DBNull.Value)
                _countryName = (string)reader["CountryName"];
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

        }

        #endregion

    }
}