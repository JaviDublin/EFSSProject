using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Diagnostics;
using APP.Data;
using RAD.Data;
using RAD.Diagnostics;

namespace APP.Search
{
    public class BuyerMFG
    {
        public static List<BuyerMFG> GetManufacturerCode(int countryId, int companyId,string buyername)
        {
            try
            {
                //Initialise Command
                SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = ConnectionManager.CreateProcedure(StoredProcedures.ManualInvoicesSelectBuyerManufacturer, con);
                Parameters.CreateParameter(cmd, "@countryId", countryId);
                Parameters.CreateParameter(cmd, "@companyId", companyId);
                Parameters.CreateParameter(cmd, "@buyerName", buyername);

                var results = new List<BuyerMFG>();
                using (con)
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        results.Add(new BuyerMFG(reader));
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

        private string _manufacturerCode;

        public string ManufacturerCode
        {
            get { return _manufacturerCode; }
        }

        public BuyerMFG(SqlDataReader reader)
        {
            if (reader["ManufacturerCode"] != DBNull.Value)
                _manufacturerCode = (string)reader["ManufacturerCode"];
        }
    }
}