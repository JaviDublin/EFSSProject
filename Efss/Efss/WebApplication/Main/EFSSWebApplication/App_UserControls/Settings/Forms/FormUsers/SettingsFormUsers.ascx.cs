using System;
using System.Collections;
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

namespace APP.App_UserControls.Settings.Forms.FormUsers
{
    public partial class SettingsFormUsers : UserControlBase
    {

        public void LoadData(bool isRefreshed)
        {
            if (isRefreshed)
            {
                string errorImageUrl = @"../App_Images/error.png";
                this.RequiredFieldValidatorRacfId.Text = @"<img src='" + errorImageUrl + "'>";

                if (SessionHandler.UserFormAction == "Insert")
                {
                    ClearForm();
                }
                else
                {
                    FillForm();
                }

               
                this.UpdatePanelFormusers.Update();

            }
        }

        protected void OnCommand(object sender, CommandEventArgs e)
        {
            if (e.CommandName == "Save")
            {
                UpdateUser();
                ScriptManager.RegisterStartupScript(this.UpdatePanelFormusers, this.UpdatePanelFormusers.GetType(), "alertuserupdate", "alert('User Updated.');", true);
                this.UpdatePanelFormusers.Update();
            }
            else if (e.CommandName == "Insert")
            {
                if (hasDuplicates())
                {
                    ScriptManager.RegisterStartupScript(this.UpdatePanelFormusers, this.UpdatePanelFormusers.GetType(), "alertduplicate", "alert('The Racf Id already exists');", true);
                    this.UpdatePanelFormusers.Update();
                }
                else
                {
                    AddUser();
                    ScriptManager.RegisterStartupScript(this.UpdatePanelFormusers, this.UpdatePanelFormusers.GetType(), "alertuserinsert", "alert('User Inserted.');", true);
                    this.UpdatePanelFormusers.Update();
                }
            }
        }

        public bool hasDuplicates()
        {
            int result;
            ArrayList parameters = new ArrayList();
            ArrayList values = new ArrayList();
            parameters.Add("@racfId");
            values.Add(TextBoxRacfId.Text);
            DBAgent checkDup = new DBAgent(StoredProcedures.UsersCheck, parameters, values);
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

        private void FillForm()
        {
            var result = new List<APP.Search.SearchUsers>();
            result = APP.Search.SearchUsers.SelectUsersByUserId(Convert.ToInt32(SessionHandler.SelectedUserId));
            
            if (result.Count >= 1)
            {
                var name = result.Select(n => n.Name);
                TextBoxUserName.Text = Convert.ToString(name.Single());

                var surname = result.Select(n => n.Surname);
                TextBoxSurname.Text = Convert.ToString(surname.Single());

                var racfid = result.Select(n => n.RacfId);
                TextBoxRacfId.Text = Convert.ToString(racfid.Single());

                var email = result.Select(n => n.Email);
                TextBoxEmail.Text = Convert.ToString(email.Single());

                var phone = result.Select(n => n.Phone);
                TextBoxPhone.Text = Convert.ToString(phone.Single());

                var roleid = result.Select(n => n.RoleId);
                DropDownListRoles.SelectedValue = Convert.ToString(roleid.Single());
            }
        }

        public void ClearForm()
        {
            TextBoxUserName.Text = String.Empty;
            TextBoxSurname.Text = String.Empty;
            TextBoxRacfId.Text = String.Empty;
            TextBoxEmail.Text = String.Empty;
            TextBoxPhone.Text = String.Empty;
        }

        private void AddUser()
        {
            try
            {
                SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = ConnectionManager.CreateProcedure(StoredProcedures.UsersInsert, con);

                RAD.Data.Parameters.CreateParameter(cmd, "@racfId", TextBoxRacfId.Text);
                RAD.Data.Parameters.CreateParameter(cmd, "@name", TextBoxUserName.Text);
                RAD.Data.Parameters.CreateParameter(cmd, "@surname", TextBoxSurname.Text);
                RAD.Data.Parameters.CreateParameter(cmd, "@phone", TextBoxPhone.Text);
                RAD.Data.Parameters.CreateParameter(cmd, "@email", TextBoxEmail.Text);
                RAD.Data.Parameters.CreateParameter(cmd, "@roleid", Convert.ToInt32(DropDownListRoles.SelectedValue));

                ConnectionManager.ExecuteCommandNonQuery(con, cmd);
            }
            catch (Exception ex)
            {
                StackTrace errorStackTrace = new StackTrace(true);
                Logs.LogError(errorStackTrace, ex);
            }
        }

        private void UpdateUser()
        {
            try
            {
                SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = ConnectionManager.CreateProcedure(StoredProcedures.UsersUpdate, con);
                RAD.Data.Parameters.CreateParameter(cmd, "@userId", Convert.ToInt32(SessionHandler.SelectedUserId));
                RAD.Data.Parameters.CreateParameter(cmd, "@racfId", TextBoxRacfId.Text);
                RAD.Data.Parameters.CreateParameter(cmd, "@name", TextBoxUserName.Text);
                RAD.Data.Parameters.CreateParameter(cmd, "@surname", TextBoxSurname.Text);
                RAD.Data.Parameters.CreateParameter(cmd, "@phone", TextBoxPhone.Text);
                RAD.Data.Parameters.CreateParameter(cmd, "@email", TextBoxEmail.Text);
                RAD.Data.Parameters.CreateParameter(cmd, "@roleid", Convert.ToInt32(DropDownListRoles.SelectedValue));

                ConnectionManager.ExecuteCommandNonQuery(con, cmd);
            }
            catch (Exception ex)
            {
                StackTrace errorStackTrace = new StackTrace(true);
                Logs.LogError(errorStackTrace, ex);
            }
        }

       
    }
}