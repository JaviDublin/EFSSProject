using System;
using System.Web.Security;
using RAD.Common;
using RAD.Events;
using APP.Search;

namespace APP.Login
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.PanelLogin.DefaultLinkButton = this.Login.LoginButton;

            if (User.Identity.IsAuthenticated)
            {
                Response.Redirect("~");
            }
        }


        #region Control Methods

        protected void OnLoggedIn_Command(object sender, LoginEventArgs e)
        {

            if (e.ResultCode == ResultCode.Success)
            {
                if (SecurityUsersAccess.UserExist(e.GlobalId))
                {
                    Response.Redirect(FormsAuthentication.GetRedirectUrl(e.Username, e.IsPersistant));
                }
                else
                {
                    e.ResultCode = ResultCode.Failed; 
                }
            }
        }

        #endregion
    }
}