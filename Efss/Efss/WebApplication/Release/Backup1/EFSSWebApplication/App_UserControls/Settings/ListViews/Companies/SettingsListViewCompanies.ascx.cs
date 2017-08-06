using System;
using System.Collections.Generic;
using System.Web.UI.WebControls;
using APP.Base;
using APP.Events;
using APP.Session;
using RAD.Common;

namespace APP.App_UserControls.Settings.ListViews.Companies
{
    public partial class SettingsListViewCompanies : UserControlBase
    {
        public event EventHandler SearchCompanies;

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
                SessionHandler.ApplicationFilterSearchCompaniesOverview = e;
                this.LoadControlData(null, e, null, 15, null);
            }


        }

        public void LoadControlData(object sender, FilterEvents e, int? currentPage, int? pageSize, string sortExpression)
        {

            var results = new List<APP.Search.CompaniesOverView>();
            if (sortExpression == null)
            {
                this.ListViewCompaniesOverview.ColumnSortExpression = null;
                this.ListViewCompaniesOverview.ColumnIndexSorted = null;
            }

            results = APP.Search.CompaniesOverView.SelectCompaniesOverview(currentPage, pageSize, sortExpression);

            if (results.Count >= 1)
            {
                //Set Pager details
                this.ListViewPager.SetPagerDetails(results[0].Count, ((currentPage == null || currentPage == 1) ? true : false));

                this.ListViewCompaniesOverview.DataSource = results;
                this.ListViewCompaniesOverview.DataBind();

                Templates.SetListViewDataTemplate(this.PlaceHolderData, this.PlaceHolderNoData, true);
            }
            else
            {
                Templates.SetListViewDataTemplate(this.PlaceHolderData, this.PlaceHolderNoData, true);
            }

            this.UpdatePanelListView.Update();
        }


        /// <summary>
        /// Occurs when sorting the listview
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void ListView_Sorting(object sender, ListViewSortEventArgs e)
        {
            //Get a reference to the listview
            RAD.Controls.ListView listView = (RAD.Controls.ListView)sender;


            //Get the pager event args
            RAD.Events.PagerEventArgs args = this.ListViewPager.GetPagerEventArgs();

            //Get the filter event args
            FilterEvents filterEventArgs = SessionHandler.ApplicationFilterSearchCompaniesOverview;

            //Load the data based on users selection
            this.LoadControlData(sender, filterEventArgs, args.CurrentPageNumber, args.PageSize, listView.ColumnSortExpression);

        }


        /// <summary>
        /// Fired on item command on listview
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void ListView_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            if (e.CommandName == "EditDetails")
            {
                ListViewDataItem dataItem = (ListViewDataItem)e.Item;

                string primaryDataKey = this.ListViewCompaniesOverview.DataKeys[dataItem.DisplayIndex].Values[0].ToString();
                SessionHandler.SelectedCompanyId = primaryDataKey;
                if (SearchCompanies != null)
                {
                    SearchCompanies(this, EventArgs.Empty);
                }
            }
        }

        /// <summary>
        /// Fired o pager command
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void OnPager_Command(object sender, RAD.Events.PagerEventArgs e)
        {
            this.LoadControlData(sender, SessionHandler.ApplicationFilterSearchCompaniesOverview, (int?)e.CurrentPageNumber, (int?)e.PageSize, this.ListViewCompaniesOverview.ColumnSortExpression);
        }

    }
}