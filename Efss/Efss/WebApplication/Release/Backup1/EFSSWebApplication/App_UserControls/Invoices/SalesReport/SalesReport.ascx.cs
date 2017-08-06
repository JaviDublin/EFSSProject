using System;
using System.Web.UI.WebControls;
using APP.Search;

namespace APP.App_UserControls.Invoices.SalesReport
{
    public partial class SalesReport : System.Web.UI.UserControl
    {
       
        public void LoadData(bool isRefreshed)
        {
            this.SetNavigtionMenu();
            this.UCCountriesSales.LoadData(true);
            this.UpdatePanelSalesReport.Update();
        }

        protected void SetNavigtionMenu()
        {
            var results = this.NavigationPanelSalesReport.LoadControlData((int)MenuType.MenuF);
            int index = NavigationMenu.GetMinimumIndex(results);
            this.MultiViewSalesReport.ActiveViewIndex = index;
            this.NavigationPanelSalesReport.SetMenuStyle(this.MultiViewSalesReport.ActiveViewIndex);
        }

        protected void NavigationMenuClick(object sender, Navigation e)
        {
            int index = e.Index;
            this.MultiViewSalesReport.ActiveViewIndex = index;
            
            if (index == 1)
            {
                this.UCBuyersSales.LoadBuyersData(true);
            }
            else if (index == 2)
            {
                this.UCInvoicesList.LoadInvoicesData(true);
            }

            this.UpdatePanelSalesReport.Update();
        }

        #region "Countries Information"

        protected void SearchBuyers(object sender, EventArgs e)
        {
            this.MultiViewSalesReport.ActiveViewIndex = 1;
            this.NavigationPanelSalesReport.SetMenuStyle(this.MultiViewSalesReport.ActiveViewIndex);
            this.UCBuyersSales.LoadBuyersData(true);
            this.UpdatePanelSalesReport.Update();
        }

        #endregion

        #region "Buyers Information"

        protected void SearchInvoices(object sender, EventArgs e)
        {
            this.MultiViewSalesReport.ActiveViewIndex = 2;
            this.NavigationPanelSalesReport.SetMenuStyle(this.MultiViewSalesReport.ActiveViewIndex);
            this.UCInvoicesList.LoadInvoicesData(true);
            this.UpdatePanelSalesReport.Update();
        }

        #endregion

 
    }
}