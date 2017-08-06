using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Diagnostics;
using APP.Data;
using APP.Session;
using RAD.Data;
using RAD.Diagnostics;

namespace APP.Reports
{
    public class FCTDetailsTotal
    {
        public static List<FCTDetailsTotal> SelectFleetCashTargetReportTotals(int regionId, int reportTypeId)
        {
            try
            {
                SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = ConnectionManager.CreateProcedure(StoredProcedures.Report_FCT_Select_Total, con);
                Parameters.CreateParameter(cmd, "@regionId", regionId);
                Parameters.CreateParameter(cmd, "@reportTypeId", reportTypeId);
                Parameters.CreateParameter(cmd, "@dateUpdated", SessionHandler.FCSelectedDay);

                var results = new List<FCTDetailsTotal>();
                using (con)
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        results.Add(new FCTDetailsTotal(reader));
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

        private string _balanceInit;
        private string _balanceVat;
        private string _balanceEnd;
        private string _targetAmt;
        private string _collectionTarget;
        private string _mtd;
        private string _expected;
        private string _remaining;

        #endregion

        #region "Properties"

        public string BalanceInit
        {
            get { return _balanceInit; }
        }

        public string BalanceVat
        {
            get { return _balanceVat; }
        }

        public string BalanceEnd
        {
            get { return _balanceEnd; }
        }

        public string TargetAmt
        {
            get { return _targetAmt; }
        }

        public string CollectionsTarget
        {
            get { return _collectionTarget; }
        }

        public string Mtd
        {
            get { return _mtd; }
        }

        public string Expected
        {
            get { return _expected; }
        }

        public string Remaining
        {
            get { return _remaining; }
        }

        #endregion

        #region "Constructor"

        public FCTDetailsTotal(SqlDataReader reader)
        {
            if (reader["BalanceInit"] != DBNull.Value)
                _balanceInit = reader["BalanceInit"].ToString();
            if (reader["BalanceVat"] != DBNull.Value)
                _balanceVat = reader["BalanceVat"].ToString();
            if (reader["BalanceEnd"] != DBNull.Value)
                _balanceEnd = reader["BalanceEnd"].ToString();
            if (reader["TargetAmt"] != DBNull.Value)
                _targetAmt = reader["TargetAmt"].ToString();
            if (reader["CollectionTarget"] != DBNull.Value)
                _collectionTarget = reader["CollectionTarget"].ToString();
            if (reader["Mtd"] != DBNull.Value)
                _mtd = reader["Mtd"].ToString();
            if (reader["Expected"] != DBNull.Value)
                _expected = reader["Expected"].ToString();
            if (reader["Remaining"] != DBNull.Value)
                _remaining = reader["Remaining"].ToString();
        
        }

        #endregion
    }
}