using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.IO;
using System.Web;
using System.Web.UI.WebControls;
using AjaxControlToolkit;
using APP.Base;
using APP.Data;
using APP.Events;
using APP.Session;
using RAD.Common;
using RAD.Data;
using RAD.Diagnostics;
using RAD.Controls;
using RAD.IO;

namespace APP.App_UserControls.Reports.OutputFileSpain
{
    public partial class FileSpain : UserControlBase
    {

        protected override void OnPreRender(EventArgs e)
        {
            FileManager.AddMultiPart();
        }

        public void LoadData(bool isRefreshed)
        {
            if (isRefreshed)
            {
                string ButtonText = "La Caixa";
                string ButtonImageUrl = "~/App_Images/IcoLaCaixa.png";
                string url = @"http://www.catalunyacaixa.com/Portal/es/Empresas";
                LinkLaCaixa.Attributes.Add("target", "_blank");
                LinkLaCaixa.Attributes.Add("href", url);
                this.LinkLaCaixa.Text = @"<img src='" + (this.Page.ResolveUrl(ButtonImageUrl)) + "' class='image-CommandButton'>   " + ButtonText;


                string ButtonText2 = "Agencia Tributaria";
                string ButtonImageUrl2 = "~/App_Images/IcoAgencia.png";
                string url2 = @"https://www.agenciatributaria.gob.es/AEAT.sede/tramitacion/G502.shtml";
                LinkAgencia.Attributes.Add("target", "_blank");
                LinkAgencia.Attributes.Add("href", url2);
                this.LinkAgencia.Text = @"<img src='" + (this.Page.ResolveUrl(ButtonImageUrl2)) + "' class='image-CommandButton'>   " + ButtonText2;


                SessionHandler.TaxFileDate = APP.Settings.ReportSettings.GetLastDateTaxFileReport();
                txtReportFileDate.Text = SessionHandler.TaxFileDate;
                SessionHandler.SPSelectedCompany = "11";

                LoadManufacturer();

                SessionHandler.SPTaxFilter = "1";

                FilterEvents e = new FilterEvents();
                SessionHandler.ApplicationTaxFileFilter = e;
                this.LoadControlData(null, e, null, null, null);

            }
        }

        public void LoadControlData(object sender, FilterEvents e, int? currentPage, int? pageSize, string sortExpression)
        {
            var results = new List<APP.Reports.TaxOverView>();
            if (sortExpression == null)
            {
                this.ListViewTaxFile.ColumnSortExpression = null;
                this.ListViewTaxFile.ColumnIndexSorted = null;
            }

            results = APP.Reports.TaxOverView.SelectTaxFileOverView(currentPage, pageSize, sortExpression);

            if (results.Count >= 1)
            {
                //Set Pager details
                this.ListViewPager.SetPagerDetails(results[0].Count, ((currentPage == null || currentPage == 1) ? true : false));

                this.ListViewTaxFile.DataSource = results;
                this.ListViewTaxFile.DataBind();

                Templates.SetListViewDataTemplate(this.PlaceHolderData, this.PlaceHolderNoData, true);
            }
            else
            {
                this.ListViewPager.SetPagerDetails(0, true);
                this.ListViewTaxFile.DataSource = results;
                this.ListViewTaxFile.DataBind();
                Templates.SetListViewDataTemplate(this.PlaceHolderData, this.PlaceHolderNoData, true);
            }

            this.UpdatePanelTextSpain.Update();
        
        }

        protected void ListView_Sorting(object sender, ListViewSortEventArgs e)
        {
            //Get a reference to the listview
            RAD.Controls.ListView listView = (RAD.Controls.ListView)sender;

            //Get the pager event args
            RAD.Events.PagerEventArgs args = this.ListViewPager.GetPagerEventArgs();

            //Get the filter event args
            FilterEvents filterEventArgs = SessionHandler.ApplicationTaxFileFilter;

            //Load the data based on users selection
            this.LoadControlData(sender, filterEventArgs, args.CurrentPageNumber, args.PageSize, listView.ColumnSortExpression);
        
        }

        protected void OnPager_Command(object sender, RAD.Events.PagerEventArgs e)
        {
            this.LoadControlData(sender, SessionHandler.ApplicationTaxFileFilter, (int?)e.CurrentPageNumber, (int?)e.PageSize, this.ListViewTaxFile.ColumnSortExpression);
        }

        protected void OnCommand(object sender, CommandEventArgs e)
        {
            if (e.CommandName == "Filter")
            {
                if (DropDownListBuyers.SelectedIndex == 0)
                {
                    LoadManufacturer();
                }
                
                SetSearchSessions();

                FilterEvents filterEventArgs = SessionHandler.ApplicationTaxFileFilter;
                this.LoadControlData(null, filterEventArgs, null, null, null);
                
            }
            else if (e.CommandName == "ExportFile")
            {
                //SetSearchSessions();
                string option = DropDownListFileType.SelectedValue;
                switch (option)
                { 
                    case "1":
                        //NRC Bank
                        CreateNRC();
                        break;
                    case "2":
                        //AEAT
                         CreateAEAT();
                        break;
                    case "3":
                        //NRC
                        CreateNRCTax();
                        break;
                }
                this.UpdatePanelTextSpain.Update();
            }
        }

