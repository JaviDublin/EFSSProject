using System.Data;

namespace APP.Data
{
    public class DBNoData
    {
        private static DataTable NoData;

        public DBNoData()
        {
            NoData = new DataTable();
            DataColumn dc;
            dc = new DataColumn();
            dc.ColumnName = "Information";
            dc.DataType = System.Type.GetType("System.String");
            NoData.Columns.Add(dc);

            DataRow dr;
            dr = NoData.NewRow();
            dr["Information"] = "No Information available";
            NoData.Rows.Add(dr);
        }

        public DataTable NoDataAvailable()
        {
            return NoData;
        }


    }
}