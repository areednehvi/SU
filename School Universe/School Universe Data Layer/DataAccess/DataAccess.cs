using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace School_Universe_Data_Layer.DataAccess
{
    public class DataAccess
    {
        static string path = System.IO.Path.GetFullPath(Environment.CurrentDirectory);
        //static SqlConnection objSqlConnection = new SqlConnection(@"Data Source=(localdb)\v11.0;AttachDbFilename=" + path + @"\SchoolUniverse.mdf;Integrated Security=True;");
        static SqlConnection objSqlConnection = new SqlConnection(@"Data Source=(localdb)\MSSQLLocalDB;AttachDbFilename=" + path + @"\SchoolUniverse.mdf;Integrated Security=True;");

        public DataAccess()
        {            
            
        }

        public static DataTable GetDataTable(string storedProcedure, List<SqlParameter> lstSqlParameters)
        {
            DataTable objDatabale = new DataTable();
            SqlCommand objSqlCommand = new SqlCommand(storedProcedure, objSqlConnection);
            try
            {                                
                objSqlConnection.Open();                
                objSqlCommand.CommandType = CommandType.StoredProcedure;
                objSqlCommand.CommandTimeout = 9000;
                if(lstSqlParameters != null)
                    objSqlCommand.Parameters.AddRange(lstSqlParameters.ToArray());
                SqlDataAdapter da = new SqlDataAdapter(objSqlCommand);
                da.Fill(objDatabale);               
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                objSqlCommand.Dispose();
                objSqlConnection.Close();
            }
            return objDatabale;
        }

        public static DataTable GetDataTable(string query)
        {
            DataTable objDatabale = new DataTable();
            SqlCommand objSqlCommand = new SqlCommand(query, objSqlConnection);
            try
            {
                objSqlConnection.Open();
                objSqlCommand.CommandType = CommandType.Text;
            
                SqlDataAdapter da = new SqlDataAdapter(objSqlCommand);
                da.Fill(objDatabale);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                objSqlCommand.Dispose();
                objSqlConnection.Close();
            }
            return objDatabale;
        }

        public static object GetScalar(string storedProcedure, List<SqlParameter> lstSqlParameters)
        {
            object value;
            SqlCommand objSqlCommand = new SqlCommand(storedProcedure, objSqlConnection);
            try
            {
                objSqlConnection.Open();
                objSqlCommand.CommandType = CommandType.StoredProcedure;
                objSqlCommand.Parameters.AddRange(lstSqlParameters.ToArray());
                value = objSqlCommand.ExecuteScalar();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                objSqlCommand.Dispose();
                objSqlConnection.Close();
            }
            return value;
        }

        public static Boolean ExecuteNonQuery(string storedProcedure, List<SqlParameter> lstSqlParameters)
        {
            Boolean success = false;
            SqlCommand objSqlCommand = new SqlCommand(storedProcedure, objSqlConnection);
            try
            {
                objSqlConnection.Open();
                objSqlCommand.CommandType = CommandType.StoredProcedure;
                objSqlCommand.Parameters.AddRange(lstSqlParameters.ToArray());
                objSqlCommand.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                objSqlCommand.Dispose();
                objSqlConnection.Close();
            }
            return success;
        }
        public static void update()
        {
            SqlCommand cmd = new SqlCommand("exec UpdatePayment @list", objSqlConnection);
            string str ="";
            objSqlConnection.Open();

            using (var table = new DataTable())
            {
                table.Columns.Add("Item", typeof(string));

                for (int i = 0; i < 10; i++)
                    table.Rows.Add("Item " + i.ToString());

                var pList = new SqlParameter("@list", SqlDbType.Structured);
                pList.TypeName = "dbo.StringList";
                pList.Value = table;

                cmd.Parameters.Add(pList);

                using (var dr = cmd.ExecuteReader())
                {
                    while (dr.Read())
                        str += dr["Item"].ToString();
                }
            }
            
        }
    }
}
