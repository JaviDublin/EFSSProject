using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Diagnostics;
using APP.Data;
using RAD.Data;
using RAD.Diagnostics;

namespace APP.Search
{
    public class SearchUsers
    {

        public static List<SearchUsers> SelectUsers(string racfId)
        {
            try
            {
                //Initialise Command
                SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = ConnectionManager.CreateProcedure(StoredProcedures.Select_User_Details, con);
                Parameters.CreateParameter(cmd, "@racfId", racfId);
                var results = new List<SearchUsers>();

                using (con)
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        results.Add(new SearchUsers(reader));
                    }
                }

                return results;
            }
            catch (Exception ex)
            {
                StackTrace errorStackTrace = new StackTrace(true);
                Logs.LogError(errorStackTrace, ex);
                return null;
            }

        }

        public static List<SearchUsers> SelectUsersByUserId(int userId)
        {
            try
            {
                //Initialise Command
                SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = ConnectionManager.CreateProcedure(StoredProcedures.UsersSelectByUserId, con);
                Parameters.CreateParameter(cmd, "@userId", userId);
                var results = new List<SearchUsers>();

                using (con)
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        results.Add(new SearchUsers(reader));
                    }
                }

                return results;
            }
            catch (Exception ex)
            {
                StackTrace errorStackTrace = new StackTrace(true);
                Logs.LogError(errorStackTrace, ex);
                return null;
            }

        }
        

        #region "Variables"

        private int _userid;
        private string _racfid;
        private string _name;
        private string _surname;
        private string _email;
        private string _phone;
        private int _roleid;

        #endregion

        #region "Properties"

        public int Userid
        {
            get { return _userid; }
        }

        public string RacfId
        {
            get { return _racfid; }
        }

        public string Name
        {
            get { return _name; }
        }

        public string Surname
        {
            get { return _surname; }
        }

        public string Email
        {
            get { return _email; }
        }

        public string Phone
        {
            get { return _phone; }
        }

        public int RoleId
        {
            get { return _roleid; }
        }

        #endregion

        #region "Constructor"

        public SearchUsers(SqlDataReader reader)
        {
            if (reader["PKID"] != DBNull.Value)
                _userid = Convert.ToInt32(reader["PKID"]);
            if (reader["RacfId"] != DBNull.Value)
                _racfid = (string)reader["RacfId"];
            if (reader["FirstName"] != DBNull.Value)
                _name = (string)reader["FirstName"];
            if (reader["SurName"] != DBNull.Value)
                _surname = (string)reader["SurName"];
            if (reader["Phone"] != DBNull.Value)
                _phone = (string)reader["Phone"];
            if (reader["Email"] != DBNull.Value)
                _email = (string)reader["Email"];
            if (reader["RoleId"] != DBNull.Value)
                _roleid = Convert.ToInt32(reader["RoleId"]);
        }

        #endregion
    }
}