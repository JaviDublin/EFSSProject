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
    public partial class TransactionsYear : UserControlBase
    {
        public void LoadData(bool isRefreshed)
        {
            if (isRefreshed)
            {
                
                this.SetNavigtionMenu();
                DateTime myDateTime = DateTime.Now;
                string year = myDateTime.Year.ToString();

                SessionHandler.FilterYearFleetYearTransReport = year;
                SessionHandler.FilterFileIdFleetYearTransReport = "5";

                this.ListViewYearOverView.LoadData(true);
                this.UpdatePanelFleetYear.Update();
            }
        }

        protected void SetNavigtionMenu()
        {
            var results = this.NavigationPanelYearTransactions.LoadControlData((int)MenuType.MenuE);
            int index = NavigationMenu.GetMinimumIndex(results);
            this.MultiViewYearTransactions.ActiveViewIndex = index;
            this.NavigationPanelYearTransactions.SetMenuStyle(this.MultiViewYearTransactions.ActiveViewIndex);
        }

        protected void NavigationMenuClick(object sender, Navigation e)
        {
            int index = e.Index;
            this.MultiViewYearTransactions.ActiveViewIndex = index;
            this.UpdatePanelFleetYear.Update();
        }

  
        protected void OnCommand(object sender, CommandEventArgs e)
        {
            if (e.CommandName == "Filter")
            {
                SessionHandler.FilterYearFleetYearTransReport = DropDownListYears.SelectedValue.ToString();
                SessionHandler.FilterFileIdFleetYearTransReport = DropDownListFile.SelectedValue.ToString();
                this.ListViewYearOverView.LoadData(true);
                this.UpdatePanelFleetYear.Update();

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
            this.ListViewYearOverViewMFG.LoadData(true);
            this.MultiViewYearTransactions.ActiveViewIndex = 1;
            this.NavigationPanelYearTransactions.SetMenuStyle(this.MultiViewYearTransactions.ActiveViewIndex);
            this.UpdatePanelFleetYear.Update();
        }

        private void CreateExcel()
        {
            var results = new List<APP.Reports.FleetYearReportOverView>();
            results = APP.Reports.FleetYearReportOverView.SelectFleetYearReport(1, 10, null, SessionHandler.FilterYearFleetYearTransReport, Convert.ToInt32(SessionHandler.FilterFileIdFleetYearTransReport));
            APP.CustomControls.ExcelGrid gv = new APP.CustomControls.ExcelGrid();
            
            if (results.Count >= 1)
            {
                gv.DataSource = results;
                gv.DataBind();


                Response.Clear();
                Response.Buffer = true;
                Response.ContentType = "application/vnd.ms-excel";
                Response.AddHeader("content-disposition", "attachment;filename=FleetYearAddsDels.xls");
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
            var results = new List<APP.Reports.FleetYearReportOverViewMFG>();
            results = APP.Reports.FleetYearReportOverViewMFG.SelectFleetYearReportMFG(1, 100, null, SessionHandler.FilterYearFleetYearTransReport, Convert.ToInt32(SessionHandler.FilterFileIdFleetYearTransReport), Convert.ToInt32(SessionHandler.SelectedFleetYearCountryId));
            APP.CustomControls.ExcelGrid gv = new APP.CustomControls.ExcelGrid();

            if (results.Count >= 1)
            {
                gv.DataSource = results;
                gv.DataBind();

                Response.Clear();
                Response.Buffer = true;
                Response.ContentType = "application/vnd.ms-excel";
                Response.AddHeader("content-disposition", "attachment;filename=FleetYearAddsDelsMFG.xls");
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