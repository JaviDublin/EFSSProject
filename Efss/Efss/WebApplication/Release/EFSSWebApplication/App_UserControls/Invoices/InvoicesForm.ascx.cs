using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
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


namespace APP.App_UserControls.Payables
{
    public partial class InvoicesForm : UserControlBase
    {
        string countryName;
        private ArrayList parameters;
        private ArrayList values;
        private string procedure;
        private int _documentId;

        protected override void OnPreRender(EventArgs e)
        {
            if (this.Visible)
            {
                this.ListViewPager.PagerProgress.AssociatedUpdatePanelID = this.UpdatePanelListView.ID;
            }
            base.OnPreRender(e);
        }

        public int DocumentId
        {
            get { return _documentId; }
            set { _documentId = value; }
        }

        public void LoadControlData()
        {
            Page.Form.Attributes.Add("enctype", "multipart/form-data");
            
            TextBoxDatePicker.Text = DateTime.Now.ToShortDateString();

            if (Request.Form["hid_f"] == "1")
            {
                Request.Form["hid_f"].Replace("1", "0");   //Reset the hidden field back to original value "0"
            }

            DropDownListInvoiceType.DataSource = DocumentsSubTypes.SelectDocSubType(1).Select(s => s.DocumentSubType);
            DropDownListInvoiceType.DataBind();
            DropDownListDocumentType.DataSource = DocumentTypes.SelectDocType(1).Select(d => d.DocumentType);
            DropDownListDocumentType.DataBind();
            DropDownListCountries.DataSource = SearchCountries.SelectCountries().OrderBy(m => m.CountryName).Select(m => m.CountryName);
            DropDownListCountries.DataBind();
            LoadCompanies();
            LoadTaxCodes();
            LoadBuyers();
            LoadManufacturer();
            LoadAddress();

            LoadDataSerials(true);
        }

        public void LoadCompanies()
        {
            countryName = DropDownListCountries.Text;
            DropDownListCompanies.DataSource = SearchCompanies.SelectCompaniesByCountry(countryName).OrderBy(c => c.CompanyType).Select(c => c.CompanyName);
            DropDownListCompanies.DataBind();
            SetApplicationSessions();
        }

        public void LoadTaxCodes()
        {
            DropDownListTaxCode.DataSource = null;
            DropDownListTaxCode.Items.Clear();
            var taxcode = new List<APP.Search.SearchTaxCode>();
            taxcode = APP.Search.SearchTaxCode.SelectTaxCodes(Convert.ToInt32(SessionHandler.ApplicationCountryId));
            DropDownListTaxCode.DataSource = taxcode;
            DropDownListTaxCode.DataTextField = "TaxCode";
            DropDownListTaxCode.DataValueField = "TaxCodeId";
            DropDownListTaxCode.DataBind();
            //DropDownListTaxCode.SelectedIndex = 0;
        }

        public void LoadBuyers()
        {
            DropDownListBuyers.DataSource = null;
            DropDownListBuyers.Items.Clear();
            var buyer = new List<APP.Search.BuyerCodeName>();
            buyer = APP.Search.BuyerCodeName.SelectBuyers(Convert.ToInt32(SessionHandler.ApplicationCountryId), Convert.ToInt32(SessionHandler.ApplicationCompanyId));
            DropDownListBuyers.DataSource = buyer;
            DropDownListBuyers.DataTextField = "BuyerName";
            DropDownListBuyers.DataValueField = "BuyerCode";
            DropDownListBuyers.DataBind();
            //DropDownListBuyers.SelectedIndex = 0;
        
        }

        public void LoadManufacturer()
        {
            DropDownListManufacturerCode.DataSource = null;
            DropDownListManufacturerCode.Items.Clear();
            var manufacturer = new List<APP.Search.BuyerMFG>();
            manufacturer = APP.Search.BuyerMFG.GetManufacturerCode(Convert.ToInt32(SessionHandler.ApplicationCountryId), Convert.ToInt32(SessionHandler.ApplicationCompanyId), DropDownListBuyers.SelectedValue);
            DropDownListManufacturerCode.DataSource = manufacturer;
            DropDownListManufacturerCode.DataTextField = "ManufacturerCode";
            DropDownListManufacturerCode.DataValueField = "ManufacturerCode";
            DropDownListManufacturerCode.DataBind();
        }

