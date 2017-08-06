using System;
using System.Web.UI.WebControls;
using APP.BLL;
using RAD.Security;

namespace APP.App_MasterPages
{
    public partial class Application : MasterBase
    {
        protected override void OnInit(EventArgs e)
        {

            base.OnInit(e);

            //Add style Sheets
            base.AddStyleSheet("Core.css", "Core", false);
            base.AddStyleSheet("Controls.css", "Controls", false);
            base.AddStyleSheet("Application.css", "Application", false);
            base.AddStyleSheet("jquery-ui-1.8.11.css", "JQuery-CSS", false);

            //Add Javascript Files

            base.IncludeScripts("jquery-1.5.1.js", "Jquery", false);
            base.IncludeScripts("jquery-ui-1.8.11.custom.js", "Jquery-Custom", false);
            base.IncludeScripts("jquery.cookie.js", "Jquery-Cookie", false);
            base.IncludeScripts("jquery.fixedheadertable.js", "Jquery-FixedHeader", false);
            base.IncludeScripts("Application.js", "Application", false);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            string username = Authentication.GetUsername();
            this.RibbonControlPanel.UserLoggedIn = username;
            this.RibbonControlPanel.ControlTitle = @"European Fleet Sales System";
        }

        public event CommandEventHandler MenuCommand;

        protected void ControlPanel_ItemCommand(object sender, CommandEventArgs e)
        {
            if (MenuCommand != null)
            {
                MenuCommand(sender, e);
            }

        }
    }
}