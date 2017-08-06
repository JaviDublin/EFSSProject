using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web.UI.WebControls;
using APP.Base;
using APP.Email;
using APP.Search;
using APP.Session;
using APP.Settings;
using Microsoft.Reporting.WebForms;
using System.Text;


namespace APP.App_UserControls.Invoices.Search
{
    public partial class SearchEngine : UserControlBase
    {
        string countryName;
        

        protected override void OnPreRender(EventArgs e)
        {
            if (this.Visible)
            {
                //this.ListViewPager.PagerProgress.AssociatedUpdatePanelID = this.UpdatePanelListView.ID;
            }
            base.OnPreRender(e);
        }

        public void LoadData(bool isRefreshed)
        {
            if (isRefreshed)
            {
                DropDownListInvoiceType.DataSource = null;
                DropDownListInvoiceType.Items.Clear();
                DropDownListInvoiceType.Items.Add("");
                DropDownListInvoiceType.DataSource = DocumentsSubTypes.SelectDocSubType(2).Select(s => s.DocumentSubType);
                DropDownListInvoiceType.DataBind();
                DropDownListInvoiceType.SelectedIndex = 1;


                DropDownListDocumentType.DataSource = null;
                DropDownListDocumentType.Items.Clear();
                DropDownListDocumentType.Items.Add("");

                DropDownListDocumentType.DataSource = DocumentTypes.SelectDocType(1).Select(d => d.DocumentType);
                DropDownListDocumentType.DataBind();
                DropDownListDocumentType.SelectedIndex = 1;

                DropDownListCountries.DataSource = null;
                DropDownListCountries.Items.Clear();
                var countries = new List<APP.Search.SearchCountries>(); 
                countries = APP.Search.SearchCountries.SelectCountries();
                DropDownListCountries.DataSource = countries;
                DropDownListCountries.DataTextField = "CountryName";
                DropDownListCountries.DataValueField = "CountryId";
                DropDownListCountries.DataBind();
                DropDownListCountries.SelectedIndex = 0;

                LoadCompanies();

                LoadManufacturers();
                //FillListView();
            }
        }

        private void SetFormSessions()
        {
            SessionHandler.SearchFormCountryName = DropDownListCountries.SelectedItem.Text;
            SessionHandler.SearchFormCountryId = ApplicationSettings.GetCountryId(SessionHandler.ApplicationCountryName);
            SessionHandler.SearchFormCompanyName = DropDownListCompanies.SelectedItem.Text;
            SessionHandler.SearchFormCompanyId = ApplicationSettings.GetCompanyId(SessionHandler.ApplicationCompanyName);
        }

        protected void OnCommand(object sender, CommandEventArgs e)
        {
            if (e.CommandName == "ExportPDF")
            {
                SetFormSessions();
                GetFormValues();
                CreatePDF();
            
            }
            else if (e.CommandName == "ExportExcel")
            {
                SetFormSessions();
                GetFormValues();
                CreateExcelFile();
            }
            else if (e.CommandName == "SendEmail")
            {
                ClearAttachments();
                CreateExcelAttachment();
                CreatePDFAttachment();

                string attachmentpath = APP.Properties.Settings.Default.AttachmentPDFPath;
                string excelAttachment = APP.Properties.Settings.Default.AttachmentExcelPath;
                string pdfAttachment = APP.Properties.Settings.Default.AttachmentPDFPath;

                int buyerId = ApplicationSettings.GetBuyerId(SessionHandler.SearchBuyerCode, Convert.ToInt32(SessionHandler.SearchFormCountryId));
                int emailid = ApplicationSettings.GetEmailId(Convert.ToInt32(SessionHandler.SearchFormCountryId));

                if (SessionHandler.SelectedCountryId == "5")
                {
                    CreatePDFNetherlandsTransport();
                    string pdftransport = APP.Properties.Settings.Default.AttacmentsNETransport;

                    if (EmailBuilder.GetEmailTo(buyerId) != null)
                    {
                        EmailBuilder.SendMailNetherlands(ApplicationSettings.GetEmailId(Convert.ToInt32(SessionHandler.SelectedCountryId)), Server.MapPath(excelAttachment), Server.MapPath(pdfAttachment), Server.MapPath(pdftransport));
                    }
                }
                else
                {
                    if (EmailBuilder.GetEmailTo(buyerId) != null)
                    {
                        EmailBuilder.SendMailWithAttachments(ApplicationSettings.GetEmailId(Convert.ToInt32(SessionHandler.SelectedCountryId)), Server.MapPath(excelAttachment), Server.MapPath(pdfAttachment));
                    }
                }

            }
            else if (e.CommandName == "Transport")
            {
                SetFormSessions();
                GetFormValues();
                CreatePDFTransport();
            }
        }

