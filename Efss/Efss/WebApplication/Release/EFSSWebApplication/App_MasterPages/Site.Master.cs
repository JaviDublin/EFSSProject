using System;
using APP.BLL;

namespace APP.App_MasterPages
{
    public partial class Site : MasterBase
    {

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            base.AddStyleSheet("Site.css", "Site", false);
        }

    }
}