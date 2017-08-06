using System;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.IO;
using System.Web.UI.WebControls;
using APP.Base;
using APP.Data;
using APP.Session;
using RAD.Data;
using RAD.Diagnostics;

namespace APP.App_UserControls.Reports.OutputFileFrance
{
    public partial class FileFrance : UserControlBase
    {
        protected void OnCommand(object sender, CommandEventArgs e)
        {
            try
            {
                GetFormValues();

                DataTable dt = new DataTable();
                SqlDataAdapter da = new SqlDataAdapter();

                SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = ConnectionManager.CreateProcedure(StoredProcedures.ReportLtsc, con);
                RAD.Data.Parameters.CreateParameter(cmd, "@companyId", SessionHandler.FRSelectedCompany);
                RAD.Data.Parameters.CreateParameter(cmd, "@docType", SessionHandler.FRSelectedDocumentType);
                RAD.Data.Parameters.CreateParameter(cmd, "@docSubType", SessionHandler.FRSelectedDocumentSubType);
                RAD.Data.Parameters.CreateParameter(cmd, "@dateFrom", SessionHandler.FRSelectedInvoiceDateFrom);
                RAD.Data.Parameters.CreateParameter(cmd, "@dateTo", SessionHandler.FRSelectedInvoiceDateTo);
                RAD.Data.Parameters.CreateParameter(cmd, "@fileDate", SessionHandler.FRSelectedFileDate);

                using (con)
                {
                    con.Open();

                    cmd.ExecuteNonQuery();
                    da.SelectCommand = cmd;
                    da.Fill(dt);
                }
                con.Close();

                string ltscpath = Server.MapPath("~/App_Files/LTSC.txt");
                FileInfo ltsc = new FileInfo(ltscpath);
                if (ltsc.Exists)
                {
                    File.Delete(ltscpath);
                }
                StreamWriter w;
                w = File.CreateText(ltscpath);
                w.WriteLine("CountryCode;Unit;Serial;SaleDocNbr;VehTye;Saletype;InserviceDate;SaleDate;CapCost;DiffBvCapCost;BVHT;SalePriceTTC;MsoDate;MFGCode;PurchaserName;LastLoc;OwnerAreaCode;ModelYear;VisionModelCode;Moddesc;License;LstMlg;ExcessMileAge;MiscAditions;SaleInvNbr;SalePriceHT;SalePriceTVA;CodeVendeur;VisionPO;Energie;SaleProcessDate;AccountingMonthEnd;OutOfServiceDate;VehClass;DaysInService;AccountingMonthEnd2;ClientNb;AdresseAcheteur1;AdresseAcheteur2;AdresseAcheteur3;PaysExport;Taxe;marque;Date_prem_circ;GENRE;Carrosserie;Puissance;Rectification;TypeVente;DateFichier");

                foreach (DataRow dr in dt.Rows)
                {
                    if (dr[0].ToString() != String.Empty)
                    {
                        w.WriteLine(dr[0].ToString());
                    }
                }
                w.Flush();
                w.Close();

                Response.ClearContent();
                Response.AddHeader("Content-Disposition", "attachment; filename=" + ltsc.Name);
                Response.AddHeader("Content-Length", ltsc.Length.ToString());
                Response.ContentType = "text/plain";
                Response.TransmitFile(ltsc.FullName);
                Response.End();

                this.UpdatePanelTextFrance.Update();
            }
            catch (Exception ex)
            {
                StackTrace errorStackTrace = new StackTrace(true);
                Logs.LogError(errorStackTrace, ex);
            }
        }

        public void GetFormValues()
        {
            if (DropDownListCompanies.SelectedIndex == 0)
            {
                SessionHandler.FRSelectedCompany = null;
            }
            else
            {
                SessionHandler.FRSelectedCompany = DropDownListCompanies.SelectedValue.ToString();
            }

            if (DropDownListDocumentType.SelectedIndex == 0)
            {
                SessionHandler.FRSelectedDocumentType = null;
            }
            else
            {
                SessionHandler.FRSelectedDocumentType = DropDownListDocumentType.SelectedValue.ToString();
            }

            if (DropDownListSaleType.SelectedIndex == 0)
            {
                SessionHandler.FRSelectedDocumentSubType = null;
            }
            else
            {
                SessionHandler.FRSelectedDocumentSubType = DropDownListSaleType.SelectedValue.ToString();
            }

            if (TextBoxFileDate.Text == String.Empty)
            {
                SessionHandler.FRSelectedFileDate = null;
            }
            else
            {
                SessionHandler.FRSelectedFileDate = TextBoxFileDate.Text;
            }

            if (TextBoxInvoiceDateFrom.Text == String.Empty)
            {
                SessionHandler.FRSelectedInvoiceDateFrom = null;
            }
            else
            {
                SessionHandler.FRSelectedInvoiceDateFrom = TextBoxInvoiceDateFrom.Text;
            }

            if (TextBoxInvoiceDateTo.Text == String.Empty)
            {
                SessionHandler.FRSelectedInvoiceDateTo = null;
            }
            else
            {
                SessionHandler.FRSelectedInvoiceDateTo = TextBoxInvoiceDateTo.Text;
            }
        }

    }
}