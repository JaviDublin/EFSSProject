using System.Globalization;
using APP.Common;
using APP.Session;

namespace APP.Base
{
    public class PageBase : System.Web.UI.Page
    {

        protected override void InitializeCulture()
        {

            base.InitializeCulture();

            //Check session variable for selected language
            if (SessionHandler.ApplicationCulture != null)
            {
                //Apply the new language settings
                ApplyLanguage(SessionHandler.ApplicationCulture, false);
            }
        }

        protected void ApplyLanguage(CultureInfo culture, bool refreshPage)
        {
            //Set the new culture settings
            LanguageManager.ApplicationCurrentCulture = culture;
            SessionHandler.ApplicationCulture = LanguageManager.ApplicationCurrentCulture;

            //Refresh the page if requested
            if (refreshPage)
                Response.Redirect(Request.Url.AbsoluteUri, false);
        }

        protected override void OnPreInit(System.EventArgs e)
        {
            base.OnPreInit(e);
        }
    }
}