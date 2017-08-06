using System;
using System.Collections.Generic;
using System.Web.UI.WebControls;
using APP.Base;
using APP.Events;
using APP.Session;
using RAD.Common;

namespace APP.App_UserControls.Settings.ListViews.Users
{
    public partial class SettingsListViewUsers : UserControlBase
    {
        public event EventHandler SearchUsers;
        

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
                SessionHandler.ApplicationFilterSecurityUsersOverview = e;
                SessionHandler.UserRacfIdSearch = "ALL";
                this.LoadControlData(null, e, null, null, null);
            }
        }

        public void LoadControlData(object sender, FilterEvents e, int? currentPage, int? pageSize, string sortExpression)
        {
            var results = new List<APP.Search.UsersOverView>();
            if (sortExpression == null)
            {
                this.ListViewUsersOverview.ColumnSortExpression = null;
                this.ListViewUsersOverview.ColumnIndexSorted = null;
            }

            results = APP.Search.UsersOverView.SelectUsersOverview(currentPage, pageSize, sortExpression, SessionHandler.UserRacfIdSearch);

            if (results.Count >= 1)
            {
                //Set Pager details
                this.ListViewPager.SetPagerDetails(results[0].Count, ((currentPage == null || currentPage == 1) ? true : false));

                this.ListViewUsersOverview.DataSource = results;
                this.ListViewUsersOverview.DataBind();

                //Make sure listview is visible and hide the emptydatatemplate
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
            FilterEvents filterEventArgs = SessionHandler.ApplicationFilterSecurityUsersOverview;

            //Load the data based on users selection
            this.LoadControlData(sender, filterEventArgs, args.CurrentPageNumber, args.PageSize, listView.ColumnSortExpression);
        }

        protected void ListView_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            if (e.CommandName == "EditDetails")
            {
                ListViewDataItem dataItem = (ListViewDataItem)e.Item;
                string primaryDataKey = this.ListViewUsersOverview.DataKeys[dataItem.DisplayIndex].Values[0].ToString();
                SessionHandler.SelectedUserId = primaryDataKey;
                SessionHandler.UserFormAction = "Update";
                
                if (SearchUsers != null)
                {
                    SearchUsers(this, EventArgs.Empty);
                }
            }
        }   

        protected void OnPager_Command(object sender, RAD.Events.PagerEventArgs e)
        {
            this.LoadControlData(sender, SessionHandler.ApplicationFilterSecurityUsersOverview, (int?)e.CurrentPageNumber, (int?)e.PageSize, this.ListViewUsersOverview.ColumnSortExpression);
        }

        protected void OnCommand(object sender, CommandEventArgs e)
        {
            if (e.CommandName == "Filter")
            {
                if (TextBoxRacfId.Text == String.Empty)
                { SessionHandler.UserRacfIdSearch = "ALL"; }
                else
                { SessionHandler.UserRacfIdSearch = TextBoxRacfId.Text; }

                this.LoadControlData(null, SessionHandler.ApplicationFilterSecurityUsersOverview, null, null, null);
            }
            //else if (e.CommandName == "Insert")
            //{
            //    SessionHandler.UserFormAction = "Insert";
            //    if (AddUsers != null)
            //    {
            //        AddUsers(this, EventArgs.Empty);
            //    }
            //}   
        }
    }
}