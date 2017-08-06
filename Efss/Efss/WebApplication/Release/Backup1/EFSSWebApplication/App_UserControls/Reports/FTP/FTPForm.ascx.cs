using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Diagnostics;
using System.IO;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using AjaxControlToolkit;
using APP.Base;
using RAD.Data;
using RAD.Diagnostics;
using RAD.IO;

namespace APP.App_UserControls.Reports.FTP
{
    public partial class FTPForm : UserControlBase
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


        public void LoadData()
        { 
        
        }

        protected void OnCommand(object sender, CommandEventArgs e)
        {
            if (e.CommandName == "Run")
            {
                //LabelMessage.Text = "";
                //if (TextBoxUserName.Text == String.Empty || TextBoxPassword.Text == String.Empty || TextBoxFileName.Text == String.Empty)
                //{
                //    LabelMessage.Text = "The User Name , the password and the file name are mandatory.";
                //}
                //else
                //{
                //    string strFile;
                //    string FTP_Filename;
                //    string FTP_Script;
                //    string FTP_Script_FileName;
                //    string strReportName;

                //    //FTP_Filename = "c:\\FTP_Me.bat";
                //    FTP_Filename = APP.Properties.Settings.Default.FTP_Filename;
                //    FTP_Script = "FTP_Script.txt";
                //    //FTP_Script_FileName = "c:\\" + FTP_Script;
                //    FTP_Script_FileName = APP.Properties.Settings.Default.FTP_Script_FileName;
                //    //strFile = "c:\\" + TextBoxFileName.Text  + ".txt";
                //    strFile = APP.Properties.Settings.Default.FTP_Path + TextBoxFileName.Text + ".txt";

                //    strReportName = DropDownReport.SelectedItem.Text;

                //    if (File.Exists(FTP_Filename))
                //    {
                //        File.Delete(FTP_Filename);
                //    }

                //    StreamWriter w;
                //    w = File.CreateText(FTP_Filename);
                //    w.WriteLine("cd \\");
                //    w.WriteLine("C:");
                //    w.WriteLine("ftp -s:\\" + FTP_Script);
                //    w.WriteLine("Del " + FTP_Script_FileName);
                //    w.WriteLine("Del " + FTP_Filename);

                //    w.Flush();
                //    w.Close();

                //    if (File.Exists(FTP_Script_FileName))
                //    {
                //        File.Delete(FTP_Script_FileName);
                //    }
                //    w = File.CreateText(FTP_Script_FileName);
                //    w.WriteLine("open " + DropDownSystem.SelectedItem.Text);
                //    w.WriteLine(TextBoxUserName.Text + "");
                //    w.WriteLine(TextBoxPassword.Text + "");
                //    w.WriteLine("get '" + strReportName  + "' " + strFile);
                //    w.WriteLine("Quit");

                //    w.Flush();
                //    w.Close();

                //    try
                //    {
                //        System.Diagnostics.ProcessStartInfo psi = new System.Diagnostics.ProcessStartInfo("cmd.exe");
                //        psi.UseShellExecute = false;
                //        psi.RedirectStandardOutput = true;
                //        psi.RedirectStandardInput = true;
                //        psi.RedirectStandardError = true;
                //        psi.WorkingDirectory = "c:\\";

                //        // Start the process
                //        System.Diagnostics.Process proc = System.Diagnostics.Process.Start(psi);

                //        System.IO.StreamReader strm = System.IO.File.OpenText(FTP_Filename);

                //        // Attach the output for reading
                //        System.IO.StreamReader sOut = proc.StandardOutput;

                //        // Attach the in for writing
                //        System.IO.StreamWriter sIn = proc.StandardInput;

                //        // Write each line of the batch file to standard input
                //        while (strm.Peek() != -1)
                //        {
                //            sIn.WriteLine(strm.ReadLine());
                //        }

                //        strm.Close();

                //        // Exit CMD.EXE
                //        string stEchoFmt = "# {0} run successfully. Exiting";

                //        sIn.WriteLine(String.Format(stEchoFmt, FTP_Filename));
                //        sIn.WriteLine("EXIT");

                //        // Close the process
                //        proc.Close();

                //        // Read the sOut to a string.
                //        string results = sOut.ReadToEnd().Trim();

                //        // Close the io Streams;
                //        sIn.Close();
                //        sOut.Close();
                //    }
                //    catch (Exception ex)
                //    {
                //        LabelMessage.Text = "Message: " + ex.Message;
                //    }
                //}
            }
        }


        #region "FileUpload"

