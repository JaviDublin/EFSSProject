using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Diagnostics;
using APP.Data;
using APP.Session;
using RAD.Data;
using RAD.Diagnostics;
namespace APP.Search
{
    public class SecurityUserPermissions
    {

        public static List<SecurityUserPermissions> SelectUserPermissions()
        {
            try
            {
                //Initialise Connection
                SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = ConnectionManager.CreateProcedure(StoredProcedures.Select_Users_Permissions, con);

                //Set Parameters
                Parameters.CreateParameter(cmd, "@userId", SessionHandler.AuthenticationUserId);

                //Execute Command
                var results = new List<SecurityUserPermissions>();

                using (con)
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        results.Add(new SecurityUserPermissions(reader));
                    }
                }

                //Close connection
                con.Close();

                //Sort Results
                GenericLists.SortList<SecurityUserPermissions, int>(results, x => x.ControlId);

                //Return results
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
        private int _controlId;
        private int _permissionId;

        #endregion

        #region "Properties"

        public int ControlId
        {
            get { return _controlId; }
        }

        public int PermissionId
        {
            get { return _permissionId; }
        }

        #endregion

        #region "Constructors"

        public SecurityUserPermissions(SqlDataReader reader)
        {
            if (reader["controlId"] != DBNull.Value)
                _controlId = Convert.ToInt32(reader["controlId"]);
            if (reader["permissionId"] != DBNull.Value)
                _permissionId = Convert.ToInt32(reader["permissionId"]);
        }

        #endregion
    }
}