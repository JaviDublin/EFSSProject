using System;

/// <summary>
/// Summary description for EditEvents
/// </summary>
namespace APP.Events
{

    public class EditEvents : EventArgs
    {

        #region "Properties"

        public string Message { get; set; }

        #endregion

        #region "Constructors"
        public EditEvents()
        {
        }
        public EditEvents(string message)
        {
            Message = message;
        }

        #endregion

    }


}
