using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using APP.Base;
using APP.Data;
using APP.Session;
using RAD.Data;
using RAD.Diagnostics;
namespace APP.App_UserControls.Settings.Forms.FormCompanies
{
    public partial class SettingsFormCompanies : UserControlBase
    {
        public void LoadData(bool isRefreshed)
        {
            if (isRefreshed)
            {
                var result = new List<APP.Search.CompanyDetails>();
                result = APP.Search.CompanyDetails.CompanyDetailsById(Convert.ToInt32(SessionHandler.SelectedCompanyId));

                var companyName = result.Select(x => x.CompanyName);
                TextBoxCompanyName.Text = Convert.ToString(companyName.Single());

                var companyCode = result.Select(n => n.CompanyCode);
                TextBoxCompanyCode.Text = Convert.ToString(companyCode.Single());

                var countryName = result.Select(c => c.CountryName);
                TextBoxCountryName.Text = Convert.ToString(countryName.Single());

                var companyFiscalCode = result.Select(t => t.CompanyFiscalCode);
                TextBoxCompanyFiscalCode.Text = Convert.ToString(companyFiscalCode.Single());

                var companyType = result.Select(p => p.CompanyType);
                TextBoxCompanyType.Text = Convert.ToString(companyType.Single());

                var vatRate = result.Select(f => f.VatRate);
                TextBoxCountryVatRate.Text = Convert.ToString(vatRate.Single());

                var regionName = result.Select(p => p.RegionName);
                TextBoxCompanyRegion.Text = Convert.ToString(regionName.Single());

                var currencyName = result.Select(p => p.CurrencyName);
                TextBoxCompanyCurrency.Text = Convert.ToString(currencyName.Single());

                var oracleCode = result.Select(p => p.OracleCode);
                TextBoxOracleCode.Text = Convert.ToString(oracleCode.Single());

                var group = result.Select(p => p.GroupName);
                TextBoxGroup.Text = Convert.ToString(group.Single());

                var rate = result.Select(r => r.Rate);
                TextBoxRate.Text = Convert.ToString(rate.Single());


            }

            this.UpdatePanelForm.Update();

        }

        protected void OnCommand(object sender, CommandEventArgs e)
        {
            if (e.CommandName == "Save")
            {
                UpdateCompany();
            }
        }

        private void UpdateCompany()
        {
            try
            {
                if (TextBoxCountryVatRate.Text == String.Empty)
                {
                    ScriptManager.RegisterStartupScript(this.UpdatePanelForm, this.UpdatePanelForm.GetType(), "alertdate", "alert('The Vat Rate cannot be empty.');", true);
                }
                else if (TextBoxCompanyFiscalCode.Text == String.Empty)
                {
                    ScriptManager.RegisterStartupScript(this.UpdatePanelForm, this.UpdatePanelForm.GetType(), "alertdate", "alert('The Fiscal Code cannot be empty.');", true);
                }
                else
                {
                    SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
                    SqlCommand cmd = ConnectionManager.CreateProcedure(StoredProcedures.Companies_Update, con);
                    RAD.Data.Parameters.CreateParameter(cmd, "@companyId", SessionHandler.SelectedCompanyId);
                    RAD.Data.Parameters.CreateParameter(cmd, "@vatRate", TextBoxCountryVatRate.Text);
                    RAD.Data.Parameters.CreateParameter(cmd, "@companyFiscalCode", TextBoxCompanyFiscalCode.Text);
                    ConnectionManager.ExecuteCommandNonQuery(con, cmd);

                    ScriptManager.RegisterStartupScript(this.UpdatePanelForm, this.UpdatePanelForm.GetType(), "alertdate", "alert('Information updated.');", true);
                }
            }
            catch (Exception ex)
            {
                StackTrace errorStackTrace = new StackTrace(true);
                Logs.LogError(errorStackTrace, ex);
            }
        }
    }
}