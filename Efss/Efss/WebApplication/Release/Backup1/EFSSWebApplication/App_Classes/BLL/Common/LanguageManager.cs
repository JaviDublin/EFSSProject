using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Threading;

namespace APP.Common
{
    public class LanguageManager
    {
        #region "Fields"

        public static readonly CultureInfo ApplicationDefaultCulture = new CultureInfo("en-GB");

        public static readonly CultureInfo[] AvailableCultures;

        #endregion

        #region "Properties"

        public static CultureInfo ApplicationCurrentCulture
        {
            get
            {
                return Thread.CurrentThread.CurrentCulture;
            }
            set
            {

                Thread.CurrentThread.CurrentCulture = value;
                Thread.CurrentThread.CurrentUICulture = value;
            }

        }

        #endregion

        #region "Constructors"

        static LanguageManager()
        {

            //Declare a generic list of string to hold the available resources
            List<string> availableResourceFiles = new List<string>();

            //Get the file path to the resources and directory information
            string resourceFilePath = Path.Combine(System.Web.HttpRuntime.AppDomainAppPath, "App_GlobalResources");
            DirectoryInfo dirInfo = new DirectoryInfo(resourceFilePath);


            //Loop through each file and get the files we need
            foreach (FileInfo fi in dirInfo.GetFiles("*.*.resx", SearchOption.AllDirectories))
            {
                //Take the cultureName from resx filename eg: en-GB or en-IE
                //Remove .resx from filename
                string cultureName = Path.GetFileNameWithoutExtension(fi.Name);
                if (cultureName.LastIndexOf(".") == cultureName.Length - 1)
                    continue; //doesnt accept format FileName..resx

                //Add the available resource file name to or generic list
                cultureName = cultureName.Substring(cultureName.LastIndexOf(".") + 1);
                availableResourceFiles.Add(cultureName);
            }


            //Delcare a new list of culture info
            List<CultureInfo> result = new List<CultureInfo>();

            //See what available cultures the user has
            foreach (CultureInfo culture in CultureInfo.GetCultures(CultureTypes.SpecificCultures))
            {
                //If we have a file to match their culture add it to our list of cultures
                if (availableResourceFiles.Contains(culture.ToString()))
                {
                    result.Add(culture);
                }
            }

            //Add results to available cultures
            AvailableCultures = result.ToArray();

            ApplicationCurrentCulture = ApplicationDefaultCulture;

            // If default culture is not available, take another available one to use
            if (!result.Contains(ApplicationDefaultCulture) && result.Count > 0)
            {
                ApplicationCurrentCulture = result[0];
            }

        }

        #endregion

    }
}