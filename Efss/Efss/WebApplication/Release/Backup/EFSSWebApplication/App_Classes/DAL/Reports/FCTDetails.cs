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
    public class FCTDetails
    {
        public static List<FCTDetails> SelectFleetCashTargetReport(int groupId, int reportTypeId)
        {
            try
            {
                SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = ConnectionManager.CreateProcedure(StoredProcedures.Report_FCT_Select, con);
                Parameters.CreateParameter(cmd, "@groupId", groupId);
                Parameters.CreateParameter(cmd, "@reportTypeId", reportTypeId);
                Parameters.CreateParameter(cmd, "@dateUpdated", SessionHandler.FCSelectedDay);

                var results = new List<FCTDetails>();
                using (con)
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        results.Add(new FCTDetails(reader));
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

        private int _rowId;
        private int _groupId;
        private int _regionId;
        private int _reportTypeId;
        private int _monthNumber;
        private string _dateUpdated;
        private int _currencyId;
        private string _balanceInit;
        private string _balanceVat;
        private string _balanceEnd;
        private string _targetAmt;
        private string _collectionTarget;
        private string _mtd;
        private string _expected;
        private string _remaining;
        private string _note;
        private string _noteExpected;
        private string _racfId;

        #endregion

        #region "Properties"

        public int RowId
        {
            get { return _rowId; }
        }

        public int GroupId
        {
            get { return _groupId; }
        }

        public int RegionId
        {
            get { return _regionId; }
        }

        public int ReportTypeId
        {
            get { return _reportTypeId; }
        }

        public int MonthNumber
        {
            get { return _monthNumber; }
        }

        public string DateUpdated
        {
            get { return _dateUpdated; }
        }

        public int CurrencyId
        {
            get { return _currencyId; }
        }

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

        public string Note
        {
            get { return _note; }
        }

        public string NoteExpected
        {
            get { return _noteExpected; }
        }

        public string RacfId
        {
            get { return _racfId; }
        }

        #endregion

        #region "Constructor"

        public FCTDetails(SqlDataReader reader)
        {
            if (reader["RowId"] != DBNull.Value)
                _rowId = Convert.ToInt32(reader["RowId"]);
            if (reader["GroupId"] != DBNull.Value)
                _groupId = Convert.ToInt32(reader["GroupId"]);
            if (reader["RegionId"] != DBNull.Value)
                _regionId = Convert.ToInt32(reader["RegionId"]);
            if (reader["ReportTypeId"] != DBNull.Value)
                _reportTypeId = Convert.ToInt32(reader["ReportTypeId"]);
            if (reader["MonthNumber"] != DBNull.Value)
                _monthNumber = Convert.ToInt32(reader["MonthNumber"]);
            if (reader["DateUpdated"] != DBNull.Value)
                _dateUpdated = (string)reader["DateUpdated"];
            if (reader["CurrencyId"] != DBNull.Value)
                _currencyId = Convert.ToInt32(reader["CurrencyId"]);
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
            if (reader["Note"] != DBNull.Value)
                _note = (string)reader["Note"];
            if (reader["NoteExpected"] != DBNull.Value)
                _noteExpected = (string)reader["NoteExpected"];
            if (reader["RacfId"] != DBNull.Value)
                _racfId = (string)reader["RacfId"];
        }

        #endregion


    }
}