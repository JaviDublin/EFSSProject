using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Diagnostics;
using APP.Data;
using RAD.Data;
using RAD.Diagnostics;
namespace APP.Search
{
    public class SearchCompanies
    {
        public static List<SearchCompanies> SelectCompaniesByCountry(string countryName)
        {
            try
            {
                //Initialise Command
                SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = ConnectionManager.CreateProcedure(StoredProcedures.Select_Companies_Country_Search, con);
                Parameters.CreateParameter(cmd, "@countryName", countryName);

                var results = new List<SearchCompanies>();
                using (con)
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        results.Add(new SearchCompanies(reader));
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

        public static List<SearchCompanies> SelectCompanyId(string companyName)
        {
            try
            {
                //Initialise Command
                SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = ConnectionManager.CreateProcedure(StoredProcedures.Select_CompanyId, con);
                Parameters.CreateParameter(cmd, "@companyName", companyName);

                var results = new List<SearchCompanies>();
                using (con)
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        results.Add(new SearchCompanies(reader));
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

        #region "Fields"

        private int _companyId;
        private string _companyName;
        private string _companyType;

        #endregion

        #region "Properties"

        public int CompanyId
        {
            get { return _companyId; }
        }

        public string CompanyName
        {
            get { return _companyName; }
        }

        public string CompanyType
        {
            get { return _companyType; }
        }


        #endregion

        #region "Constructor"

        public SearchCompanies(SqlDataReader reader)
        {
            if (reader["CompanyId"] != DBNull.Value)
                _companyId = Convert.ToInt32(reader["CompanyId"]);
            if (reader["CompanyName"] != DBNull.Value)
                _companyName = (string)reader["CompanyName"];
            if (reader["CompanyType"] != DBNull.Value)
                _companyType = (string)reader["CompanyType"];
        }

        #endregion


    }
}