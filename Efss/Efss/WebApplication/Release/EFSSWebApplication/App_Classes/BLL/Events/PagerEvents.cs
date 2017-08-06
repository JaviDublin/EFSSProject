using System;

/// <summary>
/// Summary description for PagerEvents
/// </summary>
namespace APP.Events
{
    public class PagerEvents : EventArgs
    {

        #region "Properties"

        public int CurrentPageNumber { get; set; }
        public int PageSize { get; set; }
        public bool IsRefreshed { get; set; }

        #endregion

        #region "Constructors"

        public PagerEvents(int currentPageNumber, int pageSize, bool isRefreshed)
        {
            CurrentPageNumber = currentPageNumber;
            PageSize = pageSize;
            IsRefreshed = isRefreshed;
        }

        #endregion

    }

}
