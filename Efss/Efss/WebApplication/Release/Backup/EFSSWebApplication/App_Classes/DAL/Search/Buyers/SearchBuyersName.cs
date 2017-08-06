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
    public class SearchBuyersName
    {

        public static List<SearchBuyersName> SelectBuyersName(int countryId, int buyerCode)
        {
            try
            {
                //Initialise Command
                SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = ConnectionManager.CreateProcedure(StoredProcedures.Select_BuyerName, con);
                Parameters.CreateParameter(cmd, "@countryId", countryId);
                Parameters.CreateParameter(cmd, "@buyerCode", buyerCode);

                var results = new List<SearchBuyersName>();

                using (con)
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        results.Add(new SearchBuyersName(reader));
                    }
                }

                return results;
            }
            catch (Exception ex)
            {
                StackTrace errorStackTrace = new StackTrace(true);
                Logs.LogError(errorStackTrace, ex);
                return null;
            }
        }


        public static List<SearchBuyersName> SelectBuyersNameDashboard()
        {
            try
            {
                //Initialise Command
                SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = ConnectionManager.CreateProcedure(StoredProcedures.BuyersSelectNameListing, con);
                Parameters.CreateParameter(cmd, "@countryId", SessionHandler.DashBoardCountryId);
                Parameters.CreateParameter(cmd, "@companyId", SessionHandler.DashBoardCompanyId);
                Parameters.CreateParameter(cmd, "@manufacturerId", SessionHandler.DashBoardManufacturer);

                var results = new List<SearchBuyersName>();

                using (con)
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        results.Add(new SearchBuyersName(reader));
                    }
                }

                return results;
            }
            catch (Exception ex)
            {
                StackTrace errorStackTrace = new StackTrace(true);
                Logs.LogError(errorStackTrace, ex);
                return null;
            }
        }

        private int _buyerId;
        private string _buyerName;

        public string BuyerName
        {
            get { return _buyerName; }
        }

        public int BuyerId
        {
            get { return _buyerId; }
        }

        public SearchBuyersName(SqlDataReader reader)
        {
            if (reader["BuyerId"] != DBNull.Value)
                _buyerId = Convert.ToInt32(reader["BuyerId"]);
            if (reader["BuyerName"] != DBNull.Value)
                _buyerName = (string)reader["BuyerName"];
        }
    }
}