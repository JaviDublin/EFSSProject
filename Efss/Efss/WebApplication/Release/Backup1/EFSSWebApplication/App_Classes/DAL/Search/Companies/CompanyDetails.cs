using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Diagnostics;
using APP.Data;
using RAD.Data;
using RAD.Diagnostics;
namespace APP.Search
{
    public class CompanyDetails
    {
        public static List<CompanyDetails> CompanyDetailsById(int companyId)
        {
            try
            {
                SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = ConnectionManager.CreateProcedure(StoredProcedures.Select_Companies_ById, con);
                Parameters.CreateParameter(cmd, "@companyId", companyId);

                var results = new List<CompanyDetails>();
                using (con)
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        results.Add(new CompanyDetails(reader));
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

        private int _companyId;
        private string _companyName;
        private string _companyCode;
        private string _countryName;
        private string _companyFiscalCode;
        private string _vatRate;
        private string _currencyName;
        private string _regionName;
        private string _companyType;
        private string _oracleCode;
        private string _groupName;
        private string _rate;

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

        public string CompanyCode
        {
            get { return _companyCode; }
        }

        public string CountryName
        {
            get { return _countryName; }
        }

        public string CompanyFiscalCode
        {
            get { return _companyFiscalCode; }
        }

        public string VatRate
        {
            get { return _vatRate; }
        }

        public string CurrencyName
        {
            get { return _currencyName; }
        }

        public string RegionName
        {
            get { return _regionName; }
        }

        public string CompanyType
        {
            get { return _companyType; }
        }

        public string OracleCode
        {
            get { return _oracleCode; }
        }

        public string GroupName
        {
            get { return _groupName; }
        }

        public string Rate
        {
            get { return _rate; }
        }

        #endregion

        #region "Constructor"

        public CompanyDetails(SqlDataReader reader)
        {
            if (reader["CompanyId"] != DBNull.Value)
                _companyId = Convert.ToInt32(reader["CompanyId"]);
            if (reader["CompanyName"] != DBNull.Value)
                _companyName = (string)reader["CompanyName"];
            if (reader["CompanyCode"] != DBNull.Value)
                _companyCode = (string)reader["CompanyCode"];
            if (reader["CountryName"] != DBNull.Value)
                _countryName = (string)reader["CountryName"];
            if (reader["CompanyFiscalCode"] != DBNull.Value)
                _companyFiscalCode = (string)reader["CompanyFiscalCode"];
            if (reader["VatRate"] != DBNull.Value)
                _vatRate = (string)reader["VatRate"];
            if (reader["CurrencyName"] != DBNull.Value)
                _currencyName = (string)reader["CurrencyName"];
            if (reader["RegionName"] != DBNull.Value)
                _regionName = (string)reader["RegionName"];
            if (reader["CompanyType"] != DBNull.Value)
                _companyType = (string)reader["CompanyType"];
            if (reader["OracleCode"] != DBNull.Value)
                _oracleCode = (string)reader["OracleCode"];
            if (reader["GroupName"] != DBNull.Value)
                _groupName = (string)reader["GroupName"];
            if (reader["Rate"] != DBNull.Value)
                _rate = reader["Rate"].ToString();
        }

        #endregion

    }
}