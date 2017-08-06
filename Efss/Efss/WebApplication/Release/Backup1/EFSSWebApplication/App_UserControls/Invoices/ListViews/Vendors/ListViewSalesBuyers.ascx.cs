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


namespace APP.App_UserControls.Invoices.ListViews.Vendors
{
    public partial class ListViewSalesBuyers : UserControlBase
    {
        public event EventHandler SearchInvoices;

        protected override void OnPreRender(EventArgs e)
        {
            if (this.Visible)
            {
                this.ListViewPager.PagerProgress.AssociatedUpdatePanelID = this.UpdatePanelListViewBuyers.ID;
            }
            base.OnPreRender(e);
        }

        public void LoadBuyersData(bool isRefreshed)
        {
            FilterEvents e = new FilterEvents();
            SessionHandler.BuyersFilterSales = e;
            this.LoadControlBuyersData(null, e, null, 15, null);

            AddAsyncControls();
        }

        public void AddAsyncControls()
        {
            foreach (ListViewDataItem i in ListViewBuyersOverView.Items)
            {
                ImageButtonListViewExcel imgexcel = (ImageButtonListViewExcel)i.FindControl("ImageButtonExportExcel");
                //PostBackTrigger trigger = new PostBackTrigger();
                AsyncPostBackTrigger trigger = new AsyncPostBackTrigger();
                trigger.ControlID = imgexcel.UniqueID;
                UpdatePanelListViewBuyers.Triggers.Add(trigger);
                ScriptManager.GetCurrent(Page).RegisterPostBackControl(imgexcel);
            }

            foreach (ListViewDataItem i in ListViewBuyersOverView.Items)
            {
                ImageButtonListViewPDF imgpdf = (ImageButtonListViewPDF)i.FindControl("ImageButtonExportPDF");
                //PostBackTrigger trigger = new PostBackTrigger();
                AsyncPostBackTrigger trigger = new AsyncPostBackTrigger();
                trigger.ControlID = imgpdf.UniqueID;
                UpdatePanelListViewBuyers.Triggers.Add(trigger);
                ScriptManager.GetCurrent(Page).RegisterPostBackControl(imgpdf);
            }
        
        }

        public void LoadControlBuyersData(object sender, FilterEvents e, int? currentPage, int? pageSize, string sortExpression)
        {
            
            var results = new List<APP.Search.SalesFileBuyersOverView>();
            if (sortExpression == null)
            {
                this.ListViewBuyersOverView.ColumnSortExpression = null;
                this.ListViewBuyersOverView.ColumnIndexSorted = null;
            }

            results = APP.Search.SalesFileBuyersOverView.SelectSalesFileOverViewByFileDateAndCountry(currentPage, pageSize, sortExpression, SessionHandler.SelectedFileDate, SessionHandler.SelectedInvoiceDate, Convert.ToInt32(SessionHandler.SelectedCountryId));

            if (results.Count >= 1)
            {
                  //Set Pager details
                this.ListViewPager.SetPagerDetails(results[0].Count, ((currentPage == null || currentPage == 1) ? true : false));
                this.ListViewBuyersOverView.DataSource = results;
                this.ListViewBuyersOverView.DataBind();
                Templates.SetListViewDataTemplate(this.PlaceHolderData, this.PlaceHolderNoData, true);

            }
            else
            {
                this.ListViewPager.SetPagerDetails(0, true);
                this.ListViewBuyersOverView.DataSource = results;
                this.ListViewBuyersOverView.DataBind();
                Templates.SetListViewDataTemplate(this.PlaceHolderData, this.PlaceHolderNoData, true);
            }

            this.UpdatePanelListViewBuyers.Update();
        }

        protected void ListViewBuyersOverview_Sorting(object sender, ListViewSortEventArgs e)
        {
            //Get a reference to the listview
            RAD.Controls.ListView listView = (RAD.Controls.ListView)sender;

            //Get the pager event args
            RAD.Events.PagerEventArgs args = this.ListViewPager.GetPagerEventArgs();

            //Get the filter event args
            FilterEvents filterEventArgs = SessionHandler.BuyersFilterSales;

            //Load the data based on users selection
            this.LoadControlBuyersData(sender, filterEventArgs, args.CurrentPageNumber, args.PageSize, listView.ColumnSortExpression);
        }

