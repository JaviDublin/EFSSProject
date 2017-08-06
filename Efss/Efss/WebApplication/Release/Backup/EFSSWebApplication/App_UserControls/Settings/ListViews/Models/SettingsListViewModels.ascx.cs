using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Web.UI.WebControls;
using APP.Base;
using APP.Data;
using APP.Events;
using APP.Session;
using RAD.Common;


namespace APP.App_UserControls.Settings.ListViews.Models
{
    public partial class SettingsListViewModels : UserControlBase
    {
        private ArrayList parameters;
        private ArrayList values;
        private string procedure;

        protected override void OnPreRender(EventArgs e)
        {
            if (this.Visible)
            {
                this.ListViewPager.PagerProgress.AssociatedUpdatePanelID = this.UpdatePanelListView.ID;
            }
            base.OnPreRender(e);
        }

        public void LoadData(bool isRefreshed)
        {
            if (isRefreshed)
            {
                FilterEvents e = new FilterEvents();
                SessionHandler.ApplicationFilterModelsOverView = e;
                SessionHandler.SelectedModelYear = "0";
                SessionHandler.SelectedModelCompanyId = "0";
                LabelManufacturerInformation.Text = APP.Settings.ApplicationSettings.getManufaturerName(Convert.ToInt32(SessionHandler.SelectedManufacturerid));
                this.LoadControlData(null, e, null, null, null);

            }
        }

        public void LoadControlData(object sender, FilterEvents e, int? currentPage, int? pageSize, string sortExpression)
        {

            var results = new List<APP.Search.ModelsOverView>();

            if (sortExpression == null)
            {
                this.ListViewModelsOverview.ColumnSortExpression = null;
                this.ListViewModelsOverview.ColumnIndexSorted = null;
            }

            results = APP.Search.ModelsOverView.SelectModelsFiltered(currentPage, pageSize, sortExpression, Convert.ToInt32(SessionHandler.SelectedManufacturerid), Convert.ToInt32(SessionHandler.SelectedModelCompanyId), SessionHandler.SelectedModelYear);
            
            if (results.Count >= 1)
            {
                //Set Pager details
                this.ListViewPager.SetPagerDetails(results[0].Count, ((currentPage == null || currentPage == 1) ? true : false));
                this.ListViewModelsOverview.DataSource = results;
                this.ListViewModelsOverview.DataBind();
                Templates.SetListViewDataTemplate(this.PlaceHolderData, this.PlaceHolderNoData, true);
            }
            else
            {
                this.ListViewPager.SetPagerDetails(0, true);
                this.ListViewModelsOverview.DataSource = results;
                this.ListViewModelsOverview.DataBind();
                Templates.SetListViewDataTemplate(this.PlaceHolderData, this.PlaceHolderNoData, true);
            }

            this.UpdatePanelListView.Update();
        }

        protected void ListView_Sorting(object sender, ListViewSortEventArgs e)
        {
            //Get a reference to the listview
            RAD.Controls.ListView listView = (RAD.Controls.ListView)sender;

            //Get the pager event args
            RAD.Events.PagerEventArgs args = this.ListViewPager.GetPagerEventArgs();

            //Get the filter event args
            FilterEvents filterEventArgs = SessionHandler.ApplicationFilterModelsOverView;

            //Load the data based on users selection
            this.LoadControlData(sender, filterEventArgs, args.CurrentPageNumber, args.PageSize, listView.ColumnSortExpression);
        }

        protected void OnCommand(object sender, CommandEventArgs e)
        {
            if (e.CommandName == "Filter")
            {
                if (DropDownListCompanyCode.SelectedIndex == 0)
                { SessionHandler.SelectedModelCompanyId = "0"; }
                else
                { SessionHandler.SelectedModelCompanyId = DropDownListCompanyCode.SelectedValue; }

                if (DropDownListMModelYear.SelectedIndex == 0)
                { SessionHandler.SelectedModelYear = "0"; }
                else
                { SessionHandler.SelectedModelYear = DropDownListMModelYear.SelectedValue; }

                this.LoadControlData(null, SessionHandler.ApplicationFilterModelsOverView, null, null, null);
            }
            else if (e.CommandName == "Export")
            {
                ExportToExcel();
            }
        }

        protected void OnPager_Command(object sender, RAD.Events.PagerEventArgs e)
        {
            this.LoadControlData(sender, SessionHandler.ApplicationFilterModelsOverView, (int?)e.CurrentPageNumber, (int?)e.PageSize, this.ListViewModelsOverview.ColumnSortExpression);
        }

        private void ExportToExcel()
        {
            DataTable dt = new DataTable();
            APP.CustomControls.ExcelGrid gv = new APP.CustomControls.ExcelGrid();
            DBAgent export;
            procedure = StoredProcedures.Select_Models_ExportToExcel;
            parameters = new ArrayList();
            values = new ArrayList();
            parameters.Add("@manufacturerId");
            values.Add(SessionHandler.SelectedManufacturerid);
            parameters.Add("@companyId");
            values.Add(SessionHandler.SelectedModelCompanyId);
            parameters.Add("@modelYear");
            values.Add(SessionHandler.SelectedModelYear);
            export = new DBAgent(procedure, parameters, values);
            dt = export.ReturnData();
            
            
            gv.DataSource = dt;
            gv.DataBind();

            Response.Clear();
            Response.Buffer = true;
            Response.ContentType = "application/vnd.ms-excel";
            Response.AddHeader("content-disposition", "attachment;filename=Models.xls");
            Response.Charset = "";
            this.EnableViewState = false;
            System.IO.StringWriter sw = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter htw = new System.Web.UI.HtmlTextWriter(sw);
            gv.RenderControl(htw);
            Response.Write(sw.ToString());
            Response.End();
        }

    }
}