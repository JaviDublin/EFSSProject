using System;
using System.Web.UI.WebControls;
using APP.Base;

namespace Insight.App_UserControls.Controls.Commands
{
    public partial class ButtonCommand : UserControlBase
    {
        #region "Properties"

        public bool CausesValidation
        {
            set { this.LinkButtonCommand.CausesValidation = value; }
        }

        public LinkButton CommandLinkButton
        {
            get { return this.LinkButtonCommand; }
        }

        public string ButtonCommandName
        {
            set { this.LinkButtonCommand.CommandName = value; }
        }

        public string ButtonCommandArgument
        {
            set { this.LinkButtonCommand.CommandArgument = value; }
        }

        public string ButtonToolTip
        {
            set { this.LinkButtonCommand.ToolTip = value; }
        }

        public string ButtonImageUrl { get; set; }

        public string ButtonText { get; set; }

        #endregion

        #region "Page Methods"

        protected override void OnPreRender(EventArgs e)
        {
            if (this.Visible)
            {
                this.LinkButtonCommand.ValidationGroup = this.ValidationGroup;
                this.LinkButtonCommand.Text = @"<img src='" + (this.Page.ResolveUrl(ButtonImageUrl)) + "' class='image-CommandButton'>   " + ButtonText;
            }

            base.OnPreRender(e);
        }

        #endregion

        #region "Event Handlers"

        public event CommandEventHandler Command;

        #endregion

        #region "Control Methods"
        protected void LinkButtonCommand_Command(object sender, CommandEventArgs e)
        {
            //Make sure we have something calling the event
            if (Command != null)
            {
                Command(this, e);
            }
        }
        #endregion
    }
}