        protected void ListViewBuyersOverview_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            switch (e.CommandName)
            {
                case "DisplayDetails":
                    ListViewDataItem dataItem = (ListViewDataItem)e.Item;
                    string primaryDataKey = this.ListViewBuyersOverView.DataKeys[dataItem.DisplayIndex].Values[0].ToString();
                    SessionHandler.SelectedBuyerId = primaryDataKey;
                    if (SearchInvoices != null)
                    {
                        SearchInvoices(this, EventArgs.Empty);
                    }
                    break;
                case "ExportExcel":
                    ListViewDataItem dataItemEx = (ListViewDataItem)e.Item;
                    string primaryDataKeyEx = this.ListViewBuyersOverView.DataKeys[dataItemEx.DisplayIndex].Values[0].ToString();
                    SessionHandler.SelectedBuyerId = primaryDataKeyEx;
                    CreateExcelFile();
                    break;
                case "ExportPDF":
                    ListViewDataItem dataItemPDF = (ListViewDataItem)e.Item;
                    string primaryDataKeyPDF = this.ListViewBuyersOverView.DataKeys[dataItemPDF.DisplayIndex].Values[0].ToString();
                    SessionHandler.SelectedBuyerId = primaryDataKeyPDF;
                    CreatePDF();
                    break;
                case "SendEmail":
                    ListViewDataItem dataItemEmail = (ListViewDataItem)e.Item;
                    string primaryDataKeyEmail = this.ListViewBuyersOverView.DataKeys[dataItemEmail.DisplayIndex].Values[0].ToString();
                    SessionHandler.SelectedBuyerId = primaryDataKeyEmail;

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

                    break;
            }
        }

        protected void OnPager_Command(object sender, RAD.Events.PagerEventArgs e)
        {
            this.LoadControlBuyersData(sender, SessionHandler.BuyersFilterSales, (int?)e.CurrentPageNumber, (int?)e.PageSize, this.ListViewBuyersOverView.ColumnSortExpression);
            AddAsyncControls();
        }