        public void LoadAddress()
        {
            DropDownListAddress.DataSource = null;
            DropDownListAddress.Items.Clear();
            var address = new List<APP.Search.BuyerMFGAddr>();
            address = APP.Search.BuyerMFGAddr.GetAddress(Convert.ToInt32(SessionHandler.ApplicationCountryId), Convert.ToInt32(SessionHandler.ApplicationCompanyId), DropDownListBuyers.SelectedValue, DropDownListManufacturerCode.SelectedValue);
            DropDownListAddress.DataSource = address;
            DropDownListAddress.DataTextField = "BuyerAddress";
            DropDownListAddress.DataValueField = "BuyerAddress";
            DropDownListAddress.DataBind();
        }

        private void SetApplicationSessions()
        {
            SessionHandler.ApplicationCountryName = DropDownListCountries.Text;
            SessionHandler.ApplicationCountryId = ApplicationSettings.GetCountryId(SessionHandler.ApplicationCountryName);
            SessionHandler.ApplicationCompanyName = DropDownListCompanies.Text;
            SessionHandler.ApplicationCompanyId = ApplicationSettings.GetCompanyId(SessionHandler.ApplicationCompanyName);
        }

        protected void DropDownListCountries_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadCompanies();
            LoadTaxCodes();
            LoadBuyers();
            LoadManufacturer();
            LoadAddress();
            this.UpdatePanelForm.Update();
        }

        protected void DropDownListCompanies_SelectedIndexChanged(object sender, System.EventArgs e)
        {
            LoadBuyers();
            LoadManufacturer();
            LoadAddress();
            this.UpdatePanelForm.Update();
        }

