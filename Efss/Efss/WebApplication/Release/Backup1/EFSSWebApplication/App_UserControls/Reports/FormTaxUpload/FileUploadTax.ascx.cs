using System;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.IO;
using System.Web;
using AjaxControlToolkit;
using APP.Base;
using APP.Data;
using RAD.Data;
using RAD.Diagnostics;
using RAD.IO;

namespace APP.App_UserControls.Reports.FormTaxUpload
{
    public partial class FileUploadTax : UserControlBase
    {
        protected override void OnPreRender(EventArgs e)
        {
            FileManager.AddMultiPart();
        }
       
        public HttpPostedFile FileUploadPosted
        {
            get
            {
                object o = Session["FileUploadPosted"];
                return (o != null) ? o as HttpPostedFile : null;
            }
            set
            {
                Session["FileUploadPosted"] = value;
            }
        }


        protected void OnFileUploadComplete(object sender, AsyncFileUploadEventArgs e)
        {
            if (e.FileName != null)
            {
                this.FileUploadPosted = this.AsyncFileUploadFileBank.PostedFile;

                string savePath = Server.MapPath("~/Uploads/" + Path.GetFileName(this.FileUploadPosted.FileName));
                this.FileUploadPosted.SaveAs(savePath);
                string filename = savePath;

                if (DropDownListFileTye.SelectedValue == "1")
                {
                    TruncateTaxFile();

                    string readcontent;
                    StreamReader filestream = new StreamReader(filename, System.Text.Encoding.GetEncoding(1252));
                    readcontent = filestream.ReadLine();
                    while ((readcontent != null))
                    {
                        UploadTaxFile(readcontent);
                        readcontent = filestream.ReadLine();
                    }
                    filestream.Close();
                    readcontent = String.Empty;
                    ParseFile();
                }
                else
                {
                    DataTable dt = ReadExcelFile("Matriculaciones", savePath).Tables[0];

                    if (dt.Rows.Count > 0)
                    {
                        TruncateFleetSP();

                        foreach (DataRow dr in dt.Rows)
                        {
                            if (dr.ItemArray[2].ToString() != String.Empty)
                            {
                                UploadFleetSP(dr.ItemArray[2].ToString(), dr.ItemArray[6].ToString(), dr.ItemArray[9].ToString(), dr.ItemArray[13].ToString(), dr.ItemArray[14].ToString(), dr.ItemArray[16].ToString(), dr.ItemArray[17].ToString(), dr.ItemArray[18].ToString());
                            }
                            else
                            {
                                break;
                            }
                        }

                        TransferFleetSP();
                        ParseFleetSP();
                    }
                }
            }

        }

        protected void OnFileUploadError(object sender, AsyncFileUploadEventArgs e)
        {
            //TODO:Handle Error 

        }

        #region "Bank File"

        private void TruncateTaxFile()
        {
            try
            {
                SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = ConnectionManager.CreateProcedure(StoredProcedures.TaxFileNRCBankTruncate, con);
                ConnectionManager.ExecuteCommandNonQuery(con, cmd);

            }
            catch (Exception ex)
            {
                StackTrace errorStackTrace = new StackTrace(true);
                Logs.LogError(errorStackTrace, ex);
            }
        }

        private void UploadTaxFile(string rowValue)
        {
            try
            {
                SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = ConnectionManager.CreateProcedure(StoredProcedures.TaxFileNRCBankImport, con);
                RAD.Data.Parameters.CreateParameter(cmd, "@rowValue", rowValue);
                ConnectionManager.ExecuteCommandNonQuery(con, cmd);

            }
            catch (Exception ex)
            {
                StackTrace errorStackTrace = new StackTrace(true);
                Logs.LogError(errorStackTrace, ex);
            }

        }

        private void ParseFile()
        {
            try
            {
                SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = ConnectionManager.CreateProcedure(StoredProcedures.TaxFileNRCBankParse, con);
                ConnectionManager.ExecuteCommandNonQuery(con, cmd);

            }
            catch (Exception ex)
            {
                StackTrace errorStackTrace = new StackTrace(true);
                Logs.LogError(errorStackTrace, ex);
            }
        }

