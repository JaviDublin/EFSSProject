using System;
using System.Collections.Generic;
using System.IO;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;
using APP.Base;
using APP.CustomControls;
using APP.Email;
using APP.Events;
using APP.Session;
using APP.Settings;
using Microsoft.Reporting.WebForms;
using RAD.Common;

namespace APP.App_UserControls.Invoices.ListViews.Documents
{
    public partial class ListViewSalesInvoices : UserControlBase
    {
        protected override void OnPreRender(EventArgs e)
        {
            if (this.Visible)
            {
                this.ListViewPager.PagerProgress.AssociatedUpdatePanelID = this.UpdatePanelListViewInvoices.ID;
            }
            base.OnPreRender(e);
        }

        public void LoadInvoicesData(bool isRefreshed)
        {
            if (isRefreshed)
            {
                FilterEvents e = new FilterEvents();
                SessionHandler.ApplicationFilterFileBuyerInvoicesOverView = e;
                this.LoadControlInvoicesData(null, e, null, 15, null);

                AddAsyncControls();

            }
        }

        public void AddAsyncControls()
        {
            foreach (ListViewDataItem i in ListViewInvoicesOverView.Items)
            {
                ImageButtonListViewPDF imgpdf = (ImageButtonListViewPDF)i.FindControl("ImageButtonExportPDFInvoice");
                AsyncPostBackTrigger trigger = new AsyncPostBackTrigger();
                trigger.ControlID = imgpdf.UniqueID;
                UpdatePanelListViewInvoices.Triggers.Add(trigger);
                ScriptManager.GetCurrent(Page).RegisterPostBackControl(imgpdf);
            }
        }

        public void LoadControlInvoicesData(object sender, FilterEvents e, int? currentPage, int? pageSize, string sortExpression)
        {

            var results = new List<APP.Search.SalesFileInvoicesOverView>();
            if (sortExpression == null)
            {
                this.ListViewInvoicesOverView.ColumnSortExpression = null;
                this.ListViewInvoicesOverView.ColumnIndexSorted = null;
            }

            results = APP.Search.SalesFileInvoicesOverView.SelectFileInvoicesOverView(currentPage, pageSize, sortExpression, SessionHandler.SelectedFileDate, SessionHandler.SelectedInvoiceDate, Convert.ToInt32(SessionHandler.SelectedCountryId), Convert.ToInt32(SessionHandler.SelectedBuyerId));

            if (results.Count >= 1)
            {
                this.ListViewPager.SetPagerDetails(results[0].Count, ((currentPage == null || currentPage == 1) ? true : false));
                this.ListViewInvoicesOverView.DataSource = results;
                this.ListViewInvoicesOverView.DataBind();
                Templates.SetListViewDataTemplate(this.PlaceHolderData, this.PlaceHolderNoData, true);
            }
            else
            {
                this.ListViewPager.SetPagerDetails(0, true);
                this.ListViewInvoicesOverView.DataSource = results;
                this.ListViewInvoicesOverView.DataBind();
                Templates.SetListViewDataTemplate(this.PlaceHolderData, this.PlaceHolderNoData, true);
            }

            this.UpdatePanelListViewInvoices.Update();
        }

        protected void ListViewInvoicesOverview_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            if (e.CommandName == "ExportPDF")
            {
                ListViewDataItem dataItem = (ListViewDataItem)e.Item;
                string primaryDataKey = this.ListViewInvoicesOverView.DataKeys[dataItem.DisplayIndex].Values[0].ToString();
                SessionHandler.SelectedRowId = primaryDataKey;  // Document Item Id
                CreatePDF();
                //this.UpdatePanelListViewInvoices.Update();

            }
            else if (e.CommandName == "SendEmail")
            {
                ListViewDataItem dataItem = (ListViewDataItem)e.Item;
                string primaryDataKey = this.ListViewInvoicesOverView.DataKeys[dataItem.DisplayIndex].Values[0].ToString();
                SessionHandler.SelectedRowId = primaryDataKey;  // Document Item Id

                string excelAttachment = APP.Properties.Settings.Default.AttachmentExcelPath;
                string pdfAttachment = APP.Properties.Settings.Default.AttachmentPDFPath;

                ClearAttachments();
                CreateExcelAttachment();
                CreatePDFAttachment();

                if (SessionHandler.SelectedCountryId == "5")
                {
                    CreatePDFNetherlandsTransport();
                    string pdftransport = APP.Properties.Settings.Default.AttacmentsNETransport;

                    if (EmailBuilder.GetEmailTo(Convert.ToInt32(SessionHandler.SelectedBuyerId)) != null)
                    {
                        EmailBuilder.SendMailNetherlands(ApplicationSettings.GetEmailId(Convert.ToInt32(SessionHandler.SelectedCountryId)), Server.MapPath(excelAttachment), Server.MapPath(pdfAttachment), Server.MapPath(pdftransport));
                    }
                }
                else
                {
                    if (EmailBuilder.GetEmailTo(Convert.ToInt32(SessionHandler.SelectedBuyerId)) != null)
                    {
                        EmailBuilder.SendMailWithAttachments(ApplicationSettings.GetEmailId(Convert.ToInt32(SessionHandler.SelectedCountryId)), Server.MapPath(excelAttachment), Server.MapPath(pdfAttachment));
                    }
                }   
            }
        }