        protected void DropDownListCountries_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadCompanies();
            SetFormSessions();
            LoadManufacturers();
            this.UpdatePanelForm.Update();
        }

        protected void DropDownListCompanies_SelectedIndexChanged(object sender, EventArgs e)
        {
            SetFormSessions();
            LoadManufacturers();
            this.UpdatePanelForm.Update();
        }

        public void LoadCompanies()
        {

            DropDownListCompanies.DataSource = null;
            DropDownListCompanies.Items.Clear();
            countryName = DropDownListCountries.SelectedItem.Text;
            var companies = new List<APP.Search.SearchCompanies>();
            companies = APP.Search.SearchCompanies.SelectCompaniesByCountry(countryName);
            if (companies.Count > 1)
            {
                DropDownListCompanies.Items.Add("ALL");
            }
            DropDownListCompanies.DataSource = companies;
            DropDownListCompanies.DataTextField = "CompanyName";
            DropDownListCompanies.DataValueField = "CompanyId";
            DropDownListCompanies.DataBind();

            SetFormSessions();
        }

        public void LoadManufacturers()
        {
            DropDownListManufacturer.DataSource = null;
            DropDownListManufacturer.Items.Clear();
            DropDownListManufacturer.Items.Add("ALL");
            var manufacturer = new List<APP.Search.SearchManufacturers>();
            manufacturer = APP.Search.SearchManufacturers.SelectManufacturersByCompanyId();
            DropDownListManufacturer.DataSource = manufacturer;
            DropDownListManufacturer.DataTextField = "ManufacturerName";
            DropDownListManufacturer.DataValueField = "ManufacturerId";
            DropDownListManufacturer.DataBind();
            DropDownListManufacturer.SelectedIndex = 0;
        
        }

