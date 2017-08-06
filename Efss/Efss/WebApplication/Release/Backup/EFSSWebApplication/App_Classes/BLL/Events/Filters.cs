using System.Collections.Generic;
using RAD.Data;
/// <summary>
/// Summary description for Filters
/// </summary>
namespace APP.Search
{
    public class Filters
    {

        #region "Enum Items"

        public enum FilterOption : int
        {
            Acriss = 1,
            RacfId,
            Firstname,
            Surname,
            Email,
            Approved,
            LockedOut,
            IsDeleted,
            LastActivity,
            LastLoggedIn,
            CompanyName,
            CompanyCode,
            CompanyType,
            CountryName,
            RegionName,
            CurrencyCode,
            CountryVat,
            CompanyFiscalCode,
            Serial,
            Unit,
            Plate,
            Mileage,
            Model,
            Manufacturer,
            BuyerName,
            BuyBack,
            BuyeerTaxCode,
            BuyerFiscalCode,
            ContactName,
            ContactEmail,
            ContactTypeName,
            BuyerCode,
            VehicleType,
            InServiceDate,
            ManufacturerName,
            ModelsCount,
            IsBe,
            IsGE,
            IsFR,
            IsIT,
            IsLU,
            IsNE,
            IsSP,
            IsSZ,
            IsUK,
            FileDate,
            TotalInvoices,
            Original,
            CreditNotes,
            FleetCo,
            OpCo,
            WholeSale,
            Wreck,
            Errors,
            InvoiceNumber,
            InvoiceDate,
            IsValid,
            AreaCode,
            AreaName,
            AreaId,
            Araes,

            Active,
            AddedBy,
            AddedDate,
            AgreementCreator,
            Analyst,
            BrowserType,
            BrowserVersion,
            Cars,
            CBMPCompulsion,
            Changes,
            ContractStatus,
            ControlName,
            CountryStatus,
            CountryType,
            Currency,
            DailyExclusiveRate,
            DailyInclusiveRate,
            DailyMileageCap,
            DateFrom,
            DateLogged,
            DateTo,
            DayFrom,
            DayTo,
            DecimalUsage,
            EffectiveFrom,
            EffectiveTo,
            Executive,
            ExpectedMarketShare,
            FlexibleRate,
            GlobalParentNumber,
            GroupCode,
            GroupCodeLY,
            HasBespoke,
            HertzStatus,
            IPAddress,
            IsCostBreakOrMultiplier,
            ISOCode,
            IsStandard,
            JavascriptEnabled,
            Level,
            LevelNumber,
            LevelRange,
            MarketSize,
            MileageMonthlyMax,
            Percentage,
            Rates,
            ReportingParentNumber,
            RequestedBy,
            RequestedDate,
            SalesDirector,
            SourceCountry,
            Standard,
            Subject,
            SupportsJavascript,
            TargetGoLiveDate,
            TargetYear,
            Title,
            UpdatedBy,
            UpdatedDate,
            ValidFrom,
            ValidTo,
            Vans,
            XMRate

        };

        #endregion

        #region "Methods"

        public static List<Filters> SelectFilter(int filterOption)
        {
            //Declare a new list of filters
            var results = new List<Filters>();

            //Check which filter we are using and create 
            switch (filterOption)
            {

                case (int)FilterOptions.Users:
                    //Add the new items to the list
                    results.Add(new Filters((int)FilterOption.RacfId, Resources.ListItems.RacfId, (int)FilterType.SearchString));
                    results.Add(new Filters((int)FilterOption.Firstname, Resources.ListItems.Firstname, (int)FilterType.SearchString));
                    results.Add(new Filters((int)FilterOption.Surname, Resources.ListItems.Surname, (int)FilterType.SearchString));
                    results.Add(new Filters((int)FilterOption.Email, Resources.ListItems.Email, (int)FilterType.SearchString));
                    results.Add(new Filters((int)FilterOption.Approved, Resources.ListItems.Approved, (int)FilterType.Bit));
                    results.Add(new Filters((int)FilterOption.LockedOut, Resources.ListItems.LockedOut, (int)FilterType.Bit));
                    results.Add(new Filters((int)FilterOption.IsDeleted, Resources.ListItems.IsDeleted, (int)FilterType.Bit));
                    results.Add(new Filters((int)FilterOption.LastActivity, Resources.ListItems.LastActivity, (int)FilterType.DateRange));
                    results.Add(new Filters((int)FilterOption.LastLoggedIn, Resources.ListItems.LastLoggedIn, (int)FilterType.DateRange));
                    break;

            }


            //Sort List Ascending by name
            GenericLists.SortList<Filters, string>(results, x => x.FilterName);
            //Return results
            return results;

        }


        #endregion

        #region "Properties"

        public string FilterName { get; set; }
        public string Filter { get; set; }

        #endregion

        #region "Constructors"

        public Filters(int filterId, string filterName, int filterType)
        {
            FilterName = filterName;
            Filter = filterId.ToString() + "|" + filterType.ToString();
        }

        #endregion

    }
}