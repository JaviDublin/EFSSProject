using System;
using System.Web.UI.WebControls;
using APP.Base;
using APP.Session;
using APP.Search;

namespace APP.App_UserControls.Security
{
    public partial class UsersForm : UserControlBase
    {
       
        public void LoadData(bool isRefreshed)
        {
            if (isRefreshed)
            {
                this.SetNavigtionMenu();
                this.ListViewUser.LoadData(true);
                this.UpdatePanelUsers.Update();
            }
        }
        
        protected void SetNavigtionMenu()
        {
            var results = this.NavigationPanelUsers.LoadControlData((int)MenuType.MenuK);
            int index = NavigationMenu.GetMinimumIndex(results);
            this.MultiViewUsers.ActiveViewIndex = index;
            this.NavigationPanelUsers.SetMenuStyle(this.MultiViewUsers.ActiveViewIndex);
        }

        protected void NavigationMenuClick(object sender, Navigation e)
        {
            int index = e.Index;
            this.MultiViewUsers.ActiveViewIndex = index;
            this.UpdatePanelUsers.Update();
        }

        protected void SearchUsers(object sender, EventArgs e)
        {
           
            SessionHandler.UserFormAction = "Update";
            this.MultiViewUsers.ActiveViewIndex = 1;
            this.NavigationPanelUsers.SetMenuStyle(this.MultiViewUsers.ActiveViewIndex);
            this.FormUsers.LoadData(true);
            this.UpdatePanelUsers.Update();
        }

        protected void AddUsers(object sender, EventArgs e)
        {
           
            SessionHandler.UserFormAction = "Insert";
            this.MultiViewUsers.ActiveViewIndex = 1;
            this.NavigationPanelUsers.SetMenuStyle(this.MultiViewUsers.ActiveViewIndex);
            this.FormUsers.LoadData(true);
            this.UpdatePanelUsers.Update();
        }

    }
}