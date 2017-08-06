using System.Web.UI;

/// <summary>
/// Summary description for Search
/// </summary>
namespace APP.Search
{

    #region "Enum Items"

    public enum ServiceName : int
    {
        AccountName = 1,
        Country,
        Email,
        RACFID,
        RatePlan,
        RPNumber,
        Subject,
        Username
    };

    #endregion

    #region "Classes"

    public class Search
    {
        #region "Constants"

        public const string SearchUrl = @"~/App_WebServices/Search.asmx/";

        #endregion

        #region "Methods"

        public static string WebServiceUrl(Page currentPage, int service)
        {
            string result = null;

            switch (service)
            {
                case (int)ServiceName.AccountName:
                    result = @"SAccountName";
                    break;
                case (int)ServiceName.Country:
                    result = @"SCountry";
                    break;
                case (int)ServiceName.Email:
                    result = @"SEmail";
                    break;
                case (int)ServiceName.Username:
                    result = @"SUsername";
                    break;
                case (int)ServiceName.RACFID:
                    result = @"SRacfid";
                    break;
                case (int)ServiceName.RPNumber:
                    result = @"SRPNumber";
                    break;
                case (int)ServiceName.Subject:
                    result = @"STermsConditionsSubject";
                    break;
                case (int)ServiceName.RatePlan:
                    result = @"SRatePlan";
                    break;
            }

            return (currentPage.ResolveUrl(SearchUrl + result));

        }

        #endregion
    }

    #endregion

}
