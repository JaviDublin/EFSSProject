using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Diagnostics;
using APP.Data;
using RAD.Data;
using RAD.Diagnostics;
namespace APP.Search
{
    public class SearchCountries
    {

        public static List<SearchCountries> SelectCountriesNamesByUser(string racfId)
        {
            try
            {
                //Initialise Command
                SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = ConnectionManager.CreateProcedure(StoredProcedures.Select_Countries_User, con);
                Parameters.CreateParameter(cmd, "@racfId", racfId);

                var results = new List<SearchCountries>();
                using (con)
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        results.Add(new SearchCountries(reader));
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

        public static List<SearchCountries> SelectCountries()
        {
            try
            {
                //Initialise Command
                SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = ConnectionManager.CreateProcedure(StoredProcedures.Select_Countries, con);
                var results = new List<SearchCountries>();
                using (con)
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        results.Add(new SearchCountries(reader));
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

        public static List<SearchCountries> SelectCountryId(string countryName)
        {
            try
            {
                //Initialise Command
                SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = ConnectionManager.CreateProcedure(StoredProcedures.Select_CountryId, con);
                Parameters.CreateParameter(cmd, "@countryName", countryName);

                var results = new List<SearchCountries>();
                using (con)
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        results.Add(new SearchCountries(reader));
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

        private int _countryId;
        private string _countryName;

        public int CountryId
        {
            get { return _countryId; }
        }

        public string CountryName
        {
            get { return _countryName; }
        }

        public SearchCountries(SqlDataReader reader)
        {
            if (reader["CountryId"] != DBNull.Value)
                _countryId = Convert.ToInt32(reader["CountryId"]);
            if (reader["CountryName"] != DBNull.Value)
                _countryName = (string)reader["CountryName"];
        }

    }
}