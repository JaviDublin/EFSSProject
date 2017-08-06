using System;
using System.Collections.Generic;
using System.Text;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using APP.Paging;
using RAD.Common;


/// <summary>
/// Custom Control Class
/// Standard ASP.Net controls modified to application needs.
/// To use these controls please ensure that namespace is referenced in web.config under the controls section
/// </summary>
namespace APP.CustomControls
{

    #region "TextBoxes"

    /// <summary>
    /// 
    /// </summary>
    public class NumericUnlimitedTextBox : NumericTextBox
    {
        public string AssociatedCheckBoxControlID { get; set; }

        protected override void OnPreRender(EventArgs e)
        {

            this.Attributes.Add("onkeyup", "UnlimitedNumeric('TextBox','" + this.ClientID + "','" + AssociatedCheckBoxControlID + "')");
            base.OnPreRender(e);
        }

    }

    /// <summary>
    /// Enable validation of max length of textbox when in multi line mode.
    /// Please ensure that javascript file Controls is included where ever you use this control.
    /// </summary>
    public class TextArea : System.Web.UI.WebControls.TextBox
    {
        protected override void OnPreRender(EventArgs e)
        {
            if (MaxLength > 0 && TextMode == TextBoxMode.MultiLine)
            {
                // Add javascript handlers for paste and keypress 
                Attributes.Add("onkeypress", "TextAreaDoKeypress(this);");
                Attributes.Add("onbeforepaste", "TextAreaDoBeforePaste(this);");
                Attributes.Add("onpaste", "TextAreaDoPaste(this);");

                // Add attribute for access of maxlength property on client-side 
                Attributes.Add("maxLength", this.MaxLength.ToString());

            }
            base.OnPreRender(e);
        }
    }

    /// <summary>
    /// A textbox that allows only numeric digits to be entered.
    /// Please ensure that javascript file Controls is included where ever you use this control.
    /// </summary>
    public class NumericTextBox : System.Web.UI.WebControls.TextBox
    {
        protected override void OnPreRender(EventArgs e)
        {

            Attributes.Add("onkeydown", "return isNumeric(event.keyCode);");
            Attributes.Add("onpaste", "return false;");

            this.MaxLength = 15;
            base.OnPreRender(e);
        }
    }

    /// <summary>
    /// 
    /// </summary>
    public class DecimalTextBox : System.Web.UI.WebControls.TextBox
    {
        protected override void OnPreRender(EventArgs e)
        {
            Attributes.Add("onblur", "CheckDecimal('" + this.ClientID + "');");
            Attributes.Add("onkeydown", "return isDecimal(event.keyCode);");
            Attributes.Add("onpaste", "return false;");
            base.OnPreRender(e);
        }
    }

    public class NumericLargeTextBox : System.Web.UI.WebControls.TextBox
    {
        protected override void OnPreRender(EventArgs e)
        {
            Attributes.Add("onblur", "addCommas('" + this.ClientID + "');");
            Attributes.Add("onkeydown", "return isNumeric(event.keyCode);");
            Attributes.Add("onpaste", "return false;");
            this.MaxLength = 15;
            base.OnPreRender(e);
        }
    }
    /// <summary>
    /// A textbox that allows only alpha characters to be entered.
    /// Please ensure that javascript file Controls is included where ever you use this control.
    /// </summary>
    public class AlphaTextBox : System.Web.UI.WebControls.TextBox
    {
        protected override void OnPreRender(EventArgs e)
        {

            Attributes.Add("onkeydown", "return isAlpha(event.keyCode);");
            Attributes.Add("onpaste", "return false;");
            base.OnPreRender(e);
        }
    }

    /// <summary>
    /// A textbox that allows only alpha characters and numeric digits to be entered.
    /// Please ensure that javascript file Controls is included where ever you use this control.
    /// </summary>
    public class AlphaNumericTextBox : System.Web.UI.WebControls.TextBox
    {
        protected override void OnPreRender(EventArgs e)
        {

            Attributes.Add("onkeydown", "return isAlphaNumeric(event.keyCode);");
            Attributes.Add("onpaste", "return false;");
            base.OnPreRender(e);
        }
    }

    /// <summary>
    /// 
    /// </summary>
    public class AlphaNumericTextBoxSpace : System.Web.UI.WebControls.TextBox
    {
        protected override void OnPreRender(EventArgs e)
        {

            Attributes.Add("onkeydown", "return isAlphaNumericSpace(event.keyCode);");
            Attributes.Add("onpaste", "return false;");
            base.OnPreRender(e);
        }
    }

