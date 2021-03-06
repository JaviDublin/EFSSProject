﻿using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Diagnostics;
using APP.Data;
using APP.Paging;
using RAD.Data;
using RAD.Diagnostics;
using RAD.Controls;

namespace APP.Search
{
    public class SalesManualInvoiceJournal
    {
        public static List<SalesManualInvoiceJournal> GetJournal()
        {
            try
            {
                //Initialise Command
                SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = ConnectionManager.CreateProcedure(StoredProcedures.ManualInvoicesJournal, con);
               
                //Execute Command
                var results = new List<SalesManualInvoiceJournal>();
                using (con)
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        results.Add(new SalesManualInvoiceJournal(reader));
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

        private string _serial;
        private string _primeAccount;
        private string _subAccount;
        private string _costCenter;
        private string _activity;
        private string _division;

        #endregion

        #region "Properties"

        public string Serial
        {
            get { return _serial; }
        }

        public string PrimeAccount
        {
            get { return _primeAccount; }
        }

        public string SubAccount
        {
            get { return _subAccount; }
        }

        public string CostCenter
        {
            get { return _costCenter; }
        }

        public string Activity
        {
            get { return _activity; }
        }

        public string Division
        {
            get { return _division; }
        }
        
        #endregion

        #region "Constructor"

        public SalesManualInvoiceJournal(SqlDataReader reader)
        {
            if (reader["Serial"] != DBNull.Value)
                _serial = (string)reader["Serial"];
            if (reader["PrimeAccount"] != DBNull.Value)
                _primeAccount = (string)reader["PrimeAccount"];
            if (reader["SubAccount"] != DBNull.Value)
                _subAccount = (string)reader["SubAccount"];
            if (reader["CostCenter"] != DBNull.Value)
                _costCenter = (string)reader["CostCenter"];
            if (reader["Activity"] != DBNull.Value)
                _activity = (string)reader["Activity"];
            if (reader["Division"] != DBNull.Value)
                _division = (string)reader["Division"];

        }
        
        #endregion

    }
}