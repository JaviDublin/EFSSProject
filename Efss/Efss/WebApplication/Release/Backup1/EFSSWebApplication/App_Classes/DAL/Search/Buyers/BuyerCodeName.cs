using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Diagnostics;
using APP.Data;
using RAD.Data;
using RAD.Diagnostics;

namespace APP.Search
{
    public class BuyerCodeName
    {

        public static List<BuyerCodeName> SelectBuyers(int countryId,int companyId)
        {
            try
            {
                //Initialise Command
                SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = ConnectionManager.CreateProcedure(StoredProcedures.ManualInvoicesSelectBuyer, con);
                Parameters.CreateParameter(cmd, "@countryId", countryId);
                Parameters.CreateParameter(cmd, "@companyId", companyId);

                var results = new List<BuyerCodeName>();
                using (con)
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        results.Add(new BuyerCodeName(reader));
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
        private string _buyerCode;

        public string BuyerName
        {
            get { return _buyerName; }
        }

        public string BuyerCode
        {
            get { return _buyerCode; }
        }

        public BuyerCodeName(SqlDataReader reader)
        {
            if (reader["BuyerName"] != DBNull.Value)
                _buyerName = (string)reader["BuyerName"];
            if (reader["BuyerCode"] != DBNull.Value)
                _buyerCode = (string)reader["BuyerCode"];
        }

    }
}