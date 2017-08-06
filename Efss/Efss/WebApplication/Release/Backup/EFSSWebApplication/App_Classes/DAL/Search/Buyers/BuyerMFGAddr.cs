using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Diagnostics;
using APP.Data;
using RAD.Data;
using RAD.Diagnostics;

namespace APP.Search
{
    public class BuyerMFGAddr
    {
        public static List<BuyerMFGAddr> GetAddress(int countryId, int companyId, string buyername,string manufacturercode)
        {
            try
            {
                //Initialise Command
                SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = ConnectionManager.CreateProcedure(StoredProcedures.ManualInvoicesSelectBuyerAddress, con);
                Parameters.CreateParameter(cmd, "@countryId", countryId);
                Parameters.CreateParameter(cmd, "@companyId", companyId);
                Parameters.CreateParameter(cmd, "@buyerName", buyername);
                Parameters.CreateParameter(cmd, "@manufactuerCode", manufacturercode);

                var results = new List<BuyerMFGAddr>();
                using (con)
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        results.Add(new BuyerMFGAddr(reader));
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
        
        private string _buyerAddress;

        public string BuyerAddress
        {
            get { return _buyerAddress; }
        }

        public BuyerMFGAddr(SqlDataReader reader)
        {
            if (reader["BuyerAddress"] != DBNull.Value)
                _buyerAddress = (string)reader["BuyerAddress"];
        }
    }
}