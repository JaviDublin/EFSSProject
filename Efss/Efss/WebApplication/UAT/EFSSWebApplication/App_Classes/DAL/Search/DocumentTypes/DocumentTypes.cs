using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Diagnostics;
using APP.Data;
using RAD.Data;
using RAD.Diagnostics;
namespace APP.Search
{
    public class DocumentTypes
    {
        public static List<DocumentTypes> SelectDocType(int selectType)
        {
            try
            {
                //Initialise Command
                SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = ConnectionManager.CreateProcedure(StoredProcedures.Select_Documents_Types_Manual, con);
                Parameters.CreateParameter(cmd, "@selectType", selectType);
                var results = new List<DocumentTypes>();

                using (con)
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        results.Add(new DocumentTypes(reader));
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

        private string _documenttype;

        public string DocumentType
        {
            get { return _documenttype; }
        }

        public DocumentTypes(SqlDataReader reader)
        {
            if (reader["DocType"] != DBNull.Value)
                _documenttype = (string)reader["DocType"];
        }
    }
}