        protected void ListViewInvoicesOverview_Sorting(object sender, ListViewSortEventArgs e)
        {

            //Get a reference to the listview
            RAD.Controls.ListView listView = (RAD.Controls.ListView)sender;

            //Get the pager event args
            RAD.Events.PagerEventArgs args = this.ListViewPager.GetPagerEventArgs();

            //Get the filter event args
            FilterEvents filterEventArgs = SessionHandler.ApplicationFilterFileBuyerInvoicesOverView;

            //Load the data based on users selection
            this.LoadControlInvoicesData(sender, filterEventArgs, args.CurrentPageNumber, args.PageSize, listView.ColumnSortExpression);
          
        }

        protected void OnPager_Command(object sender, RAD.Events.PagerEventArgs e)
        {
            this.LoadControlInvoicesData(sender, SessionHandler.ApplicationFilterFileBuyerInvoicesOverView, (int?)e.CurrentPageNumber, (int?)e.PageSize, this.ListViewInvoicesOverView.ColumnSortExpression);
            AddAsyncControls();
        }

        #region "Report Functions"

        ReportParameter param;

        private ReportParameter DocItemId()
        {
            param = new ReportParameter("docItemId", SessionHandler.SelectedRowId);
            return param;
        }

        private ReportParameter Type()
        {
            param = new ReportParameter("type", "3");
            return param;
        }

        private string ReportName()
        {
            string reportName;
            switch (SessionHandler.SelectedCountryId)
            {
                case "1":
                    reportName = "InvoiceUK";
                    break;
                case "2":
                    reportName = "InvoiceBE";
                    break;
                case "3":
                    reportName = "InvoiceSZ";
                    break;
                case "4":
                    reportName = "InvoiceGE";
                    break;
                case "5":
                    reportName = "InvoiceNE";
                    break;
                case "6":
                    reportName = "InvoiceFR";
                    break;
                case "7":
                    reportName = "InvoiceLU";
                    break;
                case "8":
                    reportName = "InvoiceSP";
                    break;
                case "9":
                    reportName = "InvoiceIT";
                    break;
                default:
                    reportName = "";
                    break;
            }

            return reportName;
        }

        private void CreatePDF()
        {
            // Variables
            Warning[] warnings;
            string[] streamIds;
            string mimeType = string.Empty;
            string encoding = string.Empty;
            string extension = string.Empty;
            string fileName = string.Empty;

            // Setup the report viewer object and get the array of bytes

            string reportName = ReportName();
            string reportPath;
            reportPath = ApplicationSettings.GetReportFolderName() + reportName;

            ReportViewer viewer = new ReportViewer();
            viewer.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
            viewer.ServerReport.ReportServerUrl = new System.Uri(APP.Properties.Settings.Default.ReportServerRadReports);
            viewer.ServerReport.ReportPath = reportPath;
            viewer.ServerReport.SetParameters(new ReportParameter[] { DocItemId(), Type() });
            viewer.ServerReport.Refresh();

            byte[] bytes = viewer.ServerReport.Render("PDF", null, out mimeType, out encoding, out extension, out streamIds, out warnings);

            // Now that you have all the bytes representing the PDF report, buffer it and send it to the client.
            fileName = APP.Properties.Settings.Default.FileNamePDFAttachment;
            Response.Buffer = true;
            Response.Clear();
            Response.ContentType = "Application/pdf";
            Response.AddHeader("content-disposition", "attachment; filename=" + fileName);
            Response.BinaryWrite(bytes); // create the file
            Response.Flush(); // send it to the client to download

        }

