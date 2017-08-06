using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Diagnostics;
using APP.Data;
using RAD.Data;
using RAD.Diagnostics;
using APP.Session;

namespace APP.Search
{
    public class BuyerName
    {

        public static List<BuyerName> SelectBuyersTax()
        {
            try
            {
                //Initialise Command
                SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = ConnectionManager.CreateProcedure(StoredProcedures.spSpainSelectBuyers, con);
                Parameters.CreateParameter(cmd, "@fileDate", SessionHandler.TaxFileDate);
                Parameters.CreateParameter(cmd, "@InvoiceFrom", SessionHandler.SPSaleDocumentNumberFrom);
                Parameters.CreateParameter(cmd, "@invoiceTo", SessionHandler.SPSaleDocumentNumberTo);
                Parameters.CreateParameter(cmd, "@taxFilter", SessionHandler.SPTaxFilter);
                Parameters.CreateParameter(cmd, "@mileage", SessionHandler.SPMileageFilter);
                Parameters.CreateParameter(cmd, "@saleDate", SessionHandler.SPSaleDateFilter);

                var results = new List<BuyerName>();
                using (con)
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        results.Add(new BuyerName(reader));
                    }
                }

                return results;

            }
            catch (Exception ex)
            {
                //Log Error
                StackTrace errorStackTrace = new StackTrace(true);
                Logs.LogError(errorStackTrace, ex);
                return null;
            }
        }

        private string _buyerName;

        public string VendorName
        {
            get { return _buyerName; }
        }

        public BuyerName(SqlDataReader reader)
        {
            if (reader["BuyerName"] != DBNull.Value)
                _buyerName = (string)reader["BuyerName"];
        }
    }
}