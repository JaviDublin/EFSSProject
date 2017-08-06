using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using APP.Session;

namespace APP.App_UserControls.Reports
{
    public partial class ListViewReports : System.Web.UI.UserControl
    {
        string countryName;
       

        public void LoadData(bool isRefreshed)
        {
            if (isRefreshed)
            {
                DropDownListCountries.DataSource = null;
                DropDownListCountries.Items.Clear();         
                DropDownListCountries.DataSource = APP.Search.CompanyGroupNames.SelectCompanyGroupName();
                DropDownListCountries.DataTextField = "GroupName";
                DropDownListCountries.DataValueField = "GroupId";
                DropDownListCountries.DataBind();
                DropDownListCountries.SelectedIndex = 0;

                SessionHandler.DashBoardCountryId = DropDownListCountries.SelectedValue;

                LoadCompanies();
                LoadManufacturers();
                LoadVendors();
                this.UpdatePanelDash.Update();
            }
        }

        public void LoadCompanies()
        {
            DropDownListCompanies.DataSource = null;
            DropDownListCompanies.Items.Clear();
            countryName = DropDownListCountries.SelectedItem.Text;
            var companies = new List<APP.Search.SearchCompanies>();
            companies = APP.Search.SearchCompanies.SelectCompaniesByCountry(countryName);
            if (companies.Count > 1)
            {
                DropDownListCompanies.Items.Add("ALL");
            }
            DropDownListCompanies.DataSource = companies;
            DropDownListCompanies.DataTextField = "CompanyName";
            DropDownListCompanies.DataValueField = "CompanyId";
            DropDownListCompanies.DataBind();
        }

        public void LoadManufacturers()
        {
            DropDownListManufacturer.DataSource = null;
            DropDownListManufacturer.Items.Clear();
            DropDownListManufacturer.Items.Add("ALL");
            var manufacturer = new List<APP.Search.SearchManufacturers>();
            manufacturer = APP.Search.SearchManufacturers.SelectManufacturersDashBoardByCompanyId();
            DropDownListManufacturer.DataSource = manufacturer;
            DropDownListManufacturer.DataTextField = "ManufacturerName";
            DropDownListManufacturer.DataValueField = "ManufacturerId";
            DropDownListManufacturer.DataBind();
           
        }

        public void LoadVendors()
        {
            DropDownListVendors.DataSource = null;
            DropDownListVendors.Items.Clear();
            DropDownListVendors.Items.Add("ALL");
            var buyers = new List<APP.Search.SearchBuyersName>();
            buyers = APP.Search.SearchBuyersName.SelectBuyersNameDashboard();
            DropDownListVendors.DataSource = buyers;
            DropDownListVendors.DataTextField = "BuyerName";
            DropDownListVendors.DataValueField = "BuyerId";
            DropDownListVendors.DataBind();
            
                
        }

        protected void OnCommand(object sender, CommandEventArgs e)
        {
            if (e.CommandName == "Run")
            {
                GetFormValues();
                CreateExcelFile();
            }
        }

        private void GetFormValues()
        {
            SessionHandler.DashBoardCountryId = DropDownListCountries.SelectedValue;

            if (DropDownListCompanies.SelectedValue == "ALL")
            {
                SessionHandler.DashBoardCompanyId = null;
            }
            else
            {
                SessionHandler.DashBoardCompanyId = DropDownListCompanies.SelectedValue;
            }

            if (DropDownListManufacturer.SelectedValue == "ALL")
            {
                SessionHandler.DashBoardManufacturer = null;
            }
            else
            {
                SessionHandler.DashBoardManufacturer = DropDownListManufacturer.SelectedValue;
            }

            if (DropDownListVendors.SelectedValue == "ALL")
            {
                SessionHandler.DashBoardBuyer = null;
            }
            else
            {
                SessionHandler.DashBoardBuyer = DropDownListVendors.SelectedItem.Text;
            }

            if (CheckBoxBuyBack.Checked)
            {
                SessionHandler.DashBoardBuyBack = "BUYBACK";
            }
            else 
            {
                SessionHandler.DashBoardBuyBack = null;
            }

            if (CheckBoxNonReturn.Checked)
            {
                SessionHandler.DashBoardNRBonus = "NON RETURN BONUS";
            }
            else
            {
                SessionHandler.DashBoardNRBonus = null;
            }

            if (CheckBoxVolumeBonus.Checked)
            {
                SessionHandler.DashBoardVBouns = "VOLUME BONUS";
            }
            else
            {
                SessionHandler.DashBoardVBouns = null;
            }

            if (CheckBoxOpen.Checked)
            {
                SessionHandler.DashBoardStatusOpen = "O";
            }
            else
            {
                SessionHandler.DashBoardStatusOpen = null;
            }

            if (CheckBoxMatched.Checked)
            {
                SessionHandler.DashBoardStatusMatched = "M";
            }
            else
            {
                SessionHandler.DashBoardStatusMatched = null;
            }

            if (CheckBoxUnapplied.Checked)
            {
                SessionHandler.DashBoardStatusUnapplied = "U";
            }
            else
            {
                SessionHandler.DashBoardStatusUnapplied = null;
            }
        }

