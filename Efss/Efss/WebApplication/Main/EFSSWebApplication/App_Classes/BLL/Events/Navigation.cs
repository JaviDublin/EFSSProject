using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;

namespace APP.Search
{
    public enum MenuType : int
    {
        MenuA = 1,
        MenuB,
        MenuC,
        MenuD,
        MenuE,
        MenuF,
        MenuG,
        MenuH,
        MenuI,
        MenuJ,
        MenuK,
        MenuL
    };

    public class Navigation
    {
        public int Index { get; set; }

        public Navigation(int index)
        {
            Index = index;
        }

    }

    public class NavigationMenu : IComparable<NavigationMenu>
    {
        public static List<NavigationMenu> SelectMenuItem(int selectedMenu, Page selectedPage)
        {
            var results = new List<NavigationMenu>();
            
            switch (selectedMenu)
            {
                case (int)MenuType.MenuA:
                    results.Add(new NavigationMenu(0, "Reg Tax Amount", "Click to View Reg Tax Amount", selectedPage.ResolveUrl("~/App_Images/control-home.gif")));
                    results.Add(new NavigationMenu(1, "Tax Prices", "Click to View tax Price Information", selectedPage.ResolveUrl("~/App_Images/control-termsconditions.gif")));
                    results.Add(new NavigationMenu(2, "File Upload", "Click to Upload File", selectedPage.ResolveUrl("~/App_Images/control-termsconditions.gif")));
                    break;
                case (int)MenuType.MenuB:
                    results.Add(new NavigationMenu(0, "Sales By Country", "Click to View Sales By Country", selectedPage.ResolveUrl("~/App_Images/chart_pie.png")));
                    results.Add(new NavigationMenu(1, "Sales By Region", "Click to View Sales By Region", selectedPage.ResolveUrl("~/App_Images/chart_pie.png")));
                    results.Add(new NavigationMenu(2, "Fleet By Country", "Click to View Fleet By Country", selectedPage.ResolveUrl("~/App_Images/chart_pie.png")));
                    results.Add(new NavigationMenu(3, "Fleet By Region", "Click to View Fleet By Region", selectedPage.ResolveUrl("~/App_Images/chart_pie.png")));
                    results.Add(new NavigationMenu(4, "Month Adds/Dels", "Click to View Month Adds/Dels", selectedPage.ResolveUrl("~/App_Images/chart_pie.png")));
                    results.Add(new NavigationMenu(5, "Year Adds/Dels", "Click to View Year Adds/Dels", selectedPage.ResolveUrl("~/App_Images/chart_pie.png")));
                    break;
                case (int)MenuType.MenuC:
                    results.Add(new NavigationMenu(0, "Edit Area", "Click to View Active Fleet", selectedPage.ResolveUrl("~/App_Images/Command-Edit.gif")));
                    results.Add(new NavigationMenu(1, "Insert Area", "Click to View Vehicles Added", selectedPage.ResolveUrl("~/App_Images/Command-Insert.png")));
                    
                    break;
                case (int)MenuType.MenuD:
                    results.Add(new NavigationMenu(0, "Edit Currencies", "Click to View Currencies", selectedPage.ResolveUrl("~/App_Images/Command-Edit.gif")));
                    results.Add(new NavigationMenu(1, "Edit Documents", "Click to View Documents", selectedPage.ResolveUrl("~/App_Images/Command-Edit.gif")));
                    results.Add(new NavigationMenu(2, "Insert Documents", "Click to Create Documents", selectedPage.ResolveUrl("~/App_Images/Command-Insert.png")));
                    
                    break;
                case (int)MenuType.MenuE:
                    results.Add(new NavigationMenu(0, "Countries", "Click to View Countries", selectedPage.ResolveUrl("~/App_Images/world.png")));
                    results.Add(new NavigationMenu(1, "Manufacturers", "Click to View Mnaufacturers", selectedPage.ResolveUrl("~/App_Images/wrench.png")));
                    break;
                case (int)MenuType.MenuF:
                    results.Add(new NavigationMenu(0, "Countries", "Click to View Invoices by country", selectedPage.ResolveUrl("~/App_Images/world.png")));
                    results.Add(new NavigationMenu(1, "Buyers", "Click to View Invoices by Buyer", selectedPage.ResolveUrl("~/App_Images/user_suit.png")));
                    results.Add(new NavigationMenu(2, "Invoices", "Click to View Invoices", selectedPage.ResolveUrl("~/App_Images/control-termsconditions.gif")));
                    break;
                case (int)MenuType.MenuG:
                    results.Add(new NavigationMenu(0, "User Details", "Click to View Vehicle Details", selectedPage.ResolveUrl("~/App_Images/user_edit.png")));
                    results.Add(new NavigationMenu(1, "User Access", "Click to View Service Details", selectedPage.ResolveUrl("~/App_Images/key.png")));
                    break;

                case (int)MenuType.MenuH:
                    results.Add(new NavigationMenu(0, "Buyers List", "Click to View Buyers List", selectedPage.ResolveUrl("~/App_Images/tab-details.gif")));
                    results.Add(new NavigationMenu(1, "Buyers Details", "Click to View Buyers Details", selectedPage.ResolveUrl("~/App_Images/information.png")));
                    break;

                case (int)MenuType.MenuI:
                    results.Add(new NavigationMenu(0, "Manufacturers List", "Click to View Manufacturers List", selectedPage.ResolveUrl("~/App_Images/tab-details.gif")));
                    results.Add(new NavigationMenu(1, "Models List", "Click to View Models List", selectedPage.ResolveUrl("~/App_Images/information.png")));
                    break;

                case (int)MenuType.MenuJ:
                    results.Add(new NavigationMenu(0, "Companies List", "Click to View Companies List", selectedPage.ResolveUrl("~/App_Images/tab-details.gif")));
                    results.Add(new NavigationMenu(1, "Companies Details", "Click to View Companies Details", selectedPage.ResolveUrl("~/App_Images/information.png")));
                    break;

                case (int)MenuType.MenuK:
                    results.Add(new NavigationMenu(0, "Users List", "Click to View Users List", selectedPage.ResolveUrl("~/App_Images/tab-details.gif")));
                    results.Add(new NavigationMenu(1, "Users Details", "Click to View Users Details", selectedPage.ResolveUrl("~/App_Images/information.png")));
                    break;
                case (int)MenuType.MenuL:
                    results.Add(new NavigationMenu(0, "Files", "Click to View Invoices by country", selectedPage.ResolveUrl("~/App_Images/chart_pie.png")));
                    results.Add(new NavigationMenu(1, "Countries", "Click to View Invoices by country", selectedPage.ResolveUrl("~/App_Images/world.png")));
                    results.Add(new NavigationMenu(2, "Invoices", "Click to View Invoices", selectedPage.ResolveUrl("~/App_Images/control-termsconditions.gif")));
                    break;
            
            }

            GenericLists.SortList<NavigationMenu, int>(results, x => x.Index);
            return results;
        
        }


