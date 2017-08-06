using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Diagnostics;
using APP.Data;
using RAD.Data;
using RAD.Diagnostics;

namespace APP.Search
{
    public class BuyerDetailsFull
    {
        public static List<BuyerDetailsFull> SelectBuyerFullDetails(int BuyerId,int CompanyTypeId)
        {
            try
            {
                //Initialise Command
                SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = ConnectionManager.CreateProcedure(StoredProcedures.Select_BuyerDetails, con);
                Parameters.CreateParameter(cmd, "@buyerId", BuyerId);
                Parameters.CreateParameter(cmd, "@companyTypeId", CompanyTypeId);

                var results = new List<BuyerDetailsFull>();
                using (con)
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        results.Add(new BuyerDetailsFull(reader));
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

        private int _contactId;
        private string _contactName;
        private string _contactEmail;
        private string _contactPhone;
        private string _buyerAddress1;
        private string _buyerAddress2;
        private string _buyerAddress3;
        private string _buyerAddress4;
        private string _buyerAddress5;
        private string _buyerAddress6;
        private int _companyTypeId;

        #endregion
        
        #region "Properties"

        public int ContactId { get { return _contactId; } }
        public string ContactName { get { return _contactName; } }
        public string ContactEmail { get { return _contactEmail; } }
        public string ContactPhone { get { return _contactPhone; } }
        public string BuyerAddress1 { get { return _buyerAddress1; } }
        public string BuyerAddress2 { get { return _buyerAddress2; } }
        public string BuyerAddress3 { get { return _buyerAddress3; } }
        public string BuyerAddress4 { get { return _buyerAddress4; } }
        public string BuyerAddress5 { get { return _buyerAddress5; } }
        public string BuyerAddress6 { get { return _buyerAddress6; } }
        public int CompanyTypeId { get { return _companyTypeId; } }

        #endregion

        #region "Constructor"

        public BuyerDetailsFull(SqlDataReader reader)
        {
            if (reader["ContactId"] != DBNull.Value)
                _contactId = Convert.ToInt32(reader["ContactId"]);
            if (reader["ContactName"] != DBNull.Value)
                _contactName = (string)reader["ContactName"];
            if (reader["ContactEmail"] != DBNull.Value)
                _contactEmail = (string)reader["ContactEmail"];
            if (reader["ContactPhone"] != DBNull.Value)
                _contactPhone = (string)reader["ContactPhone"];
            if (reader["BuyerAddress1"] != DBNull.Value)
                _buyerAddress1 = (string)reader["BuyerAddress1"];
            if (reader["BuyerAddress2"] != DBNull.Value)
                _buyerAddress2 = (string)reader["BuyerAddress2"];
            if (reader["BuyerAddress3"] != DBNull.Value)
                _buyerAddress3 = (string)reader["BuyerAddress3"];
            if (reader["BuyerAddress4"] != DBNull.Value)
                _buyerAddress4 = (string)reader["BuyerAddress4"];
            if (reader["BuyerAddress5"] != DBNull.Value)
                _buyerAddress5 = (string)reader["BuyerAddress5"];
            if (reader["BuyerAddress6"] != DBNull.Value)
                _buyerAddress6 = (string)reader["BuyerAddress6"];
            if (reader["CompanyTypeId"] != DBNull.Value)
                _companyTypeId = Convert.ToInt32(reader["CompanyTypeId"]);
        }

        #endregion
    }
}