        protected void DropDownListManufacturer_SelectedIndexChanged(object sender, EventArgs e)
        {
            SessionHandler.DashBoardCountryId = DropDownListCountries.SelectedValue;
            if (DropDownListCompanies.SelectedValue == "ALL")
            {
                SessionHandler.DashBoardCompanyId = null;
            }
            else
            {
                SessionHandler.DashBoardCompanyId = DropDownListCompanies.SelectedValue;
            }

            if (DropDownListManufacturer.SelectedValue == "ALL")
            {
                SessionHandler.DashBoardManufacturer = null;
            }
            else
            {
                SessionHandler.DashBoardManufacturer = DropDownListManufacturer.SelectedValue;
            }

            LoadVendors();
            this.UpdatePanelDash.Update();
        }

        protected void DropDownListCompanies_SelectedIndexChanged(object sender, EventArgs e)
        {
            SessionHandler.DashBoardCountryId = DropDownListCountries.SelectedValue;
            if (DropDownListCompanies.SelectedValue == "ALL")
            {
                SessionHandler.DashBoardCompanyId = null;
            }
            else
            {
                SessionHandler.DashBoardCompanyId = DropDownListCompanies.SelectedValue;
            }
            LoadManufacturers();
            if (DropDownListManufacturer.SelectedValue == "ALL")
            {
                SessionHandler.DashBoardManufacturer = null;
            }
            else
            {
                SessionHandler.DashBoardManufacturer = DropDownListManufacturer.SelectedValue;
            }
            LoadVendors();
            this.UpdatePanelDash.Update();
        }

        protected void DropDownListCountries_SelectedIndexChanged(object sender, EventArgs e)
        {
            SessionHandler.DashBoardCountryId = DropDownListCountries.SelectedValue;
            LoadCompanies();
            if (DropDownListCompanies.SelectedValue == "ALL")
            {
                SessionHandler.DashBoardCompanyId = null;
            }
            else
            {
                SessionHandler.DashBoardCompanyId = DropDownListCompanies.SelectedValue;
            }
            LoadManufacturers();
            if (DropDownListManufacturer.SelectedValue == "ALL")
            {
                SessionHandler.DashBoardManufacturer = null;
            }
            else
            {
                SessionHandler.DashBoardManufacturer = DropDownListManufacturer.SelectedValue;
            }
            LoadVendors();
            this.UpdatePanelDash.Update();
        }

        private void CreateExcelFile()
        {
            GridView gv = new GridView();
            var results = new List<APP.Search.DashboardToExcel>();

            results = APP.Search.DashboardToExcel.SelectDashBoardExcel();

            if (results.Count >= 1)
            {
                gv.DataSource = results;
                gv.DataBind();
                Response.Clear();
                Response.Buffer = true;
                Response.ContentType = "application/vnd.ms-excel";
                Response.AddHeader("content-disposition", "attachment;filename=DashboardListing.xls");
                Response.Charset = "";
                this.EnableViewState = false;
                System.IO.StringWriter sw = new System.IO.StringWriter();
                System.Web.UI.HtmlTextWriter htw = new System.Web.UI.HtmlTextWriter(sw);
                gv.RenderControl(htw);
                Response.Write(sw.ToString());
                Response.End();
            }
            else
            {
                APP.Data.DBNoData nd = new APP.Data.DBNoData();
                gv.DataSource = nd.NoDataAvailable();
                gv.DataBind();
                Response.Clear();
                Response.Buffer = true;
                Response.ContentType = "application/vnd.ms-excel";
                Response.AddHeader("content-disposition", "attachment;filename=Dashboard.xls");
                Response.Charset = "";
                this.EnableViewState = false;
                System.IO.StringWriter sw = new System.IO.StringWriter();
                System.Web.UI.HtmlTextWriter htw = new System.Web.UI.HtmlTextWriter(sw);
                gv.RenderControl(htw);
                Response.Write(sw.ToString());
                Response.End();

            }

        }
    }
}