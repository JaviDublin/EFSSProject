using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Linq;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using AjaxControlToolkit;
using APP.Base;
using APP.Data;
using APP.Events;
using APP.Search;
using APP.Session;
using APP.Settings;
using Microsoft.Reporting.WebForms;
using RAD.Common;
using RAD.Data;
using RAD.Diagnostics;

namespace APP.App_UserControls.Reports
{
    public partial class FleetDashboardForm : UserControlBase
    {
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
                DropDownListCountries.DataSource = CompanyGroupNames.SelectCompanyGroupName();
                DropDownListCountries.DataTextField = "GroupName";
                DropDownListCountries.DataValueField = "GroupId";
                DropDownListCountries.DataBind();
                DropDownListCountries.SelectedIndex = 0;

                DropDownListInvoiceType.DataSource = DocumentsSubTypes.SelectDocSubType(3).Select(s => s.DocumentSubType);
                DropDownListInvoiceType.DataBind();
                DropDownListInvoiceType.SelectedIndex = 0;

                SessionHandler.DashBoardDocSubType = DropDownListInvoiceType.SelectedItem.Text;
                SessionHandler.DashBoardGroupName = DropDownListCountries.SelectedItem.Text;

                FilterEvents e = new FilterEvents();
                SessionHandler.DashboardFilter = e;

