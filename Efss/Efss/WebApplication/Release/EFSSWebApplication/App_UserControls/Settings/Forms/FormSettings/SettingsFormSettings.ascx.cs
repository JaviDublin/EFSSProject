using System;
using System.Collections;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using APP.Data;
using APP.Search;
using APP.Session;
using RAD.Data;
using RAD.Diagnostics;


namespace APP.App_UserControls.Settings.Forms.FormSettings
{
    public partial class SettingsFormSettings : System.Web.UI.UserControl
    {
       
        public void LoadData()
        {
            this.SetNavigtionMenu();
            LoadCurrencyCodes();
            LoadDocumentTypes();
        }

        private void LoadDocumentTypes()
        {

            DropDownListDocumentSubType.DataSource = DocumentsSubTypes.SelectDocSubType(1).Select(s => s.DocumentSubType);
            DropDownListDocumentSubType.DataBind();
            DropDownListDocumentSubType.SelectedIndex = 0;
            SessionHandler.DocumentSubTypeSettings = DropDownListDocumentSubType.SelectedValue.ToString();
            FillDocumentSettings();
            this.UpdatePanelDocumentTypes.Update();

        }

        private void LoadCurrencyCodes()
        {
            var currencyCodes = new List<APP.Search.CurrencyCodes>();
            currencyCodes = APP.Search.CurrencyCodes.SelectCurrencyCodes();
            DropDownListCurrency.DataSource = currencyCodes;
            DropDownListCurrency.DataTextField = "CurrencyCode";
            DropDownListCurrency.DataValueField = "CurrencyId";
            DropDownListCurrency.DataBind();
            DropDownListCurrency.SelectedIndex = 0;
            SessionHandler.CurrencyCodeSettings = DropDownListCurrency.SelectedItem.ToString();
            FillCurrencySettings();
            this.UpdatePanelCurrencies.Update();

        }

        protected void OnCommand(object sender, CommandEventArgs e)
        {
            if (e.CommandName == "SaveCurrency")
            {
                UpdateCurrencyRate();
                ScriptManager.RegisterStartupScript(this.UpdatePanelCurrencies, this.UpdatePanelCurrencies.GetType(), "alertcurrencyupdate", "alert('Currency Rate Updated.');", true);
                this.UpdatePanelCurrencies.Update();

            }
            else if (e.CommandName == "SaveDocument")
            {
                UpdateDocumentAccount();
                ScriptManager.RegisterStartupScript(this.UpdatePanelDocumentTypes, this.UpdatePanelDocumentTypes.GetType(), "alertdocumentupdate", "alert('Document Account Updated.');", true);
                this.UpdatePanelDocumentTypes.Update();
            }
            else if (e.CommandName == "InsertDocument")
            {
                if (TextBoxDocuemntTypeAdd.Text == String.Empty)
                {
                    ScriptManager.RegisterStartupScript(this.UpdatePanelDocumentTypes, this.UpdatePanelDocumentTypes.GetType(), "alertempty", "alert('The Documnent type cannot be empty');", true);
                    this.UpdatePanelDocumentTypes.Update();
                }
                else
                {
                    if (hasDuplicates())
                    {
                        ScriptManager.RegisterStartupScript(this.UpdatePanelDocumentTypes, this.UpdatePanelDocumentTypes.GetType(), "alertduplicate", "alert('The Documnent type already exists');", true);
                        this.UpdatePanelDocumentTypes.Update();
                    }
                    else
                    {
                        AddNewDocument();
                        ClearForm();
                        LoadDocumentTypes();
                        ScriptManager.RegisterStartupScript(this.UpdatePanelDocumentTypes, this.UpdatePanelDocumentTypes.GetType(), "alertdocumentadd", "alert('New Document Type added.');", true);
                        this.UpdatePanelDocumentTypes.Update();
                    }
                }
                

            }
        }

        protected void NavigationMenuClick(object sender, Navigation e)
        {
            int index = e.Index;
            this.MultiViewSettings.ActiveViewIndex = index;
            this.UpdatePanelSettings.Update();
        }

        protected void SetNavigtionMenu()
        {
            var results = this.NavigationPanelSettings.LoadControlData((int)MenuType.MenuD);
            int index = NavigationMenu.GetMinimumIndex(results);
            this.MultiViewSettings.ActiveViewIndex = index;
            this.NavigationPanelSettings.SetMenuStyle(this.MultiViewSettings.ActiveViewIndex);
        }

        #region "View Details"

        protected void DropDownListCurrency_SelectedIndexChanged(object sender, EventArgs e)
        {
            SessionHandler.CurrencyCodeSettings = DropDownListCurrency.SelectedItem.ToString();
            FillCurrencySettings();
            this.UpdatePanelCurrencies.Update();
        }