    /// <summary>
    /// A textbox control that only allows digits and / for entering date values eg: 02/10/2010
    /// Please ensure that javascript file Controls is included where ever you use this control.
    /// </summary>
    public class DateTextBox : System.Web.UI.WebControls.TextBox
    {
        protected override void OnPreRender(EventArgs e)
        {
            Attributes.Add("onkeydown", "return isDate(event.keyCode);");
            Attributes.Add("onpaste", "return false;");
            base.OnPreRender(e);
        }
    }


    /// <summary>
    /// 
    /// </summary>
    public class AutoCompleteInteger : NumericTextBox
    {
        public string WebServiceUrl { get; set; }
        public string HiddenFieldId { get; set; }

        protected override void OnPreRender(EventArgs e)
        {

            this.MaxLength = 9;
            this.Width = 60;
            this.CssClass = "textbox-AutoComplete";

            base.OnPreRender(e);
            if (this.Visible)
            {
                //Create the script
                StringBuilder script = new StringBuilder();
                script.Append("$(document).ready(function() {SearchAutoComplete('");
                script.Append(this.ClientID);
                script.Append("','");
                script.Append(this.HiddenFieldId);
                script.Append("','");
                script.Append(this.WebServiceUrl);
                script.Append("')});");

                //Register the script
                Scripts.RegisterStartUpClientScript(Page, script.ToString(), "AutoComplete" + this.ClientID);
            }

        }

    }

    /// <summary>
    /// 
    /// </summary>
    public class AutoCompleteString : AlphaNumericTextBox
    {
        public string WebServiceUrl { get; set; }
        public string HiddenFieldId { get; set; }

        protected override void OnPreRender(EventArgs e)
        {

            base.OnPreRender(e);
            this.MaxLength = 200;
            this.CssClass = "textbox-AutoComplete";

            //if (this.Visible)
            //{
            //    ////Create the script
            //    //StringBuilder script = new StringBuilder();
            //    //script.Append("$(document).ready(function() {SearchAutoComplete('");
            //    //script.Append(this.ClientID);
            //    //script.Append("','");
            //    //script.Append(this.HiddenFieldId);
            //    //script.Append("','");
            //    //script.Append(this.WebServiceUrl);
            //    //script.Append("')});");

            //    ////Register the script
            //    //Scripts.RegisterStartUpClientScript(Page, script.ToString(), "AutoComplete" + this.ClientID);

            //}
        }

    }

    /// <summary>
    /// 
    /// </summary>
    public class AutoCompleteSpace : AlphaNumericTextBoxSpace
    {
        public string WebServiceUrl { get; set; }
        public string HiddenFieldId { get; set; }

        protected override void OnPreRender(EventArgs e)
        {

            base.OnPreRender(e);
            this.MaxLength = 200;
            this.CssClass = "textbox-AutoComplete";

            //if (this.Visible)
            //{
            //    //Create the script
            //    StringBuilder script = new StringBuilder();
            //    script.Append("$(document).ready(function() {SearchAutoComplete('");
            //    script.Append(this.ClientID);
            //    script.Append("','");
            //    script.Append(this.HiddenFieldId);
            //    script.Append("','");
            //    script.Append(this.WebServiceUrl);
            //    script.Append("')});");

            //    //Register the script
            //    Scripts.RegisterStartUpClientScript(Page, script.ToString(), "AutoComplete" + this.ClientID);

            //}
        }

    }

    #endregion

    #region "ListViews"

    public class ListViewSortingControl : System.Web.UI.WebControls.ListView
    {
        /// <summary>
        /// Property value of the table within the layout of the listview
        /// </summary>
        public string LayoutTableID { get; set; }

        /// <summary>
        /// Property value for the Item Template row
        /// </summary>
        public string ItemTemplateRow { get; set; }

        /// <summary>
        /// Store the index of the column being sorted so we can change the style of that column
        /// when the user has sorted by a particular item
        /// </summary>
        public int? ColumnIndexSorted
        {
            get
            {
                object viewStateObject = this.ViewState["ColumnIndexSorted"];
                return (viewStateObject != null) ? (int?)viewStateObject : null;
            }
            set { this.ViewState["ColumnIndexSorted"] = value; }
        }