        private void SetSearchSessions()
        {
            if (txtReportFileDate.Text == String.Empty)
            {
                SessionHandler.TaxFileDate = null;
            }
            else
            {
                SessionHandler.TaxFileDate = txtReportFileDate.Text;
            }

            if (TextBoxInvoiceFrom.Text == String.Empty)
            {
                SessionHandler.SPSaleDocumentNumberFrom = null;
            }
            else
            {
                SessionHandler.SPSaleDocumentNumberFrom = TextBoxInvoiceFrom.Text;
            }

            if (TextBoxInvoiceTo.Text == String.Empty)
            {
                SessionHandler.SPSaleDocumentNumberTo = null;
            }
            else
            {
                SessionHandler.SPSaleDocumentNumberTo = TextBoxInvoiceTo.Text;
            }

            SessionHandler.SPTaxFilter = DropDownListInvoiceType.SelectedValue;
            SessionHandler.SPMileageFilter = DropDownListMileage.SelectedValue;
            SessionHandler.SPSaleDateFilter = DropDownListMonths.SelectedValue;
            SessionHandler.SPManufacturerFilter = DropDownListBuyers.SelectedValue;

        }

        private void filedelete(string path)
        {
            string[] st;
            st = Directory.GetFiles(path);
            int i;
            string filenamepart = String.Empty;
            for (i = 0; i < st.Length; i++)
            {
                filenamepart = Path.GetFileNameWithoutExtension(st[i]).Substring(0, 3);
                if (filenamepart == "NRC")
                {
                    File.Delete(st.GetValue(i).ToString());
                }
            }
        }

        private void LoadManufacturer()
        {
            DropDownListBuyers.DataSource = null;
            DropDownListBuyers.Items.Clear();
            DropDownListBuyers.Items.Add("ALL");
            var manufacturer = new List<APP.Search.BuyerName>();
            manufacturer = APP.Search.BuyerName.SelectBuyersTax();
            DropDownListBuyers.DataSource = manufacturer;
            DropDownListBuyers.DataTextField = "VendorName";
            DropDownListBuyers.DataValueField = "VendorName";
            DropDownListBuyers.DataBind();
            DropDownListBuyers.SelectedIndex = 0;


        }

        
        #region "NRC Bank"

        private void CreateNRC()
        {
            try
            {
                DateTime datefile = DateTime.Now;
                string year = datefile.Year.ToString();
                string day = datefile.Day.ToString();
                string month = datefile.Month.ToString();
                string hour = datefile.Hour.ToString();
                string minute = datefile.Minute.ToString();
                string second = datefile.Second.ToString();

                string filename = "NRC_" + year + month + day + "_" + hour + "_" + minute + "_" + second + ".txt";

                //GetFormValues();

                DataTable dt = new DataTable();
                SqlDataAdapter da = new SqlDataAdapter();

                SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = ConnectionManager.CreateProcedure(StoredProcedures.TaxFileNRCBank, con);

                RAD.Data.Parameters.CreateParameter(cmd, "@fileDate", SessionHandler.TaxFileDate);
                RAD.Data.Parameters.CreateParameter(cmd, "@InvoiceFrom", SessionHandler.SPSaleDocumentNumberFrom);
                RAD.Data.Parameters.CreateParameter(cmd, "@invoiceTo", SessionHandler.SPSaleDocumentNumberTo);
                RAD.Data.Parameters.CreateParameter(cmd, "@taxFilter", SessionHandler.SPTaxFilter);
                RAD.Data.Parameters.CreateParameter(cmd, "@mileage", SessionHandler.SPMileageFilter);
                RAD.Data.Parameters.CreateParameter(cmd, "@saleDate", SessionHandler.SPSaleDateFilter);
                RAD.Data.Parameters.CreateParameter(cmd, "@manufacturerName", SessionHandler.SPManufacturerFilter);



                using (con)
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    da.SelectCommand = cmd;
                    da.Fill(dt);
                }
                con.Close();

                filedelete(Server.MapPath("~/App_Files/"));
                string nrcpath = Server.MapPath("~/App_Files/" + filename);

                StreamWriter w = new StreamWriter(File.Create(nrcpath), System.Text.Encoding.ASCII);


                foreach (DataRow dr in dt.Rows)
                {
                    if (dr[0].ToString() != String.Empty)
                    {
                        w.WriteLine(dr[0].ToString());
                    }
                }

                w.Flush();
                w.Close();


                FileInfo OutFile = new FileInfo(nrcpath);

                Response.ClearContent();
                Response.AddHeader("Content-Disposition", "attachment; filename=" + OutFile.Name);
                Response.AddHeader("Content-Length", OutFile.Length.ToString());
                Response.ContentType = "text/plain";
                Response.TransmitFile(OutFile.FullName);
                Response.End();

            }
            catch (Exception ex)
            {
                StackTrace errorStackTrace = new StackTrace(true);
                Logs.LogError(errorStackTrace, ex);
            }
        }

