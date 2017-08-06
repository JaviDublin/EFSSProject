using System;
using System.Collections.Generic;
using System.Web.UI.WebControls;
using APP.Base;
using APP.Events;
using APP.Session;
using RAD.Common;
using APP.Search;

namespace APP.App_UserControls.Fleet
{
    public partial class TransactionsDay : UserControlBase
    {
        public void LoadData(bool isRefreshed)
        {
            if (isRefreshed)
            {
                this.SetNavigtionMenu();
                string year = APP.Settings.ReportSettings.GetLastYearFleetDayAddReport();
                string month = APP.Settings.ReportSettings.GetLastMonthFleetDayAddReport();
                SessionHandler.FilterMonthFleetDayTransReport = month;
                SessionHandler.FilterYearFleetDayTransReport = year;
                SessionHandler.FilterFileIdFleetDayTransReport = "3";
                this.ListViewDayOverView.LoadData(true);
                DropDownListMonths.SelectedValue = month;
                this.UpdatePanelDayTransactions.Update();
            }
        }

        protected void SetNavigtionMenu()
        {
            var results = this.NavigationPanelDayTransactions.LoadControlData((int)MenuType.MenuE);
            int index = NavigationMenu.GetMinimumIndex(results);
            this.MultiViewDayTransactions.ActiveViewIndex = index;
            this.NavigationPanelDayTransactions.SetMenuStyle(this.MultiViewDayTransactions.ActiveViewIndex);
        }

        protected void NavigationMenuClick(object sender, Navigation e)
        {
            int index = e.Index;
            this.MultiViewDayTransactions.ActiveViewIndex = index;
            this.UpdatePanelDayTransactions.Update();
        }

        protected void OnCommand(object sender, CommandEventArgs e)
        {
            if (e.CommandName == "Filter")
            {
                SessionHandler.FilterMonthFleetDayTransReport = DropDownListMonths.SelectedValue.ToString();
                SessionHandler.FilterYearFleetDayTransReport = DropDownListYears.SelectedValue.ToString();
                SessionHandler.FilterFileIdFleetDayTransReport = DropDownListFile.SelectedValue.ToString();
                this.ListViewDayOverView.LoadData(true);
                this.UpdatePanelDayTransactions.Update();
            }
            else if (e.CommandName == "Export")
            {
                CreateExcel();
            }
            else if (e.CommandName == "ExportManufacturer")
            {
                CreateExcelManufacturer();
            }
        }

        protected void SearchByManufacturer(object sender, EventArgs e)
        {
          
            this.ListViewDayOverViewMFG.LoadData(true);
            this.MultiViewDayTransactions.ActiveViewIndex = 1;
            this.NavigationPanelDayTransactions.SetMenuStyle(this.MultiViewDayTransactions.ActiveViewIndex);
            this.UpdatePanelDayTransactions.Update();
        }

        private void CreateExcel()
        {
            var results = new List<APP.Reports.FleetDayTransactionsOverView>();
            results = APP.Reports.FleetDayTransactionsOverView.SelectFleetDayTransactionsReport(1, 10, null, SessionHandler.FilterMonthFleetDayTransReport, SessionHandler.FilterYearFleetDayTransReport, Convert.ToInt32(SessionHandler.FilterFileIdFleetDayTransReport));
            APP.CustomControls.ExcelGrid gv = new APP.CustomControls.ExcelGrid();

            if (results.Count >= 1)
            {
                gv.DataSource = results;
                gv.DataBind();

                Response.Clear();
                Response.Buffer = true;
                Response.ContentType = "application/vnd.ms-excel";
                Response.AddHeader("content-disposition", "attachment;filename=FleetDayAddsDels.xls");
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
                CreateEmptyExcel();
            }
        }

        private void CreateExcelManufacturer()
        {
            
            var results = new List<APP.Reports.FleetDayTransactionsOverViewMFG>();
            results = APP.Reports.FleetDayTransactionsOverViewMFG.SelectFleetDayTransactionsReportMFG(1, 100, null, SessionHandler.FilterMonthFleetDayTransReport, SessionHandler.FilterYearFleetDayTransReport, Convert.ToInt32(SessionHandler.FilterFileIdFleetDayTransReport), Convert.ToInt32(SessionHandler.SelectedFleetDayCountryId));
            APP.CustomControls.ExcelGrid gv = new APP.CustomControls.ExcelGrid();

            if (results.Count >= 1)
            {
                gv.DataSource = results;
                gv.DataBind();

                Response.Clear();
                Response.Buffer = true;
                Response.ContentType = "application/vnd.ms-excel";
                Response.AddHeader("content-disposition", "attachment;filename=FleetDayAddsDelsMFG.xls");
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
                CreateEmptyExcel();       
            }
            
        }

        private void CreateEmptyExcel()
        {
            GridView gv = new GridView();
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