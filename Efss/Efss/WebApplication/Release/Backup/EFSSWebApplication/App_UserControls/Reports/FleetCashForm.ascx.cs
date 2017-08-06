using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Linq;
using System.Web.UI.WebControls;
using APP.Data;
using APP.Session;
using APP.Settings;
using Microsoft.Reporting.WebForms;
using RAD.Data;
using RAD.Diagnostics;

namespace APP.App_UserControls.Reports
{
    public partial class FleetCashForm : System.Web.UI.UserControl
    {
        public void LoadData(bool isRefreshed)
        {
            if (isRefreshed)
            {
                SessionHandler.FTCReportTypeReceivables = "1";
                SessionHandler.FTCReportTypePayables = "2";

                SessionHandler.FTCReportRegionNorth = "1";
                SessionHandler.FTCReportRegionSouth = "2";


                SessionHandler.FTCReportUKRAC = "1";
                SessionHandler.FTCReportNetherlands = "2";
                SessionHandler.FTCReportSwitzerland = "3";
                SessionHandler.FTCReportBelux = "5";
                SessionHandler.FTCReportGermany = "6";
                SessionHandler.FTCReportItaly = "7";
                SessionHandler.FTCReportSpain = "8";
                SessionHandler.FTCReportFrance = "9";


                SessionHandler.FCSelectedYear = ReportSettings.GetCurrentYear();
                SessionHandler.FCSelectedMonth = ReportSettings.GetCurrentMonth();
                //SessionHandler.FCSelectedCurrencyId = ReportSettings.GetLastFCTCurrencyId();

                txtReportDayDate.Text = APP.Settings.ReportSettings.GetToday();
                SessionHandler.FCSelectedDay = APP.Settings.ReportSettings.GetToday();

                FillForm();
                SetFormAccess();
                this.UpdatePanelFleetCash.Update();
            }
        }

        private void SetFormAccess()
        {
            if (SessionHandler.UserRole == "ADMINISTRATOR")
            {
                // Benelux Receivables
                txtBLXRecBalanceInit.Enabled = true;
                txtBLXRecBalanceVat.Enabled = true;
                txtBLXRecBalanceEnd.Enabled = true;
                txtBLXRecTargetCE.Enabled = true;


                // Benelux Paybles
                txtBLXPayBalanceInit.Enabled = true;
                txtBLXPayBalanceVat.Enabled = true;
                txtBLXPayBalanceEnd.Enabled = true;
                txtBLXPayTargetCE.Enabled = true;


                //Germany Receivables
                txtGERecBalanceInit.Enabled = true;
                txtGERecBalanceVat.Enabled = true;
                txtGERecBalanceEnd.Enabled = true;
                txtGERecTargetCE.Enabled = true;


                //Germany Payables
                txtGEPayBalanceInit.Enabled = true;
                txtGEPayBalanceVat.Enabled = true;
                txtGEPayBalanceEnd.Enabled = true;
                txtGEPayTargetCE.Enabled = true;



                //Netherlands Receivables
                txtNERecBalanceInit.Enabled = true;
                txtNERecBalanceVat.Enabled = true;
                txtNERecBalanceEnd.Enabled = true;
                txtNERecTargetCE.Enabled = true;


                //Netherlands Payables
                txtNEPayBalanceInit.Enabled = true;
                txtNEPayBalanceVat.Enabled = true;
                txtNEPayBalanceEnd.Enabled = true;
                txtNEPayTargetCE.Enabled = true;


                //Switzerland Receivales
                txtSZRecBalanceInit.Enabled = true;
                txtSZRecBalanceVat.Enabled = true;
                txtSZRecBalanceEnd.Enabled = true;
                txtSZRecTargetCE.Enabled = true;


                //Switzerland Payables
                txtSZPayBalanceInit.Enabled = true;
                txtSZPayBalanceVat.Enabled = true;
                txtSZPayBalanceEnd.Enabled = true;
                txtSZPayTargetCE.Enabled = true;


                //UK Receivables
                txtUKRecBalanceInit.Enabled = true;
                txtUKRecBalanceVat.Enabled = true;
                txtUKRecBalanceEnd.Enabled = true;
                txtUKRecTargetCE.Enabled = true;


                //UK PAyables
                txtUKPayBalanceInit.Enabled = true;
                txtUKPayBalanceVat.Enabled = true;
                txtUKPayBalanceEnd.Enabled = true;
                txtUKPayTargetCE.Enabled = true;


                //France Receivables
                txtFRRecBalanceInit.Enabled = true;
                txtFRRecBalanceVat.Enabled = true;
                txtFRRecBalanceEnd.Enabled = true;
                txtFRRecTargetCE.Enabled = true;


                //France Payables
                txtFRPayBalanceInit.Enabled = true;
                txtFRPayBalanceVat.Enabled = true;
                txtFRPayBalanceEnd.Enabled = true;
                txtFRPayTargetCE.Enabled = true;


                //Italy Receivables
                txtITRecBalanceInit.Enabled = true;
                txtITRecBalanceVat.Enabled = true;
                txtITRecBalanceEnd.Enabled = true;
                txtITRecTargetCE.Enabled = true;


                //Italy Payables
                txtITPayBalanceInit.Enabled = true;
                txtITPayBalanceVat.Enabled = true;
                txtITPayBalanceEnd.Enabled = true;
                txtITPayTargetCE.Enabled = true;

                //Spain Receivables
                txtSPRecBalanceInit.Enabled = true;
                txtSPRecBalanceVat.Enabled = true;
                txtSPRecBalanceEnd.Enabled = true;
                txtSPRecTargetCE.Enabled = true;


                //Spain Payables
                txtSPPayBalanceInit.Enabled = true;
                txtSPPayBalanceVat.Enabled = true;
                txtSPPayBalanceEnd.Enabled = true;
                txtSPPayTargetCE.Enabled = true;

            }
            else
            {
                // Benelux Receivables
                txtBLXRecBalanceInit.Enabled = false;
                txtBLXRecBalanceVat.Enabled = false;
                txtBLXRecBalanceEnd.Enabled = false;
                txtBLXRecTargetCE.Enabled = false;
              

                // Benelux Paybles
                txtBLXPayBalanceInit.Enabled = false;
                txtBLXPayBalanceVat.Enabled = false;
                txtBLXPayBalanceEnd.Enabled = false;
                txtBLXPayTargetCE.Enabled = false;
               

                //Germany Receivables
                txtGERecBalanceInit.Enabled = false;
                txtGERecBalanceVat.Enabled = false;
                txtGERecBalanceEnd.Enabled = false;
                txtGERecTargetCE.Enabled = false;
              

                //Germany Payables
                txtGEPayBalanceInit.Enabled = false;
                txtGEPayBalanceVat.Enabled = false;
                txtGEPayBalanceEnd.Enabled = false;
                txtGEPayTargetCE.Enabled = false;
              


                //Netherlands Receivables
                txtNERecBalanceInit.Enabled = false;
                txtNERecBalanceVat.Enabled = false;
                txtNERecBalanceEnd.Enabled = false;
                txtNERecTargetCE.Enabled = false;
               

                //Netherlands Payables
                txtNEPayBalanceInit.Enabled = false;
                txtNEPayBalanceVat.Enabled = false;
                txtNEPayBalanceEnd.Enabled = false;
                txtNEPayTargetCE.Enabled = false;
               

                //Switzerland Receivales
                txtSZRecBalanceInit.Enabled = false;
                txtSZRecBalanceVat.Enabled = false;
                txtSZRecBalanceEnd.Enabled = false;
                txtSZRecTargetCE.Enabled = false;
               

                //Switzerland Payables
                txtSZPayBalanceInit.Enabled = false;
                txtSZPayBalanceVat.Enabled = false;
                txtSZPayBalanceEnd.Enabled = false;
                txtSZPayTargetCE.Enabled = false;
               

                //UK Receivables
                txtUKRecBalanceInit.Enabled = false;
                txtUKRecBalanceVat.Enabled = false;
                txtUKRecBalanceEnd.Enabled = false;
                txtUKRecTargetCE.Enabled = false;
              

                //UK PAyables
                txtUKPayBalanceInit.Enabled = false;
                txtUKPayBalanceVat.Enabled = false;
                txtUKPayBalanceEnd.Enabled = false;
                txtUKPayTargetCE.Enabled = false;
              

                //France Receivables
                txtFRRecBalanceInit.Enabled = false;
                txtFRRecBalanceVat.Enabled = false;
                txtFRRecBalanceEnd.Enabled = false;
                txtFRRecTargetCE.Enabled = false;
               

                //France Payables
                txtFRPayBalanceInit.Enabled = false;
                txtFRPayBalanceVat.Enabled = false;
                txtFRPayBalanceEnd.Enabled = false;
                txtFRPayTargetCE.Enabled = false;
               

                //Italy Receivables
                txtITRecBalanceInit.Enabled = false;
                txtITRecBalanceVat.Enabled = false;
                txtITRecBalanceEnd.Enabled = false;
                txtITRecTargetCE.Enabled = false;
              

                //Italy Payables
                txtITPayBalanceInit.Enabled = false;
                txtITPayBalanceVat.Enabled = false;
                txtITPayBalanceEnd.Enabled = false;
                txtITPayTargetCE.Enabled = false;
              
                //Spain Receivables
                txtSPRecBalanceInit.Enabled = false;
                txtSPRecBalanceVat.Enabled = false;
                txtSPRecBalanceEnd.Enabled = false;
                txtSPRecTargetCE.Enabled = false;
               

                //Spain Payables
                txtSPPayBalanceInit.Enabled = false;
                txtSPPayBalanceVat.Enabled = false;
                txtSPPayBalanceEnd.Enabled = false;
                txtSPPayTargetCE.Enabled = false;
                              
            }
        }

