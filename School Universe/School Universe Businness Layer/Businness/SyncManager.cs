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
using static School_Universe_Models.Models.DBModels;

namespace School_Universe_Businness_Layer.Businness
{
    public class SyncManager
    { 

        public static ObservableCollection<SyncTableInfoModel> GetSyncTableInfo()
        {            
            try
            {
                DataTable objDataTable = DataAccess.GetDataTable(StoredProcedures.GetSyncTableInfo);
                return MapDatatableToSyncTableInfoList(objDataTable);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {

            }
        }

        private static ObservableCollection<SyncTableInfoModel> MapDatatableToSyncTableInfoList(DataTable objDatatable)
        {
            ObservableCollection<SyncTableInfoModel> lstSyncTableInfoList = new ObservableCollection<SyncTableInfoModel>();
            try
            {
                foreach (DataRow row in objDatatable.Rows)
                {
                    SyncTableInfoModel objSyncTableInfo = new SyncTableInfoModel();

                    objSyncTableInfo.id_offline = row["id_offline"] != DBNull.Value ? row["id_offline"].ToString() : string.Empty;
                    objSyncTableInfo.TableName = row["TableName"] != DBNull.Value ? row["TableName"].ToString() : string.Empty;
                    objSyncTableInfo.LastSyncedOn = row["LastSyncedOn"] != DBNull.Value ? Convert.ToDateTime(row["LastSyncedOn"]) : DateTime.MinValue;

                    lstSyncTableInfoList.Add(objSyncTableInfo);
                }

            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {

            }
            return lstSyncTableInfoList;
        }

    }

}