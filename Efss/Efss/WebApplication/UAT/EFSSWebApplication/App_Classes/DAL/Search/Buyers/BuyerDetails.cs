using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Diagnostics;
using APP.Data;
using RAD.Data;
using RAD.Diagnostics;
namespace APP.Search
{
    public class BuyerDetails
    {
        public static List<BuyerDetails> SelectBuyerDetails(int BuyerId)
        {
            try
            {
                //Initialise Command
                SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = ConnectionManager.CreateProcedure(StoredProcedures.Select_BuyerDetails_ById, con);
                Parameters.CreateParameter(cmd, "@buyerId", BuyerId);

                var results = new List<BuyerDetails>();
                using (con)
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        results.Add(new BuyerDetails(reader));
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

        public static List<BuyerDetails> SelectBuyerDetailsByCode(string buyerCode, int CountryId)
        {
            try
            {
                //Initialise Command
                SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = ConnectionManager.CreateProcedure(StoredProcedures.Select_BuyerDetails_ByCode, con);
                Parameters.CreateParameter(cmd, "@buyerCode", buyerCode);
                Parameters.CreateParameter(cmd, "@countryId", CountryId);

                var results = new List<BuyerDetails>();
                using (con)
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        results.Add(new BuyerDetails(reader));
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

        private int _buyerId;
        private string _countryName;
        private string _buyerCode;
        private string _buyerName;
        private string _buyerTaxCode;
        private string _buyerFiscalCode;
        private string _buyerType;
        private int _buyerTypeId;

        #endregion

        #region "Properties"

        public int BuyerId
        {
            get { return _buyerId; }
        }

        public string CountryName
        {
            get { return _countryName; }
        }

        public string BuyerCode
        {
            get { return _buyerCode; }
        }

        public string BuyerName
        {
            get { return _buyerName; }
        }

        public string BuyerTaxCode
        {
            get { return _buyerTaxCode; }
        }

        public string BuyerFiscalCode
        {
            get { return _buyerFiscalCode; }
        }

        public string BuyerType
        {
            get { return _buyerType; }
        }

        public int BuyerTypeId
        {
            get { return _buyerTypeId; }
        }


        #endregion

        #region "Counstructor"

        public BuyerDetails(SqlDataReader reader)
        {
            if (reader["BuyerId"] != DBNull.Value)
                _buyerId = Convert.ToInt32(reader["BuyerId"]);
            if (reader["CountryName"] != DBNull.Value)
                _countryName = (string)reader["CountryName"];
            if (reader["BuyerCode"] != DBNull.Value)
                _buyerCode = (string)reader["BuyerCode"];
            if (reader["BuyerName"] != DBNull.Value)
                _buyerName = (string)reader["BuyerName"];
            if (reader["BuyerTaxCode"] != DBNull.Value)
                _buyerTaxCode = (string)reader["BuyerTaxCode"];
            if (reader["BuyerFiscalCode"] != DBNull.Value)
                _buyerFiscalCode = (string)reader["BuyerFiscalCode"];
            if (reader["BuyerType"] != DBNull.Value)
                _buyerType = (string)reader["BuyerType"];
            if (reader["BuyerTypeId"] != DBNull.Value)
                _buyerTypeId = Convert.ToInt32(reader["BuyerTypeId"]);
        }

        #endregion


    }
}