using System;
using System.Web.UI.WebControls;
using APP.Base;
using APP.Search;

namespace APP.App_UserControls.Settings
{
    public partial class ManufacturersForm : UserControlBase
    {
        public void LoadData(bool isRefreshed)
        {
            this.SetNavigtionMenu();
            this.ListViewManufacturers.LoadData(true);
            this.UpdatePanelManufacturers.Update();
        }
        
        protected void SetNavigtionMenu()
        {
            var results = this.NavigationPanelManufacturers.LoadControlData((int)MenuType.MenuI);
            int index = NavigationMenu.GetMinimumIndex(results);
            this.MultiViewManufacturers.ActiveViewIndex = index;
            this.NavigationPanelManufacturers.SetMenuStyle(this.MultiViewManufacturers.ActiveViewIndex);
        }

        protected void NavigationMenuClick(object sender, Navigation e)
        {
            int index = e.Index;
            this.MultiViewManufacturers.ActiveViewIndex = index;
            this.UpdatePanelManufacturers.Update();
        }
        
        protected void SearchModels(object sender, EventArgs e)
        {
            this.MultiViewManufacturers.ActiveViewIndex = 1;
            this.NavigationPanelManufacturers.SetMenuStyle(this.MultiViewManufacturers.ActiveViewIndex);
            this.ListViewModels.LoadData(true);
            this.UpdatePanelManufacturers.Update();
        }

    }
}