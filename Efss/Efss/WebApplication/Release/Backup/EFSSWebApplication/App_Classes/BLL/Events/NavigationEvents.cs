using System;
using System.Collections.Generic;

/// <summary>
/// These events are used to pass values between controls and control navigation
/// ControlPKId - the primary key of the control we want to navigate to
/// PrimaryPKId - the primary key of the data item we want to pass
/// Parameters - Optional list of parameters that can be passed to each control
/// </summary>
namespace APP.Events
{
    public class NavigationEvents : EventArgs
    {

        #region "Properties"

        public string ControlPKId { get; set; }
        public string PrimaryPKId { get; set; }
        public List<string> Parameters { get; set; }
        public bool IsRefreshed { get; set; }

        #endregion

        #region "Constructors"

        public NavigationEvents(string controlPKId, string primaryPKId, List<string> paramerters, bool isRefreshed)
        {
            ControlPKId = controlPKId;
            PrimaryPKId = primaryPKId;
            Parameters = paramerters;
            IsRefreshed = isRefreshed;
        }

        #endregion

    }

}
