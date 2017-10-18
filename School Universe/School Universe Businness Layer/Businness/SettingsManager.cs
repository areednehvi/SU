using School_Universe.Models;
using School_Universe_Businness_Layer.Shared;
using School_Universe_Data_Layer.DataAccess;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace School_Universe_Businness_Layer.Businness
{
    public class SettingsManager
    {
        public static Boolean SaveSetting(NoOfRowsInGridsModel objNoOfRowsInGrids)
        {
            Boolean isSuccess = false;
            try
            {
                List<SqlParameter> lstSqlParameters = new List<SqlParameter>()
                {

                    new SqlParameter() {ParameterName = "@Key",     SqlDbType = SqlDbType.NVarChar, Value = objNoOfRowsInGrids.name},
                    new SqlParameter() {ParameterName = "@Value",  SqlDbType = SqlDbType.NVarChar, Value = objNoOfRowsInGrids.id}
                };
                isSuccess = DataAccess.ExecuteNonQuery(StoredProcedures.SaveSettings, lstSqlParameters);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {

            }
            return isSuccess;
        }

    }

}