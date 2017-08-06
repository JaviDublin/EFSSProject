
/// <summary>
/// This class is used to select filter type for filter options on searches
/// NoFilter - Show All
/// SearchString - String search option for user
/// DateRange - Start date and End date search option for user
/// Bit - True / False search option for user
/// IntRange - Start integer value and End integer value for user to search
/// DropDownOption - A particular list of items that a user can select from
/// AutoComplete - A webservice used to select what user searches for
/// </summary>
namespace APP.Search
{
    #region "Enum Items"

    public enum FilterType : int
    {
        NoFilter = -1,
        AutoCompleteInt = 1,
        AutoCompleteString,
        Bit,
        DateRange,
        DecimalRange,
        DropDownOption,
        IntRange,
        OptionFilter,
        PercentageRange,
        SearchDecimal,
        SearchInt,
        SearchString
    };

    #endregion

}