        protected void DropDownListDocumentSubType_SelectedIndexChanged(object sender, EventArgs e)
        {
            SessionHandler.DocumentSubTypeSettings = DropDownListDocumentSubType.SelectedValue.ToString();
            FillDocumentSettings();
            this.UpdatePanelDocumentTypes.Update();
        }

        private void FillDocumentSettings()
        {
            var result = new List<APP.Search.DocumentTypesAccounts>();
            result = APP.Search.DocumentTypesAccounts.SelectDocTypeDetails(SessionHandler.DocumentSubTypeSettings);

            if (result.Count >= 1)
            {
                var primeAccount = result.Select(b => b.PrimeAccount);
                TextBoxPrimeAccountUpdate.Text = Convert.ToString(primeAccount.Single());
                var subAccount = result.Select(b => b.SubAccount);
                TextBoxSubAccountUpdate.Text = Convert.ToString(subAccount.Single());
                var costCenter = result.Select(b => b.CostCenter);
                TextBoxCostCenterUpdate.Text = Convert.ToString(costCenter.Single());
                var activity = result.Select(b => b.Activity);
                TextBoxActivityUpdate.Text = Convert.ToString(activity.Single());
                var division = result.Select(b => b.Division);
                TextBoxDivisionUpdate.Text = Convert.ToString(division.Single());
            }
        }

        private void FillCurrencySettings()
        {
            var result = new List<APP.Search.CurrencyDetails>();
            result = APP.Search.CurrencyDetails.SelectCurrencyDetails(SessionHandler.CurrencyCodeSettings);

            if (result.Count >= 1)
            {
                var currencyId = result.Select(i => (int)i.CurrencyId);
                SessionHandler.CurrencyIdSettings = Convert.ToString(currencyId.Single());
                var currencyName = result.Select(b => b.CurrencyName);
                TextBoxCurrencyName.Text = Convert.ToString(currencyName.Single());
                var rate = result.Select(b => b.Rate);
                TextBoxRates.Text = Convert.ToString(rate.Single());
            }
        }

        #endregion

        #region "Update / Add Settings"

        private void UpdateCurrencyRate()
        {
            try
            {
                SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = ConnectionManager.CreateProcedure(StoredProcedures.Update_Currencies_Rate, con);
                Parameters.CreateParameter(cmd, "@currencyId", SessionHandler.CurrencyIdSettings);
                Parameters.CreateParameter(cmd, "@currencyRate", TextBoxRates.Text);
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

        private void UpdateDocumentAccount()
        {
            try
            {
                SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = ConnectionManager.CreateProcedure(StoredProcedures.Update_Document_Types_Accounts, con);
                Parameters.CreateParameter(cmd, "@documentSubType", SessionHandler.DocumentSubTypeSettings);
                Parameters.CreateParameter(cmd, "@primeAccount", TextBoxPrimeAccountUpdate.Text);
                Parameters.CreateParameter(cmd, "@subAccount", TextBoxSubAccountUpdate.Text);
                Parameters.CreateParameter(cmd, "@costCenter", TextBoxCostCenterUpdate.Text);
                Parameters.CreateParameter(cmd, "@activity", TextBoxActivityUpdate.Text);
                Parameters.CreateParameter(cmd, "@division", TextBoxDivisionUpdate.Text);
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

        private void AddNewDocument()
        {
            try
            {
                SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = ConnectionManager.CreateProcedure(StoredProcedures.Insert_Document_Type, con);
                Parameters.CreateParameter(cmd, "@documentSubType", TextBoxDocuemntTypeAdd.Text);
                Parameters.CreateParameter(cmd, "@primeAccount", TextBoxPrimeAccountAdd.Text);
                Parameters.CreateParameter(cmd, "@subAccount", TextBoxSubAccountAdd.Text);
                Parameters.CreateParameter(cmd, "@costCenter", TextBoxCostCenterAdd.Text);
                Parameters.CreateParameter(cmd, "@activity", TextBoxActivityAdd.Text);
                Parameters.CreateParameter(cmd, "@division", TextBoxDivisionAdd.Text);
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

        public bool hasDuplicates()
        {
            int result;
            ArrayList parameters = new ArrayList();
            ArrayList values = new ArrayList();
            parameters.Add("@documentSubType");
            values.Add(TextBoxDocuemntTypeAdd.Text);
            DBAgent checkDup = new DBAgent(StoredProcedures.Select_Document_Types_Check, parameters, values);
            result = checkDup.ExecuteQueryWithReturnId();

            // 0 =  No Duplicates
            if (result == 0)
            {
                return false;
            }
            else
            {
                return true;
            }
        }

        public void ClearForm()
        {
            TextBoxDocuemntTypeAdd.Text = String.Empty;
            TextBoxPrimeAccountAdd.Text = String.Empty;
            TextBoxSubAccountAdd.Text = String.Empty;
            TextBoxCostCenterAdd.Text = String.Empty;
            TextBoxActivityAdd.Text = String.Empty;
            TextBoxDivisionAdd.Text = String.Empty;
        }

        #endregion
    }
}