        protected void OnFileUploadComplete(object sender, AsyncFileUploadEventArgs e)
        {
            if (e.FileName != null)
            {

                string reportId = DropDownListFileTye.SelectedValue;
                this.FileUploadPosted = this.AsyncFileUploadReport.PostedFile;
                string _fileName = Path.GetFileName(this.FileUploadPosted.FileName);

                string _newFileName;
                
                //savePath = Server.MapPath("~/Uploads/" + Path.GetFileName(this.FileUploadPosted.FileName));

                switch (reportId)
                { 
                    case "1":
                        // Active Fleet Daily

                        _newFileName = APP.Properties.Settings.Default.FleetDayFileName;
                        RunProcedure("spDBImportActiveFleetDayTruncate");
                        ReadFile(_newFileName,"1");
                        RunProcedure("spDBImportActiveFleetDayParse");
                        RunProcedure("spDBImportActiveFleetDayReport");
                        break;
                    case "2":
                        //ActiveDirectory Fleet Month
                        _newFileName = APP.Properties.Settings.Default.FleetMonthFileName;
                        RunProcedure("spDBImportActiveFleetMonthTruncate");
                        ReadFile(_newFileName,"2");
                        RunProcedure("spDBImportActiveFleetMonthParse");
                        RunProcedure("spDBImportActiveFleetMonthReport");
                        break;
                    case "3":
                        //Month Additions (Day Adds)
                        if (_fileName != "DayAdds.txt")
                        {
                            ScriptManager.RegisterStartupScript(this.UpdatePanelFTP, this.UpdatePanelFTP.GetType(), "alertwrongfilename", "alert('The name of the file should be DayAdds.txt.');", true);
                        }
                        else
                        {
                            _newFileName = APP.Properties.Settings.Default.DayAddsFileName;
                            TruncateFleetTransactions("3");
                            ReadFile(_newFileName, "3");
                            RunProcedure("spDBImportFleetDayAddsParse");
                            RunProcedure("spDBImportFleetDayAddsReport");

                        }
                        
                        break;
                    case "4":
                        //Month Deletes (Day Dels)
                        if (_fileName != "DayDels.txt")
                        {
                            ScriptManager.RegisterStartupScript(this.UpdatePanelFTP, this.UpdatePanelFTP.GetType(), "alertwrongfilename", "alert('The name of the file should be DayDels.txt.');", true);

                        }
                        else
                        {
                            _newFileName = APP.Properties.Settings.Default.DayDelsFileName;
                            TruncateFleetTransactions("4");
                            ReadFile(_newFileName, "4");
                            RunProcedure("spDBImportFleetDayDelsParse");
                            RunProcedure("spDBImportFleetDayDelsReport");
                        
                        }
                        
                        break;
                    case "5":
                        //Year Additions (Year Adds)
                        if (_fileName != "YearAdds.txt")
                        {
                            ScriptManager.RegisterStartupScript(this.UpdatePanelFTP, this.UpdatePanelFTP.GetType(), "alertwrongfilename", "alert('The name of the file should be YearAdds.txt.');", true);

                        }
                        else
                        {
                            _newFileName = APP.Properties.Settings.Default.YearAddsFileName;
                            TruncateFleetTransactions("5");
                            ReadFile(_newFileName, "5");
                            RunProcedure("spDBImportFleetYearAddsParse");
                            RunProcedure("spDBImportFleetYearAddsReport");
                        }
                       
                        break;
                    case "6":
                        //Year Deletes (Year Dels)
                        if (_fileName != "YearDels.txt")
                        {
                            ScriptManager.RegisterStartupScript(this.UpdatePanelFTP, this.UpdatePanelFTP.GetType(), "alertwrongfilename", "alert('The name of the file should be YearDels.txt.');", true);

                        }
                        else
                        {
                            _newFileName = APP.Properties.Settings.Default.YearDelsFileName;
                            TruncateFleetTransactions("6");
                            ReadFile(_newFileName, "6");
                            RunProcedure("spDBImportFleetYearDelsParse");
                            RunProcedure("spDBImportFleetYearDelsReport");
                        }
                        break;
                    case "8":
                        // Buyers Report
                        _newFileName = APP.Properties.Settings.Default.BuyersFileName;
                        RunProcedure("spDBImportBuyersTruncate");
                        ReadFile(_newFileName, "8");
                        //RunProcedure("spDBImportBuyersParse");
                        
                        break;
                    case "9":
                        //Models Report
                        _newFileName = APP.Properties.Settings.Default.ModelsFileName;
                        RunProcedure("spDBImportModelsTruncate");
                        ReadFile(_newFileName, "9");
                        RunProcedure("spDBImportModelsParse");
                        break;
                    case "10":
                        //Credit Notes File
                        _newFileName = APP.Properties.Settings.Default.CreditNotesFileName;
                        RunProcedure("spDBImportSalesCNTruncate");
                        ReadFile(_newFileName,"10");
                        RunProcedure("spDBImportSalesCNParse");
                        RunProcedure("spDBImportSalesCNReportFile");
                        RunProcedure("spDBImportSalesCNTransfer");
                        break;
                    case "11":
                        // Sales File
                        _newFileName = APP.Properties.Settings.Default.SalesFileName;
                        RunProcedure("spDBImportSalesTruncate");
                        ReadFile(_newFileName,"11");
                        RunProcedure("spDBImportSalesParse");
                        RunProcedure("spDBImportSalesReportFile");
                        RunProcedure("spDBImportSalesTransfer");
                        RunProcedure("spDBImportSalesReportTax");


                        //RunDTS(_newFileName, ConfigurationManager.AppSettings["SSISpackagePath"]);
                        //RunDTS("Sales.txt", @"\\hescrad2\i$\ImportSales.dtsx");
                        //RunDTS("Sales.txt", @"\\Hescrad2\i$\EuropeanFleetSalesSystem\SSIS packages repository\EFSS\ImportSales.dtsx");
                        //RunDTS("Sales.txt", @"\\Hescrad2\SSIS packages repository\EFSS\ImportSales.dtsx");
                        //RunDTS(APP.Properties.Settings.Default.SalesFileName, APP.Properties.Settings.Default.DTSSales);
                        

                        break;
                    case "12":
                        //Dashboard File
                        _newFileName = APP.Properties.Settings.Default.DashboardFileName;
                        RunProcedure("spDBImportDashboardTruncate");
                        ReadFile(_newFileName, "12");
                        RunProcedure("spDBImportDashboardParse");
                        RunProcedure("spDBImportDashboardReport");
                        
                        break;    
                }
            }
        }

