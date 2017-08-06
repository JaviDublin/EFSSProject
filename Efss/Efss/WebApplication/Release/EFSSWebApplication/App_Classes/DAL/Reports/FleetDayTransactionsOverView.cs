using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Diagnostics;
using APP.Data;
using APP.Paging;
using RAD.Data;
using RAD.Diagnostics;
namespace APP.Reports
{
    public class FleetDayTransactionsOverView
    {
        public static List<FleetDayTransactionsOverView> SelectFleetDayTransactionsReport(int? currentPageNumber, int? pageSize, string sortExpression, string month, string year, int fileId)
        {
            try
            {
                //Initialise Command
                SqlConnection con = ConnectionManager.CreateConnection(DataBase.Application);
                SqlCommand cmd = ConnectionManager.CreateProcedure(StoredProcedures.Select_Fleet_DayReport_AddsDel, con);

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
                Parameters.CreateParameter(cmd, "@month", month);
                Parameters.CreateParameter(cmd, "@year", year);
                Parameters.CreateParameter(cmd, "@fileId", fileId);


                //Execute Command
                var results = new List<FleetDayTransactionsOverView>();
                using (con)
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        results.Add(new FleetDayTransactionsOverView(reader));
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
        private int _countryId;
        private string _countryName;
        private int _total;
        private int _day1;
        private int _day2;
        private int _day3;
        private int _day4;
        private int _day5;
        private int _day6;
        private int _day7;
        private int _day8;
        private int _day9;
        private int _day10;
        private int _day11;
        private int _day12;
        private int _day13;
        private int _day14;
        private int _day15;
        private int _day16;
        private int _day17;
        private int _day18;
        private int _day19;
        private int _day20;
        private int _day21;
        private int _day22;
        private int _day23;
        private int _day24;
        private int _day25;
        private int _day26;
        private int _day27;
        private int _day28;
        private int _day29;
        private int _day30;
        private int _day31;

        #endregion

        #region "Properties"

        public int Count
        {
            get { return _count; }
        }

        public int CountryId
        {
            get { return _countryId; }
        }

        public string CountryName
        {
            get { return _countryName; }
        }

        public int Total
        {
            get { return _total; }
        }

        public int D1
        {
            get { return _day1; }
        }

        public int D2
        {
            get { return _day2; }
        }

        public int D3
        {
            get { return _day3; }
        }

        public int D4
        {
            get { return _day4; }
        }

        public int D5
        {
            get { return _day5; }
        }

        public int D6
        {
            get { return _day6; }
        }

        public int D7
        {
            get { return _day7; }
        }

        public int D8
        {
            get { return _day8; }
        }

        public int D9
        {
            get { return _day9; }
        }

        public int D10
        {
            get { return _day10; }
        }

        public int D11
        {
            get { return _day11; }
        }

        public int D12
        {
            get { return _day12; }
        }

        public int D13
        {
            get { return _day13; }
        }

        public int D14
        {
            get { return _day14; }
        }

        public int D15
        {
            get { return _day15; }
        }

        public int D16
        {
            get { return _day16; }
        }

        public int D17
        {
            get { return _day17; }
        }

        public int D18
        {
            get { return _day18; }
        }

        public int D19
        {
            get { return _day19; }
        }

        public int D20
        {
            get { return _day20; }
        }

        public int D21
        {
            get { return _day21; }
        }

        public int D22
        {
            get { return _day22; }
        }

        public int D23
        {
            get { return _day23; }
        }

        public int D24
        {
            get { return _day24; }
        }

        public int D25
        {
            get { return _day25; }
        }

        public int D26
        {
            get { return _day26; }
        }

        public int D27
        {
            get { return _day27; }
        }

        public int D28
        {
            get { return _day28; }
        }

        public int D29
        {
            get { return _day29; }
        }

        public int D30
        {
            get { return _day30; }
        }

        public int D31
        {
            get { return _day31; }
        }

        #endregion

        #region "Constructor"

        public FleetDayTransactionsOverView(SqlDataReader reader)
        {
            if (reader["count"] != DBNull.Value)
                _count = Convert.ToInt32(reader["count"]);
            if (reader["CountryId"] != DBNull.Value)
                _countryId = Convert.ToInt32(reader["CountryId"]);
            if (reader["CountryName"] != DBNull.Value)
                _countryName = (string)reader["CountryName"];
            if (reader["Total"] != DBNull.Value)
                _total = Convert.ToInt32(reader["Total"]);
            if (reader["1"] != DBNull.Value)
                _day1 = Convert.ToInt32(reader["1"]);
            if (reader["2"] != DBNull.Value)
                _day2 = Convert.ToInt32(reader["2"]);
            if (reader["3"] != DBNull.Value)
                _day3 = Convert.ToInt32(reader["3"]);
            if (reader["4"] != DBNull.Value)
                _day4 = Convert.ToInt32(reader["4"]);
            if (reader["5"] != DBNull.Value)
                _day5 = Convert.ToInt32(reader["5"]);
            if (reader["6"] != DBNull.Value)
                _day6 = Convert.ToInt32(reader["6"]);
            if (reader["7"] != DBNull.Value)
                _day7 = Convert.ToInt32(reader["7"]);
            if (reader["8"] != DBNull.Value)
                _day8 = Convert.ToInt32(reader["8"]);
            if (reader["9"] != DBNull.Value)
                _day9 = Convert.ToInt32(reader["9"]);
            if (reader["10"] != DBNull.Value)
                _day10 = Convert.ToInt32(reader["10"]);
            if (reader["11"] != DBNull.Value)
                _day11 = Convert.ToInt32(reader["11"]);
            if (reader["12"] != DBNull.Value)
                _day12 = Convert.ToInt32(reader["12"]);
            if (reader["13"] != DBNull.Value)
                _day13 = Convert.ToInt32(reader["13"]);
            if (reader["14"] != DBNull.Value)
                _day14 = Convert.ToInt32(reader["14"]);
            if (reader["15"] != DBNull.Value)
                _day15 = Convert.ToInt32(reader["15"]);
            if (reader["16"] != DBNull.Value)
                _day16 = Convert.ToInt32(reader["16"]);
            if (reader["17"] != DBNull.Value)
                _day17 = Convert.ToInt32(reader["17"]);
            if (reader["18"] != DBNull.Value)
                _day18 = Convert.ToInt32(reader["18"]);
            if (reader["19"] != DBNull.Value)
                _day19 = Convert.ToInt32(reader["19"]);
            if (reader["20"] != DBNull.Value)
                _day20 = Convert.ToInt32(reader["20"]);
            if (reader["21"] != DBNull.Value)
                _day21 = Convert.ToInt32(reader["21"]);
            if (reader["22"] != DBNull.Value)
                _day22 = Convert.ToInt32(reader["22"]);
            if (reader["23"] != DBNull.Value)
                _day23 = Convert.ToInt32(reader["23"]);
            if (reader["24"] != DBNull.Value)
                _day24 = Convert.ToInt32(reader["24"]);
            if (reader["25"] != DBNull.Value)
                _day25 = Convert.ToInt32(reader["25"]);
            if (reader["26"] != DBNull.Value)
                _day26 = Convert.ToInt32(reader["26"]);
            if (reader["27"] != DBNull.Value)
                _day27 = Convert.ToInt32(reader["27"]);
            if (reader["28"] != DBNull.Value)
                _day28 = Convert.ToInt32(reader["28"]);
            if (reader["29"] != DBNull.Value)
                _day29 = Convert.ToInt32(reader["29"]);
            if (reader["30"] != DBNull.Value)
                _day30 = Convert.ToInt32(reader["30"]);
            if (reader["31"] != DBNull.Value)
                _day31 = Convert.ToInt32(reader["31"]);


        }

        #endregion
    }
}