        protected void OnCommand(object sender, CommandEventArgs e)
        {
            if (e.CommandName == "Save")
            {
                AddReceivablesValuesBLX();
                AddPayablesValuesBLX();
                AddReceivablesValuesGE();
                AddPayablesValuesGE();
                AddReceivablesValuesNE();
                AddPayablesValuesNE();
                AddReceivablesValuesSZ();
                AddPayablesValuesSZ();
                AddReceivablesValuesUK();
                AddPayablesValuesUK();
                AddReceivablesValuesFR();
                AddPayablesValuesFR();
                AddReceivablesValuesIT();
                AddPayablesValuesIT();
                AddReceivablesValuesSP();
                AddPayablesValuesSP();

                ClearForm();
                FillForm();

                this.UpdatePanelFleetCash.Update();

            }
            else if (e.CommandName == "Export")
            {
                if (txtReportDayDate.Text == String.Empty)
                {
                    SessionHandler.FCSelectedDay = txtReportDayDate.Text;
                }
                else
                {
                    SessionHandler.FCSelectedDay = txtReportDayDate.Text;
                }
                ExportToExcel();
            }
        }

        protected void txtReportDayDate_TextChanged(object sender, EventArgs e)
        {
            RefreshForm();

            if (txtReportDayDate.Text != APP.Settings.ReportSettings.GetToday())
            {
                this.ButtonCommandSave.Visible = false;
            }
            else
            {
                this.ButtonCommandSave.Visible = true;
            }
        }

        private void RefreshForm()
        {
            ClearForm();

            if (txtReportDayDate.Text == String.Empty)
            {
                SessionHandler.FCSelectedDay = txtReportDayDate.Text;
                txtReportDayDate.Text = APP.Settings.ReportSettings.GetToday();
            }
            else
            {
                SessionHandler.FCSelectedDay = txtReportDayDate.Text;
            }

            ClearForm();
            FillForm();
            this.UpdatePanelFleetCash.Update();
        
        }

        #region "Update"

        private void AddReceivablesValuesBLX()
        {
            AddRecord(SessionHandler.FTCReportBelux, SessionHandler.FTCReportTypeReceivables, 1, txtBLXRecBalanceInit.Text,
               txtBLXRecBalanceVat.Text, txtBLXRecBalanceEnd.Text, txtBLXRecTargetCE.Text, txtBLXRecCollection.Text, txtBLXRecNotes.Text,
               TextBoxNotesBLXRecExpected.Text, txtBLXRecMtd.Text,
               txtBLXRecExpected.Text); 
        }

        private void AddPayablesValuesBLX()
        {
            AddRecord(SessionHandler.FTCReportBelux, SessionHandler.FTCReportTypePayables, 1, txtBLXPayBalanceInit.Text,
               txtBLXPayBalanceVat.Text, txtBLXPayBalanceEnd.Text, txtBLXPayTargetCE.Text, txtBLXPayCollection.Text, txtBLXPayNotes.Text,
               TextBoxNotesBLXPayExpected.Text, txtBLXPayMtd.Text,
               txtBLXPayExpected.Text); 
        }

        private void AddReceivablesValuesGE()
        {
            AddRecord(SessionHandler.FTCReportGermany, SessionHandler.FTCReportTypeReceivables, 1, txtGERecBalanceInit.Text,
               txtGERecBalanceVat.Text, txtGERecBalanceEnd.Text, txtGERecTargetCE.Text, txtGERecCollection.Text, txtGERecNotes.Text,
               TextBoxNotesGERecExpected.Text, txtGERecMtd.Text,
               txtGERecExpected.Text); 
        }

        private void AddPayablesValuesGE()
        {
            AddRecord(SessionHandler.FTCReportGermany, SessionHandler.FTCReportTypePayables, 1, txtGEPayBalanceInit.Text,
              txtGEPayBalanceVat.Text, txtGEPayBalanceEnd.Text, txtGEPayTargetCE.Text, txtGEPayCollection.Text, txtGEPayNotes.Text,
              TextBoxNotesGEPayExpected.Text, txtGEPayMtd.Text,
              txtGEPayExpected.Text); 
        }

        private void AddReceivablesValuesNE()
        {
            AddRecord(SessionHandler.FTCReportNetherlands, SessionHandler.FTCReportTypeReceivables, 1, txtNERecBalanceInit.Text,
               txtNERecBalanceVat.Text, txtNERecBalanceEnd.Text, txtNERecTargetCE.Text, txtNERecCollection.Text, txtNERecNotes.Text,
               TextBoxNotesNERecExpected.Text, txtNERecMtd.Text,
               txtNERecExpected.Text); 
        }

        private void AddPayablesValuesNE()
        {
            AddRecord(SessionHandler.FTCReportNetherlands, SessionHandler.FTCReportTypePayables, 1, txtNEPayBalanceInit.Text,
               txtNEPayBalanceVat.Text, txtNEPayBalanceEnd.Text, txtNEPayTargetCE.Text, txtNEPayCollection.Text, txtNEPayNotes.Text,
               TextBoxNotesNEPayExpected.Text, txtNEPayMtd.Text,
               txtNEPayExpected.Text); 
        }

        private void AddReceivablesValuesSZ()
        {
            AddRecord(SessionHandler.FTCReportSwitzerland, SessionHandler.FTCReportTypeReceivables, 2, txtSZRecBalanceInit.Text,
               txtSZRecBalanceVat.Text, txtSZRecBalanceEnd.Text, txtSZRecTargetCE.Text, txtSZRecCollection.Text, txtSZRecNotes.Text,
               TextBoxNotesSZRecExpected.Text, txtSZRecMtd.Text,
               txtSZRecExpected.Text); 
        }

        private void AddPayablesValuesSZ()
        {
            AddRecord(SessionHandler.FTCReportSwitzerland, SessionHandler.FTCReportTypePayables, 2, txtSZPayBalanceInit.Text,
               txtSZPayBalanceVat.Text, txtSZPayBalanceEnd.Text, txtSZPayTargetCE.Text, txtSZPayCollection.Text, txtSZPayNotes.Text,
               TextBoxNotesSZPayExpected.Text, txtSZPayMtd.Text,
               txtSZPayExpected.Text); 
        }

        private void AddReceivablesValuesUK()
        {
            AddRecord(SessionHandler.FTCReportUKRAC, SessionHandler.FTCReportTypeReceivables, 3, txtUKRecBalanceInit.Text,
               txtUKRecBalanceVat.Text, txtUKRecBalanceEnd.Text, txtUKRecTargetCE.Text, txtUKRecCollection.Text, txtUKRecNotes.Text,
               TextBoxNotesUKRecExpected.Text, txtUKRecMtd.Text,
               txtUKRecExpected.Text); 
        }

        private void AddPayablesValuesUK()
        {
            AddRecord(SessionHandler.FTCReportUKRAC, SessionHandler.FTCReportTypePayables, 3, txtUKPayBalanceInit.Text,
                txtUKPayBalanceVat.Text, txtUKPayBalanceEnd.Text, txtUKPayTargetCE.Text, txtUKPayCollection.Text, txtUKPayNotes.Text,
                TextBoxNotesUKPayExpected.Text, txtUKPayMtd.Text,
                txtUKPayExpected.Text); 
        }

        private void AddReceivablesValuesFR()
        {
            AddRecord(SessionHandler.FTCReportFrance, SessionHandler.FTCReportTypeReceivables, 1, txtFRRecBalanceInit.Text,
                txtFRRecBalanceVat.Text, txtFRRecBalanceEnd.Text, txtFRRecTargetCE.Text, txtFRRecCollection.Text, txtFRRecNotes.Text,
                TextBoxNotesFRRecExpected.Text, txtFRRecMtd.Text,
                txtFRRecExpected.Text); 
        }

        private void AddPayablesValuesFR()
        {
            AddRecord(SessionHandler.FTCReportFrance, SessionHandler.FTCReportTypePayables, 1, txtFRPayBalanceInit.Text,
                txtFRPayBalanceVat.Text, txtFRPayBalanceEnd.Text, txtFRPayTargetCE.Text, txtFRPayCollection.Text, txtFRPayNotes.Text,
                TextBoxNotesFRPayExpected.Text, txtFRPayMtd.Text,
                txtFRPayExpected.Text); 

        }

        private void AddReceivablesValuesIT()
        {
            AddRecord(SessionHandler.FTCReportItaly, SessionHandler.FTCReportTypeReceivables, 1, txtITRecBalanceInit.Text,
                txtITRecBalanceVat.Text, txtITRecBalanceEnd.Text, txtITRecTargetCE.Text, txtITRecCollection.Text, txtITRecNotes.Text,
                TextBoxNotesITRecExpected.Text, txtITRecMtd.Text,
                txtITRecExpected.Text);  
        }

