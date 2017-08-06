using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Web;
using System.Web.UI.WebControls;
using APP.Base;
using APP.Data;
using APP.Session;
using APP.Settings;

namespace APP.App_UserControls.Fleet.PanelColumns
{
    public partial class FleetPanelColumns : UserControlBase
    {
        ArrayList columns;
        ArrayList conditions;
        private ArrayList parameters;
        private ArrayList values;
        private string procedure;
        string _select = "*";
        string _table;
        string _condition;
        string countryName;


        public void LoadData(bool isRefreshed)
        {
            if (isRefreshed)
            {
                FillDropDownFilters();

                DropDownListCountries.DataSource = null;
                DropDownListCountries.Items.Clear();
                var countries = new List<APP.Search.SearchCountries>();
                countries = APP.Search.SearchCountries.SelectCountries();
                DropDownListCountries.Items.Add("ALL");
                DropDownListCountries.DataSource = countries;
                DropDownListCountries.DataTextField = "CountryName";
                DropDownListCountries.DataValueField = "CountryId";
                DropDownListCountries.DataBind();
                DropDownListCountries.SelectedIndex = 0;

                DropDownListCompanies.DataSource = null;
                DropDownListCompanies.Items.Clear();
                DropDownListCompanies.Items.Add("ALL");

                DropDownListManufacturer.DataSource = null;
                DropDownListManufacturer.Items.Clear();
                DropDownListManufacturer.Items.Add("ALL");

                SessionHandler.SearchFormCountryName = "ALL";
                SessionHandler.SearchFormCompanyName = "ALL";

            }
        }

        private void SetFormSessions()
        {
            SessionHandler.SearchFormCountryName = DropDownListCountries.SelectedItem.Text;
            SessionHandler.SearchFormCountryId = ApplicationSettings.GetCountryId(SessionHandler.ApplicationCountryName);
            SessionHandler.SearchFormCompanyName = DropDownListCompanies.SelectedItem.Text;
            SessionHandler.SearchFormCompanyId = ApplicationSettings.GetCompanyId(SessionHandler.ApplicationCompanyName);
            if (SessionHandler.SearchFormCompanyId == 0)
            {
                SessionHandler.SearchFormCompanyId = null;
            }
        }

        public void LoadCompanies()
        {
            countryName = DropDownListCountries.SelectedItem.Text;

            if (countryName == "ALL")
            {
                DropDownListCompanies.DataSource = null;
                DropDownListCompanies.Items.Clear();
                DropDownListCompanies.Items.Add("ALL");
                SetFormSessions();
            }
            else
            {
                DropDownListCompanies.DataSource = null;
                DropDownListCompanies.Items.Clear();

                var companies = new List<APP.Search.SearchCompanies>();
                companies = APP.Search.SearchCompanies.SelectCompaniesByCountry(countryName);
                if (companies.Count > 1)
                {
                    DropDownListCompanies.Items.Add("ALL");
                }
                DropDownListCompanies.DataSource = companies;
                DropDownListCompanies.DataTextField = "CompanyName";
                DropDownListCompanies.DataValueField = "CompanyId";
                DropDownListCompanies.DataBind();
                SetFormSessions();
            }

            
        }

        public void LoadManufacturers()
        {
            DropDownListManufacturer.DataSource = null;
            DropDownListManufacturer.Items.Clear();
            DropDownListManufacturer.Items.Add("ALL");
            var manufacturer = new List<APP.Search.SearchManufacturers>();
            manufacturer = APP.Search.SearchManufacturers.SelectManufacturersByCompanyId();
            DropDownListManufacturer.DataSource = manufacturer;
            DropDownListManufacturer.DataTextField = "ManufacturerName";
            DropDownListManufacturer.DataValueField = "ManufacturerId";
            DropDownListManufacturer.DataBind();
            DropDownListManufacturer.SelectedIndex = 0;

        }

        protected void DropDownListCountries_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadCompanies();
            SetFormSessions();
            LoadManufacturers();

            this.UpdatePanelFleetExcel.Update();
        }