        #endregion

        #region "Send Email"

        private void ClearAttachments()
        {
            string attachmentpath = Server.MapPath(APP.Properties.Settings.Default.EmailAttachmentsPath);
            DirectoryInfo d = new DirectoryInfo(attachmentpath);
            foreach (FileInfo f in d.GetFiles())
            {
                f.Delete();
            }
        }

        private void CreateExcelAttachment()
        {
            string attachmentpath = Server.MapPath(APP.Properties.Settings.Default.EmailAttachmentsPath);
            string fileName = string.Empty;
            GridView gv = new GridView();
            var results = new List<APP.Search.SalesSearchEngineExcel>();
            results = APP.Search.SalesSearchEngineExcel.SearchFileInvoicesByDocItem(Convert.ToInt32(SessionHandler.SelectedRowId));
            
            if (results.Count >= 1)
            {
                gv.DataSource = results;
                gv.DataBind();
                fileName = APP.Properties.Settings.Default.FileNameExcelAttachment;
                System.IO.StringWriter sw = new System.IO.StringWriter();
                System.Web.UI.HtmlTextWriter htw = new System.Web.UI.HtmlTextWriter(sw);
                gv.RenderControl(htw);
                string htmlContent = sw.ToString();
                ASCIIEncoding encoding = new ASCIIEncoding();
                byte[] bytes = encoding.GetBytes(htmlContent);
                int length = bytes.Length;
                FileStream fs = File.Create(attachmentpath + fileName, length);
                fs.Write(bytes, 0, length);
                fs.Close();
            }
        }

        private void CreatePDFAttachment()
        {

            // Variables
            Warning[] warnings;
            string[] streamIds;
            string mimeType = string.Empty;
            string encoding = string.Empty;
            string extension = string.Empty;
            string fileName = string.Empty;

            string reportName = ReportName();
            string reportPath;
            reportPath = ApplicationSettings.GetReportFolderName() + reportName;

            ReportViewer viewer = new ReportViewer();
            viewer.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
            //viewer.ServerReport.ReportServerUrl = new System.Uri("http://hescrad2/ReportServer");
            viewer.ServerReport.ReportServerUrl = new System.Uri(APP.Properties.Settings.Default.ReportServerRadReports);
            viewer.ServerReport.ReportPath = reportPath;
            viewer.ServerReport.SetParameters(new ReportParameter[] { DocItemId(), Type() });
            viewer.ServerReport.Refresh();

            byte[] bytes = viewer.ServerReport.Render("PDF", null, out mimeType, out encoding, out extension, out streamIds, out warnings);

            string attachmentpath = Server.MapPath(APP.Properties.Settings.Default.EmailAttachmentsPath);
            fileName = APP.Properties.Settings.Default.FileNamePDFAttachment;
            FileStream fs = File.Create(attachmentpath + fileName, bytes.Length);
            fs.Write(bytes, 0, bytes.Length);
            fs.Close();

        }

        private void CreatePDFNetherlandsTransport()
        {
            // Variables
            Warning[] warnings;
            string[] streamIds;
            string mimeType = string.Empty;
            string encoding = string.Empty;
            string extension = string.Empty;
            string fileName = string.Empty;

            string reportName = APP.Properties.Settings.Default.InvoiceNETransport;
            string reportPath;
            reportPath = ApplicationSettings.GetReportFolderName() + reportName;

            ReportViewer viewer = new ReportViewer();
            viewer.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
            viewer.ServerReport.ReportServerUrl = new System.Uri(APP.Properties.Settings.Default.ReportServerRadReports);
            viewer.ServerReport.ReportPath = reportPath;
            viewer.ServerReport.SetParameters(new ReportParameter[] { DocItemId(), Type() });
            viewer.ServerReport.Refresh();
            byte[] bytes = viewer.ServerReport.Render("PDF", null, out mimeType, out encoding, out extension, out streamIds, out warnings);
            string attachmentpath = Server.MapPath(APP.Properties.Settings.Default.EmailAttachmentsPath);
            fileName = APP.Properties.Settings.Default.FileNamePDFTransport;
            FileStream fs = File.Create(attachmentpath + fileName, bytes.Length);
            fs.Write(bytes, 0, bytes.Length);
            fs.Close();
        }

        #endregion

        

    }
}