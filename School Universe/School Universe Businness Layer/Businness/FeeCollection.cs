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
    public class FeeCollection
    {        
        public static DataTable GetStudentFeeCollectionList()
        {
            DataTable objDatatable;  

         
            try
            {

                objDatatable = DataAccess.GetDataTable(StoredProcedures.GetStudentFeeAllocatedList, null);

            }
            catch(Exception ex)
            {
                throw ex;
            }
            finally
            {

            }
            return objDatatable;                
            
        }
    }
}
