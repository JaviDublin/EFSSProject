using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.IO;
using System.Web.UI.WebControls;
using APP.Base;
using APP.Data;
using APP.Events;
using APP.Session;
using RAD.Common;
using RAD.Data;
using RAD.Diagnostics;

namespace APP.App_UserControls.Reports.FormTaxSpain
{
    public partial class FormTaxSpain : UserControlBase
    {
        protected override void OnPreRender(EventArgs e)
        {
            if (this.Visible)
            {
                this.ListViewPager.PagerProgress.AssociatedUpdatePanelID = this.UpdatePanelForm.ID;
            }
            base.OnPreRender(e);
        }
        
        public void LoadData(bool isRefreshed)
        {
            if (isRefreshed)
            {
                FilterEvents e = new FilterEvents();
                SessionHandler.ApplicationTaxFileFilterPrice = e;
                this.LoadControlData(null, e, null, null, null);   
            }
        }
        
        public void LoadControlData(object sender, FilterEvents e, int? currentPage, int? pageSize, string sortExpression)
        {
            var results = new List<APP.Reports.TaxPriceOverView>();
            if (sortExpression == null)
            {
                this.ListViewFleetSP.ColumnSortExpression = null;
                this.ListViewFleetSP.ColumnIndexSorted = null;
            }

            results = APP.Reports.TaxPriceOverView.SelectTaxPriceOverView(currentPage, pageSize, sortExpression);

            if (results.Count >= 1)
            {
                //Set Pager details
                this.ListViewPager.SetPagerDetails(results[0].Count, ((currentPage == null || currentPage == 1) ? true : false));

                this.ListViewFleetSP.DataSource = results;
                this.ListViewFleetSP.DataBind();

                Templates.SetListViewDataTemplate(this.PlaceHolderData, this.PlaceHolderNoData, true);
            }
            else
            {
                this.ListViewPager.SetPagerDetails(0, true);
                this.ListViewFleetSP.DataSource = results;
                this.ListViewFleetSP.DataBind();
                Templates.SetListViewDataTemplate(this.PlaceHolderData, this.PlaceHolderNoData, true);
            }

            this.UpdatePanelForm.Update();
        }

        protected void ListView_Sorting(object sender, ListViewSortEventArgs e)
        {
            //Get a reference to the listview
            RAD.Controls.ListView listView = (RAD.Controls.ListView)sender;

            //Get the pager event args
            RAD.Events.PagerEventArgs args = this.ListViewPager.GetPagerEventArgs();

            //Get the filter event args
            FilterEvents filterEventArgs = SessionHandler.ApplicationTaxFileFilterPrice;

            //Load the data based on users selection
            this.LoadControlData(sender, filterEventArgs, args.CurrentPageNumber, args.PageSize, listView.ColumnSortExpression);
        }

        protected void ListView_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            if (e.CommandName == "EditDetails")
            {
                ListViewDataItem dataItem = (ListViewDataItem)e.Item;

                string primaryDataKey = this.ListViewFleetSP.DataKeys[dataItem.DisplayIndex].Values[0].ToString();
            }
        }

        protected void OnPager_Command(object sender, RAD.Events.PagerEventArgs e)
        {
            this.LoadControlData(sender, SessionHandler.ApplicationTaxFileFilterPrice, (int?)e.CurrentPageNumber, (int?)e.PageSize, this.ListViewFleetSP.ColumnSortExpression);
        }

        protected void OnCommand(object sender, CommandEventArgs e)
        {
            if (e.CommandName == "Filter")
            {
                if (TextBoxPlate.Text == String.Empty)
                {
                    SessionHandler.SPFleetSPPlateFilter = null;
                }
                else
                {
                    SessionHandler.SPFleetSPPlateFilter = TextBoxPlate.Text;
                }

                FilterEvents filterEventArgs = SessionHandler.ApplicationTaxFileFilterPrice;
                this.LoadControlData(null, filterEventArgs, null, null, null);
            }
        }


    }
}