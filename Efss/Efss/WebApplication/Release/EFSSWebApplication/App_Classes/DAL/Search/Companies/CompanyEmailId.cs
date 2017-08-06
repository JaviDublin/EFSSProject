using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Diagnostics;
using APP.Data;
using RAD.Data;
using RAD.Diagnostics;
namespace APP.Search
{
    public class CompanyEmailId
    {
        public static List<CompanyEmailId> SelectCompanyEmailId(int countryid)
        {
            try
            {
                SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = ConnectionManager.CreateProcedure(StoredProcedures.Select_Companies_EmailId, con);
                Parameters.CreateParameter(cmd, "@countryId", countryid);

                var results = new List<CompanyEmailId>();
                using (con)
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        results.Add(new CompanyEmailId(reader));
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

        private int _emailId;

        public int EmailId
        {
            get { return _emailId; }
        }

        public CompanyEmailId(SqlDataReader reader)
        {
            if (reader["EmailId"] != DBNull.Value)
                _emailId = Convert.ToInt32(reader["EmailId"]);
        }
    }
}