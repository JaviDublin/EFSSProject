

namespace APP.Paging
{
    #region "Enum Items"

    public enum ListViewSortDirection : int
    {
        Ascending = 1,
        Descending = 2,
        None = 3
    };

    #endregion


    public class ListViewPaging
    {

        #region "Constants"

        public const int DefaultPageSize = 10;
        public const string DefaultSortExpression = null;
        public const int DefaultPageNumber = 1;

        #endregion

        #region "Methods"

        /// <summary>
        /// 
        /// </summary>
        /// <param name="currentPageNumber"></param>
        /// <returns></returns>
        public static int? SetCurrentPageNumber(int? currentPageNumber)
        {
            return ((currentPageNumber == null) ? ListViewPaging.DefaultPageNumber : currentPageNumber);
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="pageSize"></param>
        /// <returns></returns>
        public static int? SetPageSize(int? pageSize)
        {
            return ((pageSize == null) ? ListViewPaging.DefaultPageSize : pageSize);
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="currentPageNumber"></param>
        /// <param name="pageSize"></param>
        /// <returns></returns>
        public static int? SetStartRowIndex(int? currentPageNumber, int? pageSize)
        {
            return (((SetCurrentPageNumber(currentPageNumber) - 1) * SetPageSize(pageSize)) + 1);
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="currentPageNumber"></param>
        /// <param name="pageSize"></param>
        /// <returns></returns>
        public static int? SetMaximumRows(int? currentPageNumber, int? pageSize)
        {
            return ((SetCurrentPageNumber(currentPageNumber) * SetPageSize(pageSize)));
        }




        #endregion

    }

    public class ListViewSorting
    {

        #region "Constants"

        public const string DESC = @" DESC";

        #endregion

    }

}