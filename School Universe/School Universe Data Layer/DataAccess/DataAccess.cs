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
        static SqlConnection objSqlConnection = new SqlConnection(@"Data Source=(localdb)\v11.0;AttachDbFilename=" + path + @"\SchoolUniverse.mdf;Integrated Security=True;");
        
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
    }
}