        public string ColumnSortExpression
        {
            get
            {
                object viewStateObject = this.ViewState["ColumnSortExpression"];
                return (viewStateObject != null) ? viewStateObject.ToString() : null;
            }
            set { this.ViewState["ColumnSortExpression"] = value; }
        }

        /// <summary>
        /// 
        /// </summary>
        public string CheckBoxControlID { get; set; }


        /// <summary>
        /// 
        /// </summary>
        public List<string> SelectedRows
        {
            get
            {
                object viewStateObject = this.ViewState["ListViewSelectedRows"];

                if (viewStateObject == null)
                {
                    this.ViewState["ListViewSelectedRows"] = new List<string>();
                    viewStateObject = this.ViewState["ListViewSelectedRows"];
                }
                return (List<string>)viewStateObject;
            }
        }

        /// <summary>
        /// Override the Item Databound event to set specific style rules and events
        /// </summary>
        /// <param name="e"></param>
        protected override void OnItemDataBound(ListViewItemEventArgs e)
        {

            //Build jscript to run at start up to not show progress when being updated
            // StringBuilder script = new StringBuilder();
            //script.Append("$(document).ready(function() {");

            //Get the header row of the Layout Table
            HtmlTableRow header = ((HtmlTable)this.FindControl(LayoutTableID)).Rows[0];

            //Loop throught the all the cells in the header row to find our link buttons
            for (int i = 0; i < header.Cells.Count; i++)
            {
                //Declare a variable to hold the table header
                HtmlTableCell th = header.Cells[i];

                //  find each LinkButton control
                foreach (Control c in th.Controls)
                {
                    if (c is LinkButtonListViewHeader)
                    {
                        //Add exclude progress script for that link button
                        LinkButtonListViewHeader linkButton = c as LinkButtonListViewHeader;
                        //script.Append("AddExcludeShowProgress('" + linkButton.ClientID + "');");

                    }
                }
            }

            //script.Append("});");
            //Register the script to load when the page is ready
            // Scripts.RegisterStartUpClientScript(this.Page, script.ToString(), "ListViewControlHeaders_" + this.ClientID);

            //Check if the listview is sorted
            if (this.ColumnIndexSorted != null)
            {

                //Set the style of the sorted column
                HtmlTableRow tr = (HtmlTableRow)e.Item.FindControl(this.ItemTemplateRow);
                HtmlTableCell td = tr.Cells[this.ColumnIndexSorted.Value];
                string originalCellStyle = td.Attributes["class"];
                td.Attributes["class"] = string.Format("{0} {1}", originalCellStyle, "sort").Trim();
            }
            else
            {
                //Loop throught the all the cells in the header row to find our link buttons
                for (int i = 0; i < header.Cells.Count; i++)
                {
                    //Declare a variable to hold the table header
                    HtmlTableCell th = header.Cells[i];
                    //  find each LinkButton control
                    foreach (Control c in th.Controls)
                    {
                        if (c is LinkButtonListViewHeader)
                        {

                            LinkButtonListViewHeader linkButton = c as LinkButtonListViewHeader;
                            //Remove the indicators and set the sort direction to none
                            th.Attributes["class"] = "";
                            linkButton.SortDirection = (int)ListViewSortDirection.None;
                        }
                    }
                }
            }


            if (e.Item.ItemType == ListViewItemType.DataItem)
            {

                ListViewDataItem dataItem = (ListViewDataItem)e.Item;

                //Find the checkbox in the current row
                CheckBox selectCheckBox = (CheckBox)dataItem.FindControl(CheckBoxControlID);

                //Check to make sure checkbox is not nothing
                if (selectCheckBox != null)
                {

                    //If the ID exists in our list then check the checkbox
                    string id = this.DataKeys[dataItem.DisplayIndex].Values[0].ToString();
                    selectCheckBox.Checked = this.SelectedRows.Contains(id);


                    HtmlTableRow itemRow = (HtmlTableRow)e.Item.FindControl(this.ItemTemplateRow);
                    for (int i = 0; i < itemRow.Cells.Count; i++)
                    {
                        if (i > 0 && i < itemRow.Cells.Count - 1)
                        {
                            HtmlTableCell itemCell = itemRow.Cells[i];
                            itemCell.Attributes.Add("onclick", "ListViewSelectRow('" + selectCheckBox.ClientID + "')");

                        }
                    }

                    itemRow.Attributes.Add("onmouseover", "this.className='listViewRowHover';");
                    itemRow.Attributes.Add("onmouseout", "this.className='listViewRow';");

                }

            }

            base.OnItemDataBound(e);
        }

