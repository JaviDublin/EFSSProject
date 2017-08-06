using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Diagnostics;
using APP.Data;
using RAD.Data;
using RAD.Diagnostics;
namespace APP.Search
{
    public class DocumentsSubTypes
    {

        public static List<DocumentsSubTypes> SelectDocSubType(int selectType)
        {
            try
            {
                //Initialise Command
                SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = ConnectionManager.CreateProcedure(StoredProcedures.Select_Documents_SubTypes_Manual, con);
                Parameters.CreateParameter(cmd, "@selectType", selectType);
                var results = new List<DocumentsSubTypes>();

                using (con)
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        results.Add(new DocumentsSubTypes(reader));
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

        private string _documentsubtype;

        public string DocumentSubType
        {
            get { return _documentsubtype; }
        }

        public DocumentsSubTypes(SqlDataReader reader)
        {
            if (reader["DocSubType"] != DBNull.Value)
                _documentsubtype = (string)reader["DocSubType"];
        }
    }
}