        private void AddPayablesValuesIT()
        {
            AddRecord(SessionHandler.FTCReportItaly, SessionHandler.FTCReportTypePayables, 1, txtITPayBalanceInit.Text,
                txtITPayBalanceVat.Text, txtITPayBalanceEnd.Text, txtITPayTargetCE.Text, txtITPayCollection.Text, txtITPayNotes.Text,
                TextBoxNotesITPayExpected.Text, txtITPayMtd.Text,
                txtITPayExpected.Text);   
        }

        private void AddReceivablesValuesSP()
        {
            AddRecord(SessionHandler.FTCReportSpain, SessionHandler.FTCReportTypeReceivables, 1, txtSPRecBalanceInit.Text,
                txtSPRecBalanceVat.Text, txtSPRecBalanceEnd.Text, txtSPRecTargetCE.Text, txtSPRecCollection.Text, txtSPRecNotes.Text,
                TextBoxNotesSPRecExpected.Text, txtSPRecMtd.Text,
                txtSPRecExpected.Text);   
        }

        private void AddPayablesValuesSP()
        {
            AddRecord(SessionHandler.FTCReportSpain, SessionHandler.FTCReportTypePayables, 1, txtSPPayBalanceInit.Text,
                txtSPPayBalanceVat.Text, txtSPPayBalanceEnd.Text, txtSPPayTargetCE.Text, txtSPPayCollection.Text, txtSPPayNotes.Text,
                TextBoxNotesSPPayExpected.Text, txtSPPayMtd.Text,
                txtSPPayExpected.Text);
        }

        private void AddRecord(string groupid,string reporttype,int currencyid,string balanceinit,string balancevat, string balanceend,
            string target,string collection,string notes,string notesexpected,string mtd,string expected)
        {
            try
            {
                SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = ConnectionManager.CreateProcedure(StoredProcedures.Report_FleetCash_Update, con);
                RAD.Data.Parameters.CreateParameter(cmd, "@groupId", groupid);
                RAD.Data.Parameters.CreateParameter(cmd, "@reportTypeId", reporttype);
                RAD.Data.Parameters.CreateParameter(cmd, "@racfId", SessionHandler.AuthenticationRacfId);
                RAD.Data.Parameters.CreateParameter(cmd, "@currencyId", currencyid);
                RAD.Data.Parameters.CreateParameter(cmd, "@balanceInt", balanceinit);
                RAD.Data.Parameters.CreateParameter(cmd, "@balanceVat", balancevat);
                RAD.Data.Parameters.CreateParameter(cmd, "@balanceEnd", balanceend);
                RAD.Data.Parameters.CreateParameter(cmd, "@targetAmt", target);
                RAD.Data.Parameters.CreateParameter(cmd, "@collectionTarget", collection);
                RAD.Data.Parameters.CreateParameter(cmd, "@notes", notes);
                RAD.Data.Parameters.CreateParameter(cmd, "@monthNumber", SessionHandler.FCSelectedMonth);
                RAD.Data.Parameters.CreateParameter(cmd, "@yearNumber", SessionHandler.FCSelectedYear);
                RAD.Data.Parameters.CreateParameter(cmd, "@notesExpected", notesexpected);
                RAD.Data.Parameters.CreateParameter(cmd, "@mtd", mtd);
                RAD.Data.Parameters.CreateParameter(cmd, "@expected", expected);
     

                ConnectionManager.ExecuteCommandNonQuery(con, cmd);
            }
            catch (Exception ex)
            {
                StackTrace errorStackTrace = new StackTrace(true);
                Logs.LogError(errorStackTrace, ex);
            }
        }

        #endregion

        #region "Search"

