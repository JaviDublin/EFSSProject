
namespace APP.Data
{
    public class DBSettings
    {
        public const string Delimiter = @",";
        public const string CompanyCode = @"CompanyCode";
        public const string AreaCode = @"AreaCode";
        public const string Serial = @"Serial";
        public const string Plate = @"Plate";
        public const string Unit = @"Unit";
        public const string ModelCode = @"ModelCode";
        public const string ManufacturerName = @"ManufacturerName";
        public const string ModelDescription = @"ModelDescription";
        public const string ModelYear = @"ModelYear";
        public const string Mileage = @"Mileage";
        public const string VehicleType = @"VehicleType";
        public const string VehiclaClass = @"VehicleClass";
        public const string VehicleStatus = @"VehicleStatus";
        public const string InServiceDate = @"InServiceDate";
        public const string OutServiceDate = @"OutServiceDate";
        public const string MSODate = @"MSODate";
        public const string DeliveryDate = @"DeliveryDate";
        public const string DaysInService = @"DaysInService";
        public const string CapitalCost = @"CapitalCost";
        public const string Depreciation = @"Depreciation";
        public const string DepreciationRate = @"DepreciationRate";
        public const string DepreciationPCT = @"DepreciationPCT";
        public const string BookValue = @"BookValue";
        public const string BuyBackCap = @"BuyBackCap";
        public const string SalesPrice = @"SalePrice";
        public const string BuyerCode = @"BuyerCode";
        public const string BuyerName = @"BuyerName";
        public const string RateClass = @"RateClass";
        public const string SaleDocumentNumber = @"SaleDocumentNumber";
        public const string InvoiceNumber = @"InvoiceNumber";
        public const string InvoiceStatus = @"InvoiceStatus";
        public const string SaleType = @"SaleType";

        public const string WhereClause = @" WHERE ";
        public const string EndStringValue = @"'";
        public const string StartStringValue = @"'";
        public const string AndOperator = @" AND ";
        public const string EqualOperator = @" = ";
        public const string BiggerthanOperator = @" > ";
        public const string BiggerEqualthanOperator = @" >= ";
        public const string SamllerthanOperator = @" < ";
        public const string SamllerEqualthanOperator = @" <= ";
        public const string StartConvertDate = @"Convert(datetime,'";
        public const string EndConvertDate = @"',103)";

        public const string CountryCondition = @"CountryId = ";
        public const string CountryALLCondition = @"CountryId in (1,2,3,4,5,6,7,8,9) ";
        public const string CompanyCondition = @"CompanyId = ";
        public const string AreaCondition = @"AreaCode = '";
        public const string ModelCodeCondition = @"ModelCode = '";
        public const string ManufacturerCondition = @"ManufacturerId = ";
        public const string InServiceDateCondition = @"InServiceDate";
        public const string MSODateCondition = @"MSODate";
        public const string DeliveryDateDateCondition = @"DeliveryDate";
        public const string MileageCondition = @"Mileage";
        public const string SaleTypeCondition = @"SaleType = '";
        public const string VehicleStatusCondition = @"VehicleStatus = '";
        
        public const string BuyerCondition = @"BuyerCode ='";


    }
}