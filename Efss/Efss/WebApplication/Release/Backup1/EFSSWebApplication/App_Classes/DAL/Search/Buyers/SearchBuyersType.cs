using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Diagnostics;
using APP.Data;
using RAD.Data;
using RAD.Diagnostics;
namespace APP.Search
{
    public class SearchBuyersType
    {

        public static List<SearchBuyersType> SelectBuyerTypes()
        {
            try
            {
                //Initialise Command
                SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = ConnectionManager.CreateProcedure(StoredProcedures.Select_BuyerTypes, con);
                var results = new List<SearchBuyersType>();
                using (con)
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        results.Add(new SearchBuyersType(reader));
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


        private int _buyerTypeId;
        private string _buyerType;

        public int BuyerTypeId
        {
            get { return _buyerTypeId; }
        }

        public string BuyerType
        {
            get { return _buyerType; }
        }

        public SearchBuyersType(SqlDataReader reader)
        {
            if (reader["BuyerTypeId"] != DBNull.Value)
                _buyerTypeId = Convert.ToInt32(reader["BuyerTypeId"]);
            if (reader["BuyerType"] != DBNull.Value)
                _buyerType = (string)reader["BuyerType"];
        }
    }
}