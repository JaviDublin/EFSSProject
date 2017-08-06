using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Diagnostics;
using APP.Data;
using RAD.Data;
using RAD.Diagnostics;

namespace APP.Search
{
    public class SearchCompanyTypes
    {

        public static List<SearchCompanyTypes> SelectCompanyTypes()
        {
            try
            {
                //Initialise Command
                SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = ConnectionManager.CreateProcedure(StoredProcedures.Select_Companies_Types, con);
                var results = new List<SearchCompanyTypes>();
                using (con)
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        results.Add(new SearchCompanyTypes(reader));
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

        private int _companyTypeId;
        private string _companyType;

        public int CompanyTypeId
        {
            get { return _companyTypeId; }
        }

        public string CompanyType
        {
            get { return _companyType; }
        }

        public SearchCompanyTypes(SqlDataReader reader)
        {
            if (reader["CompanyTypeId"] != DBNull.Value)
                _companyTypeId = Convert.ToInt32(reader["CompanyTypeId"]);
            if (reader["CompanyType"] != DBNull.Value)
                _companyType = (string)reader["CompanyType"];
        }


    }
}