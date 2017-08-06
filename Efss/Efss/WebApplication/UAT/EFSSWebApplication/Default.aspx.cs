using System;
using System.Web.UI.WebControls;
using APP.Base;
using APP.Session;
using APP.Search;
using RAD.Security;


namespace APP
{
    public partial class Default : PageBase
    {
        #region "Page Methods"

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            this.Master.MenuCommand += new CommandEventHandler(OnMenuItemCommand);

        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                chart.LoadControl();
            }

            //GUID
            string userId = Authentication.GetUserId();
            //RACFID
            string globalId = Authentication.GetGlobalId();
            //Firstname + Surname
            string username = Authentication.GetUsername();

            SessionHandler.UserRole = SecurityUsersAccess.SelectUserRole(globalId);

            

        }

        #endregion

        #region "Control Methods"

        protected void OnMenuItemCommand(object sender, CommandEventArgs e)
        {

            string option = string.Empty;
            string url = string.Empty;

            switch (e.CommandName)
            {

                //Logo Button Event
                case "ImageLogo":

                    option = e.CommandName;
                    break;

                //Information Button Event
                case "InformationLink":

                    option = e.CommandName;
                    break;

                //About Button Event
                case "AboutLink":

                    option = e.CommandName;
                    break;

                //FAQ Button Event
                case "FAQLink":

                    option = e.CommandName;
                    break;

                //Logout Button Event
                case "LogoutLink":

                    Authentication.SignOut();
                    break;

                //Application Link - CommandArgument = Navigate URL
                case "ApplicationLink":

                    option = e.CommandName;
                    url = e.CommandArgument.ToString();
                    break;

            }

            //this.LiteralResult.Text = @"Command Name: " + option + "<br/>Command Argument: " + url;

            SetUserControlVisible(url);

            this.UpdatePanelContent.Update();
        }

        private void SetUserControlVisible(string usercontrol)
        {

            SalesReport.Visible = false;
            SearchEngine.Visible = false;
            Invoices.Visible = false;
            ControlUCFleetDayReport.Visible = false;
            ControlUCFleetMonthReport.Visible = false;
            ExportExcel.Visible = false;
            TransactionsDay.Visible = false;
            TransactionsYear.Visible = false;
            Vendors.Visible = false;
            Companies.Visible = false;
            Manufacturers.Visible = false;
            Users.Visible = false;
            Settings.Visible = false;
            Email.Visible = false;
            FleetCash.Visible = false;
            Dashboard.Visible = false;
            FrenchFile.Visible = false;
            TaxSpain.Visible = false;
            AccessDenied.Visible = false;
            ListViewReports.Visible = false;
            chart.Visible = false;
            FTPForm.Visible = false;

            switch (usercontrol)
            {
                case "7":
                    if (SessionHandler.UserRole == "READ")
                    {
                        this.AccessDenied.Visible = true;
                    }
                    else
                    {
                        ControlUCFleetMonthReport.Visible = true;
                        ControlUCFleetMonthReport.LoadData(true);
                    }
                    
                    break;
                case "8":
                    if (SessionHandler.UserRole == "READ")
                    {
                        this.AccessDenied.Visible = true;
                    }
                    else
                    { 
                        ExportExcel.Visible = true;
                        ExportExcel.LoadData(true);
                    }
                    break;
                case "9":
                    if (SessionHandler.UserRole == "READ")
                    {
                        this.AccessDenied.Visible = true;
                    }
                    else
                    {
                        //Day-Month // ~/FleetDetails/FleetDetails.ascx
                        ControlUCFleetDayReport.Visible = true;
                        ControlUCFleetDayReport.LoadData(true);
                    }
                   
                    break;
                case "10":
                    if (SessionHandler.UserRole == "READ")
                    {
                        this.AccessDenied.Visible = true;
                    }
                    else
                    { 
                        //Day Adds-Delets
                        TransactionsDay.Visible = true;
                        TransactionsDay.LoadData(true);
                    }
                    break;
                case "11":
                    if (SessionHandler.UserRole == "READ")
                    {
                        this.AccessDenied.Visible = true;
                    }
                    else
                    {
                        //Year Adds-Deletes
                        TransactionsYear.Visible = true;
                        TransactionsYear.LoadData(true);
                    }
                    
                    break;
                case "12":

                    break;
                case "13":
                    if (SessionHandler.UserRole == "READ")
                    {
                        this.AccessDenied.Visible = true;
                    }
                    else
                    {
                        SalesReport.Visible = true;
                        SalesReport.LoadData(true);
                    }
                    
                    break;
                case "14":
                    if (SessionHandler.UserRole == "READ")
                    {
                        this.AccessDenied.Visible = true;
                    }
                    else
                    {
                        Invoices.Visible = true;
                        Invoices.LoadControlData();
                    }
                    
                    break;
                case "15":
                    SearchEngine.Visible = true;
                    SearchEngine.LoadData(true);
                    break;
                case "16":

                    break;
                case "17":
                    if (SessionHandler.UserRole == "READ")
                    {
                        this.AccessDenied.Visible = true;
                    }
                    else
                    {
                        this.Vendors.Visible = true;
                        this.Vendors.LoadData(true);
                    }
                    
                    break;
                case "18":

                    if (SessionHandler.UserRole == "ADMINISTRATOR")
                    {
                        this.Manufacturers.Visible = true;
                        this.Manufacturers.LoadData(true);
                    }
                    else 
                    {
                        this.AccessDenied.Visible = true;
                    }
                    break;
                case "19":
                    if (SessionHandler.UserRole == "ADMINISTRATOR")
                    {
                        this.Companies.Visible = true;
                        this.Companies.LoadData(true);
                    }
                    else
                    {
                        this.AccessDenied.Visible = true;
                    }
                    break;
                case "20":
                    //Users Form
                    if (SessionHandler.UserRole == "ADMINISTRATOR")
                    {
                        Users.Visible = true;
                        this.Users.LoadData(true);
                    }
                    else
                    {
                        this.AccessDenied.Visible = true;
                    }
                    
                    break;
                case "21":
                    if (SessionHandler.UserRole == "READ")
                    {
                        this.AccessDenied.Visible = true;
                    }
                    else
                    {
                        // Create the Files for LTSC (France) an "La caixa" and the Tax Office (Spain)
                        this.FrenchFile.Visible = true;
                    }
                    
                    break;
                case "22":
                    if (SessionHandler.UserRole == "READ")
                    {
                        this.AccessDenied.Visible = true;
                    }
                    else
                    {
                        // Report Fleet Cash Targets: Weekly
                        this.FleetCash.Visible = true;
                        this.FleetCash.LoadData(true);
                    }
                    break;
                case "23":
                    if (SessionHandler.UserRole == "READ")
                    {
                        this.AccessDenied.Visible = true;
                    }
                    else
                    {
                        this.Dashboard.Visible = true;
                        this.Dashboard.LoadData(true);
                    }
                    
                    break;
                case "24":
                    if (SessionHandler.UserRole == "READ")
                    {
                        this.AccessDenied.Visible = true;
                    }
                    else
                    {
                        this.ListViewReports.Visible = true;
                        this.ListViewReports.LoadData(true);
                    }
                    
                    break;
                case "26":
                    if (SessionHandler.UserRole == "READ")
                    {
                        this.AccessDenied.Visible = true;
                    }
                    else
                    {
                        this.Settings.Visible = true;
                        this.Settings.LoadData();
                    }
                    
                    break;
                case "27":
                    if (SessionHandler.UserRole == "READ")
                    {
                        this.AccessDenied.Visible = true;
                    }
                    else
                    {
                        this.Email.Visible = true;
                        this.Email.LoadData();
                    }
                    
                    break;
                case "28":
                    if (SessionHandler.UserRole == "READ")
                    {
                        this.AccessDenied.Visible = true;
                    }
                    else
                    {
                        this.TaxSpain.Visible = true;
                        this.TaxSpain.LoadData(true);
                    }
                    
                    break;
                case "29":
                    if (SessionHandler.UserRole == "READ")
                    {
                        this.AccessDenied.Visible = true;
                    }
                    else
                    {
                        this.chart.Visible = true;
                        this.chart.LoadControl();
                    }
                    
                    break;
                case "33":
                    if (SessionHandler.UserRole == "READ")
                    {
                        this.AccessDenied.Visible = true;
                    }
                    else
                    {
                        this.FTPForm.Visible = true;
                        this.FTPForm.LoadData();
                    }
                    
                    break;
            }

        }

        #endregion

    }
}