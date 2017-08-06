using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Diagnostics;
using APP.Data;
using RAD.Data;
using RAD.Diagnostics;

namespace APP.Search
{
    public class CompanyGroupNames
    {
        public static List<CompanyGroupNames> SelectCompanyGroupName()
        {
            try
            {
                SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = ConnectionManager.CreateProcedure(StoredProcedures.DashBoardSelectGroupName, con);

                var results = new List<CompanyGroupNames>();
                using (con)
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        results.Add(new CompanyGroupNames(reader));
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
        private string _groupName;

        public int GroupId
        {
            get { return _groupId; }
        }

        public string GroupName
        {
            get { return _groupName; }
        }

        public CompanyGroupNames(SqlDataReader reader)
        {
            if (reader["GroupId"] != DBNull.Value)
                _groupId = Convert.ToInt32(reader["GroupId"]);
            if (reader["GroupName"] != DBNull.Value)
                _groupName = (string)reader["GroupName"];
        }


    }
}