using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Web;
using APP.Data;
using APP.Session;
using RAD.Common;
using RAD.Data;
using RAD.Diagnostics;
namespace APP.Search
{
    public class SecurityUsers
    {
        /// <summary>
        /// 
        /// </summary>
        /// <returns></returns>
        public static int SelectNumberOfUsersOnline()
        {
            try
            {
                //Initialise Command
                SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = ConnectionManager.CreateProcedure(StoredProcedures.Select_Users_OnlineCount, con);

                //Set Parameters
                DateTime timeWindow = DateTime.Now;
                TimeSpan timeSpanWindow = new TimeSpan(0, 10, 0);
                timeWindow = timeWindow.Subtract(timeSpanWindow);

                Parameters.CreateParameter(cmd, "@userId", SessionHandler.AuthenticationUserId);
                Parameters.CreateParameter(cmd, "@timeWindow", timeWindow, DateFormat.IncludeTime);

                //Execute and return result
                return Convert.ToInt32(ConnectionManager.ExecuteCommandScalarInt32(con, cmd));


            }
            catch (Exception ex)
            {
                StackTrace errorStackTrace = new StackTrace(true);
                Logs.LogError(errorStackTrace, ex);

                return (int)RAD.Common.ResultCode.Failed;
            }
        }


        /// <summary>
        /// 
        /// </summary>
        /// <returns></returns>
        public static DateTime? UpdateUserLastActivity()
        {
            try
            {
                //Initialise Command
                SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = ConnectionManager.CreateProcedure(StoredProcedures.Update_Users_LastActivity, con);

                DateTime? lastActivity = null;
                int? userId = SessionHandler.AuthenticationUserId;
                if (userId != null)
                {
                    //Set Parameters
                    Parameters.CreateParameter(cmd, "@userId", userId);
                    Parameters.CreateParameter(cmd, "@lastActivity", DateTime.Now, DateFormat.IncludeTime);
                    //Execute Command
                    lastActivity = ConnectionManager.ExecuteCommandScalarDateTime(con, cmd);
                }
                return lastActivity;

            }
            catch (Exception ex)
            {
                StackTrace errorStackTrace = new StackTrace(true);
                Logs.LogError(errorStackTrace, ex);
                return null;
            }
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="racfid"></param>
        /// <param name="lastLoggedIn"></param>
        public static void UpdateUserLastLoggedIn(string racfid, DateTime lastLoggedIn)
        {
            try
            {
                //Initialise Command
                SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = ConnectionManager.CreateProcedure(StoredProcedures.Update_Users_LastLoggedIn, con);
                //Set Parameters
                Parameters.CreateParameter(cmd, "@racfid", racfid);
                cmd.Parameters.AddWithValue("@lastLoggedIn", lastLoggedIn);
                //Execute Command
                using (con)
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
                con.Close();
            }
            catch (Exception ex)
            {
                //Log Error
                StackTrace errorStackTrace = new StackTrace(true);
                Logs.LogError(errorStackTrace, ex);
            }
        }


        public static void UpdateUserIsLoggedIn(int? userId, bool isLoggedIn)
        {
            try
            {
                //Initialise Command
                SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = ConnectionManager.CreateProcedure(StoredProcedures.Update_Users_IsLoggedIn, con);
                //Set Parameters
                Parameters.CreateParameter(cmd, "@userId", userId);
                Parameters.CreateParameter(cmd, "@isLoggedIn", isLoggedIn);
                //Execute Command
                using (con)
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
                con.Close();
            }
            catch (Exception ex)
            {
                //Log Error
                StackTrace errorStackTrace = new StackTrace(true);
                Logs.LogError(errorStackTrace, ex);
            }
        }

        /// <summary>
        /// 
        /// </summary>
        /// <returns></returns>
        public static string GetUserRACFID()
        {
            try
            {
                if (HttpContext.Current.User.Identity.IsAuthenticated)
                {
                    //Return RACFID
                    return HttpContext.Current.User.Identity.Name.ToString();
                }
                else
                {
                    //Return Nothing
                    return null;
                }
            }
            catch (Exception ex)
            {
                //Log Error
                StackTrace errorStackTrace = new StackTrace(true);
                Logs.LogError(errorStackTrace, ex);
                return null;
            }
        }

        /// <summary>
        /// 
        /// </summary>
        /// <returns></returns>
        public static int CheckIfUserIsAuthenticated()
        {
            try
            {
                if (HttpContext.Current.User.Identity.IsAuthenticated)
                {
                    //User is authenticated
                    return (int)RAD.Common.ResultCode.Success;
                }
                else
                {
                    //Not authenticated
                    return (int)RAD.Common.ResultCode.NotAuthenticated;
                }
            }
            catch (Exception ex)
            {
                //Log Error
                StackTrace errorStackTrace = new StackTrace(true);
                Logs.LogError(errorStackTrace, ex);
                return (int)RAD.Common.ResultCode.Failed;
            }
        }

        public static List<SecurityUsers> SelectUserDetailsByRacfId(string racfid)
        {
            try
            {
                //Initialise Command
                SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = ConnectionManager.CreateProcedure(StoredProcedures.Authenticate_User, con);
                //Set Parameters
                Parameters.CreateParameter(cmd, "@racfid", racfid);
                //Execute Command
                var results = new List<SecurityUsers>();
                using (con)
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        results.Add(new SecurityUsers(reader));
                    }
                    con.Close();
                    return results;
                }
            }
            catch (Exception ex)
            {
                //Log Error
                StackTrace errorStackTrace = new StackTrace(true);
                Logs.LogError(errorStackTrace, ex);
                return null;
            }
        }


        #region "Fields"

        private int _userId;
        private string _racfId;
        private string _firstname;
        private string _surname;
        private DateTime? _lastLoggedIn;

        #endregion

        #region "Properties"

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


        public string LastLoggedIn
        {
            get { return (_lastLoggedIn != null) ? string.Format("{0:dd/MM/yyyy HH:mm:ss}", _lastLoggedIn) : ""; }
        }


        #endregion

        #region "Constructors"

        public SecurityUsers(SqlDataReader reader)
        {

            if (reader["userId"] != DBNull.Value)
                _userId = Convert.ToInt32(reader["userId"]);
            if (reader["racfId"] != DBNull.Value)
                _racfId = (string)reader["racfId"];
            if (reader["firstname"] != DBNull.Value)
                _firstname = (string)reader["firstname"];
            if (reader["surname"] != DBNull.Value)
                _surname = (string)reader["surname"];
            if (reader["lastLoggedIn"] != DBNull.Value)
                _lastLoggedIn = Convert.ToDateTime(reader["lastLoggedIn"]);

        }

        #endregion
    }
}