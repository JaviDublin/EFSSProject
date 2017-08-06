using System;
using System.Collections;
using System.Data;
using System.Data.SqlClient;
using RAD.Data;

namespace APP.Data
{
    public class DBAgent
    {
        //private static string _connectionString = APP.Properties.Settings.Default.ApplicationDataBase;
        SqlConnection connection = ConnectionManager.CreateConnection(DataBase.Application);
        string[] _parameterNames;
        string[] _parameterValues;
        string _storeProcedure;

        public DBAgent(string storeProcedure, ArrayList parameterNames, ArrayList parameterValues)
        {
            _storeProcedure = storeProcedure;
            _parameterNames = new string[parameterNames.Count];
            _parameterValues = new string[parameterValues.Count];
            parameterNames.CopyTo(_parameterNames);
            parameterValues.CopyTo(_parameterValues);
            parameterNames.Clear();
            parameterValues.Clear();
        }

        public DBAgent(string storeProcedure)
        {
            _storeProcedure = storeProcedure;
        }

        public int ExecuteQueryWithReturnId()
        {
            if (connection.State == ConnectionState.Closed)
            {
                connection.Open();
            }

            System.Data.SqlClient.SqlCommand Search = new System.Data.SqlClient.SqlCommand();
            Search.CommandType = CommandType.StoredProcedure;
            Search.Connection = connection;
            Search.CommandText = _storeProcedure;

            if (_parameterNames != null)
            {
                for (int i = 0; i <= _parameterNames.Length - 1; i++)
                {
                    Search.Parameters.AddWithValue(_parameterNames[i], _parameterValues[i]);
                }
            }

            System.Data.SqlClient.SqlParameter result = Search.Parameters.Add("@result", SqlDbType.Int);
            result.Direction = ParameterDirection.Output;
            Search.ExecuteNonQuery();

            if (connection.State == ConnectionState.Open)
            {
                connection.Close();
            }

            if (_parameterNames != null)
            {
                Array.Clear(_parameterNames, 0, _parameterNames.Length - 1);
            }
            if (_parameterValues != null)
            {
                Array.Clear(_parameterValues, 0, _parameterValues.Length - 1);
            }

            int output;
            output = Convert.ToInt32(result.Value);

            return output;

        }

        public void ExecuteQuery()
        {
            if (connection.State == ConnectionState.Closed)
            {
                connection.Open();
            }

            System.Data.SqlClient.SqlCommand Execute = new System.Data.SqlClient.SqlCommand();
            Execute.CommandType = CommandType.StoredProcedure;
            Execute.Connection = connection;
            Execute.CommandText = _storeProcedure;

            if (_parameterNames != null)
            {
                for (int i = 0; i <= _parameterNames.Length - 1; i++)
                {
                    Execute.Parameters.AddWithValue(_parameterNames[i], _parameterValues[i]);
                }
            }

            Execute.ExecuteNonQuery();

            if (connection.State == ConnectionState.Open)
            {
                connection.Close();
            }

            if (_parameterNames != null)
            {
                Array.Clear(_parameterNames, 0, _parameterNames.Length - 1);
            }
            if (_parameterValues != null)
            {
                Array.Clear(_parameterValues, 0, _parameterValues.Length - 1);
            }
        }

        public DataTable ReturnData()
        {
            if (connection.State == ConnectionState.Closed)
            {
                connection.Open();
            }

            System.Data.SqlClient.SqlCommand Search = new System.Data.SqlClient.SqlCommand();
            Search.CommandType = CommandType.StoredProcedure;
            Search.Connection = connection;
            Search.CommandTimeout = 80000;
            Search.CommandText = _storeProcedure;

            if (_parameterNames != null)
            {
                for (int i = 0; i <= _parameterNames.Length - 1; i++)
                {
                    Search.Parameters.AddWithValue(_parameterNames[i], _parameterValues[i]);
                }
            }

            Search.ExecuteNonQuery();

            System.Data.DataTable dt = new System.Data.DataTable();
            SqlDataAdapter da = new SqlDataAdapter();
            da.SelectCommand = Search;
            da.Fill(dt);

            if (connection.State == ConnectionState.Open)
            {
                connection.Close();
            }

            if (_parameterNames != null)
            {
                Array.Clear(_parameterNames, 0, _parameterNames.Length - 1);
            }
            if (_parameterValues != null)
            {
                Array.Clear(_parameterValues, 0, _parameterValues.Length - 1);
            }

            return dt;
        }

        public DataSet ReturnDataSet()
        {

            if (connection.State == ConnectionState.Closed)
            {
                connection.Open();
            }

            System.Data.SqlClient.SqlCommand Search = new System.Data.SqlClient.SqlCommand();
            Search.CommandType = CommandType.StoredProcedure;
            Search.Connection = connection;
            Search.CommandTimeout = 80000;
            Search.CommandText = _storeProcedure;

            if (_parameterNames != null)
            {
                for (int i = 0; i <= _parameterNames.Length - 1; i++)
                {
                    Search.Parameters.AddWithValue(_parameterNames[i], _parameterValues[i]);
                }
            }

            Search.ExecuteNonQuery();


            System.Data.DataSet ds = new System.Data.DataSet();
            SqlDataAdapter da = new SqlDataAdapter();
            da.SelectCommand = Search;
            da.Fill(ds);

            if (connection.State == ConnectionState.Open)
            {
                connection.Close();
            }

            if (_parameterNames != null)
            {
                Array.Clear(_parameterNames, 0, _parameterNames.Length - 1);
            }
            if (_parameterValues != null)
            {
                Array.Clear(_parameterValues, 0, _parameterValues.Length - 1);
            }

            return ds;

        }

    }
}