        /// <summary>
        /// Override the Sorting event to enable global use of control
        /// </summary>
        /// <param name="e"></param>
        protected override void OnSorting(ListViewSortEventArgs e)
        {
            this.AddSelectedRows();

            //Get the header row of the listview table
            HtmlTableRow header = ((HtmlTable)this.FindControl(this.LayoutTableID)).Rows[0];

            //Loop through the header row 
            for (int i = 0; i < header.Cells.Count; i++)
            {
                //Declare a variable to hold the table header
                HtmlTableCell th = header.Cells[i];

                //Get the class attribute for header
                string originalHeaderStyle = th.Attributes["class"];

                //Find the LinkButton controls
                foreach (Control c in th.Controls)
                {
                    //Check that controls are linkbuttons
                    if (c is LinkButtonListViewHeader)
                    {
                        //Reference the link button
                        LinkButtonListViewHeader linkButton = c as LinkButtonListViewHeader;

                        //Check the link button is not nothing and also equals the sort expression of the listview
                        if (linkButton != null && linkButton.CommandArgument == e.SortExpression)
                        {
                            //Check the sort direction of the listview
                            //And set the sort indicator for the column been sorted
                            //Set the sort direction as appropiate for the column
                            switch (linkButton.SortDirection)
                            {
                                case (int)ListViewSortDirection.None:
                                    this.ColumnSortExpression = e.SortExpression;
                                    linkButton.SortDirection = (int)ListViewSortDirection.Ascending;
                                    th.Attributes["class"] = "sortasc";
                                    break;
                                case (int)ListViewSortDirection.Ascending:
                                    this.ColumnSortExpression = e.SortExpression + ListViewSorting.DESC;
                                    linkButton.SortDirection = (int)ListViewSortDirection.Descending;
                                    th.Attributes["class"] = "sortdesc";
                                    break;
                                case (int)ListViewSortDirection.Descending:
                                    this.ColumnSortExpression = e.SortExpression;
                                    linkButton.SortDirection = (int)ListViewSortDirection.Ascending;
                                    th.Attributes["class"] = "sortasc";
                                    break;

                            }

                            //Set the columnindex being sorted
                            this.ColumnIndexSorted = i;

                        }
                        else
                        {
                            //For all other columns remove the indicators and set the sort direction to none
                            th.Attributes["class"] = "";
                            linkButton.SortDirection = (int)ListViewSortDirection.None;
                        }
                    }
                }

            }


            base.OnSorting(e);

        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="e"></param>
        protected override void OnPagePropertiesChanging(PagePropertiesChangingEventArgs e)
        {
            this.AddSelectedRows();
            base.OnPagePropertiesChanging(e);

        }

        /// <summary>
        /// 
        /// </summary>
        public void AddSelectedRows()
        {
            foreach (ListViewDataItem item in this.Items)
            {
                CheckBox selectCheckBox = (CheckBox)item.FindControl(CheckBoxControlID);

                if (selectCheckBox != null)
                {
                    string id = this.DataKeys[item.DisplayIndex].Values[0].ToString();

                    if (selectCheckBox.Checked && !this.SelectedRows.Contains(id))
                    {
                        this.SelectedRows.Add(id);
                    }
                    else if (!selectCheckBox.Checked && this.SelectedRows.Contains(id))
                    {
                        this.SelectedRows.Remove(id);
                    }

                }
            }
        }

        /// <summary>
        /// 
        /// </summary>
        public void ClearSelectedRows()
        {
            this.SelectedRows.Clear();
        }

    }

    #endregion

    #region "LinkButtons"

    /// <summary>
    /// 
    /// </summary>
    public class LinkButtonExcludeProgress : System.Web.UI.WebControls.LinkButton
    {
        protected override void OnPreRender(EventArgs e)
        {

            ////Script to exlcude from showing progress
            //StringBuilder script = new StringBuilder();
            //script.Append("$(document).ready(function() { AddExcludeShowProgress('");
            //script.Append(this.ClientID);
            //script.Append("')});");

            ////Register the script
            //Scripts.RegisterStartUpClientScript(Page, script.ToString(), "ExcludeUpdateProgress_" + this.ClientID);

            base.OnPreRender(e);
        }
    }


    /// <summary>
    /// 
    /// </summary>
    public class LinkButtonListViewHeader : System.Web.UI.WebControls.LinkButton
    {