        #endregion

        #region "AEAT"

        private void CreateAEAT()
        {
            DataTable dt = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter();
            SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
            SqlCommand cmd = ConnectionManager.CreateProcedure(StoredProcedures.TaxFileAEATOutput, con);
           
            RAD.Data.Parameters.CreateParameter(cmd, "@fileDate", SessionHandler.TaxFileDate);
            RAD.Data.Parameters.CreateParameter(cmd, "@InvoiceFrom", SessionHandler.SPSaleDocumentNumberFrom);
            RAD.Data.Parameters.CreateParameter(cmd, "@invoiceTo", SessionHandler.SPSaleDocumentNumberTo);
            RAD.Data.Parameters.CreateParameter(cmd, "@taxFilter", SessionHandler.SPTaxFilter);
            RAD.Data.Parameters.CreateParameter(cmd, "@mileage", SessionHandler.SPMileageFilter);
            RAD.Data.Parameters.CreateParameter(cmd, "@saleDate", SessionHandler.SPSaleDateFilter);
            RAD.Data.Parameters.CreateParameter(cmd, "@manufacturerName", SessionHandler.SPManufacturerFilter);
            RAD.Data.Parameters.CreateParameter(cmd, "@aeatType", SessionHandler.SPTaxFilter);

            using (con)
            {
                con.Open();
                cmd.ExecuteNonQuery();
                da.SelectCommand = cmd;
                da.Fill(dt);
            }
            con.Close();
            string aeatpath = Server.MapPath("~/App_Files/AEAT.txt");

            StreamWriter w = new StreamWriter(File.Create(aeatpath), System.Text.Encoding.ASCII);

        
            foreach (DataRow dr in dt.Rows)
            {
                if (dr[0].ToString() != String.Empty)
                {
                    w.WriteLine(dr[0].ToString());
                }
            }
            w.Flush();
            w.Close();


            FileInfo OutFile = new FileInfo(aeatpath);

            Response.ClearContent();
            Response.AddHeader("Content-Disposition", "attachment; filename=" + OutFile.Name);
            Response.AddHeader("Content-Length", OutFile.Length.ToString());
            Response.ContentType = "text/plain";
            Response.TransmitFile(OutFile.FullName);
            Response.End();

        }

        #endregion

        #region "NRC Tax"

        private void CreateNRCTax()
        {
            DataTable dt = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter();

            SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
            SqlCommand cmd = ConnectionManager.CreateProcedure(StoredProcedures.TaxFileNRCOutput, con);

            RAD.Data.Parameters.CreateParameter(cmd, "@fileDate", SessionHandler.TaxFileDate);
            RAD.Data.Parameters.CreateParameter(cmd, "@InvoiceFrom", SessionHandler.SPSaleDocumentNumberFrom);
            RAD.Data.Parameters.CreateParameter(cmd, "@invoiceTo", SessionHandler.SPSaleDocumentNumberTo);
            RAD.Data.Parameters.CreateParameter(cmd, "@taxFilter", SessionHandler.SPTaxFilter);
            RAD.Data.Parameters.CreateParameter(cmd, "@mileage", SessionHandler.SPMileageFilter);
            RAD.Data.Parameters.CreateParameter(cmd, "@saleDate", SessionHandler.SPSaleDateFilter);
            RAD.Data.Parameters.CreateParameter(cmd, "@manufacturerName", SessionHandler.SPManufacturerFilter);
            RAD.Data.Parameters.CreateParameter(cmd, "@nrcType", SessionHandler.SPTaxFilter);

            using (con)
            {
                con.Open();
                cmd.ExecuteNonQuery();
                da.SelectCommand = cmd;
                da.Fill(dt);
            }
            con.Close();
            
            string nrcpath = Server.MapPath("~/App_Files/NRC.txt");

            StreamWriter w = new StreamWriter(File.Create(nrcpath), System.Text.Encoding.ASCII);

            foreach (DataRow dr in dt.Rows)
            {
                if (dr[0].ToString() != String.Empty)
                {
                    w.WriteLine(dr[0].ToString());
                }
            }
            w.Flush();
            w.Close();

            FileInfo OutFile = new FileInfo(nrcpath);

            Response.Buffer = true;
            Response.ClearContent();
            Response.AddHeader("Content-Disposition", "attachment; filename=" + OutFile.Name);
            Response.AddHeader("Content-Length", OutFile.Length.ToString());
            Response.ContentType = "text/plain";
            Response.TransmitFile(OutFile.FullName);
            Response.End();


        }

        #endregion

    }
}