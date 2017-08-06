using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Diagnostics;
using APP.Data;
using RAD.Data;
using RAD.Diagnostics;
namespace APP.Search
{
    public class CurrencyDetails
    {

        public static List<CurrencyDetails> SelectCurrencyDetails(string currencyCode)
        {
            try
            {
                //Initialise Command
                SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = ConnectionManager.CreateProcedure(StoredProcedures.Select_Currencies_Details, con);
                Parameters.CreateParameter(cmd, "@currencyCode", currencyCode);

                var results = new List<CurrencyDetails>();

                using (con)
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        results.Add(new CurrencyDetails(reader));
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


        #region "Fields"

        private int _currencyId;
        private string _currencyName;
        private string _rate;


        #endregion

        #region "Properties"

        public int CurrencyId
        {
            get { return _currencyId; }
        }

        public string CurrencyName
        {
            get { return _currencyName; }
        }

        public string Rate
        {
            get { return _rate; }
        }


        #endregion

        #region "Constructor"

        public CurrencyDetails(SqlDataReader reader)
        {
            if (reader["CurrencyId"] != DBNull.Value)
                _currencyId = Convert.ToInt32(reader["CurrencyId"]);
            if (reader["CurrencyName"] != DBNull.Value)
                _currencyName = (string)reader["CurrencyName"];
            if (reader["Rate"] != DBNull.Value)
                _rate = (string)reader["Rate"];
        }

        #endregion

    }
}