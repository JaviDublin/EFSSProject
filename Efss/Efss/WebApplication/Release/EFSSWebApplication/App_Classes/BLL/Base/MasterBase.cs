using System;
using System.Text.RegularExpressions;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using RAD.Common;

namespace APP.BLL
{
    public class MasterBase : System.Web.UI.MasterPage
    {

        #region"Page Methods"

        protected override void OnInit(EventArgs e)
        {
            //Set Application Title
            this.Page.Title = APP.Properties.Settings.Default.ApplicationName;

            //Add Meta Information to Head Section
            HtmlMeta compatibleMeta = new HtmlMeta();
            compatibleMeta.Attributes.Add("http-equiv", "X-UA-Compatible");
            compatibleMeta.Attributes.Add("content", "IE=EmulateIE7");

            HtmlMeta contentMeta = new HtmlMeta();
            contentMeta.Attributes.Add("http-equiv", "Content-type");
            contentMeta.Attributes.Add("content", "text/html;charset=UTF-8");


            this.Page.Header.Controls.Add(compatibleMeta);
            this.Page.Header.Controls.Add(contentMeta);


            //Add Favicon to Head Section
            HtmlLink faviconLink = new HtmlLink();
            faviconLink.Attributes.Add("rel", "shortcut icon");
            faviconLink.Attributes.Add("href", "~/app_images/favicon.ico");
            faviconLink.Attributes.Add("type", "image/x-icon");

            HtmlLink faviconType = new HtmlLink();
            faviconType.Attributes.Add("rel", "icon");
            faviconType.Attributes.Add("href", "~/app_images/favicon.ico");
            faviconType.Attributes.Add("type", "image/x-icon");

            this.Page.Header.Controls.Add(faviconLink);
            this.Page.Header.Controls.Add(faviconType);


            base.OnInit(e);
        }


        //Regex values to strip white space
        private static readonly Regex RegexBetweenTags = new Regex(@">(?! )\s+", RegexOptions.Compiled);
        private static readonly Regex RegexLineBreaks = new Regex(@"([\n\s])+?(?<= {2,})<", RegexOptions.Compiled);

        protected override void Render(System.Web.UI.HtmlTextWriter writer)
        {

            //Removes all white space from html output
            using (HtmlTextWriter htmlwriter = new HtmlTextWriter(new System.IO.StringWriter()))
            {

                base.Render(htmlwriter);
                string html = htmlwriter.InnerWriter.ToString();

                //Match results with Regex values
                html = RegexBetweenTags.Replace(html, ">");
                html = RegexLineBreaks.Replace(html, "<");

                //Output the Html
                writer.Write(html);

            }

        }

        #endregion

        #region Methods

        protected void AddStyleSheet(string styleSheet, string key, bool useMinified)
        {
            string styleSheetUrl = @"~/App_Styles/";
            HtmlLink siteStyleSheet = new HtmlLink();

#if DEBUG
            styleSheetUrl += styleSheet;
#else

            if (useMinified)
            {
                styleSheet = styleSheet.Substring(0, styleSheet.Length - 4);
                styleSheet += @".min.css";
            }

            styleSheetUrl += styleSheet;


#endif
            if (!Page.ClientScript.IsClientScriptBlockRegistered(key))
            {

                styleSheetUrl = Page.ResolveUrl(styleSheetUrl);
                siteStyleSheet.Attributes.Add("href", styleSheetUrl);
                siteStyleSheet.Attributes.Add("rel", "stylesheet");
                siteStyleSheet.Attributes.Add("type", "text/css");

                this.Page.Header.Controls.Add(siteStyleSheet);
                this.Page.ClientScript.RegisterClientScriptBlock(typeof(System.Web.UI.Page), key, "");
            }
        }

        protected void IncludeScripts(string script, string key, bool useMinified)
        {
            string scriptUrl = @"~/App_Scripts/";

#if DEBUG
            scriptUrl += script;

#else
            if (useMinified)
            {
                script = script.Substring(0, script.Length - 3);
                script += @".min.js";
            }

            scriptUrl += script;
#endif

            scriptUrl = Page.ResolveUrl(scriptUrl);
            Scripts.RegisterIncludeClientScriptPage(this.Page, key, scriptUrl);
        }

        #endregion

    }
}