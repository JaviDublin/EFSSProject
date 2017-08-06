using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI.WebControls;
using APP.Base;
using APP.Events;
using APP.Search;
using APP.Session;
using RAD.Common;

namespace APP.App_UserControls.Settings.ListViews.Vendors
{
    public partial class SettingsListViewVendors : UserControlBase
    {
        public event EventHandler SearchBuyer;

        protected override void OnPreRender(EventArgs e)
        {
            if (this.Visible)
            {
                this.ListViewPager.PagerProgress.AssociatedUpdatePanelID = this.UpdatePanelListView.ID;
            }
            base.OnPreRender(e);
        }

        public void LoadData(bool isRefreshed)
        {
            if (isRefreshed)
            {
               
                LoadCountries();
                FilterEvents e = new FilterEvents();
                SessionHandler.ApplicationFilterBuyersOverView = e;
                SessionHandler.ApplicationFormBuyerCountryId = DropDownListCountries.SelectedValue.ToString();
                SessionHandler.ApplicationFormBuyerManufacturerCode = null;
                SessionHandler.ApplicationFormBuyerCode = null;
                SessionHandler.ApplicationFormBuyerName = null;

                this.LoadControlData(null, e, null, null, null);
                    
            }
        }

        private void LoadCountries()
        {
            DropDownListCountries.DataSource = null;
            DropDownListCountries.Items.Clear();
            var countries = new List<APP.Search.SearchCountries>();
            countries = APP.Search.SearchCountries.SelectCountries();
            DropDownListCountries.DataSource = countries;
            DropDownListCountries.DataTextField = "CountryName";
            DropDownListCountries.DataValueField = "CountryId";
            DropDownListCountries.DataBind();
            DropDownListCountries.SelectedIndex = 0;
            SessionHandler.ApplicationFormBuyerCountryId = DropDownListCountries.SelectedValue.ToString();
            LoadManufacturer(SessionHandler.ApplicationFormBuyerCountryId);
        }

        private void LoadManufacturer(string countryId)
        {
            DropDownListManufacturer.DataSource = null;
            DropDownListManufacturer.Items.Clear();
            DropDownListManufacturer.Items.Add("ALL");
            var manufacturers = new List<APP.Search.SearchManufacturers>();
            manufacturers = APP.Search.SearchManufacturers.SelectManufacturersCodeByCountryId(Convert.ToInt16(countryId));
            DropDownListManufacturer.DataSource = manufacturers;
            DropDownListManufacturer.DataTextField = "ManufacturerName";
            DropDownListManufacturer.DataValueField = "ManufacturerId";
            DropDownListManufacturer.DataBind();
            
        }

        public void LoadControlData(object sender, FilterEvents e, int? currentPage, int? pageSize, string sortExpression)
        {
            var results = new List<APP.Search.SearchBuyersOverView>();
            if (sortExpression == null)
            {
                this.ListViewBuyersOverview.ColumnSortExpression = null;
                this.ListViewBuyersOverview.ColumnIndexSorted = null;
            }

            results = APP.Search.SearchBuyersOverView.SelectBuyersOverview(currentPage, pageSize, sortExpression);

            if (results.Count >= 1)
            {
                this.ListViewPager.SetPagerDetails(results[0].Count, ((currentPage == null || currentPage == 1) ? true : false));

                this.ListViewBuyersOverview.DataSource = results;
                this.ListViewBuyersOverview.DataBind();

                //Make sure listview is visible and hide the emptydatatemplate
                Templates.SetListViewDataTemplate(this.PlaceHolderData, this.PlaceHolderNoData, true);
            }
            else
            {
                this.ListViewPager.SetPagerDetails(0, true);
                this.ListViewBuyersOverview.DataSource = results;
                this.ListViewBuyersOverview.DataBind();
                Templates.SetListViewDataTemplate(this.PlaceHolderData, this.PlaceHolderNoData, true);
            }

            this.UpdatePanelListView.Update();
        }

        protected void ListView_Sorting(object sender, ListViewSortEventArgs e)
        {
            RAD.Controls.ListView listView = (RAD.Controls.ListView)sender;
            RAD.Events.PagerEventArgs args = this.ListViewPager.GetPagerEventArgs();
            FilterEvents filterEventArgs = SessionHandler.ApplicationFilterBuyersOverView;
            this.LoadControlData(sender, filterEventArgs, args.CurrentPageNumber, args.PageSize, listView.ColumnSortExpression);
        }

        protected void ListView_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            if (e.CommandName == "EditDetails")
            {
                ListViewDataItem dataItem = (ListViewDataItem)e.Item;

                string primaryDataKey = this.ListViewBuyersOverview.DataKeys[dataItem.DisplayIndex].Values[0].ToString();
                SessionHandler.SelectedBuyerId = primaryDataKey;
                Session["BuyerId"] = Convert.ToInt32(SessionHandler.SelectedBuyerId);

                if (SearchBuyer != null)
                {
                    SearchBuyer(this, EventArgs.Empty);
                }
            }
        }

        protected void OnCommand(object sender, CommandEventArgs e)
        {
            if (e.CommandName == "Filter")
            {
                SessionHandler.ApplicationFormBuyerCountryId = DropDownListCountries.SelectedValue.ToString();
                if (DropDownListManufacturer.SelectedIndex == 0)
                { SessionHandler.ApplicationFormBuyerManufacturerCode = null; }
                else
                { SessionHandler.ApplicationFormBuyerManufacturerCode = DropDownListManufacturer.SelectedValue.ToString(); }

                if (TextBoxBuyerCode.Text == String.Empty)
                { SessionHandler.ApplicationFormBuyerCode = null; }
                else
                { SessionHandler.ApplicationFormBuyerCode = TextBoxBuyerCode.Text; }

                if (TextBoxBuyerName.Text == String.Empty)
                { SessionHandler.ApplicationFormBuyerName = null; }
                else
                { SessionHandler.ApplicationFormBuyerName = TextBoxBuyerName.Text; }
                
                this.LoadControlData(null, SessionHandler.ApplicationFilterBuyersOverView, null, null, null);
               
            }
        }
        
        protected void OnPager_Command(object sender, RAD.Events.PagerEventArgs e)
        {
            this.LoadControlData(sender, SessionHandler.ApplicationFilterBuyersOverView, (int?)e.CurrentPageNumber, (int?)e.PageSize, this.ListViewBuyersOverview.ColumnSortExpression);
        }

        protected void DropDownListCountries_SelectedIndexChanged(object sender, EventArgs e)
        {
            SessionHandler.ApplicationFormBuyerCountryId = DropDownListCountries.SelectedValue.ToString();
            LoadManufacturer(SessionHandler.ApplicationFormBuyerCountryId);
            this.UpdatePanelListView.Update();
        }

        protected void DropDownListManufacturer_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (DropDownListManufacturer.SelectedIndex == 0)
            { SessionHandler.ApplicationFormBuyerManufacturerCode = null; }
            else
            { SessionHandler.ApplicationFormBuyerManufacturerCode = DropDownListManufacturer.SelectedValue.ToString(); }
        }
    }
}