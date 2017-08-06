using System;
using APP.Search;

/// <summary>
/// This class is used to specifiy custom properties for the filter control
/// FilterId - Int :
/// FilterText - String: The value of the search string
/// FilterBit - Boolean: True / False value of search option
/// FilterStartDate - Datetime: Start date of date range search
/// FilterEndDate - Datetime: End date of date range search
/// FilterOption - Int :
/// </summary>
namespace APP.Events
{

    public class FilterEvents : EventArgs
    {

        #region "Properties"

        public int FilterId { get; set; }
        public string FilterText { get; set; }
        public bool FilterBit { get; set; }
        public DateTime FilterStartDate { get; set; }
        public DateTime FilterEndDate { get; set; }
        public int FilterOption { get; set; }
        public bool FilterShowAll { get; set; }
        public string FilterSelectedValue { get; set; }
        public int FilterStartInt { get; set; }
        public int FilterEndInt { get; set; }
        public decimal FilterStartDecimal { get; set; }
        public decimal FilterEndDecimal { get; set; }

        #endregion

        #region "Constructors"

        /// <summary>
        /// These event args are for Search Term Option Filter
        /// </summary>
        /// <param name="filterOption"> int - SearchString | DateRange | Bit | Int Range  | DropDownOption | AutoComplete</param>
        /// <param name="filterId">int - filter id eg: country</param>
        /// <param name="filterText">string - filter text</param>
        public FilterEvents(int filterOption, int filterId, string filterText)
        {
            FilterOption = filterOption;
            FilterId = filterId;
            FilterText = filterText;
            FilterOption = (int)FilterType.SearchString;
            FilterShowAll = false;
        }

        /// <summary>
        /// These event args are for Boolean Option Filter
        /// </summary>
        /// <param name="filterOption"> int - SearchString | DateRange | Bit | Int Range  | DropDownOption | AutoComplete</param>
        /// <param name="filterId">int - filter id eg: isActice</param>
        /// <param name="filterBit">bool - true / false</param>
        public FilterEvents(int filterOption, int filterId, bool filterBit)
        {
            FilterOption = filterOption;
            FilterId = filterId;
            FilterBit = filterBit;
            FilterOption = (int)FilterType.Bit;
            FilterShowAll = false;
        }

        /// <summary>
        /// These event args are for Date Range filter Option
        /// </summary>
        /// <param name="filterOption"> int - SearchString | DateRange | Bit | Int Range  | DropDownOption | AutoComplete</param>
        /// <param name="filterId">int - filter id eg: start date</param>
        /// <param name="filterStartDate">DateTime - from date range value</param>
        /// <param name="filterEndDate">DateTime - to date range value</param>
        public FilterEvents(int filterOption, int filterId, DateTime filterStartDate, DateTime filterEndDate)
        {
            FilterOption = filterOption;
            FilterId = filterId;
            FilterStartDate = filterStartDate;
            FilterEndDate = filterEndDate;
            FilterOption = (int)FilterType.DateRange;
            FilterShowAll = false;
        }


        /// <summary>
        /// These event args are used for Drop Down Option filter
        /// </summary>
        /// <param name="filterOption"> int - SearchString | DateRange | Bit | Int Range  | DropDownOption | AutoComplete</param>
        /// <param name="filterId">int - filter id eg: country status</param>
        /// <param name="filterSelectedValue">string - selected value of dropdown</param>
        public FilterEvents(int filterOption, int filterId, string filterSelectedValue, bool isSelectAll)
        {
            FilterOption = filterOption;
            FilterId = filterId;
            FilterSelectedValue = filterSelectedValue;
            FilterShowAll = false;
        }


        /// <summary>
        /// These event args are used for an Integer range filter option
        /// </summary>
        /// <param name="filterOption"> int - SearchString | DateRange | Bit | Int Range  | DropDownOption | AutoComplete</param>
        /// <param name="filterId">int - filter Id eg: Cars</param>
        /// <param name="filterStartInt">int - start range integer</param>
        /// <param name="filterEndInt">int - end range integer</param>
        public FilterEvents(int filterOption, int filterId, int filterStartInt, int filterEndInt)
        {
            FilterOption = filterOption;
            FilterId = filterId;
            FilterStartInt = filterStartInt;
            FilterEndInt = filterEndInt;
            FilterShowAll = false;
        }


        /// <summary>
        /// These event args are used for an decimal range filter option
        /// </summary>
        /// <param name="filterOption"></param>
        /// <param name="filterId"></param>
        /// <param name="filterStartDecimal"></param>
        /// <param name="filterEndDecimal"></param>
        public FilterEvents(int filterOption, int filterId, decimal filterStartDecimal, decimal filterEndDecimal)
        {
            FilterOption = filterOption;
            FilterId = filterId;
            FilterStartDecimal = filterStartDecimal;
            FilterEndDecimal = filterEndDecimal;
            FilterShowAll = false;
        }


        /// <summary>
        /// These event args are used to represent no filter
        /// This is used to show all results
        /// </summary>
        public FilterEvents()
        {
            FilterOption = (int)FilterType.NoFilter;
            FilterShowAll = true;
        }


        /// <summary>
        /// 
        /// </summary>
        /// <param name="filterOption"></param>
        public FilterEvents(int filterOption)
        {
            FilterOption = filterOption;
            FilterShowAll = false;
        }

        #endregion

    }

}