        private void GetFormValues()
        {
            if (TextBoxPlate.Text == String.Empty)
            { SessionHandler.SearchPlate = null; }
            else
            { SessionHandler.SearchPlate = TextBoxPlate.Text; }

            if (TextBoxSerial.Text == String.Empty)
            { SessionHandler.SearchSerial = null; }
            else
            { SessionHandler.SearchSerial = TextBoxSerial.Text; }

            if (TextBoxUnit.Text == String.Empty)
            { SessionHandler.SearchUnit = null; }
            else
            { SessionHandler.SearchUnit = TextBoxUnit.Text; }

            if (TextBoxInvoiceDateForm.Text == String.Empty)
            { SessionHandler.SearchDateFrom = null; }
            else
            { SessionHandler.SearchDateFrom = TextBoxInvoiceDateForm.Text; }

            if (TextBoxInvoiceDateTo.Text == String.Empty)
            { SessionHandler.SearchDateTo = null; }
            else
            { SessionHandler.SearchDateTo = TextBoxInvoiceDateTo.Text; }

            if (TextBoxInvoiceNumberFrom.Text == String.Empty)
            { SessionHandler.SearchInvoiceFrom = null; }
            else
            { SessionHandler.SearchInvoiceFrom = Convert.ToInt32(TextBoxInvoiceNumberFrom.Text); }

            if (TextBoxInvoiceNumberTo.Text == String.Empty)
            { SessionHandler.SearchInvoiceTo = null; }
            else
            { SessionHandler.SearchInvoiceTo = Convert.ToInt32(TextBoxInvoiceNumberTo.Text); }

            if (TextBoxBuyerCode.Text == String.Empty)
            { SessionHandler.SearchBuyerCode = null; }
            else
            { SessionHandler.SearchBuyerCode = TextBoxBuyerCode.Text; }

            if (TextBoxBuyerName.Text == String.Empty)
            { SessionHandler.SearchBuyerName = null; }
            else
            { SessionHandler.SearchBuyerName = TextBoxBuyerName.Text; }

            if (DropDownListInvoiceType.SelectedIndex == 0)
            { SessionHandler.SearchDocSubType = null; }
            else
            { SessionHandler.SearchDocSubType = DropDownListInvoiceType.Text; }

            if (DropDownListDocumentType.SelectedIndex == 0)
            { SessionHandler.SearchDocType = null; }
            else
            { SessionHandler.SearchDocType = DropDownListDocumentType.Text; }

            if (DropDownListManufacturer.SelectedIndex == 0)
            { SessionHandler.SearchManufacturer = null; }
            else
            { SessionHandler.SearchManufacturer = DropDownListManufacturer.SelectedItem.Text; }

            if (dropDownListVehicleType.SelectedValue.ToString() == "-1")
            { SessionHandler.SearchVehicleType = null; }
            else
            { SessionHandler.SearchVehicleType = dropDownListVehicleType.SelectedValue.ToString(); }

            if (dropDownListSaleType.SelectedValue.ToString() == "-1")
            { SessionHandler.SearchSaleType = null; }
            else
            { SessionHandler.SearchSaleType = dropDownListSaleType.SelectedValue.ToString();}

            if (TextBoxFileDate.Text == String.Empty)
            { SessionHandler.SearchFileDate = null; }
            else
            { SessionHandler.SearchFileDate = TextBoxFileDate.Text; }

            SessionHandler.SearchInvoiceMode = DropDownInvoiceMode.SelectedValue;

            if (TextBoxFreeFormat.Text == String.Empty)
            { SessionHandler.SearchFreeFormatText = null; }
            else
            { SessionHandler.SearchFreeFormatText = TextBoxFreeFormat.Text; }

        }

        protected void CreateExcelFile()
        {
            APP.CustomControls.ExcelGrid gv = new APP.CustomControls.ExcelGrid();
            var results = new List<APP.Search.SalesSearchEngineExcel>();

            results = APP.Search.SalesSearchEngineExcel.SearchInvoices();

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
            param = new ReportParameter("countryId", SessionHandler.SearchFormCountryId.ToString());
            return param;
        }

        private ReportParameter CompanyId()
        {
            param = new ReportParameter("companyId", SessionHandler.SearchFormCompanyId.ToString());
            return param;
        }

        private ReportParameter BuyerId()
        {
            if (SessionHandler.SearchBuyerCode == null)
            {
                param = new ReportParameter("buyerId", new string[] { null }, false);
                return param;
            }
            else
            {
                param = new ReportParameter("buyerId", ApplicationSettings.GetBuyerId(SessionHandler.SearchBuyerCode, Convert.ToInt32(SessionHandler.SearchFormCountryId)).ToString());
                return param;
            }
            
        }

        private ReportParameter DocumentType()
        {
            if (SessionHandler.SearchDocType == null)
            {
                param = new ReportParameter("documentType", new string[] { null }, false);
                return param;
            }
            else
            {
                param = new ReportParameter("documentType", SessionHandler.SearchDocType);
                return param;
            }
            
        }

        private ReportParameter DocumentSubType()
        {
            if (SessionHandler.SearchDocSubType == null)
            {
                param = new ReportParameter("documentSubType", new string[] { null }, false);
                return param;
            }
            else
            {
                param = new ReportParameter("documentSubType", SessionHandler.SearchDocSubType);
                return param;
            }
            
        }

        private ReportParameter DocItemId()
        {
            param = new ReportParameter("docItemId", new string[] { null }, false);
            return param;
        }

        private ReportParameter Serial()
        {
            if (SessionHandler.SearchSerial == null)
            {
                param = new ReportParameter("serial", new string[] { null }, false);
                return param;
            }
            else
            {
                param = new ReportParameter("serial", SessionHandler.SearchSerial);
                return param;
            }
        }

