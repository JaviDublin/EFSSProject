using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Diagnostics;
using APP.Data;
using APP.Paging;
using RAD.Data;
using RAD.Diagnostics;
using RAD.Controls;
using APP.Session;

namespace APP.Search
{
    public class SearchBuyersOverView
    {
        public static List<SearchBuyersOverView> SelectBuyersOverview(int? currentPageNumber, int? pageSize, string sortExpression)
        {
            try
            {
                //Initialise Command
                SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = ConnectionManager.CreateProcedure(StoredProcedures.select_Buyers_OverView, con);

                currentPageNumber = (currentPageNumber == null) ? ListViewPaging.DefaultPageNumber : currentPageNumber;
                pageSize = (pageSize == null) ? ListViewPaging.DefaultPageSize : pageSize;

                Parameters.CreateParameter(cmd, "@sortExpression", sortExpression);
                int? startRowIndex = PagerSettings.SetStartRowIndex(currentPageNumber, pageSize, DefaultPageSize.Fifteen);
                int? maximumRows = PagerSettings.SetMaximumRows(currentPageNumber, pageSize, DefaultPageSize.Fifteen);
                Parameters.CreateParameter(cmd, "@maximumRows", maximumRows);
                Parameters.CreateParameter(cmd, "@startRowIndex", startRowIndex);
                Parameters.CreateParameter(cmd, "@countryId", SessionHandler.ApplicationFormBuyerCountryId);
                Parameters.CreateParameter(cmd, "@manufacturerCode", SessionHandler.ApplicationFormBuyerManufacturerCode);
                Parameters.CreateParameter(cmd, "@buyerCode", SessionHandler.ApplicationFormBuyerCode);
                Parameters.CreateParameter(cmd, "@buyerName", SessionHandler.ApplicationFormBuyerName);

                //Execute Command
                var results = new List<SearchBuyersOverView>();
                using (con)
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        results.Add(new SearchBuyersOverView(reader));
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
        private int _buyerId;
        private string _companyCode;
        private string _buyerCode;
        private string _areaCode;
        private string _buyerName;
        private string _manufacturerName;
        private string _totalSales;
        private string _lastSaleDate;
        private string _total;
        private string _buyerType;
        

        #endregion

        #region "Properties"

        public int Count
        {
            get { return _count; }
        }

        public int BuyerId
        {
            get { return _buyerId; }
        }

        public string CompanyCode
        {
            get { return _companyCode; }
        }

        public string BuyerCode
        {
            get { return _buyerCode; }
        }

        public string AreaCode
        {
            get { return _areaCode; }
        }

        public string BuyerName
        {
            get { return _buyerName; }
        }

        public string ManufacturerName
        {
            get { return _manufacturerName; }
        }

        public string TotalSales
        {
            get { return _totalSales; }
        }

        public string LastSaleDate
        {
            get { return _lastSaleDate; }
        }

        public string Total
        {
            get { return _total; }
        }

        public string BuyerType
        {
            get { return _buyerType; }
        }

      
        #endregion

        #region "Constructor"

        public SearchBuyersOverView(SqlDataReader reader)
        {
            if (reader["count"] != DBNull.Value)
                _count = Convert.ToInt32(reader["count"]);
            if (reader["BuyerId"] != DBNull.Value)
                _buyerId = Convert.ToInt32(reader["BuyerId"]);
            if (reader["CompanyCode"] != DBNull.Value)
                _companyCode = (string)reader["CompanyCode"];
            if (reader["BuyerCode"] != DBNull.Value)
                _buyerCode = (string)reader["BuyerCode"];
            if (reader["AreaCode"] != DBNull.Value)
                _areaCode = (string)reader["AreaCode"];
            if (reader["BuyerName"] != DBNull.Value)
                _buyerName = (string)reader["BuyerName"];
            if (reader["ManufacturerName"] != DBNull.Value)
                _manufacturerName = (string)reader["ManufacturerName"];
            if (reader["TotalSales"] != DBNull.Value)
                _totalSales = (string)reader["TotalSales"];
            if (reader["LastSaleDate"] != DBNull.Value)
                _lastSaleDate = (string)reader["LastSaleDate"];
            if (reader["Total"] != DBNull.Value)
                _total = (string)reader["Total"];
            if (reader["BuyerType"] != DBNull.Value)
                _buyerType = (string)reader["BuyerType"];
          
          
        }

        #endregion
    }
}