        /// <summary>
        /// Property to store the sort direction when link button is clicked
        /// </summary>
        public int SortDirection
        {
            get
            {
                object viewStateObject = this.ViewState["LinkButtonSortDirection"];
                return (viewStateObject != null) ? (int)viewStateObject : (int)ListViewSortDirection.None;
            }
            set { this.ViewState["LinkButtonSortDirection"] = value; }
        }

        protected override void OnPreRender(EventArgs e)
        {
            //Set the default value of command name to sort
            //As this is what the link button is used for
            this.CausesValidation = false;
            this.CommandName = "Sort";
            base.OnPreRender(e);
        }

    }

    /// <summary>
    /// 
    /// </summary>
    public class LinkButtonMultiViewMenu : System.Web.UI.WebControls.LinkButton
    {
        protected override void OnPreRender(EventArgs e)
        {

            this.CausesValidation = false;
            this.CommandName = @"Select";

            ////Script to exlcude from showing progress
            //StringBuilder script = new StringBuilder();
            //script.Append("$(document).ready(function() { AddExcludeShowProgress('");
            //script.Append(this.ClientID);
            //script.Append("')});");

            ////Register the script
            //Scripts.RegisterStartUpClientScript(Page, script.ToString(), "ExcludeUpdateProgress_" + this.ClientID);

            base.OnPreRender(e);
        }
    }

    #endregion

    #region "Panels"

    /// <summary>
    /// Enable link Button to be default button inside asp.net panel.
    /// </summary>
    public class Panel : System.Web.UI.WebControls.Panel
    {

        public LinkButton DefaultLinkButton { get; set; }

        protected override void OnPreRender(EventArgs e)
        {
            if (this.Visible)
            {
                if (this.DefaultLinkButton != null)
                {
                    Control defButton = DefaultLinkButton;
                    if (defButton.GetType() == typeof(LinkButtonExcludeProgress))
                    {
                        LinkButtonExcludeProgress defLinkButton = (LinkButtonExcludeProgress)defButton;
                        if (defButton != null)
                        {
                            Button defaultButton = new Button();
                            defaultButton.ID = defLinkButton.ID + "_Default";
                            defaultButton.Style.Add("display", "none");
                            PostBackOptions pbOptions = new PostBackOptions(defLinkButton, "", null, false, true, true, true, true, defLinkButton.ValidationGroup);
                            defaultButton.OnClientClick = Page.ClientScript.GetPostBackEventReference(pbOptions) + "; return false;";
                            this.Controls.Add(defaultButton);

                            //Script to exlcude from showing progress
                            StringBuilder script = new StringBuilder();
                            script.Append("$(document).ready(function() { AddExcludeShowProgress('");
                            script.Append(defaultButton.ClientID);
                            script.Append("')});");

                            //Register the script
                            Scripts.RegisterStartUpClientScript(Page, script.ToString(), "ExcludeUpdateProgress_" + defaultButton.ClientID);

                            this.DefaultButton = defaultButton.ID;
                        }

                    }
                }

            }


            base.OnPreRender(e);
        }

    }

    #endregion

    #region "CheckBoxes"

    /// <summary>
    /// 
    /// </summary>
    public class CheckBoxUnlimited : System.Web.UI.WebControls.CheckBox
    {
        public string AssociatedTextBoxControlID { get; set; }

        protected override void OnPreRender(EventArgs e)
        {

            this.Attributes.Add("onclick", "UnlimitedNumeric('CheckBox','" + AssociatedTextBoxControlID + "','" + this.ClientID + "')");
            base.OnPreRender(e);
        }

    }


    /// <summary>
    /// 
    /// </summary>
    public class CheckBoxSelectAll : System.Web.UI.WebControls.CheckBox
    {
        protected override void OnPreRender(EventArgs e)
        {

            //Script to exlcude from showing progress
            //StringBuilder script = new StringBuilder();
            //script.Append("$(document).ready(function() { ListViewCheckBox('");
            //script.Append(this.ClientID);
            //script.Append("')});");

            ////Register the script
            //Scripts.RegisterStartUpClientScript(Page, script.ToString(), "ListViewCheckBox_" + this.ClientID);


            //this.Checked = false;
            base.OnPreRender(e);
        }
    }

    #endregion

    #region "Buttons"

    public class ImageButtonListViewEdit : System.Web.UI.WebControls.ImageButton
    {

