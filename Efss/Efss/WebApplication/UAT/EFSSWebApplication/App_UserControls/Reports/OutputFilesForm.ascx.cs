using System.Web.UI.DataVisualization.Charting;
using APP.Search;
using APP.Base;


namespace APP.App_UserControls.Reports
{
    public partial class OutputFilesForm : UserControlBase
    {
        public void LoadControl()
        {
            this.SetNavigtionMenu();
        }

        protected void NavigationMenuClick(object sender, Navigation e)
        {
            int index = e.Index;
            this.MultiViewCharts.ActiveViewIndex = index;
            this.UpdatePanelCharts.Update();
        }

        protected void SetNavigtionMenu()
        {
            var results = this.NavigationPanelCharts.LoadControlData((int)MenuType.MenuB);
            int index = NavigationMenu.GetMinimumIndex(results);
            this.MultiViewCharts.ActiveViewIndex = index;
            this.NavigationPanelCharts.SetMenuStyle(this.MultiViewCharts.ActiveViewIndex);
        }
    }
}