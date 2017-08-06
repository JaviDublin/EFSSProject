using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Diagnostics;
using RAD.Data;
using RAD.Diagnostics;
namespace APP.Search
{
    public class SearchLastDates
    {
        public static List<SearchLastDates> SelectRequestedDate(string procedure)
        {
            try
            {
                //Initialise Command
                SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = ConnectionManager.CreateProcedure(procedure, con);


                var results = new List<SearchLastDates>();
                using (con)
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        results.Add(new SearchLastDates(reader));
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

        private string _requestDate;

        public string RequestDate
        {
            get { return _requestDate; }
        }

        public SearchLastDates(SqlDataReader reader)
        {
            if (reader["RequestDate"] != DBNull.Value)
                _requestDate = (string)reader["RequestDate"];
        }
    }
}