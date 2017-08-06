using System;

/// <summary>
/// Summary description for MultiViewEvents
/// </summary>
namespace Insight.Events
{
    public class MultiViewEvents : EventArgs
    {

        #region "Properties"

        public int Index { get; set; }

        #endregion

        #region "Constructors"

        public MultiViewEvents(int index)
        {
            Index = index;
        }

        #endregion

    }

}
