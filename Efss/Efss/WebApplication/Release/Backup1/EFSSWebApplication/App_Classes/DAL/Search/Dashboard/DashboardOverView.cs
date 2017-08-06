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
    public class DashboardOverView
    {

        public static List<DashboardOverView> SelectDashBoard(int? currentPageNumber, int? pageSize, string sortExpression, string countryName,string docSubType)
        {
            try
            {
                //Initialise Command
                SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = ConnectionManager.CreateProcedure(StoredProcedures.DashBoard_OverView, con);

                //Check for null values 
                //If so set default values for paging
                currentPageNumber = (currentPageNumber == null) ? ListViewPaging.DefaultPageNumber : currentPageNumber;
                pageSize = (pageSize == null) ? ListViewPaging.DefaultPageSize : pageSize;

                //Set Parameters
                Parameters.CreateParameter(cmd, "@sortExpression", sortExpression);
                int? startRowIndex = PagerSettings.SetStartRowIndex(currentPageNumber, pageSize, DefaultPageSize.Fifteen);
                int? maximumRows = PagerSettings.SetMaximumRows(currentPageNumber, pageSize, DefaultPageSize.Fifteen);
                Parameters.CreateParameter(cmd, "@maximumRows", maximumRows);
                Parameters.CreateParameter(cmd, "@startRowIndex", startRowIndex);
                Parameters.CreateParameter(cmd, "@countryName", countryName);
                Parameters.CreateParameter(cmd, "@docsubtype", docSubType);
                

                //Execute Command
                var results = new List<DashboardOverView>();
                using (con)
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        results.Add(new DashboardOverView(reader));
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
        private int _manufacturerId;
        private string _manufacturerName;
        private string _current;
        private string _payment;
        private string _age_0_7;
        private string _age_8_30;
        private string _age_31_60;
        private string _age_61_90;
        private string _age_91_120;
        private string _age_121_180;
        private string _age_181_360;
        private string _age_360;
        private string _notes;
        private string _cnk;

        #endregion

        #region "Properties"

        public int Count
        {
            get { return _count; }
        }

        public int ManufacturerId
        {
            get { return _manufacturerId; }
        }

        public string ManufacturerName
        {
            get { return _manufacturerName; }
        }

        public string Current
        {
            get { return _current; }
        }

        public string Payment
        {
            get { return _payment; }
        }

        public string Age_0_7
        {
            get { return _age_0_7; }
        }

        public string Age_8_30
        {
            get { return _age_8_30; }
        }

        public string Age_31_60
        {
            get { return _age_31_60; }
        }

        public string Age_61_90
        {
            get { return _age_61_90; }
        }

        public string Age_91_120
        {
            get { return _age_91_120; }
        }

        public string Age_121_180
        {
            get { return _age_121_180; }
        }

        public string Age_181_360
        {
            get { return _age_181_360; }
        }

        public string Age_360
        {
            get { return _age_360; }
        }

        public string Notes
        {
            get { return _notes; }
        }

        public string CNK
        {
            get { return _cnk; }
        }

        #endregion

        #region "Constructor"

        public DashboardOverView(SqlDataReader reader)
        {
            if (reader["count"] != DBNull.Value)
                _count = Convert.ToInt32(reader["count"]);
            if (reader["ManufacturerId"] != DBNull.Value)
                _manufacturerId = Convert.ToInt32(reader["ManufacturerId"]);
            if (reader["ManufacturerName"] != DBNull.Value)
                _manufacturerName = (string)reader["ManufacturerName"];
            if (reader["Current"] != DBNull.Value)
                _current = reader["Current"].ToString();
            if (reader["Payment"] != DBNull.Value)
                _payment = reader["Payment"].ToString();
            if (reader["Age_0_7"] != DBNull.Value)
                _age_0_7 = reader["Age_0_7"].ToString();
            if (reader["Age_8_30"] != DBNull.Value)
                _age_8_30 = reader["Age_8_30"].ToString();
            if (reader["Age_31_60"] != DBNull.Value)
                _age_31_60 = reader["Age_31_60"].ToString();
            if (reader["Age_61_90"] != DBNull.Value)
                _age_61_90 = reader["Age_61_90"].ToString();
            if (reader["Age_91_120"] != DBNull.Value)
                _age_91_120 = reader["Age_91_120"].ToString();
            if (reader["Age_121_180"] != DBNull.Value)
                _age_121_180 = reader["Age_121_180"].ToString();
            if (reader["Age_181_360"] != DBNull.Value)
                _age_181_360 = reader["Age_181_360"].ToString();
            if (reader["Age_360"] != DBNull.Value)
                _age_360 = reader["Age_360"].ToString();
            if (reader["Notes"] != DBNull.Value)
                _notes = reader["Notes"].ToString();
            if (reader["CNK"] != DBNull.Value)
                _cnk = reader["CNK"].ToString();

        }

        #endregion
    }
}