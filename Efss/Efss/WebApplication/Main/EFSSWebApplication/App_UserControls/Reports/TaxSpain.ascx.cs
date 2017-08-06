using System.Web.UI.WebControls;
using APP.Base;
using APP.Search;

namespace APP.App_UserControls.Reports
{
    public partial class TaxSpain : UserControlBase
    {
        public void LoadData(bool isRefreshed)
        {
            this.SetNavigtionMenu();
            this.SpanishFile.LoadData(true);
            this.SpanishForm.LoadData(true);
        }

        protected void SetNavigtionMenu()
        {
            var results = this.NavigationPanelSpain.LoadControlData((int)MenuType.MenuA);
            int index = NavigationMenu.GetMinimumIndex(results);
            this.MultiViewTaxSpain.ActiveViewIndex = index;
            this.NavigationPanelSpain.SetMenuStyle(this.MultiViewTaxSpain.ActiveViewIndex);
        }

        protected void NavigationMenuClick(object sender, Navigation e)
        {
            int index = e.Index;
            this.MultiViewTaxSpain.ActiveViewIndex = index;
            this.UpdatePanelTaxSpain.Update();
        }
    }
}