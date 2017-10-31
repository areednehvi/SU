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

        #region Get Data from Online
        public static List<fee_categoriesModel> GetFeeCategoriesFromOnline()
        {
            List<fee_categoriesModel> lstFeeCategories = new List<fee_categoriesModel>();
            try
            {
                for (int i = 0; i < 100; i++)
                {
                    fee_categoriesModel objfee_categories = new fee_categoriesModel();
                    objfee_categories.id = (i).ToString();
                    lstFeeCategories.Add(objfee_categories);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {

            }
            return lstFeeCategories;
        }
        public static List<feesModel> GetFeesFromOnline()
        {
            List<feesModel> lstFees = new List<feesModel>();
            try
            {
                for (int i = 0; i < 100; i++)
                {
                    feesModel objfees = new feesModel();
                    objfees.id = (i).ToString();
                    lstFees.Add(objfees);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {

            }
            return lstFees;
        }
        public static List<filesModel> GetFilesFromOnline()
        {
            List<filesModel> lstFiles = new List<filesModel>();
            try
            {
                for (int i = 0; i < 100; i++)
                {
                    filesModel objfiles = new filesModel();
                    objfiles.id = (i).ToString();
                    lstFiles.Add(objfiles);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {

            }
            return lstFiles;
        }
        public static List<grade_feesModel> GetGradeFeesFromOnline()
        {
            List<grade_feesModel> lstgrade_fees = new List<grade_feesModel>();
            try
            {
                for (int i = 0; i < 100; i++)
                {
                    grade_feesModel objgrade_fees = new grade_feesModel();
                    objgrade_fees.id = (i).ToString();
                    lstgrade_fees.Add(objgrade_fees);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {

            }
            return lstgrade_fees;
        }
        public static List<gradesModel> GetGradesFromOnline()
        {
            List<gradesModel> lstgrades = new List<gradesModel>();
            try
            {
                for (int i = 0; i < 100; i++)
                {
                    gradesModel objgrades = new gradesModel();
                    objgrades.id = (i).ToString();
                    lstgrades.Add(objgrades);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {

            }
            return lstgrades;
        }
        public static List<parentsModel> GetParentsFromOnline()
        {
            List<parentsModel> lstparents = new List<parentsModel>();
            try
            {
                for (int i = 0; i < 100; i++)
                {
                    parentsModel objparents = new parentsModel();
                    objparents.id = (i).ToString();
                    lstparents.Add(objparents);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {

            }
            return lstparents;
        }
        public static List<route_stopsModel> GetRouteStopsFromOnline()
        {
            List<route_stopsModel> lstroute_stops = new List<route_stopsModel>();
            try
            {
                for (int i = 0; i < 100; i++)
                {
                    route_stopsModel objroute_stops = new route_stopsModel();
                    objroute_stops.id = (i).ToString();
                    lstroute_stops.Add(objroute_stops);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {

            }
            return lstroute_stops;
        }
        public static List<route_vehicle_stopsModel> GetRouteVehicleStopsFromOnline()
        {
            List<route_vehicle_stopsModel> lstroute_vehicle_stops = new List<route_vehicle_stopsModel>();
            try
            {
                for (int i = 0; i < 100; i++)
                {
                    route_vehicle_stopsModel objroute_vehicle_stops = new route_vehicle_stopsModel();
                    objroute_vehicle_stops.id = (i).ToString();
                    lstroute_vehicle_stops.Add(objroute_vehicle_stops);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {

            }
            return lstroute_vehicle_stops;
        }
        public static List<route_vehicle_stops_fee_logsModel> GetRouteVehicleStopsFeeLogsFromOnline()
        {
            List<route_vehicle_stops_fee_logsModel> lstroute_vehicle_stops_fee_logs = new List<route_vehicle_stops_fee_logsModel>();
            try
            {
                for (int i = 0; i < 100; i++)
                {
                    route_vehicle_stops_fee_logsModel objroute_vehicle_stops_fee_log = new route_vehicle_stops_fee_logsModel();
                    objroute_vehicle_stops_fee_log.id = (i).ToString();
                    lstroute_vehicle_stops_fee_logs.Add(objroute_vehicle_stops_fee_log);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {

            }
            return lstroute_vehicle_stops_fee_logs;
        }
        public static List<route_vehiclesModel> GetRouteVehiclesFromOnline()
        {
            List<route_vehiclesModel> lstroute_vehicles = new List<route_vehiclesModel>();
            try
            {
                for (int i = 0; i < 100; i++)
                {
                    route_vehiclesModel objroute_vehicles = new route_vehiclesModel();
                    objroute_vehicles.id = (i).ToString();
                    lstroute_vehicles.Add(objroute_vehicles);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {

            }
            return lstroute_vehicles;
        }
        public static List<routesModel> GetRoutesFromOnline()
        {
            List<routesModel> lstroutes = new List<routesModel>();
            try
            {
                for (int i = 0; i < 100; i++)
                {
                    routesModel objroutes = new routesModel();
                    objroutes.id = (i).ToString();
                    lstroutes.Add(objroutes);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {

            }
            return lstroutes;
        }
        public static List<sectionsModel> GetSectionsFromOnline()
        {
            List<sectionsModel> lstsections = new List<sectionsModel>();
            try
            {
                for (int i = 0; i < 100; i++)
                {
                    sectionsModel objsections = new sectionsModel();
                    objsections.id = (i).ToString();
                    lstsections.Add(objsections);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {

            }
            return lstsections;
        }
        public static List<sessionsModel> GetSessionsFromOnline()
        {
            List<sessionsModel> lstsessions = new List<sessionsModel>();
            try
            {
                for (int i = 0; i < 100; i++)
                {
                    sessionsModel objsessions = new sessionsModel();
                    objsessions.id = (i).ToString();
                    lstsessions.Add(objsessions);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {

            }
            return lstsessions;
        }
        public static List<student_feesModel> GetStudentFeesFromOnline()
        {
            List<student_feesModel> lststudent_fees = new List<student_feesModel>();
            try
            {
                for (int i = 0; i < 100; i++)
                {
                    student_feesModel objstudent_fees = new student_feesModel();
                    objstudent_fees.id = (i).ToString();
                    lststudent_fees.Add(objstudent_fees);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {

            }
            return lststudent_fees;
        }
        public static List<student_grade_session_logModel> GetStudentGradeSessionLogFromOnline()
        {
            List<student_grade_session_logModel> lststudent_grade_session_log = new List<student_grade_session_logModel>();
            try
            {
                for (int i = 0; i < 100; i++)
                {
                    student_grade_session_logModel objstudent_grade_session_log = new student_grade_session_logModel();
                    objstudent_grade_session_log.id = (i).ToString();
                    lststudent_grade_session_log.Add(objstudent_grade_session_log);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {

            }
            return lststudent_grade_session_log;
        }
        public static List<student_paymentsModel> GetStudentPaymentsFromOnline()
        {
            List<student_paymentsModel> lststudent_payments = new List<student_paymentsModel>();
            try
            {
                for (int i = 0; i < 100; i++)
                {
                    student_paymentsModel objstudent_payments = new student_paymentsModel();
                    objstudent_payments.id = (i).ToString();
                    lststudent_payments.Add(objstudent_payments);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {

            }
            return lststudent_payments;
        }
        public static List<studentsModel> GetStudentsFromOnline()
        {
            List<studentsModel> lststudents = new List<studentsModel>();
            try
            {
                for (int i = 0; i < 100; i++)
                {
                    studentsModel objstudents = new studentsModel();
                    objstudents.id = (i).ToString();
                    lststudents.Add(objstudents);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {

            }
            return lststudents;
        }
        public static List<trip_stopsModel> GetTripStopsFromOnline()
        {
            List<trip_stopsModel> lsttrip_stops = new List<trip_stopsModel>();
            try
            {
                for (int i = 0; i < 100; i++)
                {
                    trip_stopsModel objtrip_stops = new trip_stopsModel();
                    objtrip_stops.id = (i).ToString();
                    lsttrip_stops.Add(objtrip_stops);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {

            }
            return lsttrip_stops;
        }
        public static List<user_avatar_filesModel> GetUserAvatarFilesFromOnline()
        {
            List<user_avatar_filesModel> lstuser_avatar_files = new List<user_avatar_filesModel>();
            try
            {
                for (int i = 0; i < 100; i++)
                {
                    user_avatar_filesModel objuser_avatar_files = new user_avatar_filesModel();
                    objuser_avatar_files.id = (i).ToString();
                    lstuser_avatar_files.Add(objuser_avatar_files);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {

            }
            return lstuser_avatar_files;
        }
        public static List<usersModel> GetUsersFromOnline()
        {
            List<usersModel> lstUsers = new List<usersModel>();
            try
            {
                for (int i = 0; i < 100; i++)
                {
                    usersModel objUser = new usersModel();
                    objUser.id = (i).ToString();
                    lstUsers.Add(objUser);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {

            }
            return lstUsers;
        }
        public static List<vehiclesModel> GetVehiclesFromOnline()
        {
            List<vehiclesModel> lstvehicles = new List<vehiclesModel>();
            try
            {
                for (int i = 0; i < 100; i++)
                {
                    vehiclesModel objvehicles = new vehiclesModel();
                    objvehicles.id = (i).ToString();
                    lstvehicles.Add(objvehicles);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {

            }
            return lstvehicles;
        }
        #endregion

        #region Get Data from Offline        
        public static List<student_feesModel> GetStudentFeesFromOffline()
        {
            List<student_feesModel> lststudent_fees = new List<student_feesModel>();
            try
            {
                for (int i = 0; i < 100; i++)
                {
                    student_feesModel objstudent_fees = new student_feesModel();
                    objstudent_fees.id = (i).ToString();
                    lststudent_fees.Add(objstudent_fees);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {

            }
            return lststudent_fees;
        }
        public static List<student_paymentsModel> GetStudentPaymentsFromOffline()
        {
            List<student_paymentsModel> lststudent_payments = new List<student_paymentsModel>();
            try
            {
                for (int i = 0; i < 100; i++)
                {
                    student_paymentsModel objstudent_payments = new student_paymentsModel();
                    objstudent_payments.id = (i).ToString();
                    lststudent_payments.Add(objstudent_payments);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {

            }
            return lststudent_payments;
        }
        #endregion

        #region Last Sync Info from SyncTableInfo
        public static List<SyncTableInfoModel> GetSyncTableInfo()
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

        private static List<SyncTableInfoModel> MapDatatableToSyncTableInfoList(DataTable objDatatable)
        {
            List<SyncTableInfoModel> lstSyncTableInfoList = new List<SyncTableInfoModel>();
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

        public static Boolean UpdateSyncTableInfo(List<SyncTableInfoModel> objSyncTableInfoList)
        {
            Boolean IsSuccess = false;
            try
            {
                foreach(SyncTableInfoModel objSyncTableInfo in objSyncTableInfoList)
                {
                    List<SqlParameter> lstSqlParameters = new List<SqlParameter>()
                    {
                        new SqlParameter() {ParameterName = "@ID",     SqlDbType = SqlDbType.NVarChar, Value = objSyncTableInfo.id_offline},
                        new SqlParameter() {ParameterName = "@LastSyncedOn",  SqlDbType = SqlDbType.NVarChar, Value = objSyncTableInfo.LastSyncedOn}
                    };
                    IsSuccess = DataAccess.ExecuteNonQuery(StoredProcedures.UpdateSyncTableInfo, lstSqlParameters);
                }                
                

            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {

            }
            return IsSuccess;
        }


        #endregion
    }

}