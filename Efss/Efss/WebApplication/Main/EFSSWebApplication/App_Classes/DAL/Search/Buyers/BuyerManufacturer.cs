using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Diagnostics;
using APP.Data;
using RAD.Data;
using RAD.Diagnostics;
namespace APP.Search
{
    public class BuyerManufacturer
    {
        public static List<BuyerManufacturer> SelectBuyerManufacturer(int BuyerId)
        {
            try
            {
                //Initialise Command
                SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = ConnectionManager.CreateProcedure(StoredProcedures.Select_BuyerManufacturers_ById, con);
                Parameters.CreateParameter(cmd, "@buyerId", BuyerId);

                var results = new List<BuyerManufacturer>();
                using (con)
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        results.Add(new BuyerManufacturer(reader));
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

        private int _manufacturerId;
        private string _manufacturerName;

        public int ManufacturerId
        {
            get { return _manufacturerId; }
        }

        public string ManufacturerName
        {
            get { return _manufacturerName; }
        }

        public BuyerManufacturer(SqlDataReader reader)
        {
            if (reader["ManufacturerId"] != DBNull.Value)
                _manufacturerId = Convert.ToInt32(reader["ManufacturerId"]);
            if (reader["ManufacturerName"] != DBNull.Value)
                _manufacturerName = (string)reader["ManufacturerName"];
        }
    }
}