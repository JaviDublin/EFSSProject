using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Diagnostics;
using APP.Data;
using RAD.Data;
using RAD.Diagnostics;
using APP.Session;

namespace APP.Search
{
    public class SearchManufacturers
    {
        public static List<SearchManufacturers> SelectManufacturers()
        {
            try
            {
                //Initialise Command
                SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = ConnectionManager.CreateProcedure(StoredProcedures.Select_Manufacturers, con);
                var results = new List<SearchManufacturers>();
                using (con)
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        results.Add(new SearchManufacturers(reader));
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

        public static List<SearchManufacturers> SelectManufaturersById(int manufacturerId)
        {
            try
            {
                SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = ConnectionManager.CreateProcedure(StoredProcedures.Select_Manufacturers_ById, con);
                Parameters.CreateParameter(cmd, "@manufacturerId", manufacturerId);
                var results = new List<SearchManufacturers>();
                using (con)
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        results.Add(new SearchManufacturers(reader));
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

        public static List<SearchManufacturers> SelectManufacturersByCompanyId()
        {
            try
            {
                SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = ConnectionManager.CreateProcedure(StoredProcedures.Select_Manufacturers_ByCompanyId, con);
                Parameters.CreateParameter(cmd, "@companyid", SessionHandler.SearchFormCompanyId);
                Parameters.CreateParameter(cmd, "@countryId", SessionHandler.SearchFormCountryId);
                var results = new List<SearchManufacturers>();
                using (con)
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        results.Add(new SearchManufacturers(reader));
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

        public static List<SearchManufacturers> SelectManufacturersByCountryId(int countryId)
        {
             try
            {
                SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = ConnectionManager.CreateProcedure(StoredProcedures.Select_Manufacturers_ByCountryId, con);
                Parameters.CreateParameter(cmd, "@countryid", countryId);
                var results = new List<SearchManufacturers>();
                using (con)
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        results.Add(new SearchManufacturers(reader));
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

        public static List<SearchManufacturers> SelectManufacturersCodeByCountryId(int countryId)
        {
            try
            {
                SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = ConnectionManager.CreateProcedure(StoredProcedures.Select_ManufacturerCode_ByCountryId, con);
                Parameters.CreateParameter(cmd, "@countryid", countryId);
                var results = new List<SearchManufacturers>();
                using (con)
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        results.Add(new SearchManufacturers(reader));
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

        public static List<SearchManufacturers> SelectManufacturersDashBoardByCompanyId()
        {
            try
            {
                SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = ConnectionManager.CreateProcedure(StoredProcedures.Select_Manufacturers_DashBoard_ByCompanyId, con);
                Parameters.CreateParameter(cmd, "@companyid", SessionHandler.DashBoardCompanyId);
                Parameters.CreateParameter(cmd, "@countryId", SessionHandler.DashBoardCountryId);
                var results = new List<SearchManufacturers>();
                using (con)
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        results.Add(new SearchManufacturers(reader));
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

        



        private string _manufacturerId;
        private string _manufacturerName;

        public string ManufacturerId
        {
            get { return _manufacturerId; }
        }

        public string ManufacturerName
        {
            get { return _manufacturerName; }
        }

        public SearchManufacturers(SqlDataReader reader)
        {
            if (reader["ManufacturerId"] != DBNull.Value)
                _manufacturerId = (string)reader["ManufacturerId"];
            if (reader["ManufacturerName"] != DBNull.Value)
                _manufacturerName = (string)reader["ManufacturerName"];
        }

    }
}