        private ReportParameter Plate()
        {
            if (SessionHandler.SearchPlate == null)
            {
                param = new ReportParameter("plate", new string[] { null }, false);
                return param;
            }
            else
            {
                param = new ReportParameter("plate", SessionHandler.SearchPlate);
                return param;
            }

        }

        private ReportParameter Unit()
        {
            if (SessionHandler.SearchUnit == null)
            {
                param = new ReportParameter("unit", new string[] { null }, false);
                return param;
            }
            else
            {
                param = new ReportParameter("unit", SessionHandler.SearchUnit);
                return param;
            }

        }

        private ReportParameter BuyerCode()
        {
            if (SessionHandler.SearchBuyerCode == null)
            {
                param = new ReportParameter("buyerCode", new string[] { null }, false);
                return param;
            }
            else
            {
                param = new ReportParameter("buyerCode", SessionHandler.SearchBuyerCode);
                return param;
            }
        }

        private ReportParameter BuyerName()
        {
            if (SessionHandler.SearchBuyerName == null)
            {
                param = new ReportParameter("buyerName", new string[] { null }, false);
                return param;
            }
            else
            {
                param = new ReportParameter("buyerName", SessionHandler.SearchBuyerName);
                return param;
            }
        }

        private ReportParameter Manufacturer()
        {
            if (SessionHandler.SearchManufacturer == null)
            {
                param = new ReportParameter("manufacturer", new string[] { null }, false);
                return param;
            }
            else
            {
                param = new ReportParameter("manufacturer", SessionHandler.SearchManufacturer);
                return param;
            }
        }

        private ReportParameter VehicleType()
        {
            if (SessionHandler.SearchVehicleType == null)
            {
                param = new ReportParameter("vehicleType", new string[] { null }, false);
                return param;
            }
            else
            {
                param = new ReportParameter("vehicleType", SessionHandler.SearchVehicleType);
                return param;
            }
        }

        private ReportParameter InvoiceFrom()
        {
            if (SessionHandler.SearchInvoiceFrom == null)
            {
                param = new ReportParameter("invoiceFrom", new string[] { null }, false);
            return param;
            }
            else
            {
                param = new ReportParameter("invoiceFrom", SessionHandler.SearchInvoiceFrom.ToString());
                return param;
            }
            
        }

        private ReportParameter InvoiceTo()
        {
            if (SessionHandler.SearchInvoiceTo == null)
            {
                param = new ReportParameter("invoiceTo", new string[] { null }, false);
                return param;
            }
            else
            {
                param = new ReportParameter("invoiceTo", SessionHandler.SearchInvoiceTo.ToString());
                return param;
            }
            
        }

        private ReportParameter DateFrom()
        {
            if (SessionHandler.SearchDateFrom == null)
            {
                param = new ReportParameter("dateFrom", new string[] { null }, false);
                return param;
            }
            else
            {
                param = new ReportParameter("dateFrom", SessionHandler.SearchDateFrom);
                return param;
            }
        }

        private ReportParameter DateTo()
        {
            if (SessionHandler.SearchDateTo == null)
            {
                param = new ReportParameter("dateTo", new string[] { null }, false);
                return param;
            }
            else
            {
                param = new ReportParameter("dateTo", SessionHandler.SearchDateTo);
                return param;
            }
        }

        private ReportParameter Type()
        {
            param = new ReportParameter("type", "1");
            return param;
        }

        private ReportParameter FileDate()
        {
            if (SessionHandler.SearchFileDate == null)
            {
                param = new ReportParameter("fileDate", new string[] { null }, false);
                return param;
            }
            else
            {
                param = new ReportParameter("fileDate", SessionHandler.SearchFileDate);
                return param;
            }
        }

        private ReportParameter InvoiceMode()
        {
            if (SessionHandler.SearchInvoiceMode == null)
            {
                param = new ReportParameter("invoiceMode", new string[] { null }, false);
                return param;
            }
            else
            {
                param = new ReportParameter("invoiceMode", SessionHandler.SearchInvoiceMode);
                return param;
            }
        
        }

