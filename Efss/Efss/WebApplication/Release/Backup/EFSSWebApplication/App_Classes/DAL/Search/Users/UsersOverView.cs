using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Diagnostics;
using APP.Data;
using APP.Paging;
using RAD.Common;
using RAD.Data;
using RAD.Diagnostics;
namespace APP.Search
{
    public class UsersOverView
    {

        public static List<UsersOverView> SelectUsersOverview(int? currentPageNumber, int? pageSize, string sortExpression, string racfid)
        {
            try
            {
                //Initialise Command
                SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = ConnectionManager.CreateProcedure(StoredProcedures.Select_Users_Overview, con);

                //Check for null values 
                //If so set default values for paging
                currentPageNumber = (currentPageNumber == null) ? ListViewPaging.DefaultPageNumber : currentPageNumber;
                pageSize = (pageSize == null) ? ListViewPaging.DefaultPageSize : pageSize;

                //Set Parameters
                Parameters.CreateParameter(cmd, "@sortExpression", sortExpression);
                int? startRowIndex = ListViewPaging.SetStartRowIndex(currentPageNumber, pageSize);
                int? maximumRows = ListViewPaging.SetMaximumRows(currentPageNumber, pageSize);
                Parameters.CreateParameter(cmd, "@maximumRows", maximumRows);
                Parameters.CreateParameter(cmd, "@startRowIndex", startRowIndex);
                Parameters.CreateParameter(cmd, "@racfId", racfid);

                //Execute Command
                var results = new List<UsersOverView>();
                using (con)
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        results.Add(new UsersOverView(reader));
                    }
                }

                con.Close();
                return results;

            }
            catch (Exception ex)
            {
                StackTrace errorStackTrace = new StackTrace(true);
                Logs.LogError(errorStackTrace, ex);
                return null;
            }
        }


        #region "Fields"

        private int _count;
        private int _userId;
        private string _racfId;
        private string _firstname;
        private string _surname;
        private string _email;
        private bool _approved;
        private bool _lockedOut;
        private DateTime? _lastLoggedIn;
        private DateTime? _lastActivity;
        private bool _isDeleted;

        #endregion

        #region "Properties"

        public int Count
        {
            get { return _count; }
        }

        public int UserId
        {
            get { return _userId; }
        }

        public string RacfId
        {
            get { return _racfId; }
        }

        public string Firstname
        {
            get { return _firstname; }
        }
        public string Surname
        {
            get { return _surname; }
        }
        public string Email
        {
            get { return _email; }
        }
        public bool Approved
        {
            get { return _approved; }
        }
        public string ApprovedImageUrl
        {
            get { return (_approved == true) ? "~/App_Images/yes.gif" : "~/App_Images/no.gif"; }
        }
        public bool LockedOut
        {
            get { return _lockedOut; }
        }
        public string LockedOutImageUrl
        {
            get { return (_lockedOut == true) ? "~/App_Images/yes.gif" : "~/App_Images/no.gif"; }
        }
        public string LastLoggedIn
        {
            get { return (_lastLoggedIn != null) ? string.Format("{0:dd/MM/yyyy HH:mm:ss}", _lastLoggedIn) : ""; }
        }
        public string LastActivity
        {
            get { return (_lastActivity != null) ? string.Format("{0:dd/MM/yyyy HH:mm:ss}", _lastActivity) : ""; }
        }
        public bool IsDeleted
        {
            get { return _isDeleted; }
        }

        public string IsDeletedImageUrl
        {
            get { return (_isDeleted == true) ? "~/App_Images/yes.gif" : "~/App_Images/no.gif"; }
        }

        #endregion

        #region "Constructors"

        public UsersOverView(SqlDataReader reader)
        {
            if (reader["count"] != DBNull.Value)
                _count = Convert.ToInt32(reader["count"]);
            if (reader["userId"] != DBNull.Value)
                _userId = Convert.ToInt32(reader["userId"]);
            if (reader["racfId"] != DBNull.Value)
                _racfId = (string)reader["racfId"];
            if (reader["firstname"] != DBNull.Value)
                _firstname = (string)reader["firstname"];
            if (reader["surname"] != DBNull.Value)
                _surname = (string)reader["surname"];
            if (reader["email"] != DBNull.Value)
                _email = (string)reader["email"];
            if (reader["approved"] != DBNull.Value)
                _approved = Convert.ToBoolean(reader["approved"]);
            if (reader["lockedOut"] != DBNull.Value)
                _lockedOut = Convert.ToBoolean(reader["lockedOut"]);
            if (reader["lastLoggedIn"] != DBNull.Value)
                _lastLoggedIn = Convert.ToDateTime(reader["lastLoggedIn"]);
            if (reader["lastActivity"] != DBNull.Value)
                _lastActivity = Convert.ToDateTime(reader["lastActivity"]);
            if (reader["isdeleted"] != DBNull.Value)
                _isDeleted = Convert.ToBoolean(reader["isdeleted"]);
        }

        #endregion

    }
}