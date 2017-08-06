using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Diagnostics;
using APP.Data;
using RAD.Data;
using RAD.Diagnostics;
namespace APP.Search
{
    public class BuyerContacts
    {
        public static List<BuyerContacts> SelectBuyerContacts(int BuyerId)
        {
            try
            {
                //Initialise Command
                SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = ConnectionManager.CreateProcedure(StoredProcedures.Select_BuyerContacts_ById, con);
                Parameters.CreateParameter(cmd, "@buyerId", BuyerId);

                var results = new List<BuyerContacts>();
                using (con)
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        results.Add(new BuyerContacts(reader));
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
        private int _buyerId;
        private string _contactTypeName;
        private string _contactName;
        private string _contactEmail;
        private string _contactPhone;
        private string _contactFax;
        private int _position;


        #endregion

        #region "Properties"

        public int ContactId { get { return _contactId; } }
        public int BuyerId { get { return _buyerId; } }
        public string ContactTypeName { get { return _contactTypeName; } }
        public string ContactName { get { return _contactName; } }
        public string ContactEmail { get { return _contactEmail; } }
        public string ContactPhone { get { return _contactPhone; } }
        public string ContactFax { get { return _contactFax; } }
        public int Position { get { return _position; } }

        #endregion

        #region "Construtor"

        public BuyerContacts(SqlDataReader reader)
        {
            if (reader["ContactId"] != DBNull.Value)
                _contactId = Convert.ToInt32(reader["ContactId"]);
            if (reader["BuyerId"] != DBNull.Value)
                _buyerId = Convert.ToInt32(reader["BuyerId"]);
            if (reader["ContactTypeName"] != DBNull.Value)
                _contactTypeName = (string)reader["ContactTypeName"];
            if (reader["ContactName"] != DBNull.Value)
                _contactName = (string)reader["ContactName"];
            if (reader["ContactEmail"] != DBNull.Value)
                _contactEmail = (string)reader["ContactEmail"];
            if (reader["ContactPhone"] != DBNull.Value)
                _contactPhone = (string)reader["ContactPhone"];
            if (reader["ContactFax"] != DBNull.Value)
                _contactFax = (string)reader["ContactFax"];
            if (reader["Position"] != DBNull.Value)
                _position = Convert.ToInt32(reader["Position"]);
        }


        #endregion

    }
}