        private void RunDTS(string filename,string PackageName)
        {
            
           // savePath = Server.MapPath("~/Uploads/" + filename);
          
            //string savePath;
            //savePath = APP.Properties.Settings.Default.FTPFolder + filename;
            //this.FileUploadPosted.SaveAs(savePath);
            
            //Application app = new Application();

            //string SSISpackagePath = PackageName;

            //using (Package package = app.LoadPackage(SSISpackagePath, null))
            //{
            //    //Variables vars = package.Variables;
            //    //string SSISpackageVariable = GetSSISPackageVariable();
            //    //vars[SSISpackageVariable].Value = savePath;

            //    //Execute DTSX.
            //    Microsoft.SqlServer.Dts.Runtime.DTSExecResult results = package.Execute();

            //    if (results != DTSExecResult.Success)
            //    {

            //        var s = results.ToString();
            //        this.LabelFTPReports.Text = s;

            //    }
            //}
        
        }

        #region "Upload Sales and Credit Notes File"

        private void ReadFile(string filename, string filetype)
        {
            try
            {
                string savePath;
                
                savePath = APP.Properties.Settings.Default.FTPFolder + filename;
                this.FileUploadPosted.SaveAs(savePath);
                this.FileUploadPosted = null;
                this.UpdatePanelFTP.Update();


                string readcontent;
                StreamReader filestream = new StreamReader(savePath, System.Text.Encoding.GetEncoding(1252));
                readcontent = filestream.ReadLine();
                while ((readcontent != null))
                {
                    switch (filetype)
                    { 
                        case "1":
                            UploadActiveFleetDay(readcontent);
                            break;
                        case "2":
                            UploadActiveFleetMonth(readcontent);
                            break;
                        case "3":
                        case "4":
                        case "5":
                        case "6":
                            UploadFleetTransactions(readcontent, filetype);
                            break;
                        case "8":
                            UploadVendors(readcontent);
                            break;
                        case "9":
                            UploadModels(readcontent);
                            break;
                        case "10":
                            UploadCreditNotesFile(readcontent);
                            break;
                        case "11":
                            UploadSalesFile(readcontent);
                            break;
                        case "12":
                            UploadDashboard(readcontent);
                            break;

                    }
                    
                    readcontent = filestream.ReadLine();
                }
                filestream.Close();
                readcontent = String.Empty;
            }
            catch (Exception ex)
            {
                StackTrace errorStackTrace = new StackTrace(true);
                Logs.LogError(errorStackTrace, ex);
            }
        
        }

