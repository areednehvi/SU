using School_Universe.Models;
using School_Universe_Businness_Layer.Shared;
using School_Universe_Data_Layer.DataAccess;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace School_Universe_Businness_Layer.Businness
{
    public class LoginManager
    {
        public static Boolean ValidateUser(LoginModel objLogin)
        {
            Boolean isValidUser = false;


            try
            {
                List<SqlParameter> lstSqlParameters = new List<SqlParameter>()
                {

                    new SqlParameter() {ParameterName = "@Username",     SqlDbType = SqlDbType.NVarChar, Value = objLogin.Username},
                    new SqlParameter() {ParameterName = "@Password",  SqlDbType = SqlDbType.NVarChar, Value = objLogin.Password}
                };
                DataTable objDatable = DataAccess.GetDataTable(StoredProcedures.AuthenticateUser, lstSqlParameters);
                if (objDatable.Rows.Count > 0)
                {
                    isValidUser = true;
                    objLogin.ID = objDatable.Rows[0]["id"] != DBNull.Value ? objDatable.Rows[0]["id"].ToString() : string.Empty;
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {

            }
            return isValidUser;

        }

        public static SchoolModel GetSchooInfo()
        {
            try
            {
                DataTable objDatable = DataAccess.GetDataTable(StoredProcedures.GetSchoolInfo);
                return MapDatatableToSchoolObject(objDatable);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {

            }

        }

        private static SchoolModel MapDatatableToSchoolObject(DataTable objDatatable)
        {
            SchoolModel objSchoolInfo = new SchoolModel();
            try
            {
                objSchoolInfo.id = objDatatable.Rows[0]["id"] != DBNull.Value ? objDatatable.Rows[0]["id"].ToString() : string.Empty;
                objSchoolInfo.database_id = objDatatable.Rows[0]["database_id"] != DBNull.Value ? objDatatable.Rows[0]["database_id"].ToString() : string.Empty;
                objSchoolInfo.subdomain = objDatatable.Rows[0]["subdomain"] != DBNull.Value ? objDatatable.Rows[0]["subdomain"].ToString() : string.Empty;
                objSchoolInfo.domain = objDatatable.Rows[0]["domain"] != DBNull.Value ? objDatatable.Rows[0]["domain"].ToString() : string.Empty;
                objSchoolInfo.name = objDatatable.Rows[0]["name"] != DBNull.Value ? objDatatable.Rows[0]["name"].ToString() : string.Empty;
                objSchoolInfo.address = objDatatable.Rows[0]["address"] != DBNull.Value ? objDatatable.Rows[0]["address"].ToString() : string.Empty;
                objSchoolInfo.theme = objDatatable.Rows[0]["theme"] != DBNull.Value ? objDatatable.Rows[0]["theme"].ToString() : string.Empty;
                objSchoolInfo.created_on = objDatatable.Rows[0]["created_on"] != DBNull.Value ? Convert.ToDateTime(objDatatable.Rows[0]["created_on"].ToString()) : DateTime.MinValue;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {

            }
            return objSchoolInfo;
        }
    }

}