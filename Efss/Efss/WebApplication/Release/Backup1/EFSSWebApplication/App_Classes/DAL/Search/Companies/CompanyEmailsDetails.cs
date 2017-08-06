using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Diagnostics;
using APP.Data;
using RAD.Data;
using RAD.Diagnostics;
namespace APP.Search
{
    public class CompanyEmailsDetails
    {
        public static List<CompanyEmailsDetails> CompanyEmailDetails(int emailid)
        {
            try
            {
                SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = ConnectionManager.CreateProcedure(StoredProcedures.Select_Companies_Emails_Details, con);
                Parameters.CreateParameter(cmd, "@emailId", emailid);
                var results = new List<CompanyEmailsDetails>();
                using (con)
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        results.Add(new CompanyEmailsDetails(reader));
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

        private int _messageId;
        private string _title;
        private string _header;
        private string _body;
        private string _footer;

        #endregion

        #region "Properties"

        public int MessageId
        {
            get { return _messageId; }
        }

        public string Title
        {
            get { return _title; }
        }

        public string Header
        {
            get { return _header; }
        }

        public string Body
        {
            get { return _body; }
        }

        public string Footer
        {
            get { return _footer; }
        }

        #endregion

        #region "Constructor"

        public CompanyEmailsDetails(SqlDataReader reader)
        {
            if (reader["MessageId"] != DBNull.Value)
                _messageId = Convert.ToInt32(reader["MessageId"]);
            if (reader["Title"] != DBNull.Value)
                _title = (string)reader["Title"];
            if (reader["Header"] != DBNull.Value)
                _header = (string)reader["Header"];
            if (reader["Body"] != DBNull.Value)
                _body = (string)reader["Body"];
            if (reader["Footer"] != DBNull.Value)
                _footer = (string)reader["Footer"];


        }

        #endregion
    }
}