        protected void DropDownListCompanies_SelectedIndexChanged(object sender, EventArgs e)
        {
            SetFormSessions();
            LoadManufacturers();
            this.UpdatePanelFleetExcel.Update();
        }

        public void FillDropDownFilters()
        {
            ArrayList addItems = new ArrayList();
            addItems.Add(new APP.Common.ListValues("=", "0"));
            addItems.Add(new APP.Common.ListValues(">=", "1"));
            addItems.Add(new APP.Common.ListValues(">", "2"));
            addItems.Add(new APP.Common.ListValues("<=", "3"));
            addItems.Add(new APP.Common.ListValues("<", "4"));

            DropDownListInServiceDate.DataSource = addItems;
            DropDownListInServiceDate.DataTextField = "Name";
            DropDownListInServiceDate.DataValueField = "Value";
            DropDownListInServiceDate.DataBind();

            DropDownListInServiceDate2.DataSource = addItems;
            DropDownListInServiceDate2.DataTextField = "Name";
            DropDownListInServiceDate2.DataValueField = "Value";
            DropDownListInServiceDate2.DataBind();

            DropDownListMSODate.DataSource = addItems;
            DropDownListMSODate.DataTextField = "Name";
            DropDownListMSODate.DataValueField = "Value";
            DropDownListMSODate.DataBind();

            DropDownListMSODate2.DataSource = addItems;
            DropDownListMSODate2.DataTextField = "Name";
            DropDownListMSODate2.DataValueField = "Value";
            DropDownListMSODate2.DataBind();

            DropDownListDeliveryDate.DataSource = addItems;
            DropDownListDeliveryDate.DataTextField = "Name";
            DropDownListDeliveryDate.DataValueField = "Value";
            DropDownListDeliveryDate.DataBind();

            DropDownListDeliveryDate2.DataSource = addItems;
            DropDownListDeliveryDate2.DataTextField = "Name";
            DropDownListDeliveryDate2.DataValueField = "Value";
            DropDownListDeliveryDate2.DataBind();

            DropDownListOperatorMileage.DataSource = addItems;
            DropDownListOperatorMileage.DataTextField = "Name";
            DropDownListOperatorMileage.DataValueField = "Value";
            DropDownListOperatorMileage.DataBind();

        }

        protected void OnCommand(object sender, CommandEventArgs e)
        {
            if (e.CommandName == "Export")
            {
                ExportToExcel(QueryBuilderSelect(), QueryBuilderTable(), QueryBuilderConditions());
            }
            else if (e.CommandName == "Select")
            { 
                SelectAll();
                this.UpdatePanelFleetExcel.Update();
            }
            else if (e.CommandName == "Deselect")
            {
                DeselectAll();
                this.UpdatePanelFleetExcel.Update();
            }
            
        }

        private void SelectAll()
        {
            CheckBoxCompanyCode.Checked = true;
            CheckBoxMileage.Checked = true;
            CheckBoxCapitalCost.Checked = true;
            CheckBoxBuyerCode.Checked = true;

            CheckBoxAreaCode.Checked = true;
            CheckBoxInServiceDate.Checked = true;
            CheckBoxDepreciation.Checked = true;
            CheckBoxBuyerName.Checked = true;

            CheckBoxSerial.Checked = true;
            CheckBoxOutServiceDate.Checked = true;
            CheckBoxDepreciationRate.Checked = true;
            CheckBoxsaleDocumentNumber.Checked = true;


            CheckBoxPlate.Checked = true;
            CheckBoxMSOServiceDate.Checked = true;
            CheckBoxDepreciationPCT.Checked = true;
            CheckBoxInvoiceNumber.Checked = true;

            CheckBoxUnit.Checked = true;
            CheckBoxDeliveryDate.Checked = true;
            CheckBoxBookValue.Checked = true;
            CheckBoxInvoiceStatus.Checked = true;

            CheckBoxModelCode.Checked = true;
            CheckBoxDaysInService.Checked = true;
            CheckBoxBuyBackCap.Checked = true;

            CheckBoxManufacturer.Checked = true;
            CheckBoxVehicleType.Checked = true;
            CheckBoxsalesPrice.Checked = true;

            CheckBoxModelDesc.Checked = true;
            CheckBoxVehicleClass.Checked = true;
            CheckBoxSaleType.Checked = true;

            CheckBoxModelYear.Checked = true;
            CheckBoxVehicleStatus.Checked = true;
            CheckBoxRateClass.Checked = true;

     
        }