        protected void DropDownListBuyers_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadManufacturer();
            LoadAddress();
            this.UpdatePanelForm.Update();
        }

        protected void DropDownListManufacturerCode_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadAddress();
            this.UpdatePanelForm.Update();
        }


        protected void OnCommand(object sender, CommandEventArgs e)
        {
            //if (e.CommandName == "Import")
            //{
            //    string filepath = APP.Properties.Settings.Default.ManualInvoicesPath;
            //    string fileServerPath = "~/App_Files/Serials.xlsx";
            //    if (File.Exists(filepath))
            //    {
            //        File.Delete(MapPath(fileServerPath));
            //        File.Copy(filepath, MapPath(fileServerPath));

            //        if (ReadExcelFile("Sheet1", MapPath(fileServerPath)).Tables[0].Rows.Count > 0)
            //        {
            //            TruncateSerials();
            //            foreach (DataRow dr in ReadExcelFile("Sheet1", MapPath(fileServerPath)).Tables[0].Rows)
            //            {
            //                UploadSerials(dr.ItemArray[0].ToString(), dr.ItemArray[1].ToString());
            //            }

            //            UpdateSerials();
            //            PlaceHolderData.Visible = true;
            //            LoadDataSerials(true);
            //        }
            //        else
            //        {
            //            ScriptManager.RegisterStartupScript(this.UpdatePanelForm, this.UpdatePanelForm.GetType(), "alertemptyfile", "alert('The file is empty.');", true);
            //        }
            //    }
            //}


            if (e.CommandName == "Save")
            {

                char[] delimiter = new char[] { ';' }; 
                string txtserials = TextBoxSerials.Text;
                string txtamounts = TextBoxAmounts.Text;

                string _txtserials = txtserials.Replace("\r\n", ";");
                string _txtamounts = txtamounts.Replace("\r\n", ";");

                string[] serials = _txtserials.Split(delimiter);
                string[] amounts = _txtamounts.Split(delimiter);


                if (serials.Length != amounts.Length)
                {
                    if (serials.Length > amounts.Length)
                    {
                        ScriptManager.RegisterStartupScript(this.UpdatePanelForm, this.UpdatePanelForm.GetType(), "alertserials", "alert('There are more Serials than Amounts.');", true);
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this.UpdatePanelForm, this.UpdatePanelForm.GetType(), "alertamounts", "alert('There are more Amounts than Serials.');", true);
                    }
                    
                }
                else
                {
                    CreateManualInvoiceDataTable();

                    for (int i = 0; i <= serials.Length - 1; i++)
                    {
                        AddManualInvoiceRows(i + 1, DropDownListCountries.SelectedItem.Text, DropDownListCompanies.SelectedItem.Text, DropDownListDocumentType.SelectedItem.Text,
                        DropDownListInvoiceType.SelectedItem.Text, TextBoxDatePicker.Text, DropDownListBuyers.SelectedValue, DropDownListBuyers.SelectedItem.Text,
                        serials[i].ToString(), amounts[i].ToString(), DropDownListTaxCode.SelectedItem.Text, TextBoxMessage.Text,
                        DropDownListManufacturerCode.SelectedValue,DropDownListAddress.SelectedValue);
                    }

                    TruncateTableManualInvoices();

                    UploadTableManualInvoices();

                    ParseManualInvoices();

                    LoadDataSerials(true);

                }


                //if (hasDuplicates())
                //{
                //    ScriptManager.RegisterStartupScript(this.UpdatePanelForm, this.UpdatePanelForm.GetType(), "alertduplicates", "alert('The file contains Duplicates.');", true);
                //}
                //else
                //{
                //    if (isValid())
                //    {
                //        CreateDocument(SessionHandler.AuthenticationRacfId);
                //        ScriptManager.RegisterStartupScript(this.UpdatePanelForm, this.UpdatePanelForm.GetType(), "alertdone", "alert('Invoice Created.');", true);
                //    }
                //    else
                //    {
                //        ScriptManager.RegisterStartupScript(this.UpdatePanelForm, this.UpdatePanelForm.GetType(), "alertvalid", "alert('Please, check the information entered.');", true);
                //    }
                //}
            }
            else if (e.CommandName == "Export")
            {
                //CreateJournal();
                ExcelJournal();
            }
            else if (e.CommandName == "ExportPDF")
            {
                CreatePDF();
            }
          
        }

        #region "Create Manual Invoice DataTable"

        private static System.Data.DataTable ManualInvoice;

        public void CreateManualInvoiceDataTable()
        {
            ManualInvoice = new System.Data.DataTable();
            
            System.Data.DataColumn dc;
            
            dc = new DataColumn();
            dc.ColumnName = "Id";
            dc.DataType = System.Type.GetType("System.Int16");
            ManualInvoice.Columns.Add(dc);

            dc = new DataColumn();
            dc.ColumnName = "CountryName";
            dc.DataType = System.Type.GetType("System.String");
            ManualInvoice.Columns.Add(dc);

            dc = new DataColumn();
            dc.ColumnName = "CompanyName";
            dc.DataType = System.Type.GetType("System.String");
            ManualInvoice.Columns.Add(dc);

            dc = new DataColumn();
            dc.ColumnName = "DocumentType";
            dc.DataType = System.Type.GetType("System.String");
            ManualInvoice.Columns.Add(dc);

            dc = new DataColumn();
            dc.ColumnName = "InvoiceType";
            dc.DataType = System.Type.GetType("System.String");
            ManualInvoice.Columns.Add(dc);

            dc = new DataColumn();
            dc.ColumnName = "InvoiceDate";
            dc.DataType = System.Type.GetType("System.String");
            ManualInvoice.Columns.Add(dc);

            dc = new DataColumn();
            dc.ColumnName = "BuyerCode";
            dc.DataType = System.Type.GetType("System.String");
            ManualInvoice.Columns.Add(dc);

            dc = new DataColumn();
            dc.ColumnName = "BuyerName";
            dc.DataType = System.Type.GetType("System.String");
            ManualInvoice.Columns.Add(dc);

            dc = new DataColumn();
            dc.ColumnName = "Serial";
            dc.DataType = System.Type.GetType("System.String");
            ManualInvoice.Columns.Add(dc);

            dc = new DataColumn();
            dc.ColumnName = "Amount";
            dc.DataType = System.Type.GetType("System.String");
            ManualInvoice.Columns.Add(dc);

            dc = new DataColumn();
            dc.ColumnName = "TaxCode";
            dc.DataType = System.Type.GetType("System.String");
            ManualInvoice.Columns.Add(dc);


            dc = new DataColumn();
            dc.ColumnName = "DescriptionName";
            dc.DataType = System.Type.GetType("System.String");
            ManualInvoice.Columns.Add(dc);

            dc = new DataColumn();
            dc.ColumnName = "ManufactuerCode";
            dc.DataType = System.Type.GetType("System.String");
            ManualInvoice.Columns.Add(dc);

            dc = new DataColumn();
            dc.ColumnName = "Address";
            dc.DataType = System.Type.GetType("System.String");
            ManualInvoice.Columns.Add(dc);
        
        
        }

        public void AddManualInvoiceRows(int id,string country,string company,string documenttype,string invoicetype,string invoicedate,string buyercode,
            string buyername,string serial,string amount,string taxcode,string message,string manufacturerCode , string address)
        {
            DataRow dr;
            dr = ManualInvoice.NewRow();
            dr["id"] = id;
            dr["CountryName"] = country;
            dr["CompanyName"] = company;
            dr["DocumentType"] = documenttype;
            dr["InvoiceType"] = invoicetype;
            dr["InvoiceDate"] = invoicedate;
            dr["BuyerCode"] = buyercode;
            dr["BuyerName"] = buyername;
            dr["Serial"] = serial;
            dr["Amount"] = amount;
            dr["TaxCode"] = taxcode;
            dr["DescriptionName"] = message;

            dr["ManufactuerCode"] = manufacturerCode;
            dr["Address"] = address;

            ManualInvoice.Rows.Add(dr);

        }


        public void TruncateTableManualInvoices()
        {
            try
            {
                SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = ConnectionManager.CreateProcedure(StoredProcedures.TruncateTableImportManualInvoices, con);
                ConnectionManager.ExecuteCommandNonQuery(con, cmd);
            }
            catch (Exception ex)
            {
                StackTrace errorStackTrace = new StackTrace(true);
                Logs.LogError(errorStackTrace, ex);
            }
        }

        public void UploadTableManualInvoices()
        {
            try
            {
                
                foreach (DataRow dr in ManualInvoice.Rows)
                {
                    UploadParameters(dr["CountryName"].ToString(), dr["CompanyName"].ToString(), dr["DocumentType"].ToString(), dr["InvoiceType"].ToString(),
                        dr["InvoiceDate"].ToString(), dr["BuyerCode"].ToString(), dr["BuyerName"].ToString(), dr["Serial"].ToString(), dr["Amount"].ToString(),
                        dr["TaxCode"].ToString(), dr["DescriptionName"].ToString(), dr["ManufactuerCode"].ToString(), dr["Address"].ToString());                    
                }
            }
            catch (Exception ex)
            {
                StackTrace errorStackTrace = new StackTrace(true);
                Logs.LogError(errorStackTrace, ex);
            }
        }

        public void UploadParameters(string country, string company, string documenttype, string invoicetype, string invoicedate, string buyercode,
            string buyername, string serial, string amount, string taxcode, string message,string manufacturerCode,string address)
        {
            SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
            SqlCommand cmd = ConnectionManager.CreateProcedure(StoredProcedures.UploadTableImportManualInvoices, con);

            RAD.Data.Parameters.CreateParameter(cmd, "@CountryName", country);
            RAD.Data.Parameters.CreateParameter(cmd, "@CompanyName", company);
            RAD.Data.Parameters.CreateParameter(cmd, "@DocumentType", documenttype);
            RAD.Data.Parameters.CreateParameter(cmd, "@InvoiceType", invoicetype);
            RAD.Data.Parameters.CreateParameter(cmd, "@InvoiceDate", invoicedate);
            RAD.Data.Parameters.CreateParameter(cmd, "@BuyerName", buyername);
            RAD.Data.Parameters.CreateParameter(cmd, "@BuyerCode", buyercode);
            RAD.Data.Parameters.CreateParameter(cmd, "@Serial", serial);
            RAD.Data.Parameters.CreateParameter(cmd, "@Amount", amount);
            RAD.Data.Parameters.CreateParameter(cmd, "@TaxCode", taxcode);
            RAD.Data.Parameters.CreateParameter(cmd, "@DescriptionName", message);

            RAD.Data.Parameters.CreateParameter(cmd, "@manufacturerCode", manufacturerCode);
            RAD.Data.Parameters.CreateParameter(cmd, "@address", address);

            ConnectionManager.ExecuteCommandNonQuery(con, cmd);
        }


        public void ParseManualInvoices()
        {
            try
            {
                SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = ConnectionManager.CreateProcedure(StoredProcedures.ManualInvoicesParse, con);
                ConnectionManager.ExecuteCommandNonQuery(con, cmd);
            }
            catch (Exception ex)
            {
                StackTrace errorStackTrace = new StackTrace(true);
                Logs.LogError(errorStackTrace, ex);
            }
        
        }

        #endregion


        #region "Add Invoice"

        private void CreateDocument(string racfId)
        {
            DBAgent createDoc;
            procedure = StoredProcedures.CreateManualDocument;
            parameters = new ArrayList();
            values = new ArrayList();
            parameters.Add("@racfId");
            values.Add(racfId);
            createDoc = new DBAgent(procedure, parameters, values);
            DocumentId = createDoc.ExecuteQueryWithReturnId();
            parameters.Clear();
            values.Clear();
            createDoc = null;

            DBAgent createItem;
            procedure = StoredProcedures.CreateManualItems;
            parameters = new ArrayList();
            values = new ArrayList();
            parameters.Add("@documentId");
            values.Add(DocumentId.ToString());
            createItem = new DBAgent(procedure, parameters, values);
            createItem.ExecuteQuery();
            parameters.Clear();
            values.Clear();
            createItem = null;
        }

        public bool hasDuplicates()
        {
            int result;
            DBAgent checkDup = new DBAgent(StoredProcedures.CheckManualDuplicates);
            result = checkDup.ExecuteQueryWithReturnId();

            // Count the records with the value "IsDuplicate" = 1. If 0, there are no Duplicates => has Duplicates = false
            if (result == 0)
            {
                return false;
            }
            else
            {
                return true;
            }
        }

        public bool isValid()
        {
            int result;
            DBAgent checkValid = new DBAgent(StoredProcedures.CheckManualDuplicates);
            result = checkValid.ExecuteQueryWithReturnId();
            // Count the records with the value "IsValid" = 0. If 0, all the records are valid.
            if (result == 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        #endregion

        #region "List View Serials"

        public void LoadDataSerials(bool isRefreshed)
        {
            if (isRefreshed)
            {
                FilterEvents e = new FilterEvents();
                SessionHandler.ManualInvoicesSerialFilters = e;
                this.LoadControlDataSerials(null, e, null, null, null);
            }
        }

        public void LoadControlDataSerials(object sender, FilterEvents e, int? currentPage, int? pageSize, string sortExpression)
        {

            var results = new List<APP.Search.SerialsOverView>();

            //Check to see if sort expression has to be reset
            if (sortExpression == null)
            {
                this.ListViewSerialsOverView.ColumnSortExpression = null;
                this.ListViewSerialsOverView.ColumnIndexSorted = null;
            }
            results = APP.Search.SerialsOverView.SelectSerialsOverView(currentPage, pageSize, sortExpression);

            if (results.Count >= 1)
            {
                this.ListViewPager.SetPagerDetails(results[0].Count, ((currentPage == null || currentPage == 1) ? true : false));
                this.ListViewSerialsOverView.DataSource = results;
                this.ListViewSerialsOverView.DataBind();
                Templates.SetListViewDataTemplate(this.PlaceHolderData, this.PlaceHolderNoData, true);
            }
            else
            {
                this.ListViewPager.SetPagerDetails(0, true);
                this.ListViewSerialsOverView.DataSource = results;
                this.ListViewSerialsOverView.DataBind();
                Templates.SetListViewDataTemplate(this.PlaceHolderData, this.PlaceHolderNoData, true);
            }

            this.UpdatePanelListView.Update();
        }

        protected void ListView_Sorting(object sender, ListViewSortEventArgs e)
        {
            RAD.Controls.ListView listView = (RAD.Controls.ListView)sender;
            RAD.Events.PagerEventArgs args = this.ListViewPager.GetPagerEventArgs();
            FilterEvents filterEventArgs = SessionHandler.ManualInvoicesSerialFilters;
            this.LoadControlDataSerials(sender, filterEventArgs, args.CurrentPageNumber, args.PageSize, listView.ColumnSortExpression);

        }

        protected void OnPager_Command(object sender, RAD.Events.PagerEventArgs e)
        {
            this.LoadControlDataSerials(sender, SessionHandler.ManualInvoicesSerialFilters, (int?)e.CurrentPageNumber, (int?)e.PageSize, this.ListViewSerialsOverView.ColumnSortExpression);
        }

        #endregion

        #region "Export Journal"

        private void ExcelJournal()
        {
            GridView gv = new GridView();
            var results = new List<APP.Search.SalesManualInvoiceJournal>();

            results = APP.Search.SalesManualInvoiceJournal.GetJournal();

            if (results.Count >= 1)
            {
                gv.DataSource = results;
                gv.DataBind();
                Response.Clear();
                Response.Buffer = true;
                Response.ContentType = "application/vnd.ms-excel";
                Response.AddHeader("content-disposition", "attachment;filename=Journal.xls");
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
                Response.AddHeader("content-disposition", "attachment;filename=Journal.xls");
                Response.Charset = "";
                this.EnableViewState = false;
                System.IO.StringWriter sw = new System.IO.StringWriter();
                System.Web.UI.HtmlTextWriter htw = new System.Web.UI.HtmlTextWriter(sw);
                gv.RenderControl(htw);
                Response.Write(sw.ToString());
                Response.End();

            }
        
        }

        #endregion

        #region "Export To PDF"

        private void CreatePDF()
        {
            Warning[] warnings;
            string[] streamIds;
            string mimeType = string.Empty;
            string encoding = string.Empty;
            string extension = string.Empty;
            string fileName = string.Empty;

            string reportName = "InvoiceManual";
            string reportPath;
            reportPath = ApplicationSettings.GetReportFolderName() + reportName;

            ReportViewer viewer = new ReportViewer();
            viewer.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
            viewer.ServerReport.ReportServerUrl = new System.Uri(APP.Properties.Settings.Default.ReportServerRadReports);
            viewer.ServerReport.ReportPath = reportPath;
            viewer.ServerReport.Refresh();

            byte[] bytes = viewer.ServerReport.Render("PDF", null, out mimeType, out encoding, out extension, out streamIds, out warnings);

            fileName = "PDFFile";
            extension = "pdf";
            Response.Buffer = true;
            Response.Clear();
            Response.ContentType = "Application/pdf";
            Response.AddHeader("content-disposition", "attachment; filename=" + fileName + "." + extension);
            Response.BinaryWrite(bytes); // create the file
            Response.Flush(); // send it to the client to download
        }

        #endregion

       

        
    }
}