        private ReportParameter FreeFormatText()
        {
            if (SessionHandler.SearchFreeFormatText == null)
            {
                param = new ReportParameter("freeFormatText", new string[] { null }, false);
                return param;
            }
            else
            {
                param = new ReportParameter("freeFormatText", SessionHandler.SearchFreeFormatText);
                return param;
            }

        }


        private string ReportName()
        {
            string reportName;
            switch (SessionHandler.SearchFormCountryId.ToString())
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

        private string ReportNameManual()
        {
            return "InvoiceManual";
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
            viewer.ServerReport.SetParameters(new ReportParameter[] { CountryId(), CompanyId(), BuyerId(), DocumentType(), DocumentSubType(), DocItemId(), Serial(), Plate(), Unit(), BuyerCode(), BuyerName(), Manufacturer(), VehicleType(), InvoiceFrom(), InvoiceTo(), DateFrom(), DateTo(), Type(), FileDate(), InvoiceMode(), FreeFormatText() });
            viewer.ServerReport.Refresh();

            byte[] bytes = viewer.ServerReport.Render("PDF", null, out mimeType, out encoding, out extension, out streamIds, out warnings);

            // Now that you have all the bytes representing the PDF report, buffer it and send it to the client.
            fileName = "PDFFile";
            extension = "pdf";
            Response.Buffer = true;
            Response.Clear();
            Response.ContentType = "Application/pdf";
            Response.AddHeader("content-disposition", "attachment; filename=" + fileName + "." + extension);
            Response.BinaryWrite(bytes); // create the file
            Response.Flush(); // send it to the client to download

        }

        private void CreatePDFTransport()
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
            viewer.ServerReport.SetParameters(new ReportParameter[] { CountryId(), CompanyId(), BuyerId(), DocumentType(), DocumentSubType(), DocItemId(), Serial(), Plate(), Unit(), BuyerCode(), BuyerName(), Manufacturer(), VehicleType(), InvoiceFrom(), InvoiceTo(), DateFrom(), DateTo(), Type() });
            viewer.ServerReport.Refresh();
            
            byte[] bytes = viewer.ServerReport.Render("PDF", null, out mimeType, out encoding, out extension, out streamIds, out warnings);
            // Now that you have all the bytes representing the PDF report, buffer it and send it to the client.
            fileName = "PDFNetherlandsTransport";
            extension = "pdf";
            Response.Buffer = true;
            Response.Clear();
            Response.ContentType = "Application/pdf";
            Response.AddHeader("content-disposition", "attachment; filename=" + fileName + "." + extension);
            Response.BinaryWrite(bytes); // create the file
            Response.Flush(); // send it to the client to download
        }

        #endregion

        #region "Send Email"

        private void ClearAttachments()
        {
            string attachmentpath = Server.MapPath("~/App_Files/EmailAttachments/");
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
            //viewer.ServerReport.ReportServerUrl = new System.Uri("http://hescrad2/ReportServer");
            viewer.ServerReport.ReportServerUrl = new System.Uri(APP.Properties.Settings.Default.ReportServerRadReports);
            viewer.ServerReport.ReportPath = reportPath;
            viewer.ServerReport.SetParameters(new ReportParameter[] { CountryId(), CompanyId(), BuyerId(), DocumentType(), DocumentSubType(), DocItemId(), Serial(), Plate(), Unit(), BuyerCode(), BuyerName(), Manufacturer(), VehicleType(), InvoiceFrom(), InvoiceTo(), DateFrom(), DateTo() });
            viewer.ServerReport.Refresh();
            byte[] bytes = viewer.ServerReport.Render("PDF", null, out mimeType, out encoding, out extension, out streamIds, out warnings);
            string attachmentpath = Server.MapPath("~/App_Files/EmailAttachments/");
            fileName = "InvoicesPDF.pdf";
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
            viewer.ServerReport.SetParameters(new ReportParameter[] { CountryId(), CompanyId(), BuyerId(), DocumentType(), DocumentSubType(), DocItemId(), Serial(), Plate(), Unit(), BuyerCode(), BuyerName(), Manufacturer(), VehicleType(), InvoiceFrom(), InvoiceTo(), DateFrom(), DateTo(), Type() });
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