using System;
using System.Collections.Generic;
using System.Web.UI.WebControls;
using APP.Base;
using APP.Events;
using APP.Session;
using RAD.Common;

namespace APP.App_UserControls.Fleet.FleetDetails.DayReport
{
    public partial class FleetDayReport : UserControlBase
    {
        
        protected override void OnPreRender(EventArgs e)
        {
            if (this.Visible)
            {
                this.ListViewPager.PagerProgress.AssociatedUpdatePanelID = this.UpdatePanelDayReport.ID;
            }
            base.OnPreRender(e);
        }

        public void LoadData(bool isRefreshed)
        {
            if (isRefreshed)
            {
                SessionHandler.FilterDateFleetDayReport = APP.Settings.ReportSettings.GetLastDateFleetDayReport();
                txtReportDayDate.Text = SessionHandler.FilterDateFleetDayReport;
                FilterEvents e = new FilterEvents();
                SessionHandler.ReportFilterFleetDay = e;
                this.LoadControlData(null, e, null, null, null, SessionHandler.FilterDateFleetDayReport);
            }
            else
            {
                this.LoadControlData(null, SessionHandler.ReportFilterFleetDay, null, null, null, SessionHandler.FilterDateFleetDayReport);
            }
        }

        public void LoadControlData(object sender, FilterEvents e, int? currentPage, int? pageSize, string sortExpression, string date)
        {
            var results = new List<APP.Reports.FleetDayReportOverView>();

            if (sortExpression == null)
            {
                this.ListViewFleetDayReportOverview.ColumnSortExpression = null;
                this.ListViewFleetDayReportOverview.ColumnIndexSorted = null;
            }

            results = APP.Reports.FleetDayReportOverView.SelectFleetDayReport(currentPage, pageSize, sortExpression, date);

            if (results.Count >= 1)
            {
                //Set Pager details
                this.ListViewPager.SetPagerDetails(results[0].Count, ((currentPage == null || currentPage == 1) ? true : false));

                this.ListViewFleetDayReportOverview.DataSource = results;
                this.ListViewFleetDayReportOverview.DataBind();
                Templates.SetListViewDataTemplate(this.PlaceHolderData, this.PlaceHolderNoData, true);
            }
            else
            {
                this.ListViewPager.SetPagerDetails(0, true);
                this.ListViewFleetDayReportOverview.DataSource = results;
                this.ListViewFleetDayReportOverview.DataBind();
                Templates.SetListViewDataTemplate(this.PlaceHolderData, this.PlaceHolderNoData, true);
                
            }

            this.UpdatePanelDayReport.Update();
        }

        protected void OnCommand(object sender, CommandEventArgs e)
        {
            if (e.CommandName == "Filter")
            {
                if (txtReportDayDate.Text != String.Empty)
                {
                    SessionHandler.FilterDateFleetDayReport = txtReportDayDate.Text;
                }

                FilterEvents filterEventArgs = SessionHandler.ReportFilterFleetDay;

                this.LoadControlData(null, filterEventArgs, null, null, null, SessionHandler.FilterDateFleetDayReport);  

                this.UpdatePanelDayReport.Update();
            }
            else if (e.CommandName == "Export")
            {
                CreateExcel();
                this.UpdatePanelDayReport.Update();
            }
        }

        protected void ListView_Sorting(object sender, ListViewSortEventArgs e)
        {
            //Get a reference to the listview
            RAD.Controls.ListView listView = (RAD.Controls.ListView)sender;

            //Get the pager event args
            RAD.Events.PagerEventArgs args = this.ListViewPager.GetPagerEventArgs();

            //Get the filter event args
            FilterEvents filterEventArgs = SessionHandler.ReportFilterFleetDay;

            //Load the data based on users selection
            this.LoadControlData(sender, filterEventArgs, args.CurrentPageNumber, args.PageSize, listView.ColumnSortExpression, SessionHandler.FilterDateFleetDayReport);

        }

        protected void OnPager_Command(object sender, RAD.Events.PagerEventArgs e)
        {
            this.LoadControlData(sender, SessionHandler.ReportFilterFleetDay, (int?)e.CurrentPageNumber, (int?)e.PageSize, this.ListViewFleetDayReportOverview.ColumnSortExpression, SessionHandler.FilterDateFleetDayReport);
        }

        private void CreateExcel()
        {
            var results = new List<APP.Reports.FleetDayReportOverView>();
            results = APP.Reports.FleetDayReportOverView.SelectFleetDayReport(1, 10, null, SessionHandler.FilterDateFleetDayReport);
            APP.CustomControls.ExcelGrid gv = new APP.CustomControls.ExcelGrid();

            if (results.Count >= 1)
            {
                gv.DataSource = results;
                gv.DataBind();
                Response.Clear();
                Response.Buffer = true;
                Response.ContentType = "application/vnd.ms-excel";
                Response.AddHeader("content-disposition", "attachment;filename=FleetdayReport.xls");
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
                Response.AddHeader("content-disposition", "attachment;filename=Invoices.xls");
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