        private void DeselectAll()
        {
            CheckBoxCompanyCode.Checked = false;
            CheckBoxMileage.Checked = false;
            CheckBoxCapitalCost.Checked = false;
            CheckBoxBuyerCode.Checked = false;

            CheckBoxAreaCode.Checked = false;
            CheckBoxInServiceDate.Checked = false;
            CheckBoxDepreciation.Checked = false;
            CheckBoxBuyerName.Checked = false;

            CheckBoxSerial.Checked = false;
            CheckBoxOutServiceDate.Checked = false;
            CheckBoxDepreciationRate.Checked = false;
            CheckBoxsaleDocumentNumber.Checked = false;

            CheckBoxPlate.Checked = false;
            CheckBoxMSOServiceDate.Checked = false;
            CheckBoxDepreciationPCT.Checked = false;
            CheckBoxInvoiceNumber.Checked = false;

            CheckBoxUnit.Checked = false;
            CheckBoxDeliveryDate.Checked = false;
            CheckBoxBookValue.Checked = false;
            CheckBoxInvoiceStatus.Checked = false;

            CheckBoxModelCode.Checked = false;
            CheckBoxDaysInService.Checked = false;
            CheckBoxBuyBackCap.Checked = false;

            CheckBoxManufacturer.Checked = false;
            CheckBoxVehicleType.Checked = false;
            CheckBoxsalesPrice.Checked = false;

            CheckBoxModelDesc.Checked = false;
            CheckBoxVehicleClass.Checked = false;
            CheckBoxSaleType.Checked = false;

            CheckBoxModelYear.Checked = false;
            CheckBoxVehicleStatus.Checked = false;
            CheckBoxRateClass.Checked = false;
        }

        private string QueryBuilderSelect()
        {
            columns = new ArrayList();

            if (CheckBoxCompanyCode.Checked)
            { columns.Add(DBSettings.CompanyCode); }
            if (CheckBoxAreaCode.Checked)
            { columns.Add(DBSettings.AreaCode); }
            if (CheckBoxSerial.Checked)
            { columns.Add(DBSettings.Serial); }
            if (CheckBoxPlate.Checked)
            { columns.Add(DBSettings.Plate); }
            if (CheckBoxUnit.Checked)
            { columns.Add(DBSettings.Unit); }
            if (CheckBoxModelCode.Checked)
            { columns.Add(DBSettings.ModelCode); }
            if (CheckBoxManufacturer.Checked)
            { columns.Add(DBSettings.ManufacturerName); }
            if (CheckBoxModelDesc.Checked)
            { columns.Add(DBSettings.ModelDescription); }
            if (CheckBoxModelYear.Checked)
            { columns.Add(DBSettings.ModelYear); }
            if (CheckBoxMileage.Checked)
            { columns.Add(DBSettings.Mileage); }
            if (CheckBoxVehicleType.Checked)
            { columns.Add(DBSettings.VehicleType); }
            if (CheckBoxVehicleClass.Checked)
            { columns.Add(DBSettings.VehiclaClass); }
            if (CheckBoxVehicleStatus.Checked)
            { columns.Add(DBSettings.VehicleStatus); }
            if (CheckBoxInServiceDate.Checked)
            { columns.Add(DBSettings.InServiceDate); }
            if (CheckBoxOutServiceDate.Checked)
            { columns.Add(DBSettings.OutServiceDate); }
            if (CheckBoxMSOServiceDate.Checked)
            { columns.Add(DBSettings.MSODate); }
            if (CheckBoxDeliveryDate.Checked)
            { columns.Add(DBSettings.DeliveryDate); }
            if (CheckBoxDaysInService.Checked)
            { columns.Add(DBSettings.DaysInService); }
            if (CheckBoxCapitalCost.Checked)
            { columns.Add(DBSettings.CapitalCost); }
            if (CheckBoxDepreciation.Checked)
            { columns.Add(DBSettings.Depreciation); }
            if (CheckBoxDepreciationRate.Checked)
            { columns.Add(DBSettings.DepreciationRate); }
            if (CheckBoxDepreciationPCT.Checked)
            { columns.Add(DBSettings.DepreciationPCT); }
            if (CheckBoxBookValue.Checked)
            { columns.Add(DBSettings.BookValue); }
            if (CheckBoxBuyBackCap.Checked)
            { columns.Add(DBSettings.BuyBackCap); }
            if (CheckBoxsalesPrice.Checked)
            { columns.Add(DBSettings.SalesPrice); }
            if (CheckBoxBuyerCode.Checked)
            { columns.Add(DBSettings.BuyerCode); }
            if (CheckBoxBuyerName.Checked)
            { columns.Add(DBSettings.BuyerName); }
            if (CheckBoxRateClass.Checked)
            { columns.Add(DBSettings.RateClass); }
            if (CheckBoxsaleDocumentNumber.Checked)
            { columns.Add(DBSettings.SaleDocumentNumber); }
            if (CheckBoxInvoiceNumber.Checked)
            { columns.Add(DBSettings.InvoiceNumber); }
            if (CheckBoxInvoiceStatus.Checked)
            { columns.Add(DBSettings.InvoiceStatus); }
            if (CheckBoxSaleType.Checked)
            { columns.Add(DBSettings.SaleType); }

            if (columns.Count > 0)
            {
                _select = String.Empty;
                foreach (string item in columns)
                {
                    _select = _select + item + DBSettings.Delimiter;
                }
            }


            return _select.TrimEnd(',');

        }