        public void ClearForm()
        {
            // Benelux Receivables
            txtBLXRecBalanceInit.Text = String.Empty;
            txtBLXRecBalanceVat.Text = String.Empty;
            txtBLXRecBalanceEnd.Text = String.Empty;
            txtBLXRecTargetCE.Text = String.Empty;
            txtBLXRecCollection.Text = String.Empty;
            txtBLXRecMtd.Text = String.Empty;
            txtBLXRecExpected.Text = String.Empty;
            TextBoxNotesBLXRecExpected.Text = String.Empty;
            txtBLXRecRemain.Text = String.Empty;
            txtBLXRecNotes.Text = String.Empty;

            // Benelux Paybles
            txtBLXPayBalanceInit.Text = String.Empty;
            txtBLXPayBalanceVat.Text = String.Empty;
            txtBLXPayBalanceEnd.Text = String.Empty;
            txtBLXPayTargetCE.Text = String.Empty;
            txtBLXPayCollection.Text = String.Empty;
            txtBLXPayMtd.Text = String.Empty;
            txtBLXPayExpected.Text = String.Empty;
            TextBoxNotesBLXPayExpected.Text = String.Empty;
            txtBLXPayRemain.Text = String.Empty;
            txtBLXPayNotes.Text = String.Empty;

            //Germany Receivables
            txtGERecBalanceInit.Text = String.Empty;
            txtGERecBalanceVat.Text = String.Empty;
            txtGERecBalanceEnd.Text = String.Empty;
            txtGERecTargetCE.Text = String.Empty;
            txtGERecCollection.Text = String.Empty;
            txtGERecMtd.Text = String.Empty;
            txtGERecExpected.Text = String.Empty;
            TextBoxNotesGERecExpected.Text = String.Empty;
            txtGERecRemain.Text = String.Empty;
            txtGERecNotes.Text = String.Empty;

            //Germany Payables
            txtGEPayBalanceInit.Text = String.Empty;
            txtGEPayBalanceVat.Text = String.Empty;
            txtGEPayBalanceEnd.Text = String.Empty;
            txtGEPayTargetCE.Text = String.Empty;
            txtGEPayCollection.Text = String.Empty;
            txtGEPayMtd.Text = String.Empty;
            txtGEPayExpected.Text = String.Empty;
            TextBoxNotesGEPayExpected.Text = String.Empty;
            txtGEPayRemain.Text = String.Empty;
            txtGEPayNotes.Text = String.Empty;


            //Netherlands Receivables
            txtNERecBalanceInit.Text = String.Empty;
            txtNERecBalanceVat.Text = String.Empty;
            txtNERecBalanceEnd.Text = String.Empty;
            txtNERecTargetCE.Text = String.Empty;
            txtNERecCollection.Text = String.Empty;
            txtNERecMtd.Text = String.Empty;
            txtNERecExpected.Text = String.Empty;
            TextBoxNotesNERecExpected.Text = String.Empty;
            txtNERecRemain.Text = String.Empty;
            txtNERecNotes.Text = String.Empty;

            //Netherlands Payables
            txtNEPayBalanceInit.Text = String.Empty;
            txtNEPayBalanceVat.Text = String.Empty;
            txtNEPayBalanceEnd.Text = String.Empty;
            txtNEPayTargetCE.Text = String.Empty;
            txtNEPayCollection.Text = String.Empty;
            txtNEPayMtd.Text = String.Empty;
            txtNEPayExpected.Text = String.Empty;
            TextBoxNotesNEPayExpected.Text = String.Empty;
            txtNEPayRemain.Text = String.Empty;
            txtNEPayNotes.Text = String.Empty;

            //Switzerland Receivales
            txtSZRecBalanceInit.Text = String.Empty;
            txtSZRecBalanceVat.Text = String.Empty;
            txtSZRecBalanceEnd.Text = String.Empty;
            txtSZRecTargetCE.Text = String.Empty;
            txtSZRecCollection.Text = String.Empty;
            txtSZRecMtd.Text = String.Empty;
            txtSZRecExpected.Text = String.Empty;
            TextBoxNotesSZRecExpected.Text = String.Empty;
            txtSZRecRemain.Text = String.Empty;
            txtSZRecNotes.Text = String.Empty;

            //Switzerland Payables
            txtSZPayBalanceInit.Text = String.Empty;
            txtSZPayBalanceVat.Text = String.Empty;
            txtSZPayBalanceEnd.Text = String.Empty;
            txtSZPayTargetCE.Text = String.Empty;
            txtSZPayCollection.Text = String.Empty;
            txtSZPayMtd.Text = String.Empty;
            txtSZPayExpected.Text = String.Empty;
            TextBoxNotesSZPayExpected.Text = String.Empty;
            txtSZPayRemain.Text = String.Empty;
            txtSZPayNotes.Text = String.Empty;

            //UK Receivables
            txtUKRecBalanceInit.Text = String.Empty;
            txtUKRecBalanceVat.Text = String.Empty;
            txtUKRecBalanceEnd.Text = String.Empty;
            txtUKRecTargetCE.Text = String.Empty;
            txtUKRecCollection.Text = String.Empty;
            txtUKRecMtd.Text = String.Empty;
            txtUKRecExpected.Text = String.Empty;
            TextBoxNotesUKRecExpected.Text = String.Empty;
            txtUKRecRemain.Text = String.Empty;
            txtUKRecNotes.Text = String.Empty;

            //UK PAyables
            txtUKPayBalanceInit.Text = String.Empty;
            txtUKPayBalanceVat.Text = String.Empty;
            txtUKPayBalanceEnd.Text = String.Empty;
            txtUKPayTargetCE.Text = String.Empty;
            txtUKPayCollection.Text = String.Empty;
            txtUKPayMtd.Text = String.Empty;
            txtUKPayExpected.Text = String.Empty;
            TextBoxNotesUKPayExpected.Text = String.Empty;
            txtUKPayRemain.Text = String.Empty;
            txtUKPayNotes.Text = String.Empty;


            // Region North
            txtRNRecBalanceInit.Text = String.Empty;
            txtRNRecBalanceVat.Text = String.Empty;
            txtRNRecBalanceEnd.Text = String.Empty;
            txtRNRecTargetCE.Text = String.Empty;
            txtRNRecCollection.Text = String.Empty;
            txtRNRecMtd.Text = String.Empty;
            txtRNRecExpected.Text = String.Empty;
            txtRNRecRemain.Text = String.Empty;

            txtRNPayBalanceInit.Text = String.Empty;
            txtRNPayBalanceVat.Text = String.Empty;
            txtRNPayBalanceEnd.Text = String.Empty;
            txtRNPayTargetCE.Text = String.Empty;
            txtRNPayCollection.Text = String.Empty;
            txtRNPayMtd.Text = String.Empty;
            txtRNPayExpected.Text = String.Empty;
            txtRNPayRemain.Text = String.Empty;

            //France Receivables
            txtFRRecBalanceInit.Text = String.Empty;
            txtFRRecBalanceVat.Text = String.Empty;
            txtFRRecBalanceEnd.Text = String.Empty;
            txtFRRecTargetCE.Text = String.Empty;
            txtFRRecCollection.Text = String.Empty;
            txtFRRecMtd.Text = String.Empty;
            txtFRRecExpected.Text = String.Empty;
            TextBoxNotesFRRecExpected.Text = String.Empty;
            txtFRRecRemain.Text = String.Empty;
            txtFRRecNotes.Text = String.Empty;

            //France Payables
            txtFRPayBalanceInit.Text = String.Empty;
            txtFRPayBalanceVat.Text = String.Empty;
            txtFRPayBalanceEnd.Text = String.Empty;
            txtFRPayTargetCE.Text = String.Empty;
            txtFRPayCollection.Text = String.Empty;
            txtFRPayMtd.Text = String.Empty;
            txtFRPayExpected.Text = String.Empty;
            TextBoxNotesFRPayExpected.Text = String.Empty;
            txtFRPayRemain.Text = String.Empty;
            txtFRPayNotes.Text = String.Empty;

            //Italy Receivables
            txtITRecBalanceInit.Text = String.Empty;
            txtITRecBalanceVat.Text = String.Empty;
            txtITRecBalanceEnd.Text = String.Empty;
            txtITRecTargetCE.Text = String.Empty;
            txtITRecCollection.Text = String.Empty;
            txtITRecMtd.Text = String.Empty;
            txtITRecExpected.Text = String.Empty;
            TextBoxNotesITRecExpected.Text = String.Empty;
            txtITRecRemain.Text = String.Empty;
            txtITRecNotes.Text = String.Empty;

            //Italy Payables
            txtITPayBalanceInit.Text = String.Empty;
            txtITPayBalanceVat.Text = String.Empty;
            txtITPayBalanceEnd.Text = String.Empty;
            txtITPayTargetCE.Text = String.Empty;
            txtITPayCollection.Text = String.Empty;
            txtITPayMtd.Text = String.Empty;
            txtITPayExpected.Text = String.Empty;
            TextBoxNotesITPayExpected.Text = String.Empty;
            txtITPayRemain.Text = String.Empty;
            txtITPayNotes.Text = String.Empty;

            //Spain Receivables
            txtSPRecBalanceInit.Text = String.Empty;
            txtSPRecBalanceVat.Text = String.Empty;
            txtSPRecBalanceEnd.Text = String.Empty;
            txtSPRecTargetCE.Text = String.Empty;
            txtSPRecCollection.Text = String.Empty;
            txtSPRecMtd.Text = String.Empty;
            txtSPRecExpected.Text = String.Empty;
            TextBoxNotesSPRecExpected.Text = String.Empty;
            txtSPRecRemain.Text = String.Empty;
            txtSPRecNotes.Text = String.Empty;

            //Spain Payables
            txtSPPayBalanceInit.Text = String.Empty;
            txtSPPayBalanceVat.Text = String.Empty;
            txtSPPayBalanceEnd.Text = String.Empty;
            txtSPPayTargetCE.Text = String.Empty;
            txtSPPayCollection.Text = String.Empty;
            txtSPPayMtd.Text = String.Empty;
            txtSPPayExpected.Text = String.Empty;
            TextBoxNotesSPPayExpected.Text = String.Empty;
            txtSPPayRemain.Text = String.Empty;
            txtSPPayNotes.Text = String.Empty;


            //Region South
            txtRSRecBalanceInit.Text = String.Empty;
            txtRSRecBalanceVat.Text = String.Empty;
            txtRSRecBalanceEnd.Text = String.Empty;
            txtRSRecTargetCE.Text = String.Empty;
            txtRSRecCollection.Text = String.Empty;
            txtRSRecMtd.Text = String.Empty;
            txtRSRecExpected.Text = String.Empty;
            txtRSRecRemain.Text = String.Empty;

            txtRSPayBalanceInit.Text = String.Empty;
            txtRSPayBalanceVat.Text = String.Empty;
            txtRSPayBalanceEnd.Text = String.Empty;
            txtRSPayTargetCE.Text = String.Empty;
            txtRSPayCollection.Text = String.Empty;
            txtRSPayMtd.Text = String.Empty;
            txtRSPayExpected.Text = String.Empty;
            txtRSPayRemain.Text = String.Empty;

            //Report Total
            txtTTRecBalanceInit.Text = String.Empty;
            txtTTRecBalanceVat.Text = String.Empty;
            txtTTRecBalanceEnd.Text = String.Empty;
            txtTTRecTargetCE.Text = String.Empty;
            txtTTRecCollection.Text = String.Empty;
            txtTTRecMtd.Text = String.Empty;
            txtTTRecExpected.Text = String.Empty;
            txtTTRecRemain.Text = String.Empty;

            txtTTPayBalanceInit.Text = String.Empty;
            txtTTPayBalanceVat.Text = String.Empty;
            txtTTPayBalanceEnd.Text = String.Empty;
            txtTTPayTargetCE.Text = String.Empty;
            txtTTPayCollection.Text = String.Empty;
            txtTTPayMtd.Text = String.Empty;
            txtTTPayExpected.Text = String.Empty;
            txtTTPayRemain.Text = String.Empty;

        }

        public void FillForm()
        {
            SelectValuesBLX();
            SelectValuesGE();
            SelectValuesNE();
            SelectValuesSZ();
            SelectValuesUK();
            SelectValuesFR();
            SelectValuesIT();
            SelectValuesSP();
            SelectRegionNorth();
            SelectRegionSouth();
            SelectRegionTotal();

        }

        public void SelectValuesBLX()
        {
            var result = new List<APP.Reports.FCTDetails>();
            result = APP.Reports.FCTDetails.SelectFleetCashTargetReport(Convert.ToInt32(SessionHandler.FTCReportBelux), Convert.ToInt32(SessionHandler.FTCReportTypeReceivables));

            if (result.Count >= 1)
            {
                var balanceInit = result.Select(b => b.BalanceInit);
                txtBLXRecBalanceInit.Text = Convert.ToString(balanceInit.Single());
                var balanceVat = result.Select(b => b.BalanceVat);
                txtBLXRecBalanceVat.Text = Convert.ToString(balanceVat.Single());
                var balanceEnd = result.Select(b => b.BalanceEnd);
                txtBLXRecBalanceEnd.Text = Convert.ToString(balanceEnd.Single());
                var targetAmt = result.Select(b => b.TargetAmt);
                txtBLXRecTargetCE.Text = Convert.ToString(targetAmt.Single());

                var collectionTarget = result.Select(b => b.CollectionsTarget);
                txtBLXRecCollection.Text = Convert.ToString(collectionTarget.Single());

                var mtd = result.Select(b => b.Mtd);
                txtBLXRecMtd.Text = Convert.ToString(mtd.Single());
                var expected = result.Select(b => b.Expected);
                txtBLXRecExpected.Text = Convert.ToString(expected.Single());
                var remaining = result.Select(b => b.Remaining);
                txtBLXRecRemain.Text = Convert.ToString(remaining.Single());
                var note = result.Select(b => b.Note);
                txtBLXRecNotes.Text = Convert.ToString(note.Single());
                var noteExpected = result.Select(n => n.NoteExpected);
                TextBoxNotesBLXRecExpected.Text = Convert.ToString(noteExpected.Single());

            }
           

            result = APP.Reports.FCTDetails.SelectFleetCashTargetReport(Convert.ToInt32(SessionHandler.FTCReportBelux), Convert.ToInt32(SessionHandler.FTCReportTypePayables));

            if (result.Count >= 1)
            {
                var balanceInit = result.Select(b => b.BalanceInit);
                txtBLXPayBalanceInit.Text = Convert.ToString(balanceInit.Single());
                var balanceVat = result.Select(b => b.BalanceVat);
                txtBLXPayBalanceVat.Text = Convert.ToString(balanceVat.Single());
                var balanceEnd = result.Select(b => b.BalanceEnd);
                txtBLXPayBalanceEnd.Text = Convert.ToString(balanceEnd.Single());
                var targetAmt = result.Select(b => b.TargetAmt);
                txtBLXPayTargetCE.Text = Convert.ToString(targetAmt.Single());

                var collectionTarget = result.Select(b => b.CollectionsTarget);
                txtBLXPayCollection.Text = Convert.ToString(collectionTarget.Single());


                var mtd = result.Select(b => b.Mtd);
                txtBLXPayMtd.Text = Convert.ToString(mtd.Single());
                var expected = result.Select(b => b.Expected);
                txtBLXPayExpected.Text = Convert.ToString(expected.Single());
                var remaining = result.Select(b => b.Remaining);
                txtBLXPayRemain.Text = Convert.ToString(remaining.Single());
                var note = result.Select(b => b.Note);
                txtBLXPayNotes.Text = Convert.ToString(note.Single());
                var noteExpected = result.Select(n => n.NoteExpected);
                TextBoxNotesBLXPayExpected.Text = Convert.ToString(noteExpected.Single());
            }
            
        }

