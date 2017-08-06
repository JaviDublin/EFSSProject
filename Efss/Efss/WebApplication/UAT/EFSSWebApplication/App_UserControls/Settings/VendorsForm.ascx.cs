using System;
using System.Web.UI.WebControls;
using APP.Base;
using APP.Search;

namespace APP.App_UserControls.Settings
{
    public partial class VendorsForm : UserControlBase
    {
        public void LoadData(bool isRefreshed)
        {
            this.SetNavigtionMenu();
            this.BuyersListView.LoadData(true);
            this.UpdatePanelBuyers.Update();
        }

        protected void SetNavigtionMenu()
        {
            var results = this.NavigationPanelBuyers.LoadControlData((int)MenuType.MenuH);
            int index = NavigationMenu.GetMinimumIndex(results);
            this.MultiViewBuyers.ActiveViewIndex = index;
            this.NavigationPanelBuyers.SetMenuStyle(this.MultiViewBuyers.ActiveViewIndex);
        }

        protected void NavigationMenuClick(object sender, Navigation e)
        {
            int index = e.Index;
            this.MultiViewBuyers.ActiveViewIndex = index;
            this.UpdatePanelBuyers.Update();
        }

        protected void SearchBuyer(object sender, EventArgs e)
        {
            this.MultiViewBuyers.ActiveViewIndex = 1;
            this.NavigationPanelBuyers.SetMenuStyle(this.MultiViewBuyers.ActiveViewIndex);
            this.BuyersForm.LoadData(true);
            this.UpdatePanelBuyers.Update();
        }

    }
}