using System;
using System.Collections.Generic;
using System.Web.UI.WebControls;
using APP.Base;
using APP.CustomControls;
using APP.Events;
using APP.Session;
using RAD.Common;


namespace APP.App_UserControls.Invoices.ListViews.Countries
{
    public partial class ListViewSalesCountries : UserControlBase
    {
        public event EventHandler SearchBuyers;

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
                SessionHandler.SelectedFileDate = APP.Settings.ReportSettings.GetLastDateSalesLogFile();
                SessionHandler.SelectedInvoiceDate = "ALL";
                TextBoxFileDate.Text = SessionHandler.SelectedFileDate;
                FilterEvents e = new FilterEvents();
                SessionHandler.ApplicationFilterSalesFileOverView = e;
                this.LoadControlData(null, e, null, null, null);            
            }
        }

        public void LoadControlData(object sender, FilterEvents e, int? currentPage, int? pageSize, string sortExpression)
        {
            var results = new List<APP.Search.SalesFileOverView>();
            if (sortExpression == null)
            {
                this.ListViewFilesOverView.ColumnSortExpression = null;
                this.ListViewFilesOverView.ColumnIndexSorted = null;
            }

            results = APP.Search.SalesFileOverView.SelectSalesFileOverViewByFileDate(currentPage, pageSize, sortExpression, SessionHandler.SelectedFileDate, SessionHandler.SelectedInvoiceDate);

            if (results.Count >= 1)
            {
                //Set Pager details
                this.ListViewPager.SetPagerDetails(results[0].Count, ((currentPage == null || currentPage == 1) ? true : false));

                this.ListViewFilesOverView.DataSource = results;
                this.ListViewFilesOverView.DataBind();
                Templates.SetListViewDataTemplate(this.PlaceHolderData, this.PlaceHolderNoData, true);
            }
            else
            {
                this.ListViewPager.SetPagerDetails(0, true);
                this.ListViewFilesOverView.DataSource = results;
                this.ListViewFilesOverView.DataBind();
                Templates.SetListViewDataTemplate(this.PlaceHolderData, this.PlaceHolderNoData, true);
            }

            this.UpdatePanelListView.Update();
        }

        protected void ListViewFilesOverview_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            if (e.CommandName == "EditDetails")
            {
                ListViewDataItem dataItem = (ListViewDataItem)e.Item;

                string primaryDataKey = this.ListViewFilesOverView.DataKeys[dataItem.DisplayIndex].Values[0].ToString();
                SessionHandler.SelectedCountryId = primaryDataKey;

                if (SearchBuyers != null)
                {
                    SearchBuyers(this, EventArgs.Empty);
                }
            }
        }

        protected void ListViewFilesOverview_Sorting(object sender, ListViewSortEventArgs e)
        { 
            //Get a reference to the listview
            RAD.Controls.ListView listView = (RAD.Controls.ListView)sender;

            //Get the pager event args
            RAD.Events.PagerEventArgs args = this.ListViewPager.GetPagerEventArgs();

            //Get the filter event args
            FilterEvents filterEventArgs = SessionHandler.ApplicationFilterSalesFileOverView;

            //Load the data based on users selection
            this.LoadControlData(sender, filterEventArgs, args.CurrentPageNumber, args.PageSize, listView.ColumnSortExpression);

        }

        protected void OnPager_Command(object sender, RAD.Events.PagerEventArgs e)
        {
            this.LoadControlData(sender, SessionHandler.ApplicationFilterSalesFileOverView, (int?)e.CurrentPageNumber, (int?)e.PageSize, this.ListViewFilesOverView.ColumnSortExpression);
        }

        protected void OnCommand(object sender, CommandEventArgs e)
        {
            if (e.CommandName == "Filter")
            {
                if (TextBoxInvoiceDate.Text == String.Empty)
                {
                    SessionHandler.SelectedInvoiceDate = "ALL";
                }
                else
                {
                    SessionHandler.SelectedInvoiceDate = TextBoxInvoiceDate.Text;
                }

                if (TextBoxFileDate.Text == String.Empty)
                {
                    if (TextBoxInvoiceDate.Text == String.Empty)
                    { SessionHandler.SelectedFileDate = DateTime.Now.ToShortDateString(); }
                    else
                    { SessionHandler.SelectedFileDate = "ALL"; }
                }
                else
                { SessionHandler.SelectedFileDate = TextBoxFileDate.Text; }

                FilterEvents filterEventArgs = SessionHandler.ApplicationFilterSalesFileOverView;

                this.LoadControlData(null, filterEventArgs, null, null, null);  
               
            }
        }
    }
}