        public void SelectValuesGE()
        {
            var result = new List<APP.Reports.FCTDetails>();
            result = APP.Reports.FCTDetails.SelectFleetCashTargetReport(Convert.ToInt32(SessionHandler.FTCReportGermany), Convert.ToInt32(SessionHandler.FTCReportTypeReceivables));

            if (result.Count >= 1)
            {
                var balanceInit = result.Select(b => b.BalanceInit);
                txtGERecBalanceInit.Text = Convert.ToString(balanceInit.Single());
                var balanceVat = result.Select(b => b.BalanceVat);
                txtGERecBalanceVat.Text = Convert.ToString(balanceVat.Single());
                var balanceEnd = result.Select(b => b.BalanceEnd);
                txtGERecBalanceEnd.Text = Convert.ToString(balanceEnd.Single());
                var targetAmt = result.Select(b => b.TargetAmt);
                txtGERecTargetCE.Text = Convert.ToString(targetAmt.Single());

                var collectionTarget = result.Select(b => b.CollectionsTarget);
                txtGERecCollection.Text = Convert.ToString(collectionTarget.Single());


                var mtd = result.Select(b => b.Mtd);
                txtGERecMtd.Text = Convert.ToString(mtd.Single());
                var expected = result.Select(b => b.Expected);
                txtGERecExpected.Text = Convert.ToString(expected.Single());
                var remaining = result.Select(b => b.Remaining);
                txtGERecRemain.Text = Convert.ToString(remaining.Single());
                var note = result.Select(b => b.Note);
                txtGERecNotes.Text = Convert.ToString(note.Single());
                var noteExpected = result.Select(n => n.NoteExpected);
                TextBoxNotesGERecExpected.Text = Convert.ToString(noteExpected.Single());
            }

            result = APP.Reports.FCTDetails.SelectFleetCashTargetReport(Convert.ToInt32(SessionHandler.FTCReportGermany), Convert.ToInt32(SessionHandler.FTCReportTypePayables));

            if (result.Count >= 1)
            {
                var balanceInit = result.Select(b => b.BalanceInit);
                txtGEPayBalanceInit.Text = Convert.ToString(balanceInit.Single());
                var balanceVat = result.Select(b => b.BalanceVat);
                txtGEPayBalanceVat.Text = Convert.ToString(balanceVat.Single());
                var balanceEnd = result.Select(b => b.BalanceEnd);
                txtGEPayBalanceEnd.Text = Convert.ToString(balanceEnd.Single());
                var targetAmt = result.Select(b => b.TargetAmt);
                txtGEPayTargetCE.Text = Convert.ToString(targetAmt.Single());

                var collectionTarget = result.Select(b => b.CollectionsTarget);
                txtGEPayCollection.Text = Convert.ToString(collectionTarget.Single());

                var mtd = result.Select(b => b.Mtd);
                txtGEPayMtd.Text = Convert.ToString(mtd.Single());
                var expected = result.Select(b => b.Expected);
                txtGEPayExpected.Text = Convert.ToString(expected.Single());
                var remaining = result.Select(b => b.Remaining);
                txtGEPayRemain.Text = Convert.ToString(remaining.Single());
                var note = result.Select(b => b.Note);
                txtGEPayNotes.Text = Convert.ToString(note.Single());
                var noteExpected = result.Select(n => n.NoteExpected);
                TextBoxNotesGEPayExpected.Text = Convert.ToString(noteExpected.Single());
            }
        }

        public void SelectValuesNE()
        {
            var result = new List<APP.Reports.FCTDetails>();
            result = APP.Reports.FCTDetails.SelectFleetCashTargetReport(Convert.ToInt32(SessionHandler.FTCReportNetherlands), Convert.ToInt32(SessionHandler.FTCReportTypeReceivables));

            if (result.Count >= 1)
            {
                var balanceInit = result.Select(b => b.BalanceInit);
                txtNERecBalanceInit.Text = Convert.ToString(balanceInit.Single());
                var balanceVat = result.Select(b => b.BalanceVat);
                txtNERecBalanceVat.Text = Convert.ToString(balanceVat.Single());
                var balanceEnd = result.Select(b => b.BalanceEnd);
                txtNERecBalanceEnd.Text = Convert.ToString(balanceEnd.Single());
                var targetAmt = result.Select(b => b.TargetAmt);
                txtNERecTargetCE.Text = Convert.ToString(targetAmt.Single());

                var collectionTarget = result.Select(b => b.CollectionsTarget);
                txtNERecCollection.Text = Convert.ToString(collectionTarget.Single());

                var mtd = result.Select(b => b.Mtd);
                txtNERecMtd.Text = Convert.ToString(mtd.Single());
                var expected = result.Select(b => b.Expected);
                txtNERecExpected.Text = Convert.ToString(expected.Single());
                var remaining = result.Select(b => b.Remaining);
                txtNERecRemain.Text = Convert.ToString(remaining.Single());
                var note = result.Select(b => b.Note);
                txtNERecNotes.Text = Convert.ToString(note.Single());
                var noteExpected = result.Select(n => n.NoteExpected);
                TextBoxNotesNERecExpected.Text = Convert.ToString(noteExpected.Single());
            }

            result = APP.Reports.FCTDetails.SelectFleetCashTargetReport(Convert.ToInt32(SessionHandler.FTCReportNetherlands), Convert.ToInt32(SessionHandler.FTCReportTypePayables));

            if (result.Count >= 1)
            {
                var balanceInit = result.Select(b => b.BalanceInit);
                txtNEPayBalanceInit.Text = Convert.ToString(balanceInit.Single());
                var balanceVat = result.Select(b => b.BalanceVat);
                txtNEPayBalanceVat.Text = Convert.ToString(balanceVat.Single());
                var balanceEnd = result.Select(b => b.BalanceEnd);
                txtNEPayBalanceEnd.Text = Convert.ToString(balanceEnd.Single());
                var targetAmt = result.Select(b => b.TargetAmt);
                txtNEPayTargetCE.Text = Convert.ToString(targetAmt.Single());

                var collectionTarget = result.Select(b => b.CollectionsTarget);
                txtNEPayCollection.Text = Convert.ToString(collectionTarget.Single());

                var mtd = result.Select(b => b.Mtd);
                txtNEPayMtd.Text = Convert.ToString(mtd.Single());
                var expected = result.Select(b => b.Expected);
                txtNEPayExpected.Text = Convert.ToString(expected.Single());
                var remaining = result.Select(b => b.Remaining);
                txtNEPayRemain.Text = Convert.ToString(remaining.Single());
                var note = result.Select(b => b.Note);
                txtNEPayNotes.Text = Convert.ToString(note.Single());
                var noteExpected = result.Select(n => n.NoteExpected);
                TextBoxNotesNEPayExpected.Text = Convert.ToString(noteExpected.Single());
            }
        }

        public void SelectValuesSZ()
        {
            var result = new List<APP.Reports.FCTDetails>();
            result = APP.Reports.FCTDetails.SelectFleetCashTargetReport(Convert.ToInt32(SessionHandler.FTCReportSwitzerland), Convert.ToInt32(SessionHandler.FTCReportTypeReceivables));

            if (result.Count >= 1)
            {
                var balanceInit = result.Select(b => b.BalanceInit);
                txtSZRecBalanceInit.Text = Convert.ToString(balanceInit.Single());
                var balanceVat = result.Select(b => b.BalanceVat);
                txtSZRecBalanceVat.Text = Convert.ToString(balanceVat.Single());
                var balanceEnd = result.Select(b => b.BalanceEnd);
                txtSZRecBalanceEnd.Text = Convert.ToString(balanceEnd.Single());
                var targetAmt = result.Select(b => b.TargetAmt);
                txtSZRecTargetCE.Text = Convert.ToString(targetAmt.Single());

                var collectionTarget = result.Select(b => b.CollectionsTarget);
                txtSZRecCollection.Text = Convert.ToString(collectionTarget.Single());

                var mtd = result.Select(b => b.Mtd);
                txtSZRecMtd.Text = Convert.ToString(mtd.Single());
                var expected = result.Select(b => b.Expected);
                txtSZRecExpected.Text = Convert.ToString(expected.Single());
                var remaining = result.Select(b => b.Remaining);
                txtSZRecRemain.Text = Convert.ToString(remaining.Single());
                var note = result.Select(b => b.Note);
                txtSZRecNotes.Text = Convert.ToString(note.Single());
                var noteExpected = result.Select(n => n.NoteExpected);
                TextBoxNotesSZRecExpected.Text = Convert.ToString(noteExpected.Single());
            }

            result = APP.Reports.FCTDetails.SelectFleetCashTargetReport(Convert.ToInt32(SessionHandler.FTCReportSwitzerland), Convert.ToInt32(SessionHandler.FTCReportTypePayables));

            if (result.Count >= 1)
            {
                var balanceInit = result.Select(b => b.BalanceInit);
                txtSZPayBalanceInit.Text = Convert.ToString(balanceInit.Single());
                var balanceVat = result.Select(b => b.BalanceVat);
                txtSZPayBalanceVat.Text = Convert.ToString(balanceVat.Single());
                var balanceEnd = result.Select(b => b.BalanceEnd);
                txtSZPayBalanceEnd.Text = Convert.ToString(balanceEnd.Single());
                var targetAmt = result.Select(b => b.TargetAmt);
                txtSZPayTargetCE.Text = Convert.ToString(targetAmt.Single());

                var collectionTarget = result.Select(b => b.CollectionsTarget);
                txtSZPayCollection.Text = Convert.ToString(collectionTarget.Single());

                var mtd = result.Select(b => b.Mtd);
                txtSZPayMtd.Text = Convert.ToString(mtd.Single());
                var expected = result.Select(b => b.Expected);
                txtSZPayExpected.Text = Convert.ToString(expected.Single());
                var remaining = result.Select(b => b.Remaining);
                txtSZPayRemain.Text = Convert.ToString(remaining.Single());
                var note = result.Select(b => b.Note);
                txtSZPayNotes.Text = Convert.ToString(note.Single());
                var noteExpected = result.Select(n => n.NoteExpected);
                TextBoxNotesSZPayExpected.Text = Convert.ToString(noteExpected.Single());
            }
        }