        private string QueryBuilderTable()
        {
            _table = DropDownListFiles.SelectedValue;
            return _table;
        }

        private string QueryBuilderConditions()
        {
            conditions = new ArrayList();

            if (DropDownListCountries.SelectedValue != "ALL")
            {
                conditions.Add(DBSettings.CountryCondition + DropDownListCountries.SelectedValue);

                if (DropDownListCompanies.SelectedValue != "ALL")
                {
                    conditions.Add(DBSettings.CompanyCondition + DropDownListCompanies.SelectedValue);
                }
            }
            else
            {
                conditions.Add(DBSettings.CountryALLCondition);
            }

            if (txtAreaCode.Text != String.Empty)
            { conditions.Add(DBSettings.AreaCondition + txtAreaCode.Text + DBSettings.EndStringValue); }
            if (txtModelCode.Text != String.Empty)
            { conditions.Add(DBSettings.ModelCodeCondition + txtModelCode.Text + DBSettings.EndStringValue); }
            if (DropDownListManufacturer.SelectedIndex > 0)
            { conditions.Add(DBSettings.ManufacturerCondition + DropDownListManufacturer.SelectedValue); }
            if (txtInServiceDate.Text != String.Empty)
            { conditions.Add(DBSettings.InServiceDateCondition + GetOperator(DropDownListInServiceDate.SelectedValue) + DBSettings.StartConvertDate + txtInServiceDate.Text + DBSettings.EndConvertDate); }
            if (txtInServiceDate2.Text != String.Empty)
            { conditions.Add(DBSettings.InServiceDateCondition + GetOperator(DropDownListInServiceDate2.SelectedValue) + DBSettings.StartConvertDate + txtInServiceDate2.Text + DBSettings.EndConvertDate); }
            if (txtMsoDate.Text != String.Empty)
            { conditions.Add(DBSettings.MSODateCondition + GetOperator(DropDownListMSODate.SelectedValue) + DBSettings.StartConvertDate + txtMsoDate.Text + DBSettings.EndConvertDate); }
            if (txtMsoDate2.Text != String.Empty)
            { conditions.Add(DBSettings.MSODateCondition + GetOperator(DropDownListMSODate2.SelectedValue) + DBSettings.StartConvertDate + txtMsoDate2.Text + DBSettings.EndConvertDate); }
            if (txtMileage.Text != String.Empty)
            { conditions.Add(DBSettings.MileageCondition + GetOperator(DropDownListOperatorMileage.SelectedValue) + txtMileage.Text); }
            if (txtDeliveryDate.Text != String.Empty)
            { conditions.Add(DBSettings.DeliveryDateDateCondition + GetOperator(DropDownListDeliveryDate.SelectedValue) + DBSettings.StartConvertDate + txtDeliveryDate.Text + DBSettings.EndConvertDate); }
            if (txtDeliveryDate2.Text != String.Empty)
            { conditions.Add(DBSettings.DeliveryDateDateCondition + GetOperator(DropDownListDeliveryDate2.SelectedValue) + DBSettings.StartConvertDate + txtDeliveryDate2.Text + DBSettings.EndConvertDate); }
            if (TextBoxBuyerCode.Text != String.Empty)
            { conditions.Add(DBSettings.BuyerCondition + TextBoxBuyerCode.Text + DBSettings.EndStringValue); }
            if (DropDownListSaleType.SelectedIndex > 0)
            { conditions.Add(DBSettings.SaleTypeCondition + DropDownListSaleType.SelectedValue + DBSettings.EndStringValue); }
            if (DropDownListVehicleStatus.SelectedIndex > 0)
            { conditions.Add(DBSettings.VehicleStatusCondition + DropDownListVehicleStatus.SelectedValue + DBSettings.EndStringValue); }

            if (conditions.Count > 0)
            {
                _condition = DBSettings.WhereClause;
                foreach (string cond in conditions)
                {
                    _condition = _condition + cond + DBSettings.AndOperator;
                }

                return _condition.Remove(_condition.Length - 4, 3);
            }
            else
            {
                return _condition;
            }

            
        }

