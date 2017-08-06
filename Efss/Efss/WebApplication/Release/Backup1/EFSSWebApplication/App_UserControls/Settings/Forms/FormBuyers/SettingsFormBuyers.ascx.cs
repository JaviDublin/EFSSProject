using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Linq;
using System.Web.UI.WebControls;
using APP.Base;
using APP.Data;
using APP.Session;
using RAD.Data;
using RAD.Diagnostics;
using System.Web.UI;

namespace APP.App_UserControls.Settings.Forms.FormBuyers
{
    public partial class SettingsFormBuyers : UserControlBase
    {
        public void LoadData(bool isRefreshed)
        {
            if (isRefreshed)
            {
                SessionHandler.Selected_CompanyType_Id = "2";

                var buyertypes = new List<APP.Search.SearchBuyersType>();
                buyertypes = APP.Search.SearchBuyersType.SelectBuyerTypes();

                DropDownListBuyerType.DataSource = buyertypes;
                DropDownListBuyerType.DataTextField = "BuyerType";
                DropDownListBuyerType.DataValueField = "BuyerTypeId";
                DropDownListBuyerType.DataBind();

                var companyTypes = new List<APP.Search.SearchCompanyTypes>();
                companyTypes = APP.Search.SearchCompanyTypes.SelectCompanyTypes();
                DropDownListContactType.DataSource = companyTypes;
                DropDownListContactType.DataTextField = "CompanyType";
                DropDownListContactType.DataValueField = "CompanyTypeId";
                DropDownListContactType.DataBind();

                var result = new List<APP.Search.BuyerDetails>();
                result = APP.Search.BuyerDetails.SelectBuyerDetails(Convert.ToInt32(SessionHandler.SelectedBuyerId));

                if (result != null)
                {
                    var buyerid = result.Select(b => (int)b.BuyerId);
                    TextBoxId.Text = Convert.ToString(buyerid.Single());
                    var buyercountry = result.Select(x => x.CountryName);
                    TextBoxCountry.Text = Convert.ToString(buyercountry.Single());
                    var buyername = result.Select(n => n.BuyerName);
                    TextBoxBuyerName.Text = Convert.ToString(buyername.Single());
                    var buyercode = result.Select(c => c.BuyerCode);
                    TextBoxVendorCode.Text = Convert.ToString(buyercode.Single());
                    var buyertaxcode = result.Select(t => t.BuyerTaxCode);
                    TextBoxTaxCode.Text = Convert.ToString(buyertaxcode.Single());
                    var buyerfiscalcode = result.Select(f => f.BuyerFiscalCode);
                    TextBoxFiscalCode.Text = Convert.ToString(buyerfiscalcode.Single());
                    var buyertypeId = result.Select(p => (int)p.BuyerTypeId);
                    DropDownListBuyerType.SelectedValue = Convert.ToString(buyertypeId.Single());

                    //CheckBoxListManufacturers.DataBind();

                    //foreach (ListItem item in CheckBoxListManufacturers.Items)
                    //{
                    //    item.Selected = false;
                    //}

                    //var resultmanufacturer = new List<APP.Search.BuyerManufacturer>();
                    //resultmanufacturer = APP.Search.BuyerManufacturer.SelectBuyerManufacturer(Convert.ToInt32(SessionHandler.SelectedBuyerId));
                    //foreach (string manufacturer in resultmanufacturer.Select(m => m.ManufacturerName))
                    //{
                    //    foreach (ListItem item in CheckBoxListManufacturers.Items)
                    //    {
                    //        if (item.Text == manufacturer)
                    //        {
                    //            item.Selected = true;
                    //        }
                    //    }
                    //}

                    FillFormDetails();
                  

                }

                this.UpdatePanelForm.Update();
            }
        }

        protected void OnCommand(object sender, CommandEventArgs e)
        {
            if (e.CommandName == "Save")
            {
                UpdateBuyerType();
                UpdateContact();
                ScriptManager.RegisterStartupScript(this.UpdatePanelForm, this.UpdatePanelForm.GetType(), "alertupdatetype", "alert('Buyer updated');", true);
                this.UpdatePanelForm.Update();
            }
        }

        private void UpdateBuyerType()
        {
            try
            {
                SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = ConnectionManager.CreateProcedure(StoredProcedures.Update_BuyerType, con);
                RAD.Data.Parameters.CreateParameter(cmd, "@buyerId", SessionHandler.SelectedBuyerId);
                RAD.Data.Parameters.CreateParameter(cmd, "@buyerTypeId", DropDownListBuyerType.SelectedValue);

                ConnectionManager.ExecuteCommandNonQuery(con, cmd);
            }
            catch (Exception ex)
            {
                StackTrace errorStackTrace = new StackTrace(true);
                Logs.LogError(errorStackTrace, ex);
            }
        }