        private void UploadSalesFile(string rowValue)
        {
            try
            {
                char[] delimiters = new char[] { ';' };
                SqlConnection con = RAD.Data.ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = RAD.Data.ConnectionManager.CreateProcedure("spDBImportSalesUpload", con);
                //string[] parts = rowValue.Split(delimiters, StringSplitOptions.RemoveEmptyEntries);
                string[] parts = rowValue.Split(delimiters);

                RAD.Data.Parameters.CreateParameter(cmd, "@CompanyCode", parts[0]);
                RAD.Data.Parameters.CreateParameter(cmd, "@AreaCode", parts[1]);
                RAD.Data.Parameters.CreateParameter(cmd, "@Serial", parts[2]);
                RAD.Data.Parameters.CreateParameter(cmd, "@Unit", parts[3]);
                RAD.Data.Parameters.CreateParameter(cmd, "@Plate", parts[4]);
                RAD.Data.Parameters.CreateParameter(cmd, "@Mileage", parts[5]);
                RAD.Data.Parameters.CreateParameter(cmd, "@InServiceDate", parts[6]);
                RAD.Data.Parameters.CreateParameter(cmd, "@OutServiceDate", parts[7]);
                RAD.Data.Parameters.CreateParameter(cmd, "@MSODate", parts[8]);
                RAD.Data.Parameters.CreateParameter(cmd, "@ModelCode", parts[9]);
                RAD.Data.Parameters.CreateParameter(cmd, "@ModelDescription", parts[10]);
                RAD.Data.Parameters.CreateParameter(cmd, "@CarColor", parts[11]);
                RAD.Data.Parameters.CreateParameter(cmd, "@ModelYear", parts[12]);
                RAD.Data.Parameters.CreateParameter(cmd, "@ManufacturerCode", parts[13]);
                RAD.Data.Parameters.CreateParameter(cmd, "@ManufacturerName", parts[14]);
                RAD.Data.Parameters.CreateParameter(cmd, "@VehicleClass", parts[15]);
                RAD.Data.Parameters.CreateParameter(cmd, "@VehicleType", parts[16]);
                RAD.Data.Parameters.CreateParameter(cmd, "@PurchaseOrder", parts[17]);
                RAD.Data.Parameters.CreateParameter(cmd, "@PayDate", parts[18]);
                RAD.Data.Parameters.CreateParameter(cmd, "@InvoiceNumber", parts[19]);
                RAD.Data.Parameters.CreateParameter(cmd, "@SaleDate", parts[20]);
                RAD.Data.Parameters.CreateParameter(cmd, "@InvoiceDate", parts[21]);
                RAD.Data.Parameters.CreateParameter(cmd, "@SaleType", parts[22]);
                RAD.Data.Parameters.CreateParameter(cmd, "@SaleDocumentNumber", parts[23]);
                RAD.Data.Parameters.CreateParameter(cmd, "@InvoiceNet", parts[24]);
                RAD.Data.Parameters.CreateParameter(cmd, "@InvoiceVat", parts[25]);
                RAD.Data.Parameters.CreateParameter(cmd, "@InvoiceTotal", parts[26]);
                RAD.Data.Parameters.CreateParameter(cmd, "@BuyerCode", parts[27]);
                RAD.Data.Parameters.CreateParameter(cmd, "@BuyerName", parts[28]);
                RAD.Data.Parameters.CreateParameter(cmd, "@BuyerAddress1", parts[29]);
                RAD.Data.Parameters.CreateParameter(cmd, "@BuyerAddress2", parts[30]);
                RAD.Data.Parameters.CreateParameter(cmd, "@BuyerAddress3", parts[31]);
                RAD.Data.Parameters.CreateParameter(cmd, "@BuyerAddress4", parts[32]);
                RAD.Data.Parameters.CreateParameter(cmd, "@BuyerFiscalCode", parts[33]);
                RAD.Data.Parameters.CreateParameter(cmd, "@CapitalCost", parts[34]);
                RAD.Data.Parameters.CreateParameter(cmd, "@Depreciation", parts[35]);
                RAD.Data.Parameters.CreateParameter(cmd, "@BookValue", parts[36]);
                RAD.Data.Parameters.CreateParameter(cmd, "@BuyBackCap", parts[37]);
                RAD.Data.Parameters.CreateParameter(cmd, "@MileCharge", parts[38]);
                RAD.Data.Parameters.CreateParameter(cmd, "@PlusKM", parts[39]);
                RAD.Data.Parameters.CreateParameter(cmd, "@FuelCharge", parts[40]);
                RAD.Data.Parameters.CreateParameter(cmd, "@Damage", parts[41]);
                RAD.Data.Parameters.CreateParameter(cmd, "@TransferFees", parts[42]);
                RAD.Data.Parameters.CreateParameter(cmd, "@TransferFeesNoVat", parts[43]);
                RAD.Data.Parameters.CreateParameter(cmd, "@TaxDescription1", parts[44]);
                RAD.Data.Parameters.CreateParameter(cmd, "@TaxDescription2", parts[45]);
                RAD.Data.Parameters.CreateParameter(cmd, "@TaxDescription3", parts[46]);
                RAD.Data.Parameters.CreateParameter(cmd, "@OriginalBPM", parts[47]);
                RAD.Data.Parameters.CreateParameter(cmd, "@CalcVatAmortized", parts[48]);
                RAD.Data.Parameters.CreateParameter(cmd, "@Unamortized", parts[49]);
                RAD.Data.Parameters.CreateParameter(cmd, "@SuperCharge", parts[50]);
                RAD.Data.Parameters.CreateParameter(cmd, "@HandleFee", parts[51]);
                RAD.Data.Parameters.CreateParameter(cmd, "@AddOn", parts[52]);
                RAD.Data.Parameters.CreateParameter(cmd, "@Other1", parts[53]);
                RAD.Data.Parameters.CreateParameter(cmd, "@Other2", parts[54]);
                RAD.Data.Parameters.CreateParameter(cmd, "@Amount5", parts[55]);
                RAD.Data.Parameters.CreateParameter(cmd, "@Amount6", parts[56]);
                RAD.Data.Parameters.CreateParameter(cmd, "@Amount7", parts[57]);
                RAD.Data.Parameters.CreateParameter(cmd, "@ExportTo", parts[58]);
                RAD.Data.Parameters.CreateParameter(cmd, "@Tax", parts[59]);
                RAD.Data.Parameters.CreateParameter(cmd, "@RegTaxAmount", parts[60]);

                //for (int i = 0; i < parts.Length; i++)
                //{
                //    sepList.Add(parts[i]);
                //}

               
                RAD.Data.ConnectionManager.ExecuteCommandNonQuery(con, cmd);

            }
            catch (Exception ex)
            {
                StackTrace errorStackTrace = new StackTrace(true);
                Logs.LogError(errorStackTrace, ex);
            }
        
        }

        private void UploadCreditNotesFile(string rowValue)
        {
            try
            {

                SqlConnection con = RAD.Data.ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = RAD.Data.ConnectionManager.CreateProcedure("spDBImportSalesCNUpload", con);
                RAD.Data.Parameters.CreateParameter(cmd, "@rowValue", rowValue);
                RAD.Data.ConnectionManager.ExecuteCommandNonQuery(con, cmd);

            }
            catch (Exception ex)
            {
                StackTrace errorStackTrace = new StackTrace(true);
                Logs.LogError(errorStackTrace, ex);
            }
        
        
        }

        private void RunProcedure(string storedprocedure)
        {
            try
            {
                SqlConnection con = RAD.Data.ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = RAD.Data.ConnectionManager.CreateProcedure(storedprocedure, con);
                RAD.Data.ConnectionManager.ExecuteCommandNonQuery(con, cmd);

            }
            catch (Exception ex)
            {
                StackTrace errorStackTrace = new StackTrace(true);
                Logs.LogError(errorStackTrace, ex);
            }
        
        }

        #endregion

        #region "Upload Files"

