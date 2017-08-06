using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Diagnostics;
using APP.Data;
using RAD.Data;
using RAD.Diagnostics;
namespace APP.Search
{
    public class CurrencyCodes
    {
        public static List<CurrencyCodes> SelectCurrencyCodes()
        {
            try
            {
                //Initialise Command
                SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = ConnectionManager.CreateProcedure(StoredProcedures.Select_Currency_Codes, con);

                var results = new List<CurrencyCodes>();

                using (con)
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        results.Add(new CurrencyCodes(reader));
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

        private int _currencyId;
        private string _currencyCode;

        public int CurrencyId
        {
            get { return _currencyId; }
        }

        public string CurrencyCode
        {
            get { return _currencyCode; }
        }

        public CurrencyCodes(SqlDataReader reader)
        {
            if (reader["CurrencyId"] != DBNull.Value)
                _currencyId = Convert.ToInt32(reader["CurrencyId"]);
            if (reader["CurrencyCode"] != DBNull.Value)
                _currencyCode = (string)reader["CurrencyCode"];
        }

    }
}