        #endregion

        #region "Fleet File"

        private void TruncateFleetSP()
        {
            try
            {
                SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = ConnectionManager.CreateProcedure(StoredProcedures.TruncateFleetSP, con);
                ConnectionManager.ExecuteCommandNonQuery(con, cmd);
            }
            catch (Exception ex)
            {
                StackTrace errorStackTrace = new StackTrace(true);
                Logs.LogError(errorStackTrace, ex);
            }

        }

        private void UploadFleetSP(string unit, string serial, string msodate, string itvserial, string co2,string vehicleCode, string enginesize, string fueltype)
        {
            try
            {
                SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = ConnectionManager.CreateProcedure(StoredProcedures.UploadFleetSP, con);

                RAD.Data.Parameters.CreateParameter(cmd, "@Serial", serial);
                RAD.Data.Parameters.CreateParameter(cmd, "@MSODate", msodate);
                RAD.Data.Parameters.CreateParameter(cmd, "@ITVSerial", itvserial);
                RAD.Data.Parameters.CreateParameter(cmd, "@CO2", co2);
                RAD.Data.Parameters.CreateParameter(cmd, "@FuelType", fueltype);
                RAD.Data.Parameters.CreateParameter(cmd, "@unit", unit);
                RAD.Data.Parameters.CreateParameter(cmd, "@engineSize", enginesize);
                RAD.Data.Parameters.CreateParameter(cmd, "@vehicleCode", vehicleCode);
                

                ConnectionManager.ExecuteCommandNonQuery(con, cmd);

            }
            catch (Exception ex)
            {
                StackTrace errorStackTrace = new StackTrace(true);
                Logs.LogError(errorStackTrace, ex);
            }

        }

        private DataSet ReadExcelFile(string sheetName, string fileName)
        {
            string QueryExcel;
            System.Data.OleDb.OleDbCommand comExcel;
            System.Data.OleDb.OleDbDataAdapter daExcel = new System.Data.OleDb.OleDbDataAdapter();
            DataSet TableExcel = new DataSet();
            string sheet = sheetName;
            System.Data.OleDb.OleDbConnection cnExcel = new System.Data.OleDb.OleDbConnection();
            //cnExcel.ConnectionString =  "Provider=Microsoft.Jet.Oledb.4.0;Data Source=" + fileName + ";Extended Properties=\"Excel 8.0;HDR=Yes;IMEX=1\"";
            cnExcel.ConnectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + fileName + ";Extended Properties=\"Excel 12.0 Xml;HDR=Yes;IMEX=1\"";
            if (cnExcel.State == ConnectionState.Closed)
            {
                cnExcel.Open();
            }
            QueryExcel = "Select * from [" + sheet + "$]";
            comExcel = new System.Data.OleDb.OleDbCommand(QueryExcel, cnExcel);
            daExcel.SelectCommand = comExcel;
            daExcel.Fill(TableExcel);
            cnExcel.Close();
            return TableExcel;
        }

        private void TransferFleetSP()
        {
            try
            {
                SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = ConnectionManager.CreateProcedure(StoredProcedures.TransferDataFleetSP, con);
                ConnectionManager.ExecuteCommandNonQuery(con, cmd);
            }
            catch (Exception ex)
            {
                StackTrace errorStackTrace = new StackTrace(true);
                Logs.LogError(errorStackTrace, ex);
            }

        }

        private void ParseFleetSP()
        {
            try
            {
                SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = ConnectionManager.CreateProcedure(StoredProcedures.ParseDataFleetSP, con);
                ConnectionManager.ExecuteCommandNonQuery(con, cmd);
            }
            catch (Exception ex)
            {
                StackTrace errorStackTrace = new StackTrace(true);
                Logs.LogError(errorStackTrace, ex);
            }
        }

        #endregion

        
    }
}