using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Diagnostics;
using APP.Data;
using RAD.Data;
using RAD.Diagnostics;

namespace APP.Search
{
    public class SearchTaxCode
    {

         public static List<SearchTaxCode> SelectTaxCodes(int countryId)
        {
            try
            {
                //Initialise Command
                SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = ConnectionManager.CreateProcedure(StoredProcedures.ManualInvoicesSelectTax, con);
                Parameters.CreateParameter(cmd, "@countryId", countryId);
                

                var results = new List<SearchTaxCode>();
                using (con)
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        results.Add(new SearchTaxCode(reader));
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


        private int _taxCodeId;
        private string _taxCode;

        public int TaxCodeId
        {
            get { return _taxCodeId; }
        }

        public string TaxCode
        {
            get { return _taxCode; }
        }

        public SearchTaxCode(SqlDataReader reader)
        {
            if (reader["TaxCodeId"] != DBNull.Value)
                _taxCodeId = Convert.ToInt32(reader["TaxCodeId"]);
            if (reader["TaxCode"] != DBNull.Value)
                _taxCode = (string)reader["TaxCode"];
        }

    }
}