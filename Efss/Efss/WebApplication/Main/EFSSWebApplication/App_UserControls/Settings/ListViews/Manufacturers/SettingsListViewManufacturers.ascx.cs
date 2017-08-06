using System;
using System.Collections.Generic;
using System.Web.UI.WebControls;
using APP.Base;
using APP.Events;
using APP.Session;
using RAD.Common;

namespace APP.App_UserControls.Settings.ListViews.Manufacturers
{
    public partial class SettingsListViewManufacturers : UserControlBase
    {
        public event EventHandler SearchModels;

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
                FilterEvents e = new FilterEvents();
                SessionHandler.ApplicationFilterManufacturersOverview = e;
                this.LoadControlData(null, e, null, null, null);
            }
        }

        public void LoadControlData(object sender, FilterEvents e, int? currentPage, int? pageSize, string sortExpression)
        {
            var results = new List<APP.Search.ManufacturersOverView>();

            //Check to see if sort expression has to be reset
            if (sortExpression == null)
            {
                this.ListViewManufacturersOverview.ColumnSortExpression = null;
                this.ListViewManufacturersOverview.ColumnIndexSorted = null;
            }

            results = APP.Search.ManufacturersOverView.SelectManufacturersOverview(currentPage, pageSize, sortExpression);

            if (results.Count >= 1)
            {
                //Set Pager details
                this.ListViewPager.SetPagerDetails(results[0].Count, ((currentPage == null || currentPage == 1) ? true : false));

                this.ListViewManufacturersOverview.DataSource = results;
                this.ListViewManufacturersOverview.DataBind();

                Templates.SetListViewDataTemplate(this.PlaceHolderData, this.PlaceHolderNoData, true);
            }
            else
            {
                Templates.SetListViewDataTemplate(this.PlaceHolderData, this.PlaceHolderNoData, true);
            }

            this.UpdatePanelListView.Update();
        }

        protected void ListView_Sorting(object sender, ListViewSortEventArgs e)
        {
            //Get a reference to the listview
            RAD.Controls.ListView listView = (RAD.Controls.ListView)sender;

            //Get the pager event args
            RAD.Events.PagerEventArgs args = this.ListViewPager.GetPagerEventArgs();

            //Get the filter event args
            FilterEvents filterEventArgs = SessionHandler.ApplicationFilterManufacturersOverview;

            //Load the data based on users selection
            this.LoadControlData(sender, filterEventArgs, args.CurrentPageNumber, args.PageSize, listView.ColumnSortExpression);

        }
        
        protected void ListView_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            if (e.CommandName == "EditDetails")
            {
                ListViewDataItem dataItem = (ListViewDataItem)e.Item;

                string primaryDataKey = this.ListViewManufacturersOverview.DataKeys[dataItem.DisplayIndex].Values[0].ToString();
                SessionHandler.SelectedManufacturerid = primaryDataKey;
                if (SearchModels != null)
                {
                    SearchModels(this, EventArgs.Empty);
                }
            }
        }

        protected void OnPager_Command(object sender, RAD.Events.PagerEventArgs e)
        {
            this.LoadControlData(sender, SessionHandler.ApplicationFilterManufacturersOverview, (int?)e.CurrentPageNumber, (int?)e.PageSize, this.ListViewManufacturersOverview.ColumnSortExpression);
        }

        

    }
}