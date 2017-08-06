using System;
using System.Web.UI.WebControls;

namespace APP.Common
{
    public class ListItems
    {
        #region "Constants"

        public static string SelectAll = Resources.ListItems.SelectAll;
        public static string PleaseSelect = Resources.ListItems.PleaseSelect;
        public static string InitialValue1 = @"-1";
        public static string ShowAll = Resources.ListItems.ShowAll;
        public static string NoneSelected = Resources.ListItems.NoneSelected;
        public static string Optional = Resources.ListItems.Optional;
        public static string Exclusive = Resources.ListItems.Exclusive;
        public static string ExclusiveValue = @"0";

        #endregion

        #region "Methods"
        public static void RenameFirstItem(DropDownList dropDownListCtrl, bool isSelectAll)
        {
            if (isSelectAll)
            {
                dropDownListCtrl.Items[0].Text = SelectAll;
            }
            else
            {
                dropDownListCtrl.Items[0].Text = PleaseSelect;
            }

        }


        public static void RemoveSelectAll(DropDownList dropDownListCtrl)
        {
            dropDownListCtrl.Items.RemoveAt(0);
        }

        /// <summary> 
        /// Add a default "Select All" item to Dropdownlist
        /// </summary>
        /// <param name="dropDownListctrl">DropDownList</param>
        /// <param name="isSelected">Bool - Selected / Not Selected</param>
        public static void AddSelectAll(DropDownList dropDownListCtrl, bool isSelected)
        {
            ListItem item = new ListItem();
            item.Value = InitialValue1;
            item.Text = SelectAll;
            dropDownListCtrl.Items.Insert(0, item);
            item.Selected = isSelected;
        }

        /// <summary>
        /// Add a new item to Dropdownlist and set position
        /// </summary>
        /// <param name="dropDownListCtrl">DropDownList</param>
        /// <param name="itemText">string - Item Text</param>
        /// <param name="itemValue">string - Item Value</param>
        /// <param name="itemPosition">int? - position</param>
        /// <param name="isSelected">bool - Selected /Not Selected</param>
        public static void AddListItem(DropDownList dropDownListCtrl, string itemText, string itemValue, int? itemPosition, bool isSelected)
        {
            ListItem item = new ListItem();
            item.Value = itemValue;
            item.Text = itemText;
            int position = (itemPosition == null) ? 0 : (Convert.ToInt32(itemPosition));
            dropDownListCtrl.Items.Insert(position, item);
            item.Selected = isSelected;
        }

        /// <summary>
        /// Add a new item to ListBox and set position
        /// </summary>
        /// <param name="listBoxCtrl">ListBox</param>
        /// <param name="itemText">string - Item Text</param>
        /// <param name="itemValue">string - Item Value</param>
        /// <param name="itemPosition">int? - position</param>
        /// <param name="isSelected">bool - Selected /Not Selected</param>
        public static void AddListItem(ListBox listBoxCtrl, string itemText, string itemValue, int? itemPosition, bool isSelected)
        {
            ListItem item = new ListItem();
            item.Value = itemValue;
            item.Text = itemText;
            int position = (itemPosition == null) ? 0 : (Convert.ToInt32(itemPosition));
            listBoxCtrl.Items.Insert(position, item);
            item.Selected = isSelected;
        }


        #endregion
    }
}