        private void UploadVendors(string rowValue)
        {
            try
            {
                char[] delimiters = new char[] { ';' };
                SqlConnection con = RAD.Data.ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = RAD.Data.ConnectionManager.CreateProcedure("spDBImportBuyersUpload", con);
                string[] parts = rowValue.Split(delimiters);
                
                RAD.Data.Parameters.CreateParameter(cmd, "@CompanyCode", parts[0]);
                RAD.Data.Parameters.CreateParameter(cmd, "@BuyerCode", parts[1]);
                RAD.Data.Parameters.CreateParameter(cmd, "@BuyerName", parts[2]);
                RAD.Data.Parameters.CreateParameter(cmd, "@BuyerAddress1", parts[3]);
                RAD.Data.Parameters.CreateParameter(cmd, "@BuyerAddress2", parts[4]);
                RAD.Data.Parameters.CreateParameter(cmd, "@BuyerAddress3", parts[5]);
                RAD.Data.Parameters.CreateParameter(cmd, "@BuyerAddress4", parts[6]);
                RAD.Data.Parameters.CreateParameter(cmd, "@BuyerAddress5", parts[7]);
                RAD.Data.Parameters.CreateParameter(cmd, "@BuyerAddress6", parts[8]);
                //RAD.Data.Parameters.CreateParameter(cmd, "@BuyerMFG", parts[9]);
                //RAD.Data.Parameters.CreateParameter(cmd, "@BuyerDealer", parts[10]);
                RAD.Data.Parameters.CreateParameter(cmd, "@BuyerTaxCode", parts[11]);
                RAD.Data.Parameters.CreateParameter(cmd, "@BuyerFiscalCode", parts[12]);
                RAD.Data.Parameters.CreateParameter(cmd, "@BuyerEmail", parts[13]);

                RAD.Data.ConnectionManager.ExecuteCommandNonQuery(con, cmd);

            }
            catch (Exception ex)
            {
                StackTrace errorStackTrace = new StackTrace(true);
                Logs.LogError(errorStackTrace, ex);
            }

        }

        private void UploadModels(string rowValue)
        {
            try
            {
                char[] delimiters = new char[] { ',' };
                SqlConnection con = RAD.Data.ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = RAD.Data.ConnectionManager.CreateProcedure("spDBImportModelsupload", con);
                string[] parts = rowValue.Split(delimiters);
                RAD.Data.Parameters.CreateParameter(cmd, "@CompanyCode", parts[0]);
                RAD.Data.Parameters.CreateParameter(cmd, "@ManufacturerCode", parts[1]);
                RAD.Data.Parameters.CreateParameter(cmd, "@ModelYear", parts[2]);
                RAD.Data.Parameters.CreateParameter(cmd, "@ModelCode", parts[3]);
                RAD.Data.Parameters.CreateParameter(cmd, "@ModelGroup", parts[4]);
                RAD.Data.Parameters.CreateParameter(cmd, "@ModelDescription", parts[5]);
                RAD.Data.Parameters.CreateParameter(cmd, "@TasModel", parts[6]);
                RAD.Data.Parameters.CreateParameter(cmd, "@RateClass", parts[7]);
                RAD.Data.Parameters.CreateParameter(cmd, "@EngineSize", parts[8]);
                RAD.Data.Parameters.CreateParameter(cmd, "@FuelType", parts[9]);
                RAD.Data.Parameters.CreateParameter(cmd, "@EstCap", parts[10]);
                RAD.Data.Parameters.CreateParameter(cmd, "@EstDepr", parts[11]);
                RAD.Data.Parameters.CreateParameter(cmd, "@EstVB", parts[12]);
                RAD.Data.Parameters.CreateParameter(cmd, "@EstAmrt", parts[13]);
                RAD.Data.Parameters.CreateParameter(cmd, "@FastSpec", parts[14]);
                RAD.Data.Parameters.CreateParameter(cmd, "@PrepHR", parts[15]);
                RAD.Data.Parameters.CreateParameter(cmd, "@RecStoredate", parts[16]);
                RAD.Data.ConnectionManager.ExecuteCommandNonQuery(con, cmd);

            }
            catch (Exception ex)
            {
                StackTrace errorStackTrace = new StackTrace(true);
                Logs.LogError(errorStackTrace, ex);
            }

        }

        private void TruncateFleetTransactions(string fileId)
        {
            try
            {
                SqlConnection con = RAD.Data.ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = RAD.Data.ConnectionManager.CreateProcedure("spDBImportActiveFleetTransactionsTruncate", con);
                RAD.Data.Parameters.CreateParameter(cmd, "@fileId", fileId);
                RAD.Data.ConnectionManager.ExecuteCommandNonQuery(con, cmd);

            }
            catch (Exception ex)
            {
                StackTrace errorStackTrace = new StackTrace(true);
                Logs.LogError(errorStackTrace, ex);
            }
        
        }

