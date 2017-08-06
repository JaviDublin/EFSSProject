using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Diagnostics;
using APP.Data;
using APP.Paging;
using RAD.Data;
using RAD.Diagnostics;
using RAD.Controls;

namespace APP.Search
{
    public class CompaniesOverView
    {

        public static List<CompaniesOverView> SelectCompaniesOverview(int? currentPageNumber, int? pageSize, string sortExpression)
        {
            try
            {
                //Initialise Command
                SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = ConnectionManager.CreateProcedure(StoredProcedures.Select_Companies_Overview, con);


                //Check for null values 
                //If so set default values for paging
                currentPageNumber = (currentPageNumber == null) ? PagerSettings.DefaultPageNumber : currentPageNumber;
                pageSize = (pageSize == null) ? (int)DefaultPageSize.Fifteen  : pageSize;

                //Set Parameters
                Parameters.CreateParameter(cmd, "@sortExpression", sortExpression);
                int? startRowIndex = PagerSettings.SetStartRowIndex(currentPageNumber, pageSize, DefaultPageSize.Fifteen);
                int? maximumRows = PagerSettings.SetMaximumRows(currentPageNumber, pageSize, DefaultPageSize.Fifteen);
                Parameters.CreateParameter(cmd, "@maximumRows", maximumRows);
                Parameters.CreateParameter(cmd, "@startRowIndex", startRowIndex);




                //Parameters.CreateParameter(cmd, "@companyId", companyid);
                //Execute Command
                var results = new List<CompaniesOverView>();
                using (con)
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        results.Add(new CompaniesOverView(reader));
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

        private int _count;
        private int _companyid;
        private string _companyname;
        private string _companycode;
        private string _companytype;
        private string _countryname;
        private string _regionname;
        private string _currencycode;
        private string _countryvat;
        private string _companyfiscalcode;
        private string _oracleCode;
        private string _groupName;
        private string _currencyRate;

        #endregion

        #region "Properties"

        public int Count
        {
            get { return _count; }
        }

        public int CompanyId
        {
            get { return _companyid; }
        }

        public string CompanyName
        {
            get { return _companyname; }
        }

        public string CompanyCode
        {
            get { return _companycode; }
        }

        public string companyType
        {
            get { return _companytype; }
        }

        public string CountryName
        {
            get { return _countryname; }
        }

        public string RegionName
        {
            get { return _regionname; }
        }

        public string CurrencyCode
        {
            get { return _currencycode; }
        }

        public string CountryVat
        {
            get { return _countryvat; }
        }

        public string CompanyFiscalCode
        {
            get { return _companyfiscalcode; }
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
            get { return _currencyRate; }
        }

        #endregion

        #region "Constructors"

        public CompaniesOverView(SqlDataReader reader)
        {
            if (reader["count"] != DBNull.Value)
                _count = Convert.ToInt32(reader["count"]);
            if (reader["CompanyId"] != DBNull.Value)
                _companyid = Convert.ToInt32(reader["CompanyId"]);
            if (reader["CompanyName"] != DBNull.Value)
                _companyname = (string)reader["CompanyName"];
            if (reader["CompanyCode"] != DBNull.Value)
                _companycode = (string)reader["CompanyCode"];
            if (reader["CompanyType"] != DBNull.Value)
                _companytype = (string)reader["CompanyType"];
            if (reader["CountryName"] != DBNull.Value)
                _countryname = (string)reader["CountryName"];
            if (reader["RegionName"] != DBNull.Value)
                _regionname = (string)reader["RegionName"];
            if (reader["CurrencyCode"] != DBNull.Value)
                _currencycode = (string)reader["CurrencyCode"];
            if (reader["CountryVat"] != DBNull.Value)
                _countryvat = (string)reader["CountryVat"];
            if (reader["CompanyFiscalCode"] != DBNull.Value)
                _companyfiscalcode = (string)reader["CompanyFiscalCode"];
            if (reader["OracleCode"] != DBNull.Value)
                _oracleCode = (string)reader["OracleCode"];
            if (reader["GroupName"] != DBNull.Value)
                _groupName = (string)reader["GroupName"];
            if (reader["Rate"] != DBNull.Value)
                _currencyRate = (string)reader["Rate"];

        }

        #endregion

    }
}