        private string GetOperator(string value)
        {
            switch (value)
            {
                case "0":
                    return DBSettings.EqualOperator;
                case "1":
                    return DBSettings.BiggerEqualthanOperator;
                case "2":
                    return DBSettings.BiggerthanOperator;
                case "3":
                    return DBSettings.SamllerEqualthanOperator;
                case "4":
                    return DBSettings.SamllerthanOperator;
                default:
                    return DBSettings.EqualOperator;
            }
        }

        private void ExportToExcel(string columns, string table, string conditions)
        {
            DataTable dt = new DataTable();
            GridView gv = new GridView();
            DBAgent export;
            
            
            procedure = StoredProcedures.Select_Fleet_ExportToExcel;
            parameters = new ArrayList();
            values = new ArrayList();
            parameters.Add("@columnNames");
            values.Add(columns);
            parameters.Add("@fileId");
            values.Add(table);
            parameters.Add("@conditions");
            values.Add(conditions);
            export = new DBAgent(procedure, parameters, values);
            dt = export.ReturnData();
            
            if (dt.Rows.Count == 0)
            {
                APP.Data.DBNoData nd = new APP.Data.DBNoData();
                gv.DataSource = nd.NoDataAvailable();
                gv.DataBind();
                Response.Clear();
                Response.Buffer = true;
                Response.ContentType = "application/vnd.ms-excel";
                Response.AddHeader("content-disposition", "attachment;filename=Invoices.xls");
                Response.Charset = "";
                this.EnableViewState = false;
                System.IO.StringWriter sw = new System.IO.StringWriter();
                System.Web.UI.HtmlTextWriter htw = new System.Web.UI.HtmlTextWriter(sw);
                gv.RenderControl(htw);
                Response.Write(sw.ToString());
                Response.End();
            }
            else
            {
                gv.DataSource = dt;
                gv.DataBind();
                Response.Clear();
                Response.Buffer = true;
                Response.ContentType = "application/vnd.ms-excel";
                Response.AddHeader("content-disposition", "attachment;filename=Fleet.xls");
                Response.Charset = "";
                Response.Cache.SetCacheability(HttpCacheability.NoCache);
                this.EnableViewState = false;
                System.IO.StringWriter sw = new System.IO.StringWriter();
                System.Web.UI.HtmlTextWriter htw = new System.Web.UI.HtmlTextWriter(sw);
                gv.RenderControl(htw);
                Response.Write(sw.ToString());
                Response.End();
            }
        }
    }
}