        private void UploadActiveFleetDay(string rowValue)
        {
            try
            {
                char[] delimiters = new char[] { ',' };
                SqlConnection con = RAD.Data.ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = RAD.Data.ConnectionManager.CreateProcedure("spDBImportActiveFleetDayUpload", con);
                string[] parts = rowValue.Split(delimiters);

                RAD.Data.Parameters.CreateParameter(cmd, "@CompanyCode", parts[0]);
                RAD.Data.Parameters.CreateParameter(cmd, "@AreaCode", parts[1]);
                RAD.Data.Parameters.CreateParameter(cmd, "@Serial", parts[2]);
                RAD.Data.Parameters.CreateParameter(cmd, "@Unit", parts[3]);
                RAD.Data.Parameters.CreateParameter(cmd, "@TasModel", parts[4]);
                RAD.Data.Parameters.CreateParameter(cmd, "@ModelCode", parts[5]);
                RAD.Data.Parameters.CreateParameter(cmd, "@ManufacturerName", parts[6]);
                RAD.Data.Parameters.CreateParameter(cmd, "@ModelGroup", parts[7]);
                RAD.Data.Parameters.CreateParameter(cmd, "@ModelDescription", parts[8]);
                RAD.Data.Parameters.CreateParameter(cmd, "@RateClass", parts[9]);
                RAD.Data.Parameters.CreateParameter(cmd, "@VehicleType", parts[10]);
                RAD.Data.Parameters.CreateParameter(cmd, "@CapitalCost", parts[11]);
                RAD.Data.Parameters.CreateParameter(cmd, "@Depreciation", parts[12]);
                RAD.Data.Parameters.CreateParameter(cmd, "@DepreciationRate", parts[13]);
                RAD.Data.Parameters.CreateParameter(cmd, "@DepreciationPCT", parts[14]);
                RAD.Data.Parameters.CreateParameter(cmd, "@BookValue", parts[15]);
                RAD.Data.Parameters.CreateParameter(cmd, "@DeliveryDate", parts[16]);
                RAD.Data.Parameters.CreateParameter(cmd, "@MSODate", parts[17]);
                RAD.Data.Parameters.CreateParameter(cmd, "@InServiceDate", parts[18]);
                RAD.Data.Parameters.CreateParameter(cmd, "@OutServiceDate", parts[19]);
                RAD.Data.Parameters.CreateParameter(cmd, "@DaysInService", parts[20]);
                RAD.Data.Parameters.CreateParameter(cmd, "@SalePrice", parts[21]);
                RAD.Data.Parameters.CreateParameter(cmd, "@Mileage", parts[22]);
                RAD.Data.Parameters.CreateParameter(cmd, "@AdjReceivable", parts[23]);
                RAD.Data.Parameters.CreateParameter(cmd, "@ReceivableType", parts[24]);
                RAD.Data.Parameters.CreateParameter(cmd, "@AmortizedID", parts[25]);
                RAD.Data.Parameters.CreateParameter(cmd, "@FirstRA", parts[26]);
                RAD.Data.Parameters.CreateParameter(cmd, "@RADate", parts[27]);
                RAD.Data.Parameters.CreateParameter(cmd, "@SaleType", parts[28]);
                RAD.Data.Parameters.CreateParameter(cmd, "@VehicleStatus", parts[29]);
                RAD.Data.Parameters.CreateParameter(cmd, "@Plate", parts[30]);
                RAD.Data.Parameters.CreateParameter(cmd, "@SaleDate", parts[31]);
                RAD.Data.Parameters.CreateParameter(cmd, "@VehicleClass", parts[32]);
                RAD.Data.Parameters.CreateParameter(cmd, "@DeliveryDate_2", parts[33]);
                RAD.Data.Parameters.CreateParameter(cmd, "@OutServiceDate_2", parts[34]);
                RAD.Data.Parameters.CreateParameter(cmd, "@ModelYear", parts[35]);


                RAD.Data.ConnectionManager.ExecuteCommandNonQuery(con, cmd);

            }
            catch (Exception ex)
            {
                StackTrace errorStackTrace = new StackTrace(true);
                Logs.LogError(errorStackTrace, ex);
            }

        }