        private void UpdateContact()
        {
            try
            {
                SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = ConnectionManager.CreateProcedure(StoredProcedures.Update_BuyerContact, con);
                RAD.Data.Parameters.CreateParameter(cmd, "@ContactId", SessionHandler.Selected_ContactId);
                RAD.Data.Parameters.CreateParameter(cmd, "@ContactName", TextBoxContactName.Text);
                RAD.Data.Parameters.CreateParameter(cmd, "@ContactEmail", TextBoxContactEmail.Text);
                RAD.Data.Parameters.CreateParameter(cmd, "@ContactPhone", TextBoxContactPhone.Text);

                ConnectionManager.ExecuteCommandNonQuery(con, cmd);

            }
            catch (Exception ex)
            {
                StackTrace errorStackTrace = new StackTrace(true);
                Logs.LogError(errorStackTrace, ex);
            }

        }

        //private void UpdateBuyerManufacturer(string manufacturerId, int adddelete)
        //{
        //    try
        //    {
        //        SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
        //        SqlCommand cmd = ConnectionManager.CreateProcedure(StoredProcedures.Update_BuyerManufacturer, con);
        //        RAD.Data.Parameters.CreateParameter(cmd, "@buyerId", SessionHandler.SelectedBuyerId);
        //        RAD.Data.Parameters.CreateParameter(cmd, "@manufacturerId", manufacturerId);
        //        RAD.Data.Parameters.CreateParameter(cmd, "@add_delete", adddelete);

        //        ConnectionManager.ExecuteCommandNonQuery(con, cmd);

        //    }
        //    catch (Exception ex)
        //    {
        //        StackTrace errorStackTrace = new StackTrace(true);
        //        Logs.LogError(errorStackTrace, ex);
        //    }
        
        //}

        private void FillFormDetails()
        {
            var buyerdetails = new List<APP.Search.BuyerDetailsFull>();
            buyerdetails = APP.Search.BuyerDetailsFull.SelectBuyerFullDetails(Convert.ToInt32(SessionHandler.SelectedBuyerId), Convert.ToInt32(SessionHandler.Selected_CompanyType_Id));

            if (buyerdetails.Count >= 1)
            {
                var contactName = buyerdetails.Select(b => b.ContactName);
                TextBoxContactName.Text = Convert.ToString(contactName.Single());
                var contactPhone = buyerdetails.Select(x => x.ContactPhone);
                TextBoxContactPhone.Text = Convert.ToString(contactPhone.Single());
                var contactEmail = buyerdetails.Select(n => n.ContactEmail);
                TextBoxContactEmail.Text = Convert.ToString(contactEmail.Single());

                var contactId = buyerdetails.Select(c => (int)c.ContactId);
                SessionHandler.Selected_ContactId = Convert.ToString(contactId.Single());

                var buyeraddress1 = buyerdetails.Select(t => t.BuyerAddress1);
                TextBoxAddr1.Text = Convert.ToString(buyeraddress1.Single());
                var buyeraddress2 = buyerdetails.Select(f => f.BuyerAddress2);
                TextBoxAddr2.Text = Convert.ToString(buyeraddress2.Single());
                var buyeraddress3 = buyerdetails.Select(p => p.BuyerAddress3);
                TextBoxAddr3.Text = Convert.ToString(buyeraddress3.Single());
                var buyeraddress4 = buyerdetails.Select(t => t.BuyerAddress4);
                TextBoxAddr4.Text = Convert.ToString(buyeraddress4.Single());
                var buyeraddress5 = buyerdetails.Select(f => f.BuyerAddress5);
                TextBoxAddr5.Text = Convert.ToString(buyeraddress5.Single());
                var buyeraddress6 = buyerdetails.Select(p => p.BuyerAddress6);
                TextBoxAddr6.Text = Convert.ToString(buyeraddress6.Single());
                var companyTypeId = buyerdetails.Select(p => (int)p.CompanyTypeId);
                DropDownListContactType.SelectedValue = Convert.ToString(companyTypeId.Single());
            }
        }

        protected void DropDownListContactType_SelectedIndexChanged(object sender, EventArgs e)
        {
            SessionHandler.Selected_CompanyType_Id = DropDownListContactType.SelectedValue.ToString();
            FillFormDetails();
            this.UpdatePanelForm.Update();
        }

    }
}