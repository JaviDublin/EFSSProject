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
    public class ManufacturersOverView
    {

        public static List<ManufacturersOverView> SelectManufacturersOverview(int? currentPageNumber, int? pageSize, string sortExpression)
        {
            try
            {
                //Initialise Command
                SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = ConnectionManager.CreateProcedure(StoredProcedures.Select_Manufacturer_OverView, con);

                currentPageNumber = (currentPageNumber == null) ? PagerSettings.DefaultPageNumber : currentPageNumber;
                pageSize = (pageSize == null) ? (int)DefaultPageSize.Fifteen : pageSize;

                //Set Parameters
                Parameters.CreateParameter(cmd, "@sortExpression", sortExpression);
                
                int? startRowIndex = PagerSettings.SetStartRowIndex(currentPageNumber, pageSize, DefaultPageSize.Fifteen);
                int? maximumRows = PagerSettings.SetMaximumRows(currentPageNumber, pageSize, DefaultPageSize.Fifteen);

                Parameters.CreateParameter(cmd, "@maximumRows", maximumRows);
                Parameters.CreateParameter(cmd, "@startRowIndex", startRowIndex);

                //Execute Command
                var results = new List<ManufacturersOverView>();
                using (con)
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        results.Add(new ManufacturersOverView(reader));
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
        private int _modelsCount;
        private bool _isBE;
        private bool _isFR;
        private bool _isGE;
        private bool _isIT;
        private bool _isLU;
        private bool _isNE;
        private bool _isSP;
        private bool _isSZ;
        private bool _isUK;

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

        public int ModelsCount
        {
            get { return _modelsCount; }
        }

        public string IsBE
        {
            get { return (_isBE == true) ? "~/App_Images/yes.gif" : "~/App_Images/no.gif"; }
        }

        public string IsFR
        {
            get { return (_isFR == true) ? "~/App_Images/yes.gif" : "~/App_Images/no.gif"; }
        }

        public string IsGE
        {
            get { return (_isGE == true) ? "~/App_Images/yes.gif" : "~/App_Images/no.gif"; }
        }

        public string IsIT
        {
            get { return (_isIT == true) ? "~/App_Images/yes.gif" : "~/App_Images/no.gif"; }
        }

        public string IsLU
        {
            get { return (_isLU == true) ? "~/App_Images/yes.gif" : "~/App_Images/no.gif"; }
        }

        public string IsNE
        {
            get { return (_isNE == true) ? "~/App_Images/yes.gif" : "~/App_Images/no.gif"; }
        }

        public string IsSP
        {
            get { return (_isSP == true) ? "~/App_Images/yes.gif" : "~/App_Images/no.gif"; }
        }

        public string IsSZ
        {
            get { return (_isSZ == true) ? "~/App_Images/yes.gif" : "~/App_Images/no.gif"; }
        }

        public string IsUK
        {
            get { return (_isUK == true) ? "~/App_Images/yes.gif" : "~/App_Images/no.gif"; }
        }



        #endregion

        #region "Constructor"

        public ManufacturersOverView(SqlDataReader reader)
        {
            if (reader["count"] != DBNull.Value)
                _count = Convert.ToInt32(reader["count"]);
            if (reader["ManufacturerId"] != DBNull.Value)
                _manufacturerId = Convert.ToInt32(reader["ManufacturerId"]);
            if (reader["ManufacturerName"] != DBNull.Value)
                _manufacturerName = (string)reader["ManufacturerName"];
            if (reader["ModelsCount"] != DBNull.Value)
                _modelsCount = Convert.ToInt32(reader["ModelsCount"]);
            if (reader["IsBE"] != DBNull.Value)
                _isBE = Convert.ToBoolean(reader["IsBE"]);
            if (reader["IsFR"] != DBNull.Value)
                _isFR = Convert.ToBoolean(reader["IsFR"]);
            if (reader["IsGE"] != DBNull.Value)
                _isGE = Convert.ToBoolean(reader["IsGE"]);
            if (reader["IsIT"] != DBNull.Value)
                _isIT = Convert.ToBoolean(reader["IsIT"]);
            if (reader["IsLU"] != DBNull.Value)
                _isLU = Convert.ToBoolean(reader["IsLU"]);
            if (reader["IsNE"] != DBNull.Value)
                _isNE = Convert.ToBoolean(reader["IsNE"]);
            if (reader["IsSP"] != DBNull.Value)
                _isSP = Convert.ToBoolean(reader["IsSP"]);
            if (reader["IsSZ"] != DBNull.Value)
                _isSZ = Convert.ToBoolean(reader["IsSZ"]);
            if (reader["IsUK"] != DBNull.Value)
                _isUK = Convert.ToBoolean(reader["IsUK"]);
        }

        #endregion
    }
}