        private void UploadActiveFleetMonth(string rowValue)
        {
            try
            {
                char[] delimiters = new char[] { ',' };
                SqlConnection con = RAD.Data.ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = RAD.Data.ConnectionManager.CreateProcedure("spDBImportActiveFleetMonthUpload", con);
                string[] parts = rowValue.Split(delimiters);
                RAD.Data.Parameters.CreateParameter(cmd, "@CompanyCode", parts[0]);
                RAD.Data.Parameters.CreateParameter(cmd, "@Serial", parts[1]);
                RAD.Data.Parameters.CreateParameter(cmd, "@AreaCode", parts[2]);
                RAD.Data.Parameters.CreateParameter(cmd, "@Unit", parts[3]);
                RAD.Data.Parameters.CreateParameter(cmd, "@UnitLastDigit", parts[4]);
                RAD.Data.Parameters.CreateParameter(cmd, "@Plate", parts[5]);
                RAD.Data.Parameters.CreateParameter(cmd, "@InvoiceStatus", parts[6]);
                RAD.Data.Parameters.CreateParameter(cmd, "@SalePrice", parts[7]);
                RAD.Data.Parameters.CreateParameter(cmd, "@CapitalCost", parts[8]);
                RAD.Data.Parameters.CreateParameter(cmd, "@Depreciation", parts[9]);
                RAD.Data.Parameters.CreateParameter(cmd, "@DepreciationRate", parts[10]);
                RAD.Data.Parameters.CreateParameter(cmd, "@DepreciationPCT", parts[11]);
                RAD.Data.Parameters.CreateParameter(cmd, "@BuyBackCap", parts[12]);
                RAD.Data.Parameters.CreateParameter(cmd, "@LessOr", parts[13]);
                RAD.Data.Parameters.CreateParameter(cmd, "@BaseAndOptions", parts[14]);
                RAD.Data.Parameters.CreateParameter(cmd, "@SaleType", parts[15]);
                RAD.Data.Parameters.CreateParameter(cmd, "@VehicleClass", parts[16]);
                RAD.Data.Parameters.CreateParameter(cmd, "@VehicleStatus", parts[17]);
                RAD.Data.Parameters.CreateParameter(cmd, "@SpecialProgramIndicator", parts[18]);
                RAD.Data.Parameters.CreateParameter(cmd, "@ManufacturerCode", parts[19]);
                RAD.Data.Parameters.CreateParameter(cmd, "@ModelYear", parts[20]);
                RAD.Data.Parameters.CreateParameter(cmd, "@ModelCode", parts[21]);
                RAD.Data.Parameters.CreateParameter(cmd, "@PaymentMethod", parts[22]);
                RAD.Data.Parameters.CreateParameter(cmd, "@InvoiceNumber", parts[23]);
                RAD.Data.Parameters.CreateParameter(cmd, "@DeliveryDate", parts[24]);
                RAD.Data.Parameters.CreateParameter(cmd, "@InServiceDate", parts[25]);
                RAD.Data.Parameters.CreateParameter(cmd, "@OutServiceDate", parts[26]);
                RAD.Data.Parameters.CreateParameter(cmd, "@SaleDate", parts[27]);
                RAD.Data.Parameters.CreateParameter(cmd, "@MSODate", parts[28]);
                RAD.Data.Parameters.CreateParameter(cmd, "@VehicleType", parts[29]);
                RAD.Data.Parameters.CreateParameter(cmd, "@PL", parts[30]);
                RAD.Data.Parameters.CreateParameter(cmd, "@Mileage", parts[31]);
                RAD.Data.Parameters.CreateParameter(cmd, "@DaysInService", parts[32]);
                RAD.Data.Parameters.CreateParameter(cmd, "@BuyerCode", parts[33]);
                RAD.Data.Parameters.CreateParameter(cmd, "@PDepreciationRate", parts[34]);
                RAD.Data.Parameters.CreateParameter(cmd, "@PDepreciationPCT", parts[35]);
                RAD.Data.Parameters.CreateParameter(cmd, "@TasModel", parts[36]);
                RAD.Data.Parameters.CreateParameter(cmd, "@SubType", parts[37]);
                RAD.Data.Parameters.CreateParameter(cmd, "@SaleDocumentNumber", parts[38]);
                RAD.Data.Parameters.CreateParameter(cmd, "@ProgramCAP", parts[39]);
                RAD.Data.Parameters.CreateParameter(cmd, "@ProgramAccumDepreciation", parts[40]);
                RAD.Data.Parameters.CreateParameter(cmd, "@Reference", parts[41]);
                RAD.Data.ConnectionManager.ExecuteCommandNonQuery(con, cmd);

            }
            catch (Exception ex)
            {
                StackTrace errorStackTrace = new StackTrace(true);
                Logs.LogError(errorStackTrace, ex);
            }

        }

        private void UploadFleetTransactions(string rowValue,string fileid)
        {
            try
            {
                char[] delimiters = new char[] { ',' };
                SqlConnection con = RAD.Data.ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = RAD.Data.ConnectionManager.CreateProcedure("spDBImportActiveFleetTransactionsUpload", con);
                string[] parts = rowValue.Split(delimiters);
                RAD.Data.Parameters.CreateParameter(cmd, "@fileId", fileid);
                RAD.Data.Parameters.CreateParameter(cmd, "@CompanyCode", parts[0]);
                RAD.Data.Parameters.CreateParameter(cmd, "@AreaCode", parts[1]);
                RAD.Data.Parameters.CreateParameter(cmd, "@Serial", parts[2]);
                RAD.Data.Parameters.CreateParameter(cmd, "@Unit", parts[3]);
                RAD.Data.Parameters.CreateParameter(cmd, "@TasModel", parts[4]);
                RAD.Data.Parameters.CreateParameter(cmd, "@ModelCode", parts[5]);
                RAD.Data.Parameters.CreateParameter(cmd, "@ManufacturerName", parts[6]);
                RAD.Data.Parameters.CreateParameter(cmd, "@ModelGroup", parts[7]);
                RAD.Data.Parameters.CreateParameter(cmd, "@ModelDescription", parts[8]);
                RAD.Data.Parameters.CreateParameter(cmd, "@RateClass", parts[9]);
                RAD.Data.Parameters.CreateParameter(cmd, "@VehicleType", parts[10]);
                RAD.Data.Parameters.CreateParameter(cmd, "@CapitalCost", parts[11]);
                RAD.Data.Parameters.CreateParameter(cmd, "@Depreciation", parts[12]);
                RAD.Data.Parameters.CreateParameter(cmd, "@DepreciationRate", parts[13]);
                RAD.Data.Parameters.CreateParameter(cmd, "@DepreciationPCT", parts[14]);
                RAD.Data.Parameters.CreateParameter(cmd, "@BookValue", parts[15]);
                RAD.Data.Parameters.CreateParameter(cmd, "@DeliveryDate", parts[16]);
                RAD.Data.Parameters.CreateParameter(cmd, "@MSODate", parts[17]);
                RAD.Data.Parameters.CreateParameter(cmd, "@InServiceDate", parts[18]);
                RAD.Data.Parameters.CreateParameter(cmd, "@OutServiceDate", parts[19]);
                RAD.Data.Parameters.CreateParameter(cmd, "@DaysInService", parts[20]);
                RAD.Data.Parameters.CreateParameter(cmd, "@SalePrice", parts[21]);
                RAD.Data.Parameters.CreateParameter(cmd, "@Mileage", parts[22]);
                RAD.Data.Parameters.CreateParameter(cmd, "@AdjReceivable", parts[23]);
                RAD.Data.Parameters.CreateParameter(cmd, "@ReceivableType", parts[24]);
                RAD.Data.Parameters.CreateParameter(cmd, "@AmortizedID", parts[25]);
                RAD.Data.Parameters.CreateParameter(cmd, "@FirstRA", parts[26]);
                RAD.Data.Parameters.CreateParameter(cmd, "@RADate", parts[27]);
                RAD.Data.Parameters.CreateParameter(cmd, "@SaleType", parts[28]);
                RAD.Data.Parameters.CreateParameter(cmd, "@VehicleStatus", parts[29]);
                RAD.Data.Parameters.CreateParameter(cmd, "@Plate", parts[30]);
                RAD.Data.Parameters.CreateParameter(cmd, "@SaleDate", parts[31]);
                RAD.Data.Parameters.CreateParameter(cmd, "@VehicleClass", parts[32]);
                RAD.Data.Parameters.CreateParameter(cmd, "@DeliveryDate_2", parts[33]);
                RAD.Data.Parameters.CreateParameter(cmd, "@OutServiceDate_2", parts[34]);
                RAD.Data.Parameters.CreateParameter(cmd, "@ModelYear", parts[35]);
                RAD.Data.Parameters.CreateParameter(cmd, "@CapitalCostFleetco", parts[36]);
                RAD.Data.ConnectionManager.ExecuteCommandNonQuery(con, cmd);

            }
            catch (Exception ex)
            {
                StackTrace errorStackTrace = new StackTrace(true);
                Logs.LogError(errorStackTrace, ex);
            }

        }