        protected override void OnPreRender(EventArgs e)
        {
            this.ImageUrl = "~/App_Images/Command-Edit.gif";
            this.CommandName = "EditDetails";
            this.CausesValidation = false;
            base.OnPreRender(e);
        }

    }

    public class ImageButtonListViewDisplay : System.Web.UI.WebControls.ImageButton
    {
        protected override void OnPreRender(EventArgs e)
        {
            this.ImageUrl = "~/App_Images/Command-Edit.gif";
            this.CommandName = "DisplayDetails";
            this.CausesValidation = false;
            base.OnPreRender(e);
        }
    }

    public class ImageButtonListViewExcel : System.Web.UI.WebControls.ImageButton
    {
        protected override void OnPreRender(EventArgs e)
        {
            this.ImageUrl = "~/App_Images/page_excel.png";
            this.CommandName = "ExportExcel";
            this.CausesValidation = false;
            base.OnPreRender(e);
        }
    }

    public class ImageButtonListViewPDF : System.Web.UI.WebControls.ImageButton
    {
        protected override void OnPreRender(EventArgs e)
        {
            this.ImageUrl = "~/App_Images/page_white_acrobat.png";
            this.CommandName = "ExportPDF";
            this.CausesValidation = false;
            base.OnPreRender(e);
        }
    }

    public class ImageButtonListViewEmail : System.Web.UI.WebControls.ImageButton
    {
        protected override void OnPreRender(EventArgs e)
        {
            this.ImageUrl = "~/App_Images/email.png";
            this.CommandName = "SendEmail";
            this.CausesValidation = false;
            base.OnPreRender(e);
        }
    }

    public class ButtonSearch : System.Web.UI.WebControls.Button
    {
        public string HiddenFieldId { get; set; }

        protected override void OnPreRender(EventArgs e)
        {

            this.Text = Resources.Commands.Search;
            this.Attributes.Add("onclick", "return SearchClick('" + this.HiddenFieldId + "')");
            base.OnPreRender(e);
        }
    }

    #endregion

    #region "GridView"

    public class ExcelGrid : System.Web.UI.WebControls.GridView
    {
        protected override void OnDataBinding(EventArgs e)
        {
            this.Font.Size = System.Web.UI.WebControls.FontUnit.Small;
            this.ForeColor = System.Drawing.ColorTranslator.FromHtml("#333333");
            this.GridLines = GridLines.None;
            this.AlternatingRowStyle.BackColor = System.Drawing.Color.White;
            this.AlternatingRowStyle.ForeColor = System.Drawing.ColorTranslator.FromHtml("#284775");
            this.EditRowStyle.BackColor = System.Drawing.ColorTranslator.FromHtml("#999999");
            this.FooterStyle.BackColor = System.Drawing.ColorTranslator.FromHtml("#5D7B9D");
            this.FooterStyle.Font.Bold = true;
            this.FooterStyle.ForeColor = System.Drawing.Color.White;
            this.HeaderStyle.BackColor = System.Drawing.ColorTranslator.FromHtml("#5D7B9D");
            this.HeaderStyle.Font.Bold = true;
            this.HeaderStyle.ForeColor = System.Drawing.Color.White;
            this.PagerStyle.BackColor = System.Drawing.ColorTranslator.FromHtml("#284775");
            this.PagerStyle.HorizontalAlign = HorizontalAlign.Center;
            this.PagerStyle.ForeColor = System.Drawing.Color.White;
            this.RowStyle.BackColor = System.Drawing.ColorTranslator.FromHtml("#F7F6F3");
            this.RowStyle.ForeColor = System.Drawing.ColorTranslator.FromHtml("#333333");
            this.SelectedRowStyle.BackColor = System.Drawing.ColorTranslator.FromHtml("#E2DED6");
            this.SelectedRowStyle.Font.Bold = true;
            this.SelectedRowStyle.ForeColor = System.Drawing.ColorTranslator.FromHtml("#E2DED6");
            this.SortedAscendingCellStyle.BackColor = System.Drawing.ColorTranslator.FromHtml("#E9E7E2");
            this.SortedAscendingHeaderStyle.BackColor = System.Drawing.ColorTranslator.FromHtml("#506C8C");
            this.SortedDescendingCellStyle.BackColor = System.Drawing.ColorTranslator.FromHtml("#FFFDF8");
            this.SortedDescendingHeaderStyle.BackColor = System.Drawing.ColorTranslator.FromHtml("#6F8DAE");
            base.OnDataBinding(e);
        }
    
    }

    #endregion


}