        public void SelectValuesUK()
        {
            var result = new List<APP.Reports.FCTDetails>();
            result = APP.Reports.FCTDetails.SelectFleetCashTargetReport(Convert.ToInt32(SessionHandler.FTCReportUKRAC), Convert.ToInt32(SessionHandler.FTCReportTypeReceivables));

            if (result.Count >= 1)
            {
                var balanceInit = result.Select(b => b.BalanceInit);
                txtUKRecBalanceInit.Text = Convert.ToString(balanceInit.Single());
                var balanceVat = result.Select(b => b.BalanceVat);
                txtUKRecBalanceVat.Text = Convert.ToString(balanceVat.Single());
                var balanceEnd = result.Select(b => b.BalanceEnd);
                txtUKRecBalanceEnd.Text = Convert.ToString(balanceEnd.Single());
                var targetAmt = result.Select(b => b.TargetAmt);
                txtUKRecTargetCE.Text = Convert.ToString(targetAmt.Single());

                var collectionTarget = result.Select(b => b.CollectionsTarget);
                txtUKRecCollection.Text = Convert.ToString(collectionTarget.Single());

                var mtd = result.Select(b => b.Mtd);
                txtUKRecMtd.Text = Convert.ToString(mtd.Single());
                var expected = result.Select(b => b.Expected);
                txtUKRecExpected.Text = Convert.ToString(expected.Single());
                var remaining = result.Select(b => b.Remaining);
                txtUKRecRemain.Text = Convert.ToString(remaining.Single());
                var note = result.Select(b => b.Note);
                txtUKRecNotes.Text = Convert.ToString(note.Single());
                var noteExpected = result.Select(n => n.NoteExpected);
                TextBoxNotesUKRecExpected.Text = Convert.ToString(noteExpected.Single());
            }

            result = APP.Reports.FCTDetails.SelectFleetCashTargetReport(Convert.ToInt32(SessionHandler.FTCReportUKRAC), Convert.ToInt32(SessionHandler.FTCReportTypePayables));

            if (result.Count >= 1)
            {
                var balanceInit = result.Select(b => b.BalanceInit);
                txtUKPayBalanceInit.Text = Convert.ToString(balanceInit.Single());
                var balanceVat = result.Select(b => b.BalanceVat);
                txtUKPayBalanceVat.Text = Convert.ToString(balanceVat.Single());
                var balanceEnd = result.Select(b => b.BalanceEnd);
                txtUKPayBalanceEnd.Text = Convert.ToString(balanceEnd.Single());
                var targetAmt = result.Select(b => b.TargetAmt);
                txtUKPayTargetCE.Text = Convert.ToString(targetAmt.Single());

                var collectionTarget = result.Select(b => b.CollectionsTarget);
                txtUKPayCollection.Text = Convert.ToString(collectionTarget.Single());

                var mtd = result.Select(b => b.Mtd);
                txtUKPayMtd.Text = Convert.ToString(mtd.Single());
                var expected = result.Select(b => b.Expected);
                txtUKPayExpected.Text = Convert.ToString(expected.Single());
                var remaining = result.Select(b => b.Remaining);
                txtUKPayRemain.Text = Convert.ToString(remaining.Single());
                var note = result.Select(b => b.Note);
                txtUKPayNotes.Text = Convert.ToString(note.Single());
                var noteExpected = result.Select(n => n.NoteExpected);
                TextBoxNotesUKPayExpected.Text = Convert.ToString(noteExpected.Single());
            }

        }

        public void SelectValuesFR()
        {
            var result = new List<APP.Reports.FCTDetails>();
            result = APP.Reports.FCTDetails.SelectFleetCashTargetReport(Convert.ToInt32(SessionHandler.FTCReportFrance), Convert.ToInt32(SessionHandler.FTCReportTypeReceivables));

            if (result.Count >= 1)
            {
                var balanceInit = result.Select(b => b.BalanceInit);
                txtFRRecBalanceInit.Text = Convert.ToString(balanceInit.Single());
                var balanceVat = result.Select(b => b.BalanceVat);
                txtFRRecBalanceVat.Text = Convert.ToString(balanceVat.Single());
                var balanceEnd = result.Select(b => b.BalanceEnd);
                txtFRRecBalanceEnd.Text = Convert.ToString(balanceEnd.Single());
                var targetAmt = result.Select(b => b.TargetAmt);
                txtFRRecTargetCE.Text = Convert.ToString(targetAmt.Single());

                var collectionTarget = result.Select(b => b.CollectionsTarget);
                txtFRRecCollection.Text = Convert.ToString(collectionTarget.Single());

                var mtd = result.Select(b => b.Mtd);
                txtFRRecMtd.Text = Convert.ToString(mtd.Single());
                var expected = result.Select(b => b.Expected);
                txtFRRecExpected.Text = Convert.ToString(expected.Single());
                var remaining = result.Select(b => b.Remaining);
                txtFRRecRemain.Text = Convert.ToString(remaining.Single());
                var note = result.Select(b => b.Note);
                txtFRRecNotes.Text = Convert.ToString(note.Single());
                var noteExpected = result.Select(n => n.NoteExpected);
                TextBoxNotesFRRecExpected.Text = Convert.ToString(noteExpected.Single());
            }

            result = APP.Reports.FCTDetails.SelectFleetCashTargetReport(Convert.ToInt32(SessionHandler.FTCReportFrance), Convert.ToInt32(SessionHandler.FTCReportTypePayables));

            if (result.Count >= 1)
            {
                var balanceInit = result.Select(b => b.BalanceInit);
                txtFRPayBalanceInit.Text = Convert.ToString(balanceInit.Single());
                var balanceVat = result.Select(b => b.BalanceVat);
                txtFRPayBalanceVat.Text = Convert.ToString(balanceVat.Single());
                var balanceEnd = result.Select(b => b.BalanceEnd);
                txtFRPayBalanceEnd.Text = Convert.ToString(balanceEnd.Single());
                var targetAmt = result.Select(b => b.TargetAmt);
                txtFRPayTargetCE.Text = Convert.ToString(targetAmt.Single());

                var collectionTarget = result.Select(b => b.CollectionsTarget);
                txtFRPayCollection.Text = Convert.ToString(collectionTarget.Single());

                var mtd = result.Select(b => b.Mtd);
                txtFRPayMtd.Text = Convert.ToString(mtd.Single());
                var expected = result.Select(b => b.Expected);
                txtFRPayExpected.Text = Convert.ToString(expected.Single());
                var remaining = result.Select(b => b.Remaining);
                txtFRPayRemain.Text = Convert.ToString(remaining.Single());
                var note = result.Select(b => b.Note);
                txtFRPayNotes.Text = Convert.ToString(note.Single());
                var noteExpected = result.Select(n => n.NoteExpected);
                TextBoxNotesFRPayExpected.Text = Convert.ToString(noteExpected.Single());
            }
        }

