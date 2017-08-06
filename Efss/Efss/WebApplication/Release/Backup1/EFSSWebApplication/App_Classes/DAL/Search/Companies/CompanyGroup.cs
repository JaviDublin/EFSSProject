using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Diagnostics;
using APP.Data;
using RAD.Data;
using RAD.Diagnostics;
namespace APP.Search
{
    public class CompanyGroup
    {
        public static List<CompanyGroup> SelectCompanyGroupId(int countryid)
        {
            try
            {
                SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = ConnectionManager.CreateProcedure(StoredProcedures.Select_Companies_GroupId, con);
                Parameters.CreateParameter(cmd, "@countryId", countryid);

                var results = new List<CompanyGroup>();
                using (con)
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        results.Add(new CompanyGroup(reader));
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

        private int _groupId;

        public int GroupId
        {
            get { return _groupId; }
        }

        public CompanyGroup(SqlDataReader reader)
        {
            if (reader["GroupId"] != DBNull.Value)
                _groupId = Convert.ToInt32(reader["GroupId"]);
        }

    }
}