        int IComparable<NavigationMenu>.CompareTo(NavigationMenu compare)
        {
            if (compare.Index > this.Index)
                return -1;
            else if (compare.Index == this.Index)
                return 0;
            else
                return 1;
        }

        public static int GetMinimumIndex(List<NavigationMenu> navigationmenu)
        {

            NavigationMenu result = navigationmenu.Min();
            return result.Index;

        }

        public int Index { get; set; }
        public string Title { get; set; }
        public string ToolTip { get; set; }

        public NavigationMenu(int index, string title, string toolTip, string imageUrl)
        {
            Index = index;
            if (imageUrl != null)
            {
                Title = @"<img src='" + imageUrl + "' class='image-SideMenu'> " + title;
            }
            else
            {
                Title = title;
            }

            ToolTip = toolTip;
        }

    }

    public static class GenericLists
    {
        public static void SortList<TSource, TValue>(this List<TSource> source, Func<TSource, TValue> selector)
        {
            var comparer = Comparer<TValue>.Default;
            source.Sort((x, y) => comparer.Compare(selector(x), selector(y)));
        }

        public static void SortListDescending<TSource, TValue>(this List<TSource> source, Func<TSource, TValue> selector)
        {
            var comparer = Comparer<TValue>.Default;
            source.Sort((x, y) => comparer.Compare(selector(y), selector(x)));
        }

    }


}