        private void UploadDashboard(string rowValue)
        {
            try
            {
                char[] delimiters = new char[] { ',' };
                SqlConnection con = RAD.Data.ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = RAD.Data.ConnectionManager.CreateProcedure("spDBImportDashboardUpload", con);
                string[] parts = rowValue.Split(delimiters);
                RAD.Data.Parameters.CreateParameter(cmd, "@SaleDocumentNumber", parts[0]);
                RAD.Data.Parameters.CreateParameter(cmd, "@InvoiceDate", parts[1]);
                RAD.Data.Parameters.CreateParameter(cmd, "@Serial", parts[2]);
                RAD.Data.Parameters.CreateParameter(cmd, "@AreaCode", parts[3]);
                RAD.Data.Parameters.CreateParameter(cmd, "@CompanyCode", parts[4]);
                RAD.Data.Parameters.CreateParameter(cmd, "@RecvType", parts[5]);
                RAD.Data.Parameters.CreateParameter(cmd, "@ManufacturerName", parts[6]);
                RAD.Data.Parameters.CreateParameter(cmd, "@VehicleStatus", parts[7]);
                RAD.Data.Parameters.CreateParameter(cmd, "@OMU", parts[8]);
                RAD.Data.Parameters.CreateParameter(cmd, "@RMSAge", parts[9]);
                RAD.Data.Parameters.CreateParameter(cmd, "@RecvAmt", parts[10]);
                RAD.Data.Parameters.CreateParameter(cmd, "@OutServiceDate", parts[11]);
                RAD.Data.Parameters.CreateParameter(cmd, "@Plate", parts[12]);
                RAD.Data.Parameters.CreateParameter(cmd, "@InServiceDate", parts[13]);
                RAD.Data.Parameters.CreateParameter(cmd, "@PurchaseOrder", parts[14]);
                RAD.Data.Parameters.CreateParameter(cmd, "@PurchInvoiceNumber", parts[15]);
                RAD.Data.Parameters.CreateParameter(cmd, "@CapitalCost", parts[16]);
                RAD.Data.Parameters.CreateParameter(cmd, "@Depreciation", parts[17]);
                RAD.Data.Parameters.CreateParameter(cmd, "@NetRecv", parts[18]);
                RAD.Data.Parameters.CreateParameter(cmd, "@RecvDueInd", parts[19]);
                RAD.Data.Parameters.CreateParameter(cmd, "@RecvDueDate", parts[20]);
                RAD.Data.Parameters.CreateParameter(cmd, "@InvoiceNbr", parts[21]);
                RAD.Data.Parameters.CreateParameter(cmd, "@VehicleType", parts[22]);
                RAD.Data.Parameters.CreateParameter(cmd, "@SPI", parts[23]);
                RAD.Data.Parameters.CreateParameter(cmd, "@ModelCodeVision", parts[24]);
                RAD.Data.Parameters.CreateParameter(cmd, "@DueDtAge", parts[25]);
                RAD.Data.Parameters.CreateParameter(cmd, "@ClaimDate", parts[26]);
                RAD.Data.Parameters.CreateParameter(cmd, "@Unit", parts[27]);
                RAD.Data.Parameters.CreateParameter(cmd, "@InvoiceNumber", parts[28]);
                RAD.Data.ConnectionManager.ExecuteCommandNonQuery(con, cmd);

            }
            catch (Exception ex)
            {
                StackTrace errorStackTrace = new StackTrace(true);
                Logs.LogError(errorStackTrace, ex);
            }

        }

        #endregion
        

        protected void OnFileUploadError(object sender, AsyncFileUploadEventArgs e)
        {
            //TODO:Handle Error 

        }

        public static string GetSSISPackagePath()
        {
            return ConfigurationManager.AppSettings["SSISpackagePath"];
        }

        public static string GetSSISPackageVariable()
        {
            return ConfigurationManager.AppSettings["SSISpackageVariable"];
        }

     
        #endregion
    }
}