        public void SelectValuesIT()
        {
            var result = new List<APP.Reports.FCTDetails>();
            result = APP.Reports.FCTDetails.SelectFleetCashTargetReport(Convert.ToInt32(SessionHandler.FTCReportItaly), Convert.ToInt32(SessionHandler.FTCReportTypeReceivables));

            if (result.Count >= 1)
            {
                var balanceInit = result.Select(b => b.BalanceInit);
                txtITRecBalanceInit.Text = Convert.ToString(balanceInit.Single());
                var balanceVat = result.Select(b => b.BalanceVat);
                txtITRecBalanceVat.Text = Convert.ToString(balanceVat.Single());
                var balanceEnd = result.Select(b => b.BalanceEnd);
                txtITRecBalanceEnd.Text = Convert.ToString(balanceEnd.Single());
                var targetAmt = result.Select(b => b.TargetAmt);
                txtITRecTargetCE.Text = Convert.ToString(targetAmt.Single());

                var collectionTarget = result.Select(b => b.CollectionsTarget);
                txtITRecCollection.Text = Convert.ToString(collectionTarget.Single());

                var mtd = result.Select(b => b.Mtd);
                txtITRecMtd.Text = Convert.ToString(mtd.Single());
                var expected = result.Select(b => b.Expected);
                txtITRecExpected.Text = Convert.ToString(expected.Single());
                var remaining = result.Select(b => b.Remaining);
                txtITRecRemain.Text = Convert.ToString(remaining.Single());
                var note = result.Select(b => b.Note);
                txtITRecNotes.Text = Convert.ToString(note.Single());
                var noteExpected = result.Select(n => n.NoteExpected);
                TextBoxNotesITRecExpected.Text = Convert.ToString(noteExpected.Single());
            }

            result = APP.Reports.FCTDetails.SelectFleetCashTargetReport(Convert.ToInt32(SessionHandler.FTCReportItaly), Convert.ToInt32(SessionHandler.FTCReportTypePayables));

            if (result.Count >= 1)
            {
                var balanceInit = result.Select(b => b.BalanceInit);
                txtITPayBalanceInit.Text = Convert.ToString(balanceInit.Single());
                var balanceVat = result.Select(b => b.BalanceVat);
                txtITPayBalanceVat.Text = Convert.ToString(balanceVat.Single());
                var balanceEnd = result.Select(b => b.BalanceEnd);
                txtITPayBalanceEnd.Text = Convert.ToString(balanceEnd.Single());
                var targetAmt = result.Select(b => b.TargetAmt);
                txtITPayTargetCE.Text = Convert.ToString(targetAmt.Single());

                var collectionTarget = result.Select(b => b.CollectionsTarget);
                txtITPayCollection.Text = Convert.ToString(collectionTarget.Single());

                var mtd = result.Select(b => b.Mtd);
                txtITPayMtd.Text = Convert.ToString(mtd.Single());
                var expected = result.Select(b => b.Expected);
                txtITPayExpected.Text = Convert.ToString(expected.Single());
                var remaining = result.Select(b => b.Remaining);
                txtITPayRemain.Text = Convert.ToString(remaining.Single());
                var note = result.Select(b => b.Note);
                txtITPayNotes.Text = Convert.ToString(note.Single());
                var noteExpected = result.Select(n => n.NoteExpected);
                TextBoxNotesITPayExpected.Text = Convert.ToString(noteExpected.Single());
            }
        }

        public void SelectValuesSP()
        {
            var result = new List<APP.Reports.FCTDetails>();
            result = APP.Reports.FCTDetails.SelectFleetCashTargetReport(Convert.ToInt32(SessionHandler.FTCReportSpain), Convert.ToInt32(SessionHandler.FTCReportTypeReceivables));

            if (result.Count >= 1)
            {
                var balanceInit = result.Select(b => b.BalanceInit);
                txtSPRecBalanceInit.Text = Convert.ToString(balanceInit.Single());
                var balanceVat = result.Select(b => b.BalanceVat);
                txtSPRecBalanceVat.Text = Convert.ToString(balanceVat.Single());
                var balanceEnd = result.Select(b => b.BalanceEnd);
                txtSPRecBalanceEnd.Text = Convert.ToString(balanceEnd.Single());
                var targetAmt = result.Select(b => b.TargetAmt);
                txtSPRecTargetCE.Text = Convert.ToString(targetAmt.Single());

                var collectionTarget = result.Select(b => b.CollectionsTarget);
                txtSPRecCollection.Text = Convert.ToString(collectionTarget.Single());

                var mtd = result.Select(b => b.Mtd);
                txtSPRecMtd.Text = Convert.ToString(mtd.Single());
                var expected = result.Select(b => b.Expected);
                txtSPRecExpected.Text = Convert.ToString(expected.Single());
                var remaining = result.Select(b => b.Remaining);
                txtSPRecRemain.Text = Convert.ToString(remaining.Single());
                var note = result.Select(b => b.Note);
                txtSPRecNotes.Text = Convert.ToString(note.Single());
                var noteExpected = result.Select(n => n.NoteExpected);
                TextBoxNotesSPRecExpected.Text = Convert.ToString(noteExpected.Single());
            }

            result = APP.Reports.FCTDetails.SelectFleetCashTargetReport(Convert.ToInt32(SessionHandler.FTCReportSpain), Convert.ToInt32(SessionHandler.FTCReportTypePayables));

            if (result.Count >= 1)
            {
                var balanceInit = result.Select(b => b.BalanceInit);
                txtSPPayBalanceInit.Text = Convert.ToString(balanceInit.Single());
                var balanceVat = result.Select(b => b.BalanceVat);
                txtSPPayBalanceVat.Text = Convert.ToString(balanceVat.Single());
                var balanceEnd = result.Select(b => b.BalanceEnd);
                txtSPPayBalanceEnd.Text = Convert.ToString(balanceEnd.Single());
                var targetAmt = result.Select(b => b.TargetAmt);
                txtSPPayTargetCE.Text = Convert.ToString(targetAmt.Single());

                var collectionTarget = result.Select(b => b.CollectionsTarget);
                txtSPPayCollection.Text = Convert.ToString(collectionTarget.Single());

                var mtd = result.Select(b => b.Mtd);
                txtSPPayMtd.Text = Convert.ToString(mtd.Single());
                var expected = result.Select(b => b.Expected);
                txtSPPayExpected.Text = Convert.ToString(expected.Single());
                var remaining = result.Select(b => b.Remaining);
                txtSPPayRemain.Text = Convert.ToString(remaining.Single());
                var note = result.Select(b => b.Note);
                txtSPPayNotes.Text = Convert.ToString(note.Single());
                var noteExpected = result.Select(n => n.NoteExpected);
                TextBoxNotesSPPayExpected.Text = Convert.ToString(noteExpected.Single());
            }
        }

        public void SelectRegionNorth()
        {
            var result = new List<APP.Reports.FCTDetailsTotal>();
            result = APP.Reports.FCTDetailsTotal.SelectFleetCashTargetReportTotals(Convert.ToInt32(SessionHandler.FTCReportRegionNorth), Convert.ToInt32(SessionHandler.FTCReportTypeReceivables));

            if (result.Count >= 1)
            {
                var balanceInit = result.Select(b => b.BalanceInit);
                txtRNRecBalanceInit.Text = Convert.ToString(balanceInit.Single());
                var balanceVat = result.Select(b => b.BalanceVat);
                txtRNRecBalanceVat.Text = Convert.ToString(balanceVat.Single());
                var balanceEnd = result.Select(b => b.BalanceEnd);
                txtRNRecBalanceEnd.Text = Convert.ToString(balanceEnd.Single());
                var targetAmt = result.Select(b => b.TargetAmt);
                txtRNRecTargetCE.Text = Convert.ToString(targetAmt.Single());

                var collectionTarget = result.Select(b => b.CollectionsTarget);
                txtRNRecCollection.Text = Convert.ToString(collectionTarget.Single());

                var mtd = result.Select(b => b.Mtd);
                txtRNRecMtd.Text = Convert.ToString(mtd.Single());
                var expected = result.Select(b => b.Expected);
                txtRNRecExpected.Text = Convert.ToString(expected.Single());
                var remaining = result.Select(b => b.Remaining);
                txtRNRecRemain.Text = Convert.ToString(remaining.Single());
            }
            else
            {
                txtRNRecBalanceInit.Text = String.Empty;
                txtRNRecBalanceVat.Text = String.Empty;
                txtRNRecBalanceEnd.Text = String.Empty;
                txtRNRecTargetCE.Text = String.Empty;
                txtRNRecCollection.Text = String.Empty;
                txtRNRecMtd.Text = String.Empty;
                txtRNRecExpected.Text = String.Empty;
                txtRNRecRemain.Text = String.Empty;
            }

            result = APP.Reports.FCTDetailsTotal.SelectFleetCashTargetReportTotals(Convert.ToInt32(SessionHandler.FTCReportRegionNorth), Convert.ToInt32(SessionHandler.FTCReportTypePayables));

            if (result.Count >= 1)
            {
                var balanceInit = result.Select(b => b.BalanceInit);
                txtRNPayBalanceInit.Text = Convert.ToString(balanceInit.Single());
                var balanceVat = result.Select(b => b.BalanceVat);
                txtRNPayBalanceVat.Text = Convert.ToString(balanceVat.Single());
                var balanceEnd = result.Select(b => b.BalanceEnd);
                txtRNPayBalanceEnd.Text = Convert.ToString(balanceEnd.Single());
                var targetAmt = result.Select(b => b.TargetAmt);
                txtRNPayTargetCE.Text = Convert.ToString(targetAmt.Single());

                var collectionTarget = result.Select(b => b.CollectionsTarget);
                txtRNPayCollection.Text = Convert.ToString(collectionTarget.Single());

                var mtd = result.Select(b => b.Mtd);
                txtRNPayMtd.Text = Convert.ToString(mtd.Single());
                var expected = result.Select(b => b.Expected);
                txtRNPayExpected.Text = Convert.ToString(expected.Single());
                var remaining = result.Select(b => b.Remaining);
                txtRNPayRemain.Text = Convert.ToString(remaining.Single());
            }
            else
            {
                txtRNPayBalanceInit.Text = String.Empty;
                txtRNPayBalanceVat.Text = String.Empty;
                txtRNPayBalanceEnd.Text = String.Empty;
                txtRNPayTargetCE.Text = String.Empty;
                txtRNPayCollection.Text = String.Empty;
                txtRNPayMtd.Text = String.Empty;
                txtRNPayExpected.Text = String.Empty;
                txtRNPayRemain.Text = String.Empty;
            
            }
        }

