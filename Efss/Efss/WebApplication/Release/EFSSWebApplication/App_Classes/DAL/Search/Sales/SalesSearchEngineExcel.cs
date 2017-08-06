using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Diagnostics;
using APP.Data;
using RAD.Data;
using RAD.Diagnostics;
using APP.Session;
namespace APP.Search
{
    public class SalesSearchEngineExcel
    {
        public static List<SalesSearchEngineExcel> SearchInvoices()
        {
            try
            {
                //Initialise Command
                SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = ConnectionManager.CreateProcedure(StoredProcedures.Select_SearchEngine_ToExcel, con);
                Parameters.CreateParameter(cmd, "@countryId", SessionHandler.SearchFormCountryId);
                Parameters.CreateParameter(cmd, "@companyId", SessionHandler.SearchFormCompanyId);
                Parameters.CreateParameter(cmd, "@plate", SessionHandler.SearchPlate);
                Parameters.CreateParameter(cmd, "@unit", SessionHandler.SearchUnit);
                Parameters.CreateParameter(cmd, "@serial", SessionHandler.SearchSerial);
                Parameters.CreateParameter(cmd, "@dateFrom", SessionHandler.SearchDateFrom);
                Parameters.CreateParameter(cmd, "@dateTo", SessionHandler.SearchDateTo);
                Parameters.CreateParameter(cmd, "@invoiceFrom", SessionHandler.SearchInvoiceFrom);
                Parameters.CreateParameter(cmd, "@invoiceTo", SessionHandler.SearchInvoiceTo);
                Parameters.CreateParameter(cmd, "@buyerCode", SessionHandler.SearchBuyerCode);
                Parameters.CreateParameter(cmd, "@buyerName", SessionHandler.SearchBuyerName);
                Parameters.CreateParameter(cmd, "@invoiceType", SessionHandler.SearchDocType);
                Parameters.CreateParameter(cmd, "@invoiceSubType", SessionHandler.SearchDocSubType);
                Parameters.CreateParameter(cmd, "@manufacturer", SessionHandler.SearchManufacturer);
                Parameters.CreateParameter(cmd, "@vehicleType", SessionHandler.SearchVehicleType);
                Parameters.CreateParameter(cmd, "@saleType", SessionHandler.SearchSaleType);
                Parameters.CreateParameter(cmd, "@fileDate", SessionHandler.SearchFileDate);


                //Execute Command
                var results = new List<SalesSearchEngineExcel>();
                using (con)
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        results.Add(new SalesSearchEngineExcel(reader));
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

        public static List<SalesSearchEngineExcel> SearhFileInvoicesByBuyer(string FileDate, string invoiceDate, int CountryId, int BuyerId)
        {
            try
            {
                SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = ConnectionManager.CreateProcedure(StoredProcedures.Select_SearchEngine_ToExcelByBuyer, con);
                Parameters.CreateParameter(cmd, "@fileDate", FileDate);
                Parameters.CreateParameter(cmd, "@invoiceDate", invoiceDate);
                Parameters.CreateParameter(cmd, "@countryId", CountryId);
                Parameters.CreateParameter(cmd, "@buyerId", BuyerId);

                //Execute Command
                var results = new List<SalesSearchEngineExcel>();
                using (con)
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        results.Add(new SalesSearchEngineExcel(reader));
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

        public static List<SalesSearchEngineExcel> SearchFileInvoicesByDocItem(int docitemid)
        {
            try
            {
                SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = ConnectionManager.CreateProcedure(StoredProcedures.Select_SearchEngine_ToExcelByDocItemId, con);
                Parameters.CreateParameter(cmd, "@docItemId", docitemid);
               

                //Execute Command
                var results = new List<SalesSearchEngineExcel>();
                using (con)
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        results.Add(new SalesSearchEngineExcel(reader));
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

        private int _rowId;
        private string _companyCode;
        private string _areaCode;
        private string _serial;
        private string _unit;
        private string _plate;
        private string _mileage;
        private string _inServiceDate;
        private string _outServiceDate;
        private string _msoDate;
        private string _modelCode;
        private string _modelDescription;
        private string _carColor;
        private string _modelYear;
        private string _manufacturerCode;
        private string _manufacturerName;
        private string _vehicleClass;
        private string _vehicleType;
        private string _purchaseOrder;
        private string _payDate;
        private string _invoiceNumber;
        private string _inv_cn;
        private string _saleDate;
        private string _invoiceDate;
        private string _saleType;
        private string _saleDocumentNumber;
        private decimal _invoiceNet;
        private decimal _invoiceVat;
        private decimal _invoiceTotal;
        private string _buyerCode;
        private string _buyerName;
        private string _buyerAddress1;
        private string _buyerAddress2;
        private string _buyerAddress3;
        private string _buyerAddress4;
        private string _buyerFiscalCode;
        private decimal _capitalCost;
        private decimal _depreciation;
        private decimal _bookValue;
        private decimal _buyBackCap;
        private decimal _mileCharge;
        private decimal _plusKM;
        private decimal _fuelCharge;
        private decimal _damage;
        private decimal _transferFees;
        private decimal _transferFeesNoVat;
        private string _taxDescription1;
        private string _taxDescription2;
        private string _taxDescription3;
        private decimal _originalBPM;
        private decimal _calcVatAmortized;
        private decimal _unamortized;
        private decimal _superCharge;
        private decimal _handleFee;
        private decimal _addOn;
        private decimal _other1;
        private decimal _other2;
        private decimal _amount5;
        private decimal _amount6;
        private string _amount7;
        private string _exportTo;
        private string _tax;
        private decimal _RegTaxAmount;


        #endregion

        #region "Properties"

        public int RowId
        {
            get { return _rowId; }
        }

        public string CompanyCode
        {
            get { return _companyCode; }
        }

        public string AreaCode
        {
            get { return _areaCode; }
        }

        public string Serial
        {
            get { return _serial; }
        }

        public string Unit
        {
            get { return _unit; }
        }

        public string Plate
        {
            get { return _plate; }
        }

        public string Mileage
        {
            get { return _mileage; }
        }

        public string InServiceDate
        {
            get { return _inServiceDate; }
        }

        public string OutServiceDate
        {
            get { return _outServiceDate; }
        }

        public string MSODate
        {
            get { return _msoDate; }
        }

        public string ModelCode
        {
            get { return _modelCode; }
        }

        public string ModelDescription
        {
            get { return _modelDescription; }
        }

        public string CarColor
        {
            get { return _carColor; }
        }

        public string ModelYear
        {
            get { return _modelYear; }
        }

        public string ManufacturerCode
        {
            get { return _manufacturerCode; }
        }

        public string ManufacturerName
        {
            get { return _manufacturerName; }
        }

        public string VehicleClass
        {
            get { return _vehicleClass; }
        }

        public string VehicleType
        {
            get { return _vehicleType; }
        }

        public string PurchaseOrder
        {
            get { return _purchaseOrder; }
        }

        public string PayDate
        {
            get { return _payDate; }
        }

        public string InvoiceNumber
        {
            get { return _invoiceNumber; }
        }

        public string Inv_CN
        {
            get { return _inv_cn; }
        }

        public string SaleDate
        {
            get { return _saleDate; }
        }

        public string InvoiceDate
        {
            get { return _invoiceDate; }
        }

        public string SaleType
        {
            get { return _saleType; }
        }

        public string SaleDocumentNumber
        {
            get { return _saleDocumentNumber; }
        }

        public decimal InvoiceNet
        {
            get { return _invoiceNet; }
        }

        public decimal InvoiceVat
        {
            get { return _invoiceVat; }
        }

        public decimal InvoiceTotal
        {
            get { return _invoiceTotal; }
        }

        public string BuyerCode
        {
            get { return _buyerCode; }
        }

        public string BuyerName
        {
            get { return _buyerName; }
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
            get { return _buyerAddress2; }
        }

        public string BuyerFiscalCode
        {
            get { return _buyerFiscalCode; }
        }

        public decimal CapitalCost
        {
            get { return _capitalCost; }
        }

        public decimal Depreciation
        {
            get { return _depreciation; }
        }

        public decimal BookValue
        {
            get { return _bookValue; }
        }

        public decimal BuyBackCap
        {
            get { return _buyBackCap; }
        }

        public decimal MileCharge
        {
            get { return _mileCharge; }
        }

        public decimal PlusKM
        {
            get { return _plusKM; }
        }

        public decimal FuelCharge
        {
            get { return _fuelCharge; }
        }

        public decimal Damage
        {
            get { return _damage; }
        }

        public decimal TransferFees
        {
            get { return _transferFees; }
        }

        public decimal TransferFeesNoVat
        {
            get { return _transferFeesNoVat; }
        }

        public string TaxDescription1
        {
            get { return _taxDescription1; }
        }

        public string TaxDescription2
        {
            get { return _taxDescription2; }
        }

        public string TaxDescription3
        {
            get { return _taxDescription3; }
        }

        public decimal OriginalBPM
        {
            get { return _originalBPM; }
        }

        public decimal CalcVatAmortized
        {
            get { return _calcVatAmortized; }
        }

        public decimal Unamortized
        {
            get { return _unamortized; }
        }

        public decimal SuperCharge
        {
            get { return _superCharge; }
        }

        public decimal HandleFee
        {
            get { return _handleFee; }
        }

        public decimal AddOn
        {
            get { return _addOn; }
        }

        public decimal Other1
        {
            get { return _other1; }
        }

        public decimal Other2
        {
            get { return _other2; }
        }

        public decimal Amount5
        {
            get { return _amount5; }
        }

        public decimal Amount6
        {
            get { return _amount6; }
        }

        public string Amount7
        {
            get { return _amount7; }
        }

        public string ExportTo
        {
            get { return _exportTo; }
        }

        public string Tax
        {
            get { return _tax; }
        }

        public decimal RegTaxAmount
        {
            get { return _RegTaxAmount; }
        }

        #endregion

        #region "Constructor"

        public SalesSearchEngineExcel(SqlDataReader reader)
        {

            if (reader["RowId"] != DBNull.Value)
                _rowId = Convert.ToInt32(reader["RowId"]);
            if (reader["CompanyCode"] != DBNull.Value)
                _companyCode = (string)reader["CompanyCode"];
            if (reader["AreaCode"] != DBNull.Value)
                _areaCode = (string)reader["AreaCode"];
            if (reader["Serial"] != DBNull.Value)
                _serial = (string)reader["Serial"];
            if (reader["Unit"] != DBNull.Value)
                _unit = (string)reader["Unit"];
            if (reader["Plate"] != DBNull.Value)
                _plate = (string)reader["Plate"];
            if (reader["Mileage"] != DBNull.Value)
                _mileage = (string)reader["Mileage"];
            if (reader["InServiceDate"] != DBNull.Value)
                _inServiceDate = (string)reader["InServiceDate"];
            if (reader["OutServiceDate"] != DBNull.Value)
                _outServiceDate = (string)reader["OutServiceDate"];
            if (reader["MSODate"] != DBNull.Value)
                _msoDate = (string)reader["MSODate"];
            if (reader["ModelCode"] != DBNull.Value)
                _modelCode = (string)reader["ModelCode"];
            if (reader["ModelDescription"] != DBNull.Value)
                _modelDescription = (string)reader["ModelDescription"];
            if (reader["CarColor"] != DBNull.Value)
                _carColor = (string)reader["CarColor"];
            if (reader["ModelYear"] != DBNull.Value)
                _modelYear = (string)reader["ModelYear"];
            if (reader["ManufacturerCode"] != DBNull.Value)
                _manufacturerCode = (string)reader["ManufacturerCode"];
            if (reader["ManufacturerName"] != DBNull.Value)
                _manufacturerName = (string)reader["ManufacturerName"];
            if (reader["VehicleClass"] != DBNull.Value)
                _vehicleClass = (string)reader["VehicleClass"];
            if (reader["VehicleType"] != DBNull.Value)
                _vehicleType = (string)reader["VehicleType"];
            if (reader["PurchaseOrder"] != DBNull.Value)
                _purchaseOrder = (string)reader["PurchaseOrder"];
            if (reader["PayDate"] != DBNull.Value)
                _payDate = (string)reader["PayDate"];
            if (reader["InvoiceNumber"] != DBNull.Value)
                _invoiceNumber = (string)reader["InvoiceNumber"];
            if (reader["INV_CN"] != DBNull.Value)
                _inv_cn = (string)reader["INV_CN"];
            if (reader["SaleDate"] != DBNull.Value)
                _saleDate = (string)reader["SaleDate"];
            if (reader["InvoiceDate"] != DBNull.Value)
                _invoiceDate = (string)reader["InvoiceDate"];
            if (reader["SaleType"] != DBNull.Value)
                _saleType = (string)reader["SaleType"];
            if (reader["SaleDocumentNumber"] != DBNull.Value)
                _saleDocumentNumber = (string)reader["SaleDocumentNumber"];
            if (reader["InvoiceNet"] != DBNull.Value)
                _invoiceNet = Convert.ToDecimal(reader["InvoiceNet"]);
            if (reader["InvoiceVat"] != DBNull.Value)
                _invoiceVat = Convert.ToDecimal(reader["InvoiceVat"]);
            if (reader["InvoiceTotal"] != DBNull.Value)
                _invoiceTotal = Convert.ToDecimal(reader["InvoiceTotal"]);
            if (reader["BuyerCode"] != DBNull.Value)
                _buyerCode = (string)reader["BuyerCode"];
            if (reader["BuyerName"] != DBNull.Value)
                _buyerName = (string)reader["BuyerName"];
            if (reader["BuyerAddress1"] != DBNull.Value)
                _buyerAddress1 = (string)reader["BuyerAddress1"];
            if (reader["BuyerAddress2"] != DBNull.Value)
                _buyerAddress2 = (string)reader["BuyerAddress2"];
            if (reader["BuyerAddress3"] != DBNull.Value)
                _buyerAddress3 = (string)reader["BuyerAddress3"];
            if (reader["BuyerAddress4"] != DBNull.Value)
                _buyerAddress4 = (string)reader["BuyerAddress4"];
            if (reader["BuyerFiscalCode"] != DBNull.Value)
                _buyerFiscalCode = (string)reader["BuyerFiscalCode"];
            if (reader["CapitalCost"] != DBNull.Value)
                _capitalCost = Convert.ToDecimal(reader["CapitalCost"]);
            if (reader["Depreciation"] != DBNull.Value)
                _depreciation = Convert.ToDecimal(reader["Depreciation"]);
            if (reader["BookValue"] != DBNull.Value)
                _bookValue = Convert.ToDecimal(reader["BookValue"]);
            if (reader["BuyBackCap"] != DBNull.Value)
                _buyBackCap = Convert.ToDecimal(reader["BuyBackCap"]);
            if (reader["MileCharge"] != DBNull.Value)
                _mileCharge = Convert.ToDecimal(reader["MileCharge"]);
            if (reader["PlusKM"] != DBNull.Value)
                _plusKM = Convert.ToDecimal(reader["PlusKM"]);
            if (reader["FuelCharge"] != DBNull.Value)
                _fuelCharge = Convert.ToDecimal(reader["FuelCharge"]);
            if (reader["Damage"] != DBNull.Value)
                _damage = Convert.ToDecimal(reader["Damage"]);
            if (reader["TransferFees"] != DBNull.Value)
                _transferFees = Convert.ToDecimal(reader["TransferFees"]);
            if (reader["TransferFeesNoVat"] != DBNull.Value)
                _transferFeesNoVat = Convert.ToDecimal(reader["TransferFeesNoVat"]);
            if (reader["TaxDescription1"] != DBNull.Value)
                _taxDescription1 = (string)reader["TaxDescription1"];
            if (reader["TaxDescription2"] != DBNull.Value)
                _taxDescription2 = (string)reader["TaxDescription2"];
            if (reader["TaxDescription3"] != DBNull.Value)
                _taxDescription3 = (string)reader["TaxDescription3"];
            if (reader["OriginalBPM"] != DBNull.Value)
                _originalBPM = Convert.ToDecimal(reader["OriginalBPM"]);
            if (reader["CalcVatAmortized"] != DBNull.Value)
                _calcVatAmortized = Convert.ToDecimal(reader["CalcVatAmortized"]);
            if (reader["Unamortized"] != DBNull.Value)
                _unamortized = Convert.ToDecimal(reader["Unamortized"]);
            if (reader["SuperCharge"] != DBNull.Value)
                _superCharge = Convert.ToDecimal(reader["SuperCharge"]);
            if (reader["HandleFee"] != DBNull.Value)
                _handleFee = Convert.ToDecimal(reader["HandleFee"]);
            if (reader["AddOn"] != DBNull.Value)
                _addOn = Convert.ToDecimal(reader["AddOn"]);
            if (reader["Other1"] != DBNull.Value)
                _other1 = Convert.ToDecimal(reader["Other1"]);
            if (reader["Other2"] != DBNull.Value)
                _other2 = Convert.ToDecimal(reader["Other2"]);
            if (reader["Amount5"] != DBNull.Value)
                _amount5 = Convert.ToDecimal(reader["Amount5"]);
            if (reader["Amount6"] != DBNull.Value)
                _amount6 = Convert.ToDecimal(reader["Amount6"]);
            if (reader["Amount7"] != DBNull.Value)
                _amount7 = (string)reader["Amount7"];
            if (reader["ExportTo"] != DBNull.Value)
                _exportTo = (string)reader["ExportTo"];
            if (reader["Tax"] != DBNull.Value)
                _tax = (string)reader["Tax"];
            if (reader["RegTaxAmount"] != DBNull.Value)
                _RegTaxAmount = Convert.ToDecimal(reader["RegTaxAmount"]);
        }

        #endregion
    }
}