using System;
using System.Collections.Generic;
using APP.Events;
using RAD.Common;
//using Insight.Utilities;
/// <summary>
/// Summary description for UserControlBase
/// </summary>
namespace APP.Base
{

    public class UserControlBase : System.Web.UI.UserControl
    {

        #region "Properties"

        public bool IsRefreshed { get; set; }

        public string ApplicationControlID
        {
            get
            {
                object viewStateObject = this.ViewState["UserControlApplicationControlID"];
                return (viewStateObject != null) ? viewStateObject.ToString() : null;
            }
            set { this.ViewState["UserControlApplicationControlID"] = value; }
        }

        public string PrimaryPKID
        {
            get
            {
                object viewStateObject = this.ViewState["UserControlPrimaryPKID"];
                return (viewStateObject != null) ? viewStateObject.ToString() : null;
            }
            set { this.ViewState["UserControlPrimaryPKID"] = value; }
        }

        public string AccountId
        {
            get
            {
                object viewStateObject = this.ViewState["UserControlAccountId"];
                return (viewStateObject != null) ? viewStateObject.ToString() : null;
            }
            set { this.ViewState["UserControlAccountId"] = value; }
        }

        public string ReportingParentNumber
        {
            get
            {
                object viewStateObject = this.ViewState["UserControlReportingParentNumber"];
                return (viewStateObject != null) ? viewStateObject.ToString() : null;
            }
            set { this.ViewState["UserControlReportingParentNumber"] = value; }
        }

        public List<string> Parameters
        {
            get
            {
                object viewStateObject = this.ViewState["UserControlParameters"];
                return (viewStateObject != null) ? (List<string>)viewStateObject : null;
            }
            set { this.ViewState["UserControlParameters"] = value; }
        }

        public bool? IsActive
        {
            get
            {
                object viewStateObject = this.ViewState["UserControlIsActive"];
                return (viewStateObject != null) ? (bool?)viewStateObject : null;
            }
            set { this.ViewState["UserControlIsActive"] = value; }
        }

        public string ISOCode
        {
            get
            {
                object viewStateObject = this.ViewState["UserControlISOCode"];
                return (viewStateObject != null) ? viewStateObject.ToString() : null;
            }
            set { this.ViewState["UserControlISOCode"] = value; }
        }

        public int? PPDecimalUsage
        {
            get
            {
                object viewStateObject = this.ViewState["UserControlDecimalUsage"];
                return (viewStateObject != null) ? Convert.ToInt32(viewStateObject) : (int?)null;
            }
            set { this.ViewState["UserControlDecimalUsage"] = value; }
        }

        public string CountryStatus
        {
            get
            {
                object viewStateObject = this.ViewState["UserControlCountryStatus"];
                return (viewStateObject != null) ? viewStateObject.ToString() : null;
            }
            set { this.ViewState["UserControlCountryStatus"] = value; }
        }

        public string StartUpScript { get; set; }

        public string TargetControlId
        {
            get
            {
                object viewStateObject = this.ViewState["TargetControlId"];
                return (viewStateObject != null) ? viewStateObject.ToString() : null;
            }
            set { this.ViewState["TargetControlId"] = value; }
        }

        public string ApplicationLogoUrl
        {
            get
            {
                object viewStateObject = this.ViewState["ApplicationLogoUrl"];
                return (viewStateObject != null) ? viewStateObject.ToString() : null;
            }
            set { this.ViewState["ApplicationLogoUrl"] = value; }
        }

        #endregion

        #region "Validation Properties"

        private string _errorImageUrl = @"App_Images/error.png";

        public string ValidationGroup { get; set; }
        public string ErrorImageUrl
        {
            get { return _errorImageUrl; }
            set { _errorImageUrl = value; }
        }
        public string ValidationText
        {
            get { return (@"<img src='" + _errorImageUrl + "' border='0'>"); }

        }

        #endregion

        #region "Help"

        private string _helpImageUrl = @"App_Images/help.gif";

        public string HelpText
        {
            get { return (@"<img src='" + _helpImageUrl + "' border='0'>"); }
        }

        #endregion

        #region "Events"

        /// <summary>
        /// This event is used to pass values when navigating between controls
        /// </summary>
        public delegate void NavigationHandler(object sender, NavigationEvents e);
        public event NavigationHandler ChangeControl;

        protected void OnControlChanged(NavigationEvents e)
        {
            if (this.ChangeControl != null)
            {
                this.ChangeControl(this, e);
            }
        }

        /// <summary>
        /// This event is used to when user is searching the autocomplete controls
        /// </summary>
        public delegate void SearchEventHandler(object sender, SearchEvents e);
        public event SearchEventHandler SearchClick;

        protected void OnSearchClick(SearchEvents e)
        {
            if (this.SearchClick != null)
            {
                this.SearchClick(this, e);
            }
        }


        /// <summary>
        /// This event is used to pass the result messageback from an update / delete statement
        /// </summary>
        public delegate void UpdateEventHandler(object sender, EditEvents e);
        public event UpdateEventHandler UpdateClick;

        protected void OnUpdateClick(EditEvents e)
        {
            if (this.UpdateClick != null)
            {
                this.UpdateClick(this, e);
            }
        }


        #endregion

        #region "Methods"

        protected override void OnInit(EventArgs e)
        {

            base.OnInit(e);
            if (this.ID.ToLower().Contains(StringFunction.GetDelimiter(Delimiter.UnderScore)))
            {
                this.ApplicationControlID = StringFunction.SplitString(this.ID, Delimiter.UnderScore, false);
            }

        }

        protected override void OnPreRender(EventArgs e)
        {


            base.OnPreRender(e);
        }
        
        #endregion

    }

}
