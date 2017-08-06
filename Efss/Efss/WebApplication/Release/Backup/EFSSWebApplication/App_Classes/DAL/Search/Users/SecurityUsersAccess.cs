using System;
using System.Collections;
using System.Data.SqlClient;
using System.Diagnostics;
using APP.Data;
using RAD.Data;
using RAD.Diagnostics;
namespace APP.Search
{
    public class SecurityUsersAccess
    {
        public static int SelectUserAccess(string racfid, string controlname)
        {
            try
            {
                //Initialise Connection
                SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = ConnectionManager.CreateProcedure(StoredProcedures.Select_Users_Permissions, con);

                //Set Parameters
                Parameters.CreateParameter(cmd, "@racfid", racfid);
                Parameters.CreateParameter(cmd, "@controlName", controlname);

                //Execute Command
                int result = 0;
                using (con)
                {
                    con.Open();
                    result = Convert.ToInt32(cmd.ExecuteScalar());
                }
                con.Close();

                return result;

            }
            catch (Exception ex)
            {
                StackTrace errorStackTrace = new StackTrace(true);
                Logs.LogError(errorStackTrace, ex);
                return 0;
            }
        }

        public static string SelectUserRole(string racfid)
        {
            try
            {
                SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = ConnectionManager.CreateProcedure(StoredProcedures.GetUserRole, con);
                Parameters.CreateParameter(cmd, "@racfid", racfid);
                string result;
                using (con)
                {
                    con.Open();
                    result = cmd.ExecuteScalar().ToString();
                }
                con.Close();

                return result;

            }
            catch (Exception ex)
            {
                StackTrace errorStackTrace = new StackTrace(true);
                Logs.LogError(errorStackTrace, ex);
                return "USER";
            }
        
        }

        public static bool UserExist(string racfid)
        {
            int result;
            ArrayList parameters = new ArrayList();
            ArrayList values = new ArrayList();
            parameters.Add("@racfId");
            values.Add(racfid);
            DBAgent checkDup = new DBAgent(StoredProcedures.UsersCheck, parameters, values);
            result = checkDup.ExecuteQueryWithReturnId();

            // 0 =  No Duplicates
            if (result == 0)
            {
                return false;
            }
            else
            {
                return true;
            }
        
        }
    }
}