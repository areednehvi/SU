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
    public class GetListManager
    {
        public static ObservableCollection<GradesModel> GetGrades()
        {
           
            try
            {

                GetListModel objGetListModel = new GetListModel()
                {
                    tableName = "grades",
                    keyColumn = "name",
                    valueColumn = "id",
                    orderBy = "[order]"
                };
                DataTable objDatatable = GetList(objGetListModel);
                return MapDatatableToGradesModelList(objDatatable);

            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {

            }

        }

        public static ObservableCollection<SectionsModel> GetSections()
        {

            try
            {

                GetListModel objGetListModel = new GetListModel()
                {
                    tableName = "sections",
                    keyColumn = "name",
                    valueColumn = "id",
                    orderBy = "name"
                };
                DataTable objDatatable = GetList(objGetListModel);
                return MapDatatableToSectionsModelList(objDatatable);

            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {

            }

        }

        private static ObservableCollection<GradesModel> MapDatatableToGradesModelList(DataTable objDatatable)
        {
            ObservableCollection<GradesModel> objGradesModelList = new ObservableCollection<GradesModel>();
            try
            {
                objGradesModelList.Add(new GradesModel { id = "0", name = "All" });
                foreach (DataRow row in objDatatable.Rows)
                {
                    GradesModel objGradesModel = new GradesModel();

                    objGradesModel.id = row["id"] != DBNull.Value ? row["id"].ToString() : string.Empty;
                    objGradesModel.name = row["name"] != DBNull.Value ? row["name"].ToString() : string.Empty;

                    objGradesModelList.Add(objGradesModel);
                }

            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {

            }
            return objGradesModelList;
        }

        private static ObservableCollection<SectionsModel> MapDatatableToSectionsModelList(DataTable objDatatable)
        {
            ObservableCollection<SectionsModel> objSectionsModelList = new ObservableCollection<SectionsModel>();
            try
            {
                objSectionsModelList.Add(new SectionsModel { id = "0", name = "All" });
                foreach (DataRow row in objDatatable.Rows)
                {
                    SectionsModel objSectionsModel = new SectionsModel();

                    objSectionsModel.id = row["id"] != DBNull.Value ? row["id"].ToString() : string.Empty;
                    objSectionsModel.name = row["name"] != DBNull.Value ? row["name"].ToString() : string.Empty;

                    objSectionsModelList.Add(objSectionsModel);
                }

            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {

            }
            return objSectionsModelList;
        }

        public static DataTable GetList(GetListModel objGetList)
        {
            DataTable objDatatable;           
            try
            {

                List<SqlParameter> lstSqlParameters = new List<SqlParameter>()
                {
                    new SqlParameter() {ParameterName = "@tableName",  SqlDbType = SqlDbType.NVarChar, Value = objGetList.tableName},
                    new SqlParameter() {ParameterName = "@keyColumn",  SqlDbType = SqlDbType.NVarChar, Value = objGetList.keyColumn},
                    new SqlParameter() {ParameterName = "@valueColumn",SqlDbType = SqlDbType.NVarChar, Value = objGetList.valueColumn},
                    new SqlParameter() {ParameterName = "@orderBy",SqlDbType = SqlDbType.NVarChar, Value = objGetList.orderBy},                   
                };
                objDatatable = DataAccess.GetDataTable(StoredProcedures.GetList, lstSqlParameters);

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
