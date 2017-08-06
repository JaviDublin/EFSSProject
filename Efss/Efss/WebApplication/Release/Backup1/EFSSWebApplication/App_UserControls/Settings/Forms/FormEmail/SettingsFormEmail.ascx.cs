using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using APP.Data;
using APP.Session;
using RAD.Data;
using RAD.Diagnostics;
namespace APP.App_UserControls.Settings.Forms.FormEmail
{
    public partial class SettingsFormEmail : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                //LoadEmails();
            }
        }

        public void LoadData()
        {
            LoadEmails();
        }

        private void LoadEmails()
        {
            var emails = new List<APP.Search.CompanyEmails>();
            emails = APP.Search.CompanyEmails.CompanyEmailsList();
            DropDownListEmails.DataSource = emails;
            DropDownListEmails.DataTextField = "EmailDublin";
            DropDownListEmails.DataValueField = "EmailId";
            DropDownListEmails.DataBind();
            DropDownListEmails.SelectedIndex = 0;
            SessionHandler.SelectedGroupId = DropDownListEmails.SelectedValue.ToString();
            FillForm();
            this.UpdatePanelEmails.Update();
        }

        private void FillForm()
        {
            var result = new List<APP.Search.CompanyEmailsDetails>();
            result = APP.Search.CompanyEmailsDetails.CompanyEmailDetails(Convert.ToInt32(SessionHandler.SelectedGroupId));
            if (result.Count >= 1)
            {
                var messageid = result.Select(b => b.MessageId);
                SessionHandler.SelectedMessageId = Convert.ToString(messageid.Single());
                var title = result.Select(b => b.Title);
                TextBoxSubject.Text = Convert.ToString(title.Single());
                var header = result.Select(b => b.Header);
                TextBoxHeader.Text = Convert.ToString(header.Single());
                var body = result.Select(b => b.Body);
                TextBoxBody.Text = Convert.ToString(body.Single());
                var footer = result.Select(b => b.Footer);
                TextBoxFooter.Text = Convert.ToString(footer.Single());
            }
        }

        protected void OnCommand(object sender, CommandEventArgs e)
        {
            if (e.CommandName == "SaveEmail")
            {
                UpdateEmail();
                ScriptManager.RegisterStartupScript(this.UpdatePanelEmails, this.UpdatePanelEmails.GetType(), "alertemailupdate", "alert('Email Message Updated.');", true);
                this.UpdatePanelEmails.Update();
            }
        }

        private void UpdateEmail()
        {
            try
            {
                SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = ConnectionManager.CreateProcedure(StoredProcedures.Select_Companies_Emails_Update, con);
                Parameters.CreateParameter(cmd, "@messageId", Convert.ToInt32(SessionHandler.SelectedMessageId));
                Parameters.CreateParameter(cmd, "@title", TextBoxSubject.Text);
                Parameters.CreateParameter(cmd, "@header", TextBoxHeader.Text);
                Parameters.CreateParameter(cmd, "@body", TextBoxBody.Text);
                Parameters.CreateParameter(cmd, "@footer", TextBoxFooter.Text);
                ConnectionManager.ExecuteCommandNonQuery(con, cmd);
            }
            catch (Exception ex)
            {
                StackTrace errorStackTrace = new StackTrace(true);
                Logs.LogError(errorStackTrace, ex);
            }
        }

        protected void DropDownListEmails_SelectedIndexChanged(object sender, EventArgs e)
        {
            SessionHandler.SelectedGroupId = DropDownListEmails.SelectedValue.ToString();
            FillForm();
            this.UpdatePanelEmails.Update();
        }

        
    }
}