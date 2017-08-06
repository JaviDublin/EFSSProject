using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Diagnostics;
using APP.Data;
using RAD.Data;
using RAD.Diagnostics;
namespace APP.Search
{
    public class BuyerAddress
    {

        public static List<BuyerAddress> SelectBuyerAddress(int BuyerId)
        {
            try
            {
                //Initialise Command
                SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = ConnectionManager.CreateProcedure(StoredProcedures.select_BuyerAddress_ById, con);
                Parameters.CreateParameter(cmd, "@buyerId", BuyerId);

                var results = new List<BuyerAddress>();
                using (con)
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        results.Add(new BuyerAddress(reader));
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
        private string _contactType;
        private string _buyerAddress1;
        private string _buyerAddress2;
        private string _buyerAddress3;
        private string _buyerAddress4;
        private string _buyerAddress5;
        private string _buyerAddress6;
        private int _position;

        #endregion

        #region "Properties"

        public int BuyerId
        {
            get { return _buyerId; }
        }

        public string ContactType
        {
            get { return _contactType; }
        }

        public string BuyerAddress1
        {
            get { return _buyerAddress1; }
        }

        public string BuyerAddress2
        {
            get { return _buyerAddress2; }
        }

        public string BuyerAddress3
        {
            get { return _buyerAddress3; }
        }

        public string BuyerAddress4
        {
            get { return _buyerAddress4; }
        }

        public string BuyerAddress5
        {
            get { return _buyerAddress5; }
        }

        public string BuyerAddress6
        {
            get { return _buyerAddress6; }
        }

        public int Position
        {
            get { return _position; }
        }

        #endregion

        #region "Counstructor"

        public BuyerAddress(SqlDataReader reader)
        {
            if (reader["BuyerId"] != DBNull.Value)
                _buyerId = Convert.ToInt32(reader["BuyerId"]);
            if (reader["ContactType"] != DBNull.Value)
                _contactType = (string)reader["ContactType"];
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
            if (reader["Position"] != DBNull.Value)
                _position = Convert.ToInt32(reader["Position"]);
        }

        #endregion
    }
}