using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Diagnostics;
using APP.Data;
using RAD.Data;
using RAD.Diagnostics;
namespace APP.Reports
{
    public class FCTLastSettings
    {
        public static List<FCTLastSettings> GetFleetCashTargetLastSettings()
        {
            try
            {
                //Initialise Command
                SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = ConnectionManager.CreateProcedure(StoredProcedures.Report_FCT_SelectLastSettings, con);

                //Execute Command
                var results = new List<FCTLastSettings>();
                using (con)
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        results.Add(new FCTLastSettings(reader));
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

        private string _currentWeek;
        private string _currentYear;
        private string _maxWeek;
        private string _maxYear;
        private string _currencyId;

        #endregion

        #region "Properties"

        public string CurrentWeek
        {
            get { return _currentWeek; }
        }

        public string CurrentYear
        {
            get { return _currentYear; }
        }

        public string MaxWeek
        {
            get { return _maxWeek; }
        }

        public string MaxYear
        {
            get { return _maxYear; }
        }

        public string CurrencyId
        {
            get { return _currencyId; }
        }


        #endregion

        #region "Constructor"

        public FCTLastSettings(SqlDataReader reader)
        {
            if (reader["currentWeek"] != DBNull.Value)
                _currentWeek = (string)reader["currentWeek"];
            if (reader["currentYear"] != DBNull.Value)
                _currentYear = (string)reader["currentYear"];
            if (reader["maxWeek"] != DBNull.Value)
                _maxWeek = (string)reader["maxWeek"];
            if (reader["maxYear"] != DBNull.Value)
                _maxYear = (string)reader["maxYear"];
            if (reader["currencyId"] != DBNull.Value)
                _currencyId = (string)reader["currencyId"];

        }

        #endregion

    }
}