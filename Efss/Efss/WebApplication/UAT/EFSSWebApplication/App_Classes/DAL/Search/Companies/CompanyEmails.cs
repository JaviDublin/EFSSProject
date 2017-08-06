using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Diagnostics;
using APP.Data;
using RAD.Data;
using RAD.Diagnostics;
namespace APP.Search
{
    public class CompanyEmails
    {

        public static List<CompanyEmails> CompanyEmailsList()
        {
            try
            {
                SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = ConnectionManager.CreateProcedure(StoredProcedures.Select_Companies_Emails, con);

                var results = new List<CompanyEmails>();
                using (con)
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        results.Add(new CompanyEmails(reader));
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

        private int _emailId;
        private string _emailDublin;

        #endregion

        #region "Properties"

        public int EmailId
        {
            get { return _emailId; }
        }

        public string EmailDublin
        {
            get { return _emailDublin; }
        }

        #endregion

        #region "Constructor"

        public CompanyEmails(SqlDataReader reader)
        {
            if (reader["EmailId"] != DBNull.Value)
                _emailId = Convert.ToInt32(reader["EmailId"]);
            if (reader["EmailDublin"] != DBNull.Value)
                _emailDublin = (string)reader["EmailDublin"];

        }

        #endregion

    }
}