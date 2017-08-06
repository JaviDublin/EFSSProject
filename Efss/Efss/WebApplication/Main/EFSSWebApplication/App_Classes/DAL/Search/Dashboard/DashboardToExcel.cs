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
    public class DashboardToExcel
    {

        public static List<DashboardToExcel> SelectDashBoardExcel()
        {
            try
            {
                //Initialise Command
                SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = ConnectionManager.CreateProcedure(StoredProcedures.DashboardListing, con);


                Parameters.CreateParameter(cmd, "@companyId", SessionHandler.DashBoardCompanyId);
                Parameters.CreateParameter(cmd, "@countryId", SessionHandler.DashBoardCountryId);
                Parameters.CreateParameter(cmd, "@manufacturerid", SessionHandler.DashBoardManufacturer);
                Parameters.CreateParameter(cmd, "@buyerName", SessionHandler.DashBoardBuyer);
                Parameters.CreateParameter(cmd, "@buyback", SessionHandler.DashBoardBuyBack);
                Parameters.CreateParameter(cmd, "@nrbounus", SessionHandler.DashBoardNRBonus);
                Parameters.CreateParameter(cmd, "@vbouns", SessionHandler.DashBoardVBouns);

                Parameters.CreateParameter(cmd, "@open", SessionHandler.DashBoardStatusOpen);
                Parameters.CreateParameter(cmd, "@matched", SessionHandler.DashBoardStatusMatched);
                Parameters.CreateParameter(cmd, "@unapplied", SessionHandler.DashBoardStatusUnapplied);



                //Execute Command
                var results = new List<DashboardToExcel>();
                using (con)
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        results.Add(new DashboardToExcel(reader));
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

        private string _companyCode;
        private string _serial;
        private string _plate;
        private string _recvType;
        private string _omu;
        private string _manufacturerName;
        private string _buyerName;
        private string _invoiceDate;
        private string _saleDocumentNumber;
        private string _invoiceNumber;
        private decimal _recvAmt;
        private string _outServiceDate;
        private string _inServiceDate;
        private string _capitalCost;
        private string _depreciation;
        private string _netRecv;
        private string _mileage;
        private string _purchInvoiceNumber;
        private string _recvDueDate;
        private string _dueDtAge;


        #endregion

        #region "Properties"

        public string CompanyCode
        { get { return _companyCode; } }

        public string Serial
        {  get { return _serial; } }
        
        public string Plate
        { get { return _plate; } }
        
        public string RecvType
        { get { return _recvType; } }

        public string Omu
        { get { return _omu; } }
        
        public string ManufacturerName
        { get { return _manufacturerName; } }
        
        public string BuyerName
        { get { return _buyerName; } }
        
        public string InvoiceDate
        { get { return _invoiceDate; } }
        
        public string SaleDocumentNumber
        { get { return _saleDocumentNumber; } }
        
        public string InvoiceNumber
        { get { return @_invoiceNumber; } }

        public decimal RecvAmt
        { get { return _recvAmt; } }
        
        public string OutServiceDate
        { get { return _outServiceDate; } }
        
        public string InServiceDate
        { get { return _inServiceDate; } }
        
        public string CapitalCost
        { get { return _capitalCost; } }
        
        public string Depreciation
        { get { return _depreciation; } }
        
        public string NetRecv
        { get { return _netRecv; } }
        
        public string Mileage
        { get { return _mileage; } }
        
        public string PurchInvoiceNumber
        { get { return _purchInvoiceNumber; } }
        
        public string RecvDueDate
        { get { return _recvDueDate; } }
        
        public string DueDtAge
        { get { return _dueDtAge; } }
            
        #endregion

        #region "Constructor"
        
         public DashboardToExcel(SqlDataReader reader)
         {
             if (reader["CompanyCode"] != DBNull.Value)
                 _companyCode = (string)reader["CompanyCode"];
             if (reader["Serial"] != DBNull.Value)
                 _serial = (string)reader["Serial"];
             if (reader["Plate"] != DBNull.Value)
                 _plate = (string)reader["Plate"];
             if (reader["RecvType"] != DBNull.Value)
                 _recvType = (string)reader["RecvType"];
             if (reader["OMU"] != DBNull.Value)
                 _omu = (string)reader["OMU"];
             if (reader["ManufacturerName"] != DBNull.Value)
                 _manufacturerName = (string)reader["ManufacturerName"];
             if (reader["BuyerName"] != DBNull.Value)
                 _buyerName = (string)reader["BuyerName"];
             if (reader["InvoiceDate"] != DBNull.Value)
                 _invoiceDate = (string)reader["InvoiceDate"];
             if (reader["SaleDocumentNumber"] != DBNull.Value)
                 _saleDocumentNumber = (string)reader["SaleDocumentNumber"];
             if (reader["InvoiceNumber"] != DBNull.Value)
                 _invoiceNumber = (string)reader["InvoiceNumber"];
             if (reader["RecvAmt"] != DBNull.Value)
                 _recvAmt = Convert.ToDecimal(reader["RecvAmt"]);
             if (reader["OutServiceDate"] != DBNull.Value)
                 _outServiceDate = (string)reader["OutServiceDate"];
             if (reader["InServiceDate"] != DBNull.Value)
                 _inServiceDate = (string)reader["InServiceDate"];
             if (reader["CapitalCost"] != DBNull.Value)
                 _capitalCost = (string)reader["CapitalCost"];
             if (reader["Depreciation"] != DBNull.Value)
                 _depreciation = (string)reader["Depreciation"];
             if (reader["NetRecv"] != DBNull.Value)
                 _netRecv = (string)reader["NetRecv"];
             if (reader["Mileage"] != DBNull.Value)
                 _mileage = (string)reader["Mileage"];
             if (reader["PurchInvoiceNumber"] != DBNull.Value)
                 _purchInvoiceNumber = (string)reader["PurchInvoiceNumber"];
             if (reader["RecvDueDate"] != DBNull.Value)
                 _recvDueDate = (string)reader["RecvDueDate"];
             if (reader["DueDtAge"] != DBNull.Value)
                 _dueDtAge = (string)reader["DueDtAge"];
             
         }
        
        
        #endregion


    }
}