        public void SelectRegionSouth()
        {
            var result = new List<APP.Reports.FCTDetailsTotal>();
            result = APP.Reports.FCTDetailsTotal.SelectFleetCashTargetReportTotals(Convert.ToInt32(SessionHandler.FTCReportRegionSouth), Convert.ToInt32(SessionHandler.FTCReportTypeReceivables));

            if (result.Count >= 1)
            {
                var balanceInit = result.Select(b => b.BalanceInit);
                txtRSRecBalanceInit.Text = Convert.ToString(balanceInit.Single());
                var balanceVat = result.Select(b => b.BalanceVat);
                txtRSRecBalanceVat.Text = Convert.ToString(balanceVat.Single());
                var balanceEnd = result.Select(b => b.BalanceEnd);
                txtRSRecBalanceEnd.Text = Convert.ToString(balanceEnd.Single());
                var targetAmt = result.Select(b => b.TargetAmt);
                txtRSRecTargetCE.Text = Convert.ToString(targetAmt.Single());

                var collectionTarget = result.Select(b => b.CollectionsTarget);
                txtRSRecCollection.Text = Convert.ToString(collectionTarget.Single());

                var mtd = result.Select(b => b.Mtd);
                txtRSRecMtd.Text = Convert.ToString(mtd.Single());
                var expected = result.Select(b => b.Expected);
                txtRSRecExpected.Text = Convert.ToString(expected.Single());
                var remaining = result.Select(b => b.Remaining);
                txtRSRecRemain.Text = Convert.ToString(remaining.Single());
            }
            else
            {
                txtRSRecBalanceInit.Text = String.Empty;
                txtRSRecBalanceVat.Text = String.Empty;
                txtRSRecBalanceEnd.Text = String.Empty;
                txtRSRecTargetCE.Text = String.Empty;
                txtRSRecCollection.Text = String.Empty;
                txtRSRecMtd.Text = String.Empty;
                txtRSRecExpected.Text = String.Empty;
                txtRSRecRemain.Text = String.Empty;
            }

            result = APP.Reports.FCTDetailsTotal.SelectFleetCashTargetReportTotals(Convert.ToInt32(SessionHandler.FTCReportRegionSouth), Convert.ToInt32(SessionHandler.FTCReportTypePayables));

            if (result.Count >= 1)
            {
                var balanceInit = result.Select(b => b.BalanceInit);
                txtRSPayBalanceInit.Text = Convert.ToString(balanceInit.Single());
                var balanceVat = result.Select(b => b.BalanceVat);
                txtRSPayBalanceVat.Text = Convert.ToString(balanceVat.Single());
                var balanceEnd = result.Select(b => b.BalanceEnd);
                txtRSPayBalanceEnd.Text = Convert.ToString(balanceEnd.Single());
                var targetAmt = result.Select(b => b.TargetAmt);
                txtRSPayTargetCE.Text = Convert.ToString(targetAmt.Single());

                var collectionTarget = result.Select(b => b.CollectionsTarget);
                txtRSPayCollection.Text = Convert.ToString(collectionTarget.Single());

                var mtd = result.Select(b => b.Mtd);
                txtRSPayMtd.Text = Convert.ToString(mtd.Single());
                var expected = result.Select(b => b.Expected);
                txtRSPayExpected.Text = Convert.ToString(expected.Single());
                var remaining = result.Select(b => b.Remaining);
                txtRSPayRemain.Text = Convert.ToString(remaining.Single());
            }
            else
            {
                txtRSPayBalanceInit.Text = String.Empty;
                txtRSPayBalanceVat.Text = String.Empty;
                txtRSPayBalanceEnd.Text = String.Empty;
                txtRSPayTargetCE.Text = String.Empty;
                txtRSPayCollection.Text = String.Empty;
                txtRSPayMtd.Text = String.Empty;
                txtRSPayExpected.Text = String.Empty;
                txtRSPayRemain.Text = String.Empty;
            }

        }

        public void SelectRegionTotal()
        {
            var result = new List<APP.Reports.FCTDetailsTotal>();
            result = APP.Reports.FCTDetailsTotal.SelectFleetCashTargetReportTotals(0, Convert.ToInt32(SessionHandler.FTCReportTypeReceivables));

            if (result.Count >= 1)
            {
                var balanceInit = result.Select(b => b.BalanceInit);
                txtTTRecBalanceInit.Text = Convert.ToString(balanceInit.Single());
                var balanceVat = result.Select(b => b.BalanceVat);
                txtTTRecBalanceVat.Text = Convert.ToString(balanceVat.Single());
                var balanceEnd = result.Select(b => b.BalanceEnd);
                txtTTRecBalanceEnd.Text = Convert.ToString(balanceEnd.Single());
                var targetAmt = result.Select(b => b.TargetAmt);
                txtTTRecTargetCE.Text = Convert.ToString(targetAmt.Single());

                var collectionTarget = result.Select(b => b.CollectionsTarget);
                txtTTRecCollection.Text = Convert.ToString(collectionTarget.Single());

                var mtd = result.Select(b => b.Mtd);
                txtTTRecMtd.Text = Convert.ToString(mtd.Single());
                var expected = result.Select(b => b.Expected);
                txtTTRecExpected.Text = Convert.ToString(expected.Single());
                var remaining = result.Select(b => b.Remaining);
                txtTTRecRemain.Text = Convert.ToString(remaining.Single());
            }
            else
            {
                txtTTRecBalanceInit.Text = String.Empty;
                txtTTRecBalanceVat.Text = String.Empty;
                txtTTRecBalanceEnd.Text = String.Empty;
                txtTTRecTargetCE.Text = String.Empty;
                txtTTRecCollection.Text = String.Empty;
                txtTTRecMtd.Text = String.Empty;
                txtTTRecExpected.Text = String.Empty;
                txtTTRecRemain.Text = String.Empty;
            }

            result = APP.Reports.FCTDetailsTotal.SelectFleetCashTargetReportTotals(0, Convert.ToInt32(SessionHandler.FTCReportTypePayables));

            if (result.Count >= 1)
            {
                var balanceInit = result.Select(b => b.BalanceInit);
                txtTTPayBalanceInit.Text = Convert.ToString(balanceInit.Single());
                var balanceVat = result.Select(b => b.BalanceVat);
                txtTTPayBalanceVat.Text = Convert.ToString(balanceVat.Single());
                var balanceEnd = result.Select(b => b.BalanceEnd);
                txtTTPayBalanceEnd.Text = Convert.ToString(balanceEnd.Single());
                var targetAmt = result.Select(b => b.TargetAmt);
                txtTTPayTargetCE.Text = Convert.ToString(targetAmt.Single());

                var collectionTarget = result.Select(b => b.CollectionsTarget);
                txtTTPayCollection.Text = Convert.ToString(collectionTarget.Single());

                var mtd = result.Select(b => b.Mtd);
                txtTTPayMtd.Text = Convert.ToString(mtd.Single());
                var expected = result.Select(b => b.Expected);
                txtTTPayExpected.Text = Convert.ToString(expected.Single());
                var remaining = result.Select(b => b.Remaining);
                txtTTPayRemain.Text = Convert.ToString(remaining.Single());
            }
            else
            {
                txtTTPayBalanceInit.Text = String.Empty;
                txtTTPayBalanceVat.Text = String.Empty;
                txtTTPayBalanceEnd.Text = String.Empty;
                txtTTPayTargetCE.Text = String.Empty;
                txtTTPayCollection.Text = String.Empty;
                txtTTPayMtd.Text = String.Empty;
                txtTTPayExpected.Text = String.Empty;
                txtTTPayRemain.Text = String.Empty;
            }
        }

        #endregion

        #region "Excel"

        private void ExportToExcel()
        {
            string reportName = APP.Properties.Settings.Default.ReportFleetCashReport;

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
            viewer.ServerReport.SetParameters(new ReportParameter[] { DateReport() });
            viewer.ServerReport.Refresh();

            byte[] bytes = viewer.ServerReport.Render("Excel", null, out mimeType, out encoding, out extension, out streamIds, out warnings);

            // Now that you have all the bytes representing the PDF report, buffer it and send it to the client.
            fileName = "FleetCashTarget";
            extension = "xls";
            Response.Buffer = true;
            Response.Clear();
            Response.ContentType = "application/vnd.ms-excel";
            Response.AddHeader("content-disposition", "attachment; filename=" + fileName + "." + extension);
            Response.BinaryWrite(bytes); // create the file
            Response.Flush(); // send it to the client to download


        
        }

        ReportParameter param;

        private ReportParameter DateReport()
        {
            if (SessionHandler.FCSelectedDay == null)
            {
                param = new ReportParameter("dateUpdated", new string[] { null }, false);
                return param;
            }
            else
            {
                param = new ReportParameter("dateUpdated", SessionHandler.FCSelectedDay);
                return param;
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