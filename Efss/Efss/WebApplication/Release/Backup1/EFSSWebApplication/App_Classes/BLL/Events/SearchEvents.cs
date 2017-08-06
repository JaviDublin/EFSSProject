using System;

/// <summary>
/// These events are used for the auto complete search panel on the main application
/// The Primary Key is passed of the search item
/// </summary>
namespace APP.Events
{

    public class SearchEvents : EventArgs
    {

        #region "Properties"

        public string PrimaryPKId { get; set; }

        #endregion

        #region "Constructors"

        public SearchEvents(string primaryPKId)
        {
            PrimaryPKId = primaryPKId;
        }

        #endregion

    }

}