        protected void CreateExcelFile()
        {

            APP.CustomControls.ExcelGrid gv = new APP.CustomControls.ExcelGrid();
            var results = new List<APP.Search.SalesSearchEngineExcel>();

            results = APP.Search.SalesSearchEngineExcel.SearhFileInvoicesByBuyer(SessionHandler.SelectedFileDate, SessionHandler.SelectedInvoiceDate, Convert.ToInt32(SessionHandler.SelectedCountryId), Convert.ToInt32(SessionHandler.SelectedBuyerId));


            if (results.Count >= 1)
            {
                gv.DataSource = results;
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

        #region "Report Functions"

        ReportParameter param;

        private ReportParameter CountryId()
        {
            param = new ReportParameter("countryId", SessionHandler.SelectedCountryId);
            return param;
        }

        private ReportParameter FileDate()
        {
            if (SessionHandler.SelectedFileDate == "ALL")
            {
                param = new ReportParameter("fileDate", new string[] { null }, false);
                return param;
            }
            else
            {
                param = new ReportParameter("fileDate", SessionHandler.SelectedFileDate);
                return param;
            }

        }

        private ReportParameter InvoiceDate()
        {
            if (SessionHandler.SelectedInvoiceDate == "ALL")
            {
                param = new ReportParameter("invoiceDate", new string[] { null }, false);
                return param;
            }
            else
            {
                param = new ReportParameter("invoiceDate", SessionHandler.SelectedInvoiceDate);
                return param;
            }

        }

        private ReportParameter BuyerId()
        {
            param = new ReportParameter("buyerId", SessionHandler.SelectedBuyerId);
            return param;
        }

        private ReportParameter DocItemId()
        {
            param = new ReportParameter("docItemId", new string[] { null }, false);
            return param;
        }

        private ReportParameter Type()
        { 
            param = new ReportParameter("type", "2");
            return param;
        }

        private ReportParameter InvoiceMode()
        {
            param = new ReportParameter("invoiceMode", new string[] { null }, false);
            return param;
        }

        private ReportParameter FreeFormatText()
        {
            param = new ReportParameter("freeFormatText", new string[] { null }, false);
            return param;
        }

        private string ReportName()
        {
            //APP.Properties.Settings.Default.ApplicationStartYear
            string reportName;
            switch (SessionHandler.SelectedCountryId)
            {
                case "1":
                    reportName = APP.Properties.Settings.Default.InvoiceUK;
                    break;
                case "2":
                    reportName = APP.Properties.Settings.Default.InvoiceBE;
                    break;
                case "3":
                    reportName = APP.Properties.Settings.Default.InvoiceSZ;
                    break;
                case "4":
                    reportName = APP.Properties.Settings.Default.InvoiceGE;
                    break;
                case "5":
                    reportName = APP.Properties.Settings.Default.InvoiceNE;
                    break;
                case "6":
                    reportName = APP.Properties.Settings.Default.InvoiceFR;
                    break;
                case "7":
                    reportName = APP.Properties.Settings.Default.InvoiceLU;
                    break;
                case "8":
                    reportName = APP.Properties.Settings.Default.InvoiceSP;
                    break;
                case "9":
                    reportName = APP.Properties.Settings.Default.InvoiceIT;
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
            viewer.ServerReport.SetParameters(new ReportParameter[] { CountryId(), FileDate(), InvoiceDate(), BuyerId(), Type(), InvoiceMode(), FreeFormatText() });
            viewer.ServerReport.Refresh();

            byte[] bytes = viewer.ServerReport.Render("PDF", null, out mimeType, out encoding, out extension, out streamIds, out warnings);

            // Now that you have all the bytes representing the PDF report, buffer it and send it to the client.
            fileName = "PDFVendorInvoices";
            extension = "pdf";
            Response.Buffer = true;
            Response.Clear();
            Response.ContentType = "Application/pdf";
            Response.AddHeader("content-disposition", "attachment; filename=" + fileName + "." + extension);
            Response.BinaryWrite(bytes); // create the file
            Response.Flush(); // send it to the client to download

        }

        #endregion

        #region "Create Attachments"

        private void CreateExcelAttachment()
        {
            string attachmentpath = Server.MapPath(APP.Properties.Settings.Default.EmailAttachmentsPath);
            string fileName = string.Empty;
            GridView gv = new GridView();
            var results = new List<APP.Search.SalesSearchEngineExcel>();
            results = APP.Search.SalesSearchEngineExcel.SearhFileInvoicesByBuyer(SessionHandler.SelectedFileDate, SessionHandler.SelectedInvoiceDate, Convert.ToInt32(SessionHandler.SelectedCountryId), Convert.ToInt32(SessionHandler.SelectedBuyerId));

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
            else
            {
                APP.Data.DBNoData nd = new APP.Data.DBNoData();
                gv.DataSource = nd.NoDataAvailable(); ;
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
            viewer.ServerReport.ReportServerUrl = new System.Uri(APP.Properties.Settings.Default.ReportServerRadReports);


            viewer.ServerReport.ReportPath = reportPath;
            viewer.ServerReport.SetParameters(new ReportParameter[] { CountryId(), FileDate(), InvoiceDate(), BuyerId(), Type() });
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
            viewer.ServerReport.SetParameters(new ReportParameter[] { CountryId(), FileDate(), InvoiceDate(), BuyerId(), Type() });
            viewer.ServerReport.Refresh();
            byte[] bytes = viewer.ServerReport.Render("PDF", null, out mimeType, out encoding, out extension, out streamIds, out warnings);
            string attachmentpath = Server.MapPath(APP.Properties.Settings.Default.EmailAttachmentsPath);
            fileName = APP.Properties.Settings.Default.FileNamePDFTransport;
            FileStream fs = File.Create(attachmentpath + fileName, bytes.Length);
            fs.Write(bytes, 0, bytes.Length);
            fs.Close();
        }

        private void ClearAttachments()
        {
            string attachmentpath = Server.MapPath("~/App_Files/EmailAttachments/");
            DirectoryInfo d = new DirectoryInfo(attachmentpath);
            foreach (FileInfo f in d.GetFiles())
            {
                f.Delete();
            }

        }

        private string ReturnExtension(string fileExtension)
        {
            switch (fileExtension)
            {
                case ".htm":
                case ".html":
                case ".log":
                    return "text/HTML";
                case ".txt":
                    return "text/plain";
                case ".doc":
                    return "application/ms-word";
                case ".tiff":
                case ".tif":
                    return "image/tiff";
                case ".asf":
                    return "video/x-ms-asf";
                case ".avi":
                    return "video/avi";
                case ".zip":
                    return "application/zip";
                case ".xls":
                case ".xlsx":
                case ".csv":
                    return "application/vnd.ms-excel";
                case ".xlsm":
                    return "application/vnd.ms-excel.sheet.macroEnabled.12";
                case ".xltm":
                    return "application/vnd.ms-excel.template.macroEnabled.12";
                case ".gif":
                    return "image/gif";
                case ".jpg":
                case "jpeg":
                    return "image/jpeg";
                case ".bmp":
                    return "image/bmp";
                case ".wav":
                    return "audio/wav";
                case ".mp3":
                    return "audio/mpeg3";
                case ".mpg":
                case "mpeg":
                    return "video/mpeg";
                case ".rtf":
                    return "application/rtf";
                case ".asp":
                    return "text/asp";
                case ".pdf":
                    return "application/pdf";
                case ".fdf":
                    return "application/vnd.fdf";
                case ".ppt":
                    return "application/mspowerpoint";
                case ".dwg":
                    return "image/vnd.dwg";
                case ".msg":
                    return "application/msoutlook";
                case ".xml":
                case ".sdxl":
                    return "application/xml";
                case ".xdp":
                    return "application/vnd.adobe.xdp+xml";
                default:
                    return "application/octet-stream";
            }

        }

        #endregion



    }
}