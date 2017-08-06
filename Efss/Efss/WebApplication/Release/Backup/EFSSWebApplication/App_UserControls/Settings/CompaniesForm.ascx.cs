using System;
using System.Web.UI.WebControls;
using APP.Base;
using APP.Search;

namespace APP.App_UserControls.Settings
{
    public partial class CompaniesForm : UserControlBase
    {
        public void LoadData(bool isRefreshed)
        {
            this.SetNavigtionMenu();
            this.ListViewCompanies.LoadData(true);
            this.UpdatePanelCompanies.Update();
        }

        protected void SetNavigtionMenu()
        {
            var results = this.NavigationPanelCompanies.LoadControlData((int)MenuType.MenuJ);
            int index = NavigationMenu.GetMinimumIndex(results);
            this.MultiViewCompanies.ActiveViewIndex = index;
            this.NavigationPanelCompanies.SetMenuStyle(this.MultiViewCompanies.ActiveViewIndex);
        }

        protected void NavigationMenuClick(object sender, Navigation e)
        {
            int index = e.Index;
            this.MultiViewCompanies.ActiveViewIndex = index;
            this.UpdatePanelCompanies.Update();
        }

        protected void SearchCompanies(object sender, EventArgs e)
        {
            this.MultiViewCompanies.ActiveViewIndex = 1;
            this.NavigationPanelCompanies.SetMenuStyle(this.MultiViewCompanies.ActiveViewIndex);
            this.FormCompanies.LoadData(true);
            this.UpdatePanelCompanies.Update();
        }
    }
}