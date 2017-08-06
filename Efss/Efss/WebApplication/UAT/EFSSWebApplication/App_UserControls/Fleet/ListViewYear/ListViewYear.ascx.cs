using System;
using System.Collections.Generic;
using System.Web.UI.WebControls;
using APP.Base;
using APP.Events;
using APP.Session;
using RAD.Common;

namespace APP.App_UserControls.Fleet.ListViewYear
{
    public partial class ListViewYear : UserControlBase
    {
        public event EventHandler SearchByManufacturer;

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
                SessionHandler.ReportFilterFleetYearTransactions = e;
                this.LoadControlData(null, e, 1, 10, null);
            }
        }

        public void LoadControlData(object sender, FilterEvents e, int? currentPage, int? pageSize, string sortExpression)
        {
            var results = new List<APP.Reports.FleetYearReportOverView>();

            if (sortExpression == null)
            {
                this.ListViewFleetYearReportOverview.ColumnSortExpression = null;
                this.ListViewFleetYearReportOverview.ColumnIndexSorted = null;
            }

            results = APP.Reports.FleetYearReportOverView.SelectFleetYearReport(currentPage, pageSize, sortExpression, SessionHandler.FilterYearFleetYearTransReport, Convert.ToInt32(SessionHandler.FilterFileIdFleetYearTransReport));

            if (results.Count >= 1)
            {
                //Set Pager details
                this.ListViewPager.SetPagerDetails(results[0].Count, ((currentPage == null || currentPage == 1) ? true : false));

                this.ListViewFleetYearReportOverview.DataSource = results;
                this.ListViewFleetYearReportOverview.DataBind();

                //Make sure listview is visible and hide the emptydatatemplate
                Templates.SetListViewDataTemplate(this.PlaceHolderData, this.PlaceHolderNoData, true);
            }
            else
            {
                this.ListViewPager.SetPagerDetails(0, true);
                this.ListViewFleetYearReportOverview.DataSource = results;
                this.ListViewFleetYearReportOverview.DataBind();
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
            FilterEvents filterEventArgs = SessionHandler.ReportFilterFleetYearTransactions;

            //Load the data based on users selection
            this.LoadControlData(sender, filterEventArgs, args.CurrentPageNumber, args.PageSize, listView.ColumnSortExpression);
        }

        protected void ListView_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            if (e.CommandName == "EditDetails")
            {
                ListViewDataItem dataItem = (ListViewDataItem)e.Item;

                string primaryDataKey = this.ListViewFleetYearReportOverview.DataKeys[dataItem.DisplayIndex].Values[0].ToString();

                SessionHandler.SelectedFleetYearCountryId = primaryDataKey;
                
                if (SearchByManufacturer != null)
                {
                    SearchByManufacturer(this, EventArgs.Empty);
                }
            }
        }

        protected void OnPager_Command(object sender, RAD.Events.PagerEventArgs e)
        {
            this.LoadControlData(sender, SessionHandler.ReportFilterFleetYearTransactions, (int?)e.CurrentPageNumber, (int?)e.PageSize, this.ListViewFleetYearReportOverview.ColumnSortExpression);
        }
    }
}