                this.LoadControlData(null, e, null, 15, null);
            }
        }

        public void LoadControlData(object sender, FilterEvents e, int? currentPage, int? pageSize, string sortExpression)
        {
            var results = new List<APP.Search.DashboardOverView>();

            if (sortExpression == null)
            {
                this.ListViewDashboard.ColumnSortExpression = null;
                this.ListViewDashboard.ColumnIndexSorted = null;
            }

            results = APP.Search.DashboardOverView.SelectDashBoard(currentPage, pageSize, sortExpression, SessionHandler.DashBoardGroupName, SessionHandler.DashBoardDocSubType);

            if (results.Count >= 1)
            {
               
                this.ListViewPager.SetPagerDetails(results[0].Count, ((currentPage == null || currentPage == 1) ? true : false));
                this.ListViewDashboard.DataSource = results;
                this.ListViewDashboard.DataBind();
                Templates.SetListViewDataTemplate(this.PlaceHolderData, this.PlaceHolderNoData, true);
            }
            else
            {
                this.ListViewPager.SetPagerDetails(0, true);
                this.ListViewDashboard.DataSource = results;
                this.ListViewDashboard.DataBind();
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
            FilterEvents filterEventArgs = SessionHandler.DashboardFilter;

            //Load the data based on users selection
            this.LoadControlData(sender, filterEventArgs, args.CurrentPageNumber, args.PageSize, listView.ColumnSortExpression);
        }

        protected void ListView_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            ListViewDataItem dataItem = (ListViewDataItem)e.Item;

            HtmlTableRow itemRow = (HtmlTableRow)dataItem.FindControl("rowListViewDetails");
            PopupControlExtender pce = (PopupControlExtender)itemRow.FindControl("PopupControlExtenderAccounts");
            Image imageHover = (Image)itemRow.FindControl("ImageHover");
            Image imageClose = (Image)itemRow.FindControl("ImageClose");

            // Set the BehaviorID
            string behaviorID = string.Concat("pce", dataItem.DataItemIndex.ToString());
            pce.BehaviorID = behaviorID;

            // Add the client-side attributes (onmouseover & onmouseout)
            string OnMouseOverScript = string.Format("$find('{0}').showPopup();", behaviorID);
            string OnImageCloseScript = string.Format("$find('{0}').hidePopup();", behaviorID);

            imageHover.Attributes.Add("onmouseover", OnMouseOverScript);
            imageClose.Attributes.Add("onclick", OnImageCloseScript);
        }

        protected void OnCommand(object sender, CommandEventArgs e)
        {
            if (e.CommandName == "Filter")
            {
                SessionHandler.DashBoardDocSubType = DropDownListInvoiceType.SelectedItem.Text;
                SessionHandler.DashBoardGroupName = DropDownListCountries.SelectedItem.Text;
                this.LoadControlData(null, SessionHandler.DashboardFilter, null, 15, null);
            }
            else if (e.CommandName == "Save")
            {
                foreach (ListViewItem item in ListViewDashboard.Items)
                {
                    System.Web.UI.WebControls.TextBox txt = (System.Web.UI.WebControls.TextBox)item.FindControl("TextBoxNotes");
                    string notes = txt.Text;
                    string manufacturerId = this.ListViewDashboard.DataKeys[item.DisplayIndex].Values[0].ToString();
                    System.Web.UI.WebControls.TextBox txtcnk = (System.Web.UI.WebControls.TextBox)item.FindControl("TextBoxCNK");
                    string cnk = txtcnk.Text;
                    UpdateDashboardReport(notes, manufacturerId, cnk);
                }

                this.LoadControlData(null, SessionHandler.DashboardFilter, null, 15, null);
            }
            else if (e.CommandName == "Export")
            {
                ExportToExcel();
            }
            else if (e.CommandName == "ExportFile")
            {
                ExportDashboardFile();
            }
        }

        private void UpdateDashboardReport(string notes , string manufacturerId,string cnk)
        {
            try
            {
                SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = ConnectionManager.CreateProcedure(StoredProcedures.DashBoard_Update, con);
                RAD.Data.Parameters.CreateParameter(cmd, "@manufacturerId", manufacturerId);
                RAD.Data.Parameters.CreateParameter(cmd, "@countryName", SessionHandler.DashBoardGroupName);
                RAD.Data.Parameters.CreateParameter(cmd, "@docsubtype", SessionHandler.DashBoardDocSubType);
                RAD.Data.Parameters.CreateParameter(cmd, "@notes", notes);
                RAD.Data.Parameters.CreateParameter(cmd, "@CNK", cnk);
                using (con)
                {
                    con.Open();
                    cmd.ExecuteReader();
                }
            }
            catch (Exception ex)
            {
                StackTrace errorStackTrace = new StackTrace(true);
                Logs.LogError(errorStackTrace, ex);
            }
        }

        protected void OnPager_Command(object sender, RAD.Events.PagerEventArgs e)
        {
            this.LoadControlData(sender, SessionHandler.DashboardFilter, (int?)e.CurrentPageNumber, (int?)e.PageSize, this.ListViewDashboard.ColumnSortExpression);
        }

        private void ExportToExcel()
        {
            string reportName = APP.Properties.Settings.Default.ReportDashboard;
            // Variables
            Warning[] warnings;
            string[] streamIds;
            string mimeType = string.Empty;
            string encoding = string.Empty;
            string extension = string.Empty;
            string fileName = string.Empty;

            string reportPath;
            reportPath = ApplicationSettings.GetReportFolderName() + reportName;

            Microsoft.Reporting.WebForms.ReportViewer viewer = new Microsoft.Reporting.WebForms.ReportViewer();
            viewer.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
            viewer.ServerReport.ReportServerUrl = new System.Uri(APP.Properties.Settings.Default.ReportServerRadReports);
            viewer.ServerReport.ReportPath = reportPath;
            viewer.ServerReport.Refresh();

            byte[] bytes = viewer.ServerReport.Render("Excel", null, out mimeType, out encoding, out extension, out streamIds, out warnings);

            // Now that you have all the bytes representing the PDF report, buffer it and send it to the client.
            fileName = "FleetDashboard";
            extension = "xls";
            Response.Buffer = true;
            Response.Clear();
            Response.ContentType = "application/vnd.ms-excel";
            Response.AddHeader("content-disposition", "attachment; filename=" + fileName + "." + extension);
            Response.BinaryWrite(bytes); // create the file
            Response.Flush(); // send it to the client to download
        
        }

        private void ExportDashboardFile()
        {
            try
            {
                GridView gv = new GridView();
                System.Data.DataTable dt = new System.Data.DataTable();
                DBAgent getDashboardFile = new DBAgent(StoredProcedures.ExportDashboardFileToExcel);
                dt = getDashboardFile.ReturnData();
                if (dt.Rows.Count >= 1)
                {
                    gv.DataSource = dt;
                    gv.DataBind();
                    Response.Clear();
                    Response.Buffer = true;
                    Response.ContentType = "application/vnd.ms-excel";
                    Response.AddHeader("content-disposition", "attachment;filename=Dashboard.xls");
                    Response.Charset = "";
                    this.EnableViewState = false;
                    System.IO.StringWriter sw = new System.IO.StringWriter();
                    System.Web.UI.HtmlTextWriter htw = new System.Web.UI.HtmlTextWriter(sw);
                    gv.RenderControl(htw);
                    Response.Write(sw.ToString());
                    Response.End();

                }
            }
            catch (Exception ex)
            {
                StackTrace errorStackTrace = new StackTrace(true);
                Logs.LogError(errorStackTrace, ex);
            }
        }
    }
}