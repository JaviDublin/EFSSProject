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
    public class ModelsOverView
    {
        public static List<ModelsOverView> SelectModelsByManufaturer(int? currentPageNumber, int? pageSize, string sortExpression, int ManufacturerId)
        {
            try
            {
                //Initialise Command
                SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = ConnectionManager.CreateProcedure(StoredProcedures.Select_Models_OverView_ByManufacturer, con);

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
                Parameters.CreateParameter(cmd, "@manufacturerId", ManufacturerId);

                //Execute Command
                var results = new List<ModelsOverView>();
                using (con)
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        results.Add(new ModelsOverView(reader));
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

        public static List<ModelsOverView> SelectModelsFiltered(int? currentPageNumber, int? pageSize, string sortExpression, int ManufacturerId, int companyId, string modelyear)
        {
            try
            {
                SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = ConnectionManager.CreateProcedure(StoredProcedures.Select_Models_OverView_Filtered, con);
                //Check for null values 
                //If so set default values for paging
                currentPageNumber = (currentPageNumber == null) ? ListViewPaging.DefaultPageNumber : currentPageNumber;
                pageSize = (pageSize == null) ? ListViewPaging.DefaultPageSize : pageSize;

                //Set Parameters
                Parameters.CreateParameter(cmd, "@sortExpression", sortExpression);
                int? startRowIndex = ListViewPaging.SetStartRowIndex(currentPageNumber, pageSize);
                int? maximumRows = ListViewPaging.SetMaximumRows(currentPageNumber, pageSize);
                Parameters.CreateParameter(cmd, "@maximumRows", maximumRows);
                Parameters.CreateParameter(cmd, "@startRowIndex", startRowIndex);
                Parameters.CreateParameter(cmd, "@manufacturerId", ManufacturerId);
                Parameters.CreateParameter(cmd, "@companyId", companyId);
                Parameters.CreateParameter(cmd, "@modelYear", modelyear);

                //Execute Command
                var results = new List<ModelsOverView>();
                using (con)
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        results.Add(new ModelsOverView(reader));
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
        private int _modelDetailId;
        private string _companyCode;
        private string _modelCode;
        private string _modelYear;
        private string _tasModelCode;
        private string _modelGroup;
        private string _manufacturerName;
        private string _modelDescription;
        private string _rateClass;
        private string _engineSize;
        private string _fuelType;
        private string _estimatedCap;
        private string _estimatedDeprRate;
        private string _estimatedVBAmt;
        private string _estimatedAB;
        private string _fastSpec;
        private DateTime? _recivableStoredDate;


        #endregion

        #region "Properties"

        public int Count
        {
            get { return _count; }
        }

        public int ModelDetailId
        {
            get { return _modelDetailId; }
        }

        public string CompanyCode
        {
            get { return _companyCode; }
        }

        public string ModelCode
        {
            get { return _modelCode; }
        }

        public string ModelYear
        {
            get { return _modelYear; }
        }

        public string TasModelCode
        {
            get { return _tasModelCode; }
        }

        public string ModelGroup
        {
            get { return _modelGroup; }
        }

        public string ManufacturerName
        {
            get { return _manufacturerName; }
        }

        public string ModelDescription
        {
            get { return _modelDescription; }
        }

        public string RateClass
        {
            get { return _rateClass; }
        }

        public string EngineSize
        {
            get { return _engineSize; }
        }

        public string FuelType
        {
            get { return _fuelType; }
        }

        public string EstimatedCap
        {
            get { return _estimatedCap; }
        }

        public string EstimatedDeprRate
        {
            get { return _estimatedDeprRate; }
        }

        public string EstimatedVBAmtPeriod
        {
            get { return _estimatedVBAmt; }
        }

        public string EstimatedVolBonus
        {
            get { return _estimatedAB; }
        }

        public string FastSpec
        {
            get { return _fastSpec; }
        }

        public string ReceivableStoreDate
        {
            //get { return (_invoiceDate != null) ? string.Format("{0:dd/MM/yyyy HH:mm:ss}", _invoiceDate) : ""; }
            get { return (_recivableStoredDate != null) ? string.Format("{0:dd/MM/yyyy}", _recivableStoredDate) : ""; }
        }

        #endregion

        #region "Constructor"

        public ModelsOverView(SqlDataReader reader)
        {
            if (reader["count"] != DBNull.Value)
                _count = Convert.ToInt32(reader["count"]);
            if (reader["ModelDetailId"] != DBNull.Value)
                _modelDetailId = Convert.ToInt32(reader["ModelDetailId"]);
            if (reader["CompanyCode"] != DBNull.Value)
                _companyCode = (string)reader["CompanyCode"];
            if (reader["ModelCode"] != DBNull.Value)
                _modelCode = (string)reader["ModelCode"];
            if (reader["ModelYear"] != DBNull.Value)
                _modelYear = (string)reader["ModelYear"];
            if (reader["TasModelCode"] != DBNull.Value)
                _tasModelCode = (string)reader["TasModelCode"];
            if (reader["ModelGroup"] != DBNull.Value)
                _modelGroup = (string)reader["ModelGroup"];
            if (reader["ManufacturerName"] != DBNull.Value)
                _manufacturerName = (string)reader["ManufacturerName"];
            if (reader["ModelDescription"] != DBNull.Value)
                _modelDescription = (string)reader["ModelDescription"];
            if (reader["RateClass"] != DBNull.Value)
                _rateClass = (string)reader["RateClass"];
            if (reader["EngineSize"] != DBNull.Value)
                _engineSize = (string)reader["EngineSize"];
            if (reader["FuelType"] != DBNull.Value)
                _fuelType = (string)reader["FuelType"];
            if (reader["EstimatedCap"] != DBNull.Value)
                _estimatedCap = (string)reader["EstimatedCap"];
            if (reader["EstimatedDeprRate"] != DBNull.Value)
                _estimatedDeprRate = (string)reader["EstimatedDeprRate"];
            if (reader["EstimatedVBAmtPeriod"] != DBNull.Value)
                _estimatedVBAmt = (string)reader["EstimatedVBAmtPeriod"];
            if (reader["EstimatedVolBonus"] != DBNull.Value)
                _estimatedAB = (string)reader["EstimatedVolBonus"];
            if (reader["FastSpec"] != DBNull.Value)
                _fastSpec = (string)reader["FastSpec"];
            if (reader["ReceivableStoreDate"] != DBNull.Value)
                _recivableStoredDate = Convert.ToDateTime(reader["ReceivableStoreDate"]);
        }

        #endregion
    }
}