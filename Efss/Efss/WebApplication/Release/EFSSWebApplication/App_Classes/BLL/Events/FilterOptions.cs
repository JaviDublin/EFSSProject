
/// <summary>
/// This class is used to select filter options for dropdownlist searches
/// If you need to use this for a new section simply add new Option Name and value to the list below
/// </summary>
namespace APP.Search
{
    #region "Enum Items"

    public enum FilterOptions : int
    {
        AccountContracts = 1,
        Accounts,
        AccountCountry,
        AccountsNotes,
        Activity,
        ApplicationLog,
        ContractComments,
        ContractCostBreaks,
        ContractCountry,
        ContractGeneral,
        ContractRates,
        Contracts,
        ContractTermsConditions,
        ContractVehicles,
        LevelPricing,
        PPCostBreaks,
        PPRates,
        PPVehicles,
        ProposalRequest,
        ProposalRequestCountry,
        TermsConditions,
        UserGroupsAccounts,
        UserGroupsControls,
        UserGroupsCountries,
        UsersInGroups,

        Countries,
        CountriesByUser,
        Companies,
        CompaniesByCountry,
        ActiveFleet,
        Users,
        Controls,
        Manufacturers,
        Sales,
        Buyers,
        Serials
    };

    #endregion

}
