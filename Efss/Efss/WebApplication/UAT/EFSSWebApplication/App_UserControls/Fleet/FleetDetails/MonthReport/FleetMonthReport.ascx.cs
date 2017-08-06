using System;
using System.Collections.Generic;
using System.Globalization;
using System.Web.UI;
using System.Web.UI.WebControls;
using APP.Base;
using APP.CustomControls;
using APP.Events;
using APP.Session;
using RAD.Common;

namespace APP.App_UserControls.Fleet.FleetDetails.MonthReport
{
    public partial class FleetMonthReport : UserControlBase
    {
       
        protected override void OnPreRender(EventArgs e)
        {
            if (this.Visible)
            {
                this.ListViewPager.PagerProgress.AssociatedUpdatePanelID = this.UpdatePanelMonthReport.ID;
            }
            base.OnPreRender(e);
        }


        public void LoadData(bool isRefreshed)
        {
            if (isRefreshed)
            {
                DateTime myDateTime = DateTime.Now;
                //string year = myDateTime.Year.ToString();
                //string month = myDateTime.Month.ToString();

                string year = APP.Settings.ReportSettings.GetLastYearFleetMonthReport();
                string month = APP.Settings.ReportSettings.GetLastMonthFleetMonthReport();
                FilterEvents e = new FilterEvents();
                SessionHandler.ReportFilterFleetMonth = e;
                SessionHandler.FilterMonthFleetMonthReport = month;
                SessionHandler.FilterYearFleetMonthReport = year;
                this.LoadControlData(null, e, null, null, null, month, year);
         
                DropDownListMonths.SelectedValue = month;
            }
            else
            {
                FilterEvents e = new FilterEvents();
                SessionHandler.ReportFilterFleetMonth = e;
                this.LoadControlData(null, e, null, null, null, SessionHandler.FilterMonthFleetMonthReport, SessionHandler.FilterYearFleetMonthReport);
            }
        }

        public void LoadControlData(object sender, FilterEvents e, int? currentPage, int? pageSize, string sortExpression, string month, string year)
        {
            var results = new List<APP.Reports.FleetMonthReportOverView>();

            if (sortExpression == null)
            {
                this.ListViewFleetMonthReportOverview.ColumnSortExpression = null;
                this.ListViewFleetMonthReportOverview.ColumnIndexSorted = null;
            }

            results = APP.Reports.FleetMonthReportOverView.SelectFleetMonthReport(currentPage, pageSize, sortExpression, month, year);

            if (results.Count >= 1)
            {
                //Set Pager details
                this.ListViewPager.SetPagerDetails(results[0].Count, ((currentPage == null || currentPage == 1) ? true : false));

                this.ListViewFleetMonthReportOverview.DataSource = results;
                this.ListViewFleetMonthReportOverview.DataBind();
                Templates.SetListViewDataTemplate(this.PlaceHolderData, this.PlaceHolderNoData, true);
            }
            else
            {
                this.ListViewPager.SetPagerDetails(0, true);
                this.ListViewFleetMonthReportOverview.DataSource = results;
                this.ListViewFleetMonthReportOverview.DataBind();
                Templates.SetListViewDataTemplate(this.PlaceHolderData, this.PlaceHolderNoData, true);
            }

            this.UpdatePanelMonthReport.Update();

        }

        public static string GetMonthName(DateTime today)
        {
            var formatInfoinfo = new DateTimeFormatInfo();
            string[] monthName = formatInfoinfo.MonthNames;
            return monthName[today.Month - 1];
        }

        protected void OnCommand(object sender, CommandEventArgs e)
        {
            if (e.CommandName == "Filter")
            {
                SessionHandler.FilterMonthFleetMonthReport = DropDownListMonths.SelectedValue.ToString();
                SessionHandler.FilterYearFleetMonthReport = DropDownListYears.SelectedValue.ToString();

                FilterEvents filterEventArgs = SessionHandler.ReportFilterFleetMonth;

                this.LoadControlData(null, filterEventArgs, null, null, null, SessionHandler.FilterMonthFleetMonthReport, SessionHandler.FilterYearFleetMonthReport);  

                this.UpdatePanelMonthReport.Update();
            }
            else if (e.CommandName == "Export")
            {
                CreateExcel();
                this.UpdatePanelMonthReport.Update();
            }
        }

        protected void ListView_Sorting(object sender, ListViewSortEventArgs e)
        {

            //Get a reference to the listview
            RAD.Controls.ListView listView = (RAD.Controls.ListView)sender;

            //Get the pager event args
            RAD.Events.PagerEventArgs args = this.ListViewPager.GetPagerEventArgs();

            //Get the filter event args
            FilterEvents filterEventArgs = SessionHandler.ReportFilterFleetMonth;

            //Load the data based on users selection
            this.LoadControlData(sender, filterEventArgs, args.CurrentPageNumber, args.PageSize, listView.ColumnSortExpression, SessionHandler.FilterMonthFleetMonthReport, SessionHandler.FilterYearFleetMonthReport);
        }

        protected void OnPager_Command(object sender, RAD.Events.PagerEventArgs e)
        {
            this.LoadControlData(sender, SessionHandler.ReportFilterFleetMonth, (int?)e.CurrentPageNumber, (int?)e.PageSize, this.ListViewFleetMonthReportOverview.ColumnSortExpression, SessionHandler.FilterMonthFleetMonthReport, SessionHandler.FilterYearFleetMonthReport);
        }

        private void CreateExcel()
        {
            var results = new List<APP.Reports.FleetMonthReportOverView>();
            results = APP.Reports.FleetMonthReportOverView.SelectFleetMonthReport(1, 10, null, SessionHandler.FilterMonthFleetMonthReport, SessionHandler.FilterYearFleetMonthReport);
            APP.CustomControls.ExcelGrid gv = new APP.CustomControls.ExcelGrid();

            if (results.Count >= 1)
            {
                gv.DataSource = results;   
                gv.DataBind();
                gv.HeaderRow.Cells[6].Text = "E-Status";
                Response.Clear();
                Response.Buffer = true;
                Response.ContentType = "application/vnd.ms-excel";
                Response.AddHeader("content-disposition", "attachment;filename=FleetMonthReport.xls");
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