using School_Universe.Models;
using School_Universe_Businness_Layer.Shared;
using School_Universe_Data_Layer.DataAccess;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System.Threading.Tasks;
using static School_Universe_Models.Models.DBModels;
using School_Universe_Models.Models;

namespace School_Universe_Businness_Layer.Businness
{
    public class SyncManager
    {

        #region Get Data from Online
        public static List<fee_categoriesModel> GetFeeCategoriesFromOnline(string APIUri, DateTime LastSyncedOn)
        {
            List<fee_categoriesModel> lstFeeCategories = new List<fee_categoriesModel>();
            try
            {
                if (!APIUri.EndsWith("/"))
                    APIUri += "/";
                APIUri += "web-services/fee_categories?date=" + LastSyncedOn.ToString("yyyy-MM-dd HH:mm:ss");
                lstFeeCategories = JsonConvert.DeserializeObject<List<fee_categoriesModel>>(httpGetWebRequest(APIUri));
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
        public static List<feesModel> GetFeesFromOnline(string APIUri, DateTime LastSyncedOn)
        {
            List<feesModel> lstFees = new List<feesModel>();
            try
            {
                if (!APIUri.EndsWith("/"))
                    APIUri += "/";
                APIUri += "web-services/fees?date=" + LastSyncedOn.ToString("yyyy-MM-dd HH:mm:ss");
                lstFees = JsonConvert.DeserializeObject<List<feesModel>>(httpGetWebRequest(APIUri));
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
        public static List<filesModel> GetFilesFromOnline(string APIUri, DateTime LastSyncedOn)
        {
            List<filesModel> lstFiles = new List<filesModel>();
            try
            {
                //if (!APIUri.EndsWith("/"))
                //    APIUri += "/";
                //APIUri += "web-services/files?date=" + LastSyncedOn.ToString("yyyy-MM-dd HH:mm:ss");
                //lstFiles = JsonConvert.DeserializeObject<List<filesModel>>(httpGetWebRequest(APIUri));
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
        public static List<grade_feesModel> GetGradeFeesFromOnline(string APIUri, DateTime LastSyncedOn)
        {
            List<grade_feesModel> lstgrade_fees = new List<grade_feesModel>();
            try
            {
                if (!APIUri.EndsWith("/"))
                    APIUri += "/";
                APIUri += "web-services/grade_fees?date=" + LastSyncedOn.ToString("yyyy-MM-dd HH:mm:ss");
                lstgrade_fees = JsonConvert.DeserializeObject<List<grade_feesModel>>(httpGetWebRequest(APIUri));
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
        public static List<gradesModel> GetGradesFromOnline(string APIUri, DateTime LastSyncedOn)
        {
            List<gradesModel> lstGrades = new List<gradesModel>();
            try
            {
                if (!APIUri.EndsWith("/"))
                    APIUri += "/";
                APIUri += "web-services/grades?date=" + LastSyncedOn.ToString("yyyy-MM-dd HH:mm:ss");
                lstGrades = JsonConvert.DeserializeObject<List<gradesModel>>(httpGetWebRequest(APIUri));
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {

            }
            return lstGrades;
        }
        public static List<parentsModel> GetParentsFromOnline(string APIUri, DateTime LastSyncedOn)
        {
            List<parentsModel> lstparents = new List<parentsModel>();
            try
            {
                if (!APIUri.EndsWith("/"))
                    APIUri += "/";
                APIUri += "web-services/parents?date=" + LastSyncedOn.ToString("yyyy-MM-dd HH:mm:ss");
                lstparents = JsonConvert.DeserializeObject<List<parentsModel>>(httpGetWebRequest(APIUri));
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
        public static List<route_stopsModel> GetRouteStopsFromOnline(string APIUri, DateTime LastSyncedOn)
        {
            List<route_stopsModel> lstroute_stops = new List<route_stopsModel>();
            try
            {
                if (!APIUri.EndsWith("/"))
                    APIUri += "/";
                APIUri += "web-services/route_stops?date=" + LastSyncedOn.ToString("yyyy-MM-dd HH:mm:ss");
                lstroute_stops = JsonConvert.DeserializeObject<List<route_stopsModel>>(httpGetWebRequest(APIUri));
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
        public static List<route_vehicle_stopsModel> GetRouteVehicleStopsFromOnline(string APIUri, DateTime LastSyncedOn)
        {
            List<route_vehicle_stopsModel> lstroute_vehicle_stops = new List<route_vehicle_stopsModel>();
            try
            {
                if (!APIUri.EndsWith("/"))
                    APIUri += "/";
                APIUri += "web-services/route_vehicle_stops?date=" + LastSyncedOn.ToString("yyyy-MM-dd HH:mm:ss");
                lstroute_vehicle_stops = JsonConvert.DeserializeObject<List<route_vehicle_stopsModel>>(httpGetWebRequest(APIUri));
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
        public static List<route_vehicle_stops_fee_logsModel> GetRouteVehicleStopsFeeLogsFromOnline(string APIUri, DateTime LastSyncedOn)
        {
            List<route_vehicle_stops_fee_logsModel> lstroute_vehicle_stops_fee_logs = new List<route_vehicle_stops_fee_logsModel>();
            try
            {
                if (!APIUri.EndsWith("/"))
                    APIUri += "/";
                APIUri += "web-services/route_vehicle_stops_fee_logs?date=" + LastSyncedOn.ToString("yyyy-MM-dd HH:mm:ss");
                lstroute_vehicle_stops_fee_logs = JsonConvert.DeserializeObject<List<route_vehicle_stops_fee_logsModel>>(httpGetWebRequest(APIUri));
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
        public static List<route_vehiclesModel> GetRouteVehiclesFromOnline(string APIUri, DateTime LastSyncedOn)
        {
            List<route_vehiclesModel> lstroute_vehicles = new List<route_vehiclesModel>();
            try
            {
                if (!APIUri.EndsWith("/"))
                    APIUri += "/";
                APIUri += "web-services/route_vehicles?date=" + LastSyncedOn.ToString("yyyy-MM-dd HH:mm:ss");
                lstroute_vehicles = JsonConvert.DeserializeObject<List<route_vehiclesModel>>(httpGetWebRequest(APIUri));
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
        public static List<routesModel> GetRoutesFromOnline(string APIUri, DateTime LastSyncedOn)
        {
            List<routesModel> lstroutes = new List<routesModel>();
            try
            {
                if (!APIUri.EndsWith("/"))
                    APIUri += "/";
                APIUri += "web-services/routes?date=" + LastSyncedOn.ToString("yyyy-MM-dd HH:mm:ss");
                lstroutes = JsonConvert.DeserializeObject<List<routesModel>>(httpGetWebRequest(APIUri));
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
        public static List<sectionsModel> GetSectionsFromOnline(string APIUri, DateTime LastSyncedOn)
        {
            List<sectionsModel> lstSections = new List<sectionsModel>();
            try
            {
                if (!APIUri.EndsWith("/"))
                    APIUri += "/";
                APIUri += "web-services/sections?date=" + LastSyncedOn.ToString("yyyy-MM-dd HH:mm:ss");
                lstSections = JsonConvert.DeserializeObject<List<sectionsModel>>(httpGetWebRequest(APIUri));
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {

            }
            return lstSections;
        }
        public static List<sessionsModel> GetSessionsFromOnline(string APIUri, DateTime LastSyncedOn)
        {
            List<sessionsModel> lstsessions = new List<sessionsModel>();
            try
            {
                if (!APIUri.EndsWith("/"))
                    APIUri += "/";
                APIUri += "web-services/sessions?date=" + LastSyncedOn.ToString("yyyy-MM-dd HH:mm:ss");
                lstsessions = JsonConvert.DeserializeObject<List<sessionsModel>>(httpGetWebRequest(APIUri));
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
        public static List<student_feesModel> GetStudentFeesFromOnline(string APIUri, DateTime LastSyncedOn)
        {
            List<student_feesModel> lststudent_fees = new List<student_feesModel>();
            try
            {
                if (!APIUri.EndsWith("/"))
                    APIUri += "/";
                APIUri += "web-services/student_fees?date=" + LastSyncedOn.ToString("yyyy-MM-dd HH:mm:ss");
                lststudent_fees = JsonConvert.DeserializeObject<List<student_feesModel>>(httpGetWebRequest(APIUri));
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
        public static List<student_grade_session_logModel> GetStudentGradeSessionLogFromOnline(string APIUri, DateTime LastSyncedOn)
        {
            List<student_grade_session_logModel> lststudent_grade_session_log = new List<student_grade_session_logModel>();
            try
            {
                if (!APIUri.EndsWith("/"))
                    APIUri += "/";
                APIUri += "web-services/student_grade_session_log?date=" + LastSyncedOn.ToString("yyyy-MM-dd HH:mm:ss");
                lststudent_grade_session_log = JsonConvert.DeserializeObject<List<student_grade_session_logModel>>(httpGetWebRequest(APIUri));
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
        public static List<student_paymentsModel> GetStudentPaymentsFromOnline(string APIUri, DateTime LastSyncedOn)
        {
            List<student_paymentsModel> lststudent_payments = new List<student_paymentsModel>();
            try
            {
                if (!APIUri.EndsWith("/"))
                    APIUri += "/";
                APIUri += "web-services/student_payments?date=" + LastSyncedOn.ToString("yyyy-MM-dd HH:mm:ss");
                lststudent_payments = JsonConvert.DeserializeObject<List<student_paymentsModel>>(httpGetWebRequest(APIUri));
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
        public static List<studentsModel> GetStudentsFromOnline(string APIUri, DateTime LastSyncedOn)
        {
            List<studentsModel> lstStudents = new List<studentsModel>();
            try
            {
                if (!APIUri.EndsWith("/"))
                    APIUri += "/";
                APIUri += "web-services/students?date=" + LastSyncedOn.ToString("yyyy-MM-dd HH:mm:ss");
                lstStudents = JsonConvert.DeserializeObject<List<studentsModel>>(httpGetWebRequest(APIUri));
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {

            }
            return lstStudents;
        }
        public static List<trip_stopsModel> GetTripStopsFromOnline(string APIUri, DateTime LastSyncedOn)
        {
            List<trip_stopsModel> lsttrip_stops = new List<trip_stopsModel>();
            try
            {
                if (!APIUri.EndsWith("/"))
                    APIUri += "/";
                APIUri += "web-services/trip_stops?date=" + LastSyncedOn.ToString("yyyy-MM-dd HH:mm:ss");
                lsttrip_stops = JsonConvert.DeserializeObject<List<trip_stopsModel>>(httpGetWebRequest(APIUri));
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
        public static List<user_avatar_filesModel> GetUserAvatarFilesFromOnline(string APIUri, DateTime LastSyncedOn)
        {
            List<user_avatar_filesModel> lstuser_avatar_files = new List<user_avatar_filesModel>();
            try
            {
                if (!APIUri.EndsWith("/"))
                    APIUri += "/";
                APIUri += "web-services/user_avatar_files?date=" + LastSyncedOn.ToString("yyyy-MM-dd HH:mm:ss");
                lstuser_avatar_files = JsonConvert.DeserializeObject<List<user_avatar_filesModel>>(httpGetWebRequest(APIUri));
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
        public static List<usersModel> GetUsersFromOnline(string APIUri, DateTime LastSyncedOn)
        {
            List<usersModel> lstUsers = new List<usersModel>();
            try
            {
                if (!APIUri.EndsWith("/"))
                    APIUri += "/";
                APIUri += "web-services/users?date=" + LastSyncedOn.ToString("yyyy-MM-dd HH:mm:ss");
                lstUsers = JsonConvert.DeserializeObject<List<usersModel>>(httpGetWebRequest(APIUri));
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
        public static List<vehiclesModel> GetVehiclesFromOnline(string APIUri, DateTime LastSyncedOn)
        {
            List<vehiclesModel> lstvehicles = new List<vehiclesModel>();
            try
            {
                if (!APIUri.EndsWith("/"))
                    APIUri += "/";
                APIUri += "web-services/vehicles?date=" + LastSyncedOn.ToString("yyyy-MM-dd HH:mm:ss");
                lstvehicles = JsonConvert.DeserializeObject<List<vehiclesModel>>(httpGetWebRequest(APIUri));
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
        public static List<student_feesModel> GetStudentFeesFromOffline(DateTime LastSyncedOn)
        {
            try
            {
                List<SqlParameter> lstSqlParameters = new List<SqlParameter>()
                {
                    new SqlParameter() {ParameterName = "@Date", SqlDbType = SqlDbType.Date, Value = LastSyncedOn},
                };
                DataTable objDatatable = DataAccess.GetDataTable(StoredProcedures.GetStudentFeesForSync, lstSqlParameters);
                return MapDatatableToStudentFeesListObject(objDatatable);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {

            }
        }

        private static List<student_feesModel> MapDatatableToStudentFeesListObject(DataTable objDatatable)
        {

            List<student_feesModel> objStudentFeesList = new List<student_feesModel>();
            try
            {
                foreach (DataRow row in objDatatable.Rows)
                {
                    student_feesModel obj = new student_feesModel();
                    obj.id = row["id"] != DBNull.Value ? Convert.ToString(row["id"]) : string.Empty;
                    obj.school_id = row["school_id"] != DBNull.Value ? Convert.ToString(row["school_id"]) : string.Empty;
                    obj.grade_fees_id = row["grade_fees_id"] != DBNull.Value ? Convert.ToString(row["grade_fees_id"]) : string.Empty;
                    obj.student_id = row["student_id"] != DBNull.Value ? row["student_id"].ToString() : string.Empty;
                    obj.route_vehicle_stops_fee_log_id = row["route_vehicle_stops_fee_log_id"] != DBNull.Value ? row["route_vehicle_stops_fee_log_id"].ToString() : string.Empty;
                    obj.apply_from = row["apply_from"] != DBNull.Value ? Convert.ToDateTime(row["apply_from"]) : (DateTime?)null;
                    obj.apply_to = row["apply_to"] != DBNull.Value ? Convert.ToDateTime(row["apply_to"]) : (DateTime?)null;
                    obj.fine = row["fine"] != DBNull.Value ? Convert.ToDouble(row["fine"]) : 0;
                    obj.concession_amount = row["concession_amount"] != DBNull.Value ? Convert.ToDouble(row["concession_amount"]) : 0;
                    obj.no_fine = row["no_fine"] != DBNull.Value ? Convert.ToString(row["no_fine"]) : string.Empty;
                    obj.created_by = row["created_by"] != DBNull.Value ? row["created_by"].ToString() : string.Empty;
                    obj.created_on = row["created_on"] != DBNull.Value ? Convert.ToDateTime(row["created_on"]) : (DateTime?)null;
                    obj.updated_by = row["updated_by"] != DBNull.Value ? Convert.ToString(row["updated_by"]) : string.Empty;
                    obj.updated_on = row["updated_on"] != DBNull.Value ? Convert.ToDateTime(row["updated_on"]) : (DateTime?)null;

                    objStudentFeesList.Add(obj);
                }

            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {

            }
            return objStudentFeesList;
        }


        public static List<student_paymentsModel> GetStudentPaymentsFromOffline(DateTime LastSyncedOn)
        {
            try
            {
                List<SqlParameter> lstSqlParameters = new List<SqlParameter>()
                {
                    new SqlParameter() {ParameterName = "@Date", SqlDbType = SqlDbType.Date, Value = LastSyncedOn},
                };
                DataTable objDatatable = DataAccess.GetDataTable(StoredProcedures.GetStudentPaymentsForSync, lstSqlParameters);
                return MapDatatableToStudentPaymentsListObject(objDatatable);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {

            }
        }
        private static List<student_paymentsModel> MapDatatableToStudentPaymentsListObject(DataTable objDatatable)
        {

            List<student_paymentsModel> objStudentPaymentsList = new List<student_paymentsModel>();
            try
            {
                foreach (DataRow row in objDatatable.Rows)
                {
                    student_paymentsModel obj = new student_paymentsModel();
                    obj.id = row["id"] != DBNull.Value ? Convert.ToString(row["id"]) : string.Empty;
                    obj.offline_payment_id = row["offline_payment_id"] != DBNull.Value ? Convert.ToString(row["offline_payment_id"]) : string.Empty;
                    obj.school_id = row["school_id"] != DBNull.Value ? Convert.ToString(row["school_id"]) : string.Empty;
                    obj.student_fees_id = row["student_fees_id"] != DBNull.Value ? Convert.ToString(row["student_fees_id"]) : string.Empty;
                    obj.fine = row["fine"] != DBNull.Value ? Convert.ToDouble(row["fine"]) : 0;
                    obj.amount = row["amount"] != DBNull.Value ? Convert.ToDouble(row["amount"]) : 0;
                    obj.comment = row["comment"] != DBNull.Value ? Convert.ToString(row["comment"]) : string.Empty;
                    obj.recept_no = row["recept_no"] != DBNull.Value ? Convert.ToString(row["recept_no"]) : string.Empty;
                    obj.payment_mode = row["payment_mode"] != DBNull.Value ? Convert.ToString(row["payment_mode"]) : string.Empty;
                    obj.ip = row["ip"] != DBNull.Value ? Convert.ToString(row["ip"]) : string.Empty;
                    obj.payment_date = row["payment_date"] != DBNull.Value ? Convert.ToDateTime(row["payment_date"]) : (DateTime?)null;
                    obj.created_by = row["created_by"] != DBNull.Value ? row["created_by"].ToString() : string.Empty;
                    obj.created_on = row["created_on"] != DBNull.Value ? Convert.ToDateTime(row["created_on"]) : (DateTime?)null;
                    obj.updated_by = row["updated_by"] != DBNull.Value ? Convert.ToString(row["updated_by"]) : string.Empty;
                    obj.updated_on = row["updated_on"] != DBNull.Value ? Convert.ToDateTime(row["updated_on"]) : (DateTime?)null;

                    objStudentPaymentsList.Add(obj);
                }

            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {

            }
            return objStudentPaymentsList;
        }
        #endregion

        #region Sync Data

        #region 1. Users
        public static Boolean SyncUsersFromOnline(usersModel objUsers)
        {
            Boolean IsSuccess = false;
            try
            {
                DataTable objDatatable = MapUsersToDataTable(objUsers);
                SqlParameter objSqlParameter = new SqlParameter("@Model", SqlDbType.Structured);
                objSqlParameter.TypeName = DBTableTypes.users;
                objSqlParameter.Value = objDatatable;
                IsSuccess = DataAccess.ExecuteNonQuery(StoredProcedures.SyncUsers, objSqlParameter);

            }
            catch (Exception ex)
            {

            }
            finally
            {

            }
            return IsSuccess;
        }

        private static DataTable MapUsersToDataTable(usersModel obj)
        {
            try
            {
                DataTable table = new DataTable();
                table.Columns.Add("id", typeof(string));
                table.Columns.Add("school_id", typeof(string));
                table.Columns.Add("student_id", typeof(string));
                table.Columns.Add("role_id", typeof(string));
                table.Columns.Add("user_type", typeof(string));
                table.Columns.Add("username", typeof(string));
                table.Columns.Add("email", typeof(string));
                table.Columns.Add("phone", typeof(string));
                table.Columns.Add("address_line_one", typeof(string));
                table.Columns.Add("address_line_two", typeof(string));
                table.Columns.Add("area", typeof(string));
                table.Columns.Add("first_name", typeof(string));
                table.Columns.Add("middle_name", typeof(string));
                table.Columns.Add("last_name", typeof(string));
                table.Columns.Add("full_name", typeof(string));
                table.Columns.Add("gender", typeof(string));
                table.Columns.Add("blood_group", typeof(string));
                table.Columns.Add("password", typeof(string));
                table.Columns.Add("birth_date", typeof(DateTime));
                table.Columns.Add("other_phones", typeof(string));
                table.Columns.Add("default_phone_number_id", typeof(string));
                table.Columns.Add("adhaar_number", typeof(string));
                table.Columns.Add("bank_name", typeof(string));
                table.Columns.Add("bank_branch", typeof(string));
                table.Columns.Add("bank_account_number", typeof(string));
                table.Columns.Add("bank_ifsc_code", typeof(string));
                table.Columns.Add("flags", typeof(string));
                table.Columns.Add("last_login_time", typeof(DateTime));
                table.Columns.Add("user_avatar_file_id", typeof(string));
                table.Columns.Add("status", typeof(string));
                table.Columns.Add("created_on", typeof(DateTime));
                table.Columns.Add("created_by", typeof(string));
                table.Columns.Add("updated_on", typeof(DateTime));
                table.Columns.Add("updated_by", typeof(string));

                table.Rows.Add(
                                obj.id,
                                obj.school_id,
                                obj.student_id,
                                obj.role_id,
                                obj.user_type,
                                obj.username,
                                obj.email,
                                obj.phone,
                                obj.address_line_one,
                                obj.address_line_two,
                                obj.area,
                                obj.first_name,
                                obj.middle_name,
                                obj.last_name,
                                obj.full_name,
                                obj.gender,
                                obj.blood_group,
                                obj.password,
                                obj.birth_date,
                                obj.other_phones,
                                obj.default_phone_number_id,
                                obj.adhaar_number,
                                obj.bank_name,
                                obj.bank_branch,
                                obj.bank_account_number,
                                obj.bank_ifsc_code,
                                obj.flags,
                                obj.last_login_time,
                                obj.user_avatar_file_id,
                                obj.status,
                                obj.created_on,
                                obj.created_by,
                                obj.updated_on,
                                obj.updated_by
                             );
                return table;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {

            }
        }

        public static Boolean SyncUser_avatar_filesFromOnline(user_avatar_filesModel objUser_avatar_files)
        {
            Boolean IsSuccess = false;
            try
            {
                DataTable objDatatable = MapUser_avatar_filesToDataTable(objUser_avatar_files);
                SqlParameter objSqlParameter = new SqlParameter("@Model", SqlDbType.Structured);
                objSqlParameter.TypeName = DBTableTypes.user_avatar_files;
                objSqlParameter.Value = objDatatable;
                IsSuccess = DataAccess.ExecuteNonQuery(StoredProcedures.SyncUser_avatar_files, objSqlParameter);

            }
            catch (Exception ex)
            {

            }
            finally
            {

            }
            return IsSuccess;
        }

        private static DataTable MapUser_avatar_filesToDataTable(user_avatar_filesModel obj)
        {
            try
            {
                DataTable table = new DataTable();
                table.Columns.Add("id", typeof(string));
                table.Columns.Add("school_id", typeof(string));
                table.Columns.Add("user_id", typeof(string));
                table.Columns.Add("applicant_id", typeof(string));
                table.Columns.Add("file_id", typeof(string));

                table.Rows.Add(
                                obj.id,
                                obj.school_id,
                                obj.user_id,
                                obj.applicant_id,
                                obj.file_id
                             );
                return table;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {

            }
        }

        public static Boolean SyncFilesFromOnline(filesModel objFiles)
        {
            Boolean IsSuccess = false;
            try
            {
                DataTable objDatatable = MapFilesToDataTable(objFiles);
                SqlParameter objSqlParameter = new SqlParameter("@Model", SqlDbType.Structured);
                objSqlParameter.TypeName = DBTableTypes.files;
                objSqlParameter.Value = objDatatable;
                IsSuccess = DataAccess.ExecuteNonQuery(StoredProcedures.SyncFiles, objSqlParameter);

            }
            catch (Exception ex)
            {

            }
            finally
            {

            }
            return IsSuccess;
        }

        private static DataTable MapFilesToDataTable(filesModel obj)
        {
            try
            {
                DataTable table = new DataTable();
                table.Columns.Add("id", typeof(string));
                table.Columns.Add("name", typeof(string));
                table.Columns.Add("extension", typeof(string));
                table.Columns.Add("size", typeof(string));
                table.Columns.Add("school_id", typeof(string));
                table.Columns.Add("owner_user_id", typeof(string));
                table.Columns.Add("created", typeof(DateTime));

                table.Rows.Add(
                                obj.id,
                                obj.name,
                                obj.extension,
                                obj.size,
                                obj.school_id,
                                obj.owner_user_id,
                                obj.created);
                return table;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {

            }
        }
        #endregion

        #region 2. Students
        public static Boolean SyncStudentsFromOnline(studentsModel objStudents)
        {
            Boolean IsSuccess = false;
            try
            {
                DataTable objDatatable = MapStudentsToDataTable(objStudents);
                SqlParameter objSqlParameter = new SqlParameter("@Model", SqlDbType.Structured);
                objSqlParameter.TypeName = DBTableTypes.students;
                objSqlParameter.Value = objDatatable;
                IsSuccess = DataAccess.ExecuteNonQuery(StoredProcedures.SyncStudents, objSqlParameter);

            }
            catch (Exception ex)
            {

            }
            finally
            {

            }
            return IsSuccess;
        }
        private static DataTable MapStudentsToDataTable(studentsModel obj)
        {
            try
            {
                DataTable table = new DataTable();
                table.Columns.Add("id", typeof(string));
                table.Columns.Add("school_id", typeof(string));
                table.Columns.Add("user_id", typeof(string));
                table.Columns.Add("parent_id", typeof(string));
                table.Columns.Add("grade_id", typeof(string));
                table.Columns.Add("section_id", typeof(string));
                table.Columns.Add("session_id", typeof(string));
                table.Columns.Add("trip_stop_id", typeof(string));
                table.Columns.Add("registration_id", typeof(string));
                table.Columns.Add("roll_number", typeof(string));
                table.Columns.Add("exam_roll_number", typeof(string));
                table.Columns.Add("enrollment_date", typeof(DateTime));
                table.Columns.Add("status", typeof(string));
                table.Columns.Add("dc_number", typeof(string));
                table.Columns.Add("dc_date_of_issue", typeof(string));
                table.Columns.Add("created_by", typeof(string));
                table.Columns.Add("created_on", typeof(DateTime));
                table.Columns.Add("updated_by", typeof(string));
                table.Columns.Add("updated_on", typeof(DateTime));

                table.Rows.Add(
                                obj.id,
                                obj.school_id,
                                obj.user_id,
                                obj.parent_id,
                                obj.grade_id,
                                obj.section_id,
                                obj.session_id,
                                obj.trip_stop_id,
                                obj.registration_id,
                                obj.roll_number,
                                obj.exam_roll_number,
                                obj.enrollment_date,
                                obj.status,
                                obj.dc_number,
                                obj.dc_date_of_issue,
                                obj.created_by,
                                obj.created_on,
                                obj.updated_by,
                                obj.updated_on
                              );
                return table;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {

            }
        }

        public static Boolean SyncParentsFromOnline(parentsModel objParents)
        {
            Boolean IsSuccess = false;
            try
            {
                DataTable objDatatable = MapParentsToDataTable(objParents);
                SqlParameter objSqlParameter = new SqlParameter("@Model", SqlDbType.Structured);
                objSqlParameter.TypeName = DBTableTypes.parents;
                objSqlParameter.Value = objDatatable;
                IsSuccess = DataAccess.ExecuteNonQuery(StoredProcedures.SyncParents, objSqlParameter);

            }
            catch (Exception ex)
            {

            }
            finally
            {

            }
            return IsSuccess;
        }
        private static DataTable MapParentsToDataTable(parentsModel obj)
        {
            try
            {
                DataTable table = new DataTable();
                table.Columns.Add("id", typeof(string));
                table.Columns.Add("school_id", typeof(string));
                table.Columns.Add("f_first_name", typeof(string));
                table.Columns.Add("f_middle_name", typeof(string));
                table.Columns.Add("f_last_name", typeof(string));
                table.Columns.Add("f_mobile", typeof(string));
                table.Columns.Add("f_phone", typeof(string));
                table.Columns.Add("f_office", typeof(string));
                table.Columns.Add("f_email", typeof(string));
                table.Columns.Add("m_first_name", typeof(string));
                table.Columns.Add("m_middle_name", typeof(string));
                table.Columns.Add("m_last_name", typeof(string));
                table.Columns.Add("m_mobile", typeof(string));
                table.Columns.Add("m_phone", typeof(string));
                table.Columns.Add("m_office", typeof(string));
                table.Columns.Add("m_email", typeof(string));
                table.Columns.Add("g_fullname", typeof(string));
                table.Columns.Add("g_mobile", typeof(string));
                table.Columns.Add("g_email", typeof(string));

                table.Rows.Add(
                                obj.id,
                                obj.school_id,
                                obj.f_first_name,
                                obj.f_middle_name,
                                obj.f_last_name,
                                obj.f_mobile,
                                obj.f_phone,
                                obj.f_office,
                                obj.f_email,
                                obj.m_first_name,
                                obj.m_middle_name,
                                obj.m_last_name,
                                obj.m_mobile,
                                obj.m_phone,
                                obj.m_office,
                                obj.m_email,
                                obj.g_fullname,
                                obj.g_mobile,
                                obj.g_email
                              );
                return table;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {

            }
        }

        #endregion

        #region 3. Grades
        public static Boolean SyncGradesFromOnline(gradesModel objGrades)
        {
            Boolean IsSuccess = false;
            try
            {
                DataTable objDatatable = MapGradesToDataTable(objGrades);
                SqlParameter objSqlParameter = new SqlParameter("@Model", SqlDbType.Structured);
                objSqlParameter.TypeName = DBTableTypes.grades;
                objSqlParameter.Value = objDatatable;
                IsSuccess = DataAccess.ExecuteNonQuery(StoredProcedures.SyncGrades, objSqlParameter);

            }
            catch (Exception ex)
            {

            }
            finally
            {

            }
            return IsSuccess;
        }
        private static DataTable MapGradesToDataTable(gradesModel obj)
        {
            try
            {
                DataTable table = new DataTable();
                table.Columns.Add("id", typeof(string));
                table.Columns.Add("school_id", typeof(string));
                table.Columns.Add("block", typeof(string));
                table.Columns.Add("name", typeof(string));
                table.Columns.Add("order", typeof(string));
                table.Columns.Add("created_by", typeof(string));
                table.Columns.Add("created_on", typeof(DateTime));
                table.Columns.Add("updated_by", typeof(string));
                table.Columns.Add("updated_on", typeof(DateTime));

                table.Rows.Add(
                                obj.id,
                                obj.school_id,
                                obj.block,
                                obj.name,
                                obj.order,
                                obj.created_by,
                                obj.created_on,
                                obj.updated_by,
                                obj.updated_on

                              );
                return table;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {

            }
        }

        public static Boolean SyncSectionsFromOnline(sectionsModel objSections)
        {
            Boolean IsSuccess = false;
            try
            {
                DataTable objDatatable = MapSectionsToDataTable(objSections);
                SqlParameter objSqlParameter = new SqlParameter("@Model", SqlDbType.Structured);
                objSqlParameter.TypeName = DBTableTypes.sections;
                objSqlParameter.Value = objDatatable;
                IsSuccess = DataAccess.ExecuteNonQuery(StoredProcedures.SyncSections, objSqlParameter);

            }
            catch (Exception ex)
            {

            }
            finally
            {

            }
            return IsSuccess;
        }
        private static DataTable MapSectionsToDataTable(sectionsModel obj)
        {
            try
            {
                DataTable table = new DataTable();
                table.Columns.Add("id", typeof(string));
                table.Columns.Add("school_id", typeof(string));
                table.Columns.Add("name", typeof(string));
                table.Columns.Add("capacity", typeof(string));
                table.Columns.Add("created_by", typeof(string));
                table.Columns.Add("created_on", typeof(DateTime));

                table.Rows.Add(
                                obj.id,
                                obj.school_id,
                                obj.name,
                                obj.capacity,
                                obj.created_by,
                                obj.created_on

                              );
                return table;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {

            }
        }

        public static Boolean SyncSessionsFromOnline(sessionsModel objSessions)
        {
            Boolean IsSuccess = false;
            try
            {
                DataTable objDatatable = MapSessionsToDataTable(objSessions);
                SqlParameter objSqlParameter = new SqlParameter("@Model", SqlDbType.Structured);
                objSqlParameter.TypeName = DBTableTypes.sessions;
                objSqlParameter.Value = objDatatable;
                IsSuccess = DataAccess.ExecuteNonQuery(StoredProcedures.SyncSessions, objSqlParameter);

            }
            catch (Exception ex)
            {

            }
            finally
            {

            }
            return IsSuccess;
        }
        private static DataTable MapSessionsToDataTable(sessionsModel obj)
        {
            try
            {
                DataTable table = new DataTable();
                table.Columns.Add("id", typeof(string));
                table.Columns.Add("school_id", typeof(string));
                table.Columns.Add("name", typeof(string));
                table.Columns.Add("order", typeof(string));
                table.Columns.Add("from_date", typeof(DateTime));
                table.Columns.Add("to_date", typeof(DateTime));
                table.Columns.Add("created_by", typeof(string));
                table.Columns.Add("created_on", typeof(DateTime));

                table.Rows.Add(
                                obj.id,
                                obj.school_id,
                                obj.name,
                                obj.order,
                                obj.from_date,
                                obj.to_date,
                                obj.created_by,
                                obj.created_on

                              );
                return table;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {

            }
        }

        public static Boolean SyncStudent_grade_session_logFromOnline(student_grade_session_logModel objStudent_grade_session_log)
        {
            Boolean IsSuccess = false;
            try
            {
                DataTable objDatatable = MapStudent_grade_session_logToDataTable(objStudent_grade_session_log);
                SqlParameter objSqlParameter = new SqlParameter("@Model", SqlDbType.Structured);
                objSqlParameter.TypeName = DBTableTypes.student_grade_session_log;
                objSqlParameter.Value = objDatatable;
                IsSuccess = DataAccess.ExecuteNonQuery(StoredProcedures.SyncStudent_grade_session_log, objSqlParameter);

            }
            catch (Exception ex)
            {

            }
            finally
            {

            }
            return IsSuccess;
        }
        private static DataTable MapStudent_grade_session_logToDataTable(student_grade_session_logModel obj)
        {
            try
            {
                DataTable table = new DataTable();
                table.Columns.Add("id", typeof(string));
                table.Columns.Add("school_id", typeof(string));
                table.Columns.Add("student_id", typeof(string));
                table.Columns.Add("registration_id", typeof(string));
                table.Columns.Add("grade_id", typeof(string));
                table.Columns.Add("section_id", typeof(string));
                table.Columns.Add("roll_number", typeof(string));
                table.Columns.Add("exam_roll_number", typeof(string));
                table.Columns.Add("session_id", typeof(string));
                table.Columns.Add("sgsl_status", typeof(string));
                table.Columns.Add("created_by", typeof(string));
                table.Columns.Add("created_on", typeof(DateTime));
                table.Columns.Add("updated_by", typeof(string));
                table.Columns.Add("updated_on", typeof(DateTime));

                table.Rows.Add(
                                obj.id,
                                obj.school_id,
                                obj.student_id,
                                obj.registration_id,
                                obj.grade_id,
                                obj.section_id,
                                obj.roll_number,
                                obj.exam_roll_number,
                                obj.session_id,
                                obj.sgsl_status,
                                obj.created_by,
                                obj.created_on,
                                obj.updated_by,
                                obj.updated_on

                              );
                return table;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {

            }
        }
        #endregion

        #region 4. Transportation
        public static Boolean SyncVehiclesFromOnline(vehiclesModel objVehicles)
        {
            Boolean IsSuccess = false;
            try
            {
                DataTable objDatatable = MapVehiclesToDataTable(objVehicles);
                SqlParameter objSqlParameter = new SqlParameter("@Model", SqlDbType.Structured);
                objSqlParameter.TypeName = DBTableTypes.vehicles;
                objSqlParameter.Value = objDatatable;
                IsSuccess = DataAccess.ExecuteNonQuery(StoredProcedures.SyncVehicles, objSqlParameter);

            }
            catch (Exception ex)
            {

            }
            finally
            {

            }
            return IsSuccess;
        }
        private static DataTable MapVehiclesToDataTable(vehiclesModel obj)
        {
            try
            {
                DataTable table = new DataTable();
                table.Columns.Add("id", typeof(string));
                table.Columns.Add("school_id", typeof(string));
                table.Columns.Add("tracker_id", typeof(string));
                table.Columns.Add("registration_number", typeof(string));
                table.Columns.Add("bus_number", typeof(string));
                table.Columns.Add("insurance_renew_date", typeof(DateTime));
                table.Columns.Add("staff_id", typeof(string));
                table.Columns.Add("created_by", typeof(string));
                table.Columns.Add("created_on", typeof(DateTime));
                table.Columns.Add("updated_by", typeof(string));
                table.Columns.Add("updated_on", typeof(DateTime));

                table.Rows.Add(
                                obj.id,
                                obj.school_id,
                                obj.tracker_id,
                                obj.registration_number,
                                obj.bus_number,
                                obj.insurance_renew_date,
                                obj.staff_id,
                                obj.created_by,
                                obj.created_on,
                                obj.updated_by,
                                obj.updated_on
                              );
                return table;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {

            }
        }

        public static Boolean SyncRoutesFromOnline(routesModel objRoutes)
        {
            Boolean IsSuccess = false;
            try
            {
                DataTable objDatatable = MapRoutesToDataTable(objRoutes);
                SqlParameter objSqlParameter = new SqlParameter("@Model", SqlDbType.Structured);
                objSqlParameter.TypeName = DBTableTypes.routes;
                objSqlParameter.Value = objDatatable;
                IsSuccess = DataAccess.ExecuteNonQuery(StoredProcedures.SyncRoutes, objSqlParameter);

            }
            catch (Exception ex)
            {

            }
            finally
            {

            }
            return IsSuccess;
        }
        private static DataTable MapRoutesToDataTable(routesModel obj)
        {
            try
            {
                DataTable table = new DataTable();
                table.Columns.Add("id", typeof(string));
                table.Columns.Add("school_id", typeof(string));
                table.Columns.Add("name", typeof(string));
                table.Columns.Add("start_location", typeof(string));
                table.Columns.Add("end_location", typeof(string));
                table.Columns.Add("created_by", typeof(string));
                table.Columns.Add("created_on", typeof(DateTime));
                table.Columns.Add("updated_by", typeof(string));
                table.Columns.Add("updated_on", typeof(DateTime));

                table.Rows.Add(
                                obj.id,
                                obj.school_id,
                                obj.name,
                                obj.start_location,
                                obj.end_location,
                                obj.created_by,
                                obj.created_on,
                                obj.updated_by,
                                obj.updated_on

                              );
                return table;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {

            }
        }

        public static Boolean SyncRoute_stopsFromOnline(route_stopsModel objRoute_stops)
        {
            Boolean IsSuccess = false;
            try
            {
                DataTable objDatatable = MapRoute_stopsToDataTable(objRoute_stops);
                SqlParameter objSqlParameter = new SqlParameter("@Model", SqlDbType.Structured);
                objSqlParameter.TypeName = DBTableTypes.route_stops;
                objSqlParameter.Value = objDatatable;
                IsSuccess = DataAccess.ExecuteNonQuery(StoredProcedures.SyncRoute_stops, objSqlParameter);

            }
            catch (Exception ex)
            {

            }
            finally
            {

            }
            return IsSuccess;
        }
        private static DataTable MapRoute_stopsToDataTable(route_stopsModel obj)
        {
            try
            {
                DataTable table = new DataTable();
                table.Columns.Add("id", typeof(string));
                table.Columns.Add("school_id", typeof(string));
                table.Columns.Add("route_id", typeof(string));
                table.Columns.Add("name", typeof(string));
                table.Columns.Add("latitude", typeof(string));
                table.Columns.Add("longitude", typeof(string));
                table.Columns.Add("created_by", typeof(string));
                table.Columns.Add("created_on", typeof(DateTime));
                table.Columns.Add("updated_by", typeof(string));
                table.Columns.Add("updated_on", typeof(DateTime));

                table.Rows.Add(
                                obj.id,
                                obj.school_id,
                                obj.route_id,
                                obj.name,
                                obj.latitude,
                                obj.longitude,
                                obj.created_by,
                                obj.created_on,
                                obj.updated_by,
                                obj.updated_on
                              );
                return table;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {

            }
        }

        public static Boolean SyncRoute_vehiclesFromOnline(route_vehiclesModel objRoute_vehicles)
        {
            Boolean IsSuccess = false;
            try
            {
                DataTable objDatatable = MapRoute_vehiclesToDataTable(objRoute_vehicles);
                SqlParameter objSqlParameter = new SqlParameter("@Model", SqlDbType.Structured);
                objSqlParameter.TypeName = DBTableTypes.route_vehicles;
                objSqlParameter.Value = objDatatable;
                IsSuccess = DataAccess.ExecuteNonQuery(StoredProcedures.SyncRoute_vehicles, objSqlParameter);

            }
            catch (Exception ex)
            {

            }
            finally
            {

            }
            return IsSuccess;
        }
        private static DataTable MapRoute_vehiclesToDataTable(route_vehiclesModel obj)
        {
            try
            {
                DataTable table = new DataTable();
                table.Columns.Add("id", typeof(string));
                table.Columns.Add("school_id", typeof(string));
                table.Columns.Add("vehicle_id", typeof(string));
                table.Columns.Add("route_id", typeof(string));

                table.Rows.Add(
                                obj.id,
                                obj.school_id,
                                obj.vehicle_id,
                                obj.route_id

                              );
                return table;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {

            }
        }

        public static Boolean SyncRoute_vehicle_stopsFromOnline(route_vehicle_stopsModel objRoute_vehicle_stops)
        {
            Boolean IsSuccess = false;
            try
            {
                DataTable objDatatable = MapRoute_vehicle_stopsToDataTable(objRoute_vehicle_stops);
                SqlParameter objSqlParameter = new SqlParameter("@Model", SqlDbType.Structured);
                objSqlParameter.TypeName = DBTableTypes.route_vehicle_stops;
                objSqlParameter.Value = objDatatable;
                IsSuccess = DataAccess.ExecuteNonQuery(StoredProcedures.SyncRoute_vehicle_stops, objSqlParameter);

            }
            catch (Exception ex)
            {

            }
            finally
            {

            }
            return IsSuccess;
        }
        private static DataTable MapRoute_vehicle_stopsToDataTable(route_vehicle_stopsModel obj)
        {
            try
            {
                DataTable table = new DataTable();
                table.Columns.Add("id", typeof(string));
                table.Columns.Add("school_id", typeof(string));
                table.Columns.Add("route_vehicle_id", typeof(string));
                table.Columns.Add("route_stop_id", typeof(string));

                table.Rows.Add(
                                obj.id,
                                obj.school_id,
                                obj.route_vehicle_id,
                                obj.route_stop_id
                              );
                return table;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {

            }
        }

        public static Boolean SyncTrip_stopsFromOnline(trip_stopsModel objTrip_stops)
        {
            Boolean IsSuccess = false;
            try
            {
                DataTable objDatatable = MapTrip_stopsToDataTable(objTrip_stops);
                SqlParameter objSqlParameter = new SqlParameter("@Model", SqlDbType.Structured);
                objSqlParameter.TypeName = DBTableTypes.trip_stops;
                objSqlParameter.Value = objDatatable;
                IsSuccess = DataAccess.ExecuteNonQuery(StoredProcedures.SyncTrip_stops, objSqlParameter);

            }
            catch (Exception ex)
            {

            }
            finally
            {

            }
            return IsSuccess;
        }
        private static DataTable MapTrip_stopsToDataTable(trip_stopsModel obj)
        {
            try
            {
                DataTable table = new DataTable();
                table.Columns.Add("id", typeof(string));
                table.Columns.Add("school_id", typeof(string));
                table.Columns.Add("route_vehicle_stop_id", typeof(string));
                table.Columns.Add("trip", typeof(string));
                table.Columns.Add("pick", typeof(string));
                table.Columns.Add("drop", typeof(string));

                table.Rows.Add(
                                obj.id,
                                obj.school_id,
                                obj.route_vehicle_stop_id,
                                obj.trip,
                                obj.pick,
                                obj.drop
                              );
                return table;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {

            }
        }
        #endregion

        #region 5. Fees

        public static Boolean SyncFee_categoriesFromOnline(fee_categoriesModel objFee_categories)
        {
            Boolean IsSuccess = false;
            try
            {
                DataTable objDatatable = MapFee_categoriesToDataTable(objFee_categories);
                SqlParameter objSqlParameter = new SqlParameter("@Model", SqlDbType.Structured);
                objSqlParameter.TypeName = DBTableTypes.fee_categories;
                objSqlParameter.Value = objDatatable;
                IsSuccess = DataAccess.ExecuteNonQuery(StoredProcedures.SyncFee_categories, objSqlParameter);

            }
            catch (Exception ex)
            {

            }
            finally
            {

            }
            return IsSuccess;
        }
        private static DataTable MapFee_categoriesToDataTable(fee_categoriesModel obj)
        {
            try
            {
                DataTable table = new DataTable();
                table.Columns.Add("id", typeof(string));
                table.Columns.Add("school_id", typeof(string));
                table.Columns.Add("name", typeof(string));
                table.Columns.Add("recur", typeof(string));
                table.Columns.Add("is_transport", typeof(string));
                table.Columns.Add("order", typeof(string));
                table.Columns.Add("created_by", typeof(string));
                table.Columns.Add("created_on", typeof(DateTime));
                table.Columns.Add("updated_by", typeof(string));
                table.Columns.Add("updated_on", typeof(DateTime));

                table.Rows.Add(
                                obj.id,
                                obj.school_id,
                                obj.name,
                                obj.recur,
                                obj.is_transport,
                                obj.order,
                                obj.created_by,
                                obj.created_on,
                                obj.updated_by,
                                obj.updated_on
                              );
                return table;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {

            }
        }

        public static Boolean SyncFeesFromOnline(feesModel objFees)
        {
            Boolean IsSuccess = false;
            try
            {
                DataTable objDatatable = MapFeesToDataTable(objFees);
                SqlParameter objSqlParameter = new SqlParameter("@Model", SqlDbType.Structured);
                objSqlParameter.TypeName = DBTableTypes.fees;
                objSqlParameter.Value = objDatatable;
                IsSuccess = DataAccess.ExecuteNonQuery(StoredProcedures.SyncFees, objSqlParameter);

            }
            catch (Exception ex)
            {

            }
            finally
            {

            }
            return IsSuccess;
        }
        private static DataTable MapFeesToDataTable(feesModel obj)
        {
            try
            {
                DataTable table = new DataTable();
                table.Columns.Add("id", typeof(string));
                table.Columns.Add("school_id", typeof(string));
                table.Columns.Add("fee_category_id", typeof(string));
                table.Columns.Add("session_id", typeof(string));
                table.Columns.Add("amount", typeof(Double));
                table.Columns.Add("fee_cources", typeof(string));
                table.Columns.Add("last_date", typeof(DateTime));
                table.Columns.Add("last_day", typeof(string));
                table.Columns.Add("fine_per_day", typeof(Double));
                table.Columns.Add("is_allocated", typeof(string));
                table.Columns.Add("remarks", typeof(string));
                table.Columns.Add("created_by", typeof(string));
                table.Columns.Add("created_on", typeof(DateTime));
                table.Columns.Add("updated_by", typeof(string));
                table.Columns.Add("updated_on", typeof(DateTime));

                table.Rows.Add(
                                obj.id,
                                obj.school_id,
                                obj.fee_category_id,
                                obj.session_id,
                                obj.amount,
                                obj.fee_cources,
                                obj.last_date,
                                obj.last_day,
                                obj.fine_per_day,
                                obj.is_allocated,
                                obj.remarks,
                                obj.created_by,
                                obj.created_on,
                                obj.updated_by,
                                obj.updated_on
                              );
                return table;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {

            }
        }

        public static Boolean SyncGrade_feesFromOnline(grade_feesModel objGrade_fees)
        {
            Boolean IsSuccess = false;
            try
            {
                DataTable objDatatable = MapGrade_feesToDataTable(objGrade_fees);
                SqlParameter objSqlParameter = new SqlParameter("@Model", SqlDbType.Structured);
                objSqlParameter.TypeName = DBTableTypes.grade_fees;
                objSqlParameter.Value = objDatatable;
                IsSuccess = DataAccess.ExecuteNonQuery(StoredProcedures.SyncGrade_fees, objSqlParameter);

            }
            catch (Exception ex)
            {

            }
            finally
            {

            }
            return IsSuccess;
        }
        private static DataTable MapGrade_feesToDataTable(grade_feesModel obj)
        {
            try
            {
                DataTable table = new DataTable();
                table.Columns.Add("id", typeof(string));
                table.Columns.Add("school_id", typeof(string));
                table.Columns.Add("fees_id", typeof(string));
                table.Columns.Add("grade_id", typeof(string));
                table.Columns.Add("created_by", typeof(string));
                table.Columns.Add("created_on", typeof(DateTime));
                table.Columns.Add("updated_by", typeof(string));
                table.Columns.Add("updated_on", typeof(DateTime));

                table.Rows.Add(
                                obj.id,
                                obj.school_id,
                                obj.fees_id,
                                obj.grade_id,
                                obj.created_by,
                                obj.created_on,
                                obj.updated_by,
                                obj.updated_on
                              );
                return table;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {

            }
        }

        public static Boolean SyncStudent_feesFromOnline(student_feesModel objStudent_fees)
        {
            Boolean IsSuccess = false;
            try
            {
                DataTable objDatatable = MapStudent_feesToDataTable(objStudent_fees);
                SqlParameter objSqlParameter = new SqlParameter("@Model", SqlDbType.Structured);
                objSqlParameter.TypeName = DBTableTypes.student_fees;
                objSqlParameter.Value = objDatatable;
                IsSuccess = DataAccess.ExecuteNonQuery(StoredProcedures.SyncStudent_fees, objSqlParameter);

            }
            catch (Exception ex)
            {

            }
            finally
            {

            }
            return IsSuccess;
        }
        public static Boolean SyncStudent_feesFromOffline(string APIUri, List<student_feesModel> lstStudent_fees)
        {
            Boolean IsSuccess = false;
            try
            {
                if (!APIUri.EndsWith("/"))
                    APIUri += "/";
                APIUri += "web-services/student_fees_post";
                var postData = "data=";
                postData += JsonConvert.SerializeObject(lstStudent_fees);
                httpPostWebRequest(APIUri, postData);
                IsSuccess = true;
            }
            catch (Exception ex)
            {

            }
            finally
            {

            }
            return IsSuccess;
        }
        private static DataTable MapStudent_feesToDataTable(student_feesModel obj)
        {
            try
            {
                DataTable table = new DataTable();
                table.Columns.Add("id", typeof(string));
                table.Columns.Add("school_id", typeof(string));
                table.Columns.Add("grade_fees_id", typeof(string));
                table.Columns.Add("student_id", typeof(string));
                table.Columns.Add("route_vehicle_stops_fee_log_id", typeof(string));
                table.Columns.Add("apply_from", typeof(DateTime));
                table.Columns.Add("apply_to", typeof(DateTime));
                table.Columns.Add("fine", typeof(Double));
                table.Columns.Add("concession_amount", typeof(Double));
                table.Columns.Add("no_fine", typeof(string));
                table.Columns.Add("created_by", typeof(string));
                table.Columns.Add("created_on", typeof(DateTime));
                table.Columns.Add("updated_by", typeof(string));
                table.Columns.Add("updated_on", typeof(DateTime));

                table.Rows.Add(
                                obj.id,
                                obj.school_id,
                                obj.grade_fees_id,
                                obj.student_id,
                                obj.route_vehicle_stops_fee_log_id,
                                obj.apply_from,
                                obj.apply_to,
                                obj.fine,
                                obj.concession_amount,
                                obj.no_fine,
                                obj.created_by,
                                obj.created_on,
                                obj.updated_by,
                                obj.updated_on
                              );
                return table;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {

            }
        }

        public static Boolean SyncRoute_vehicle_stops_fee_logsFromOnline(route_vehicle_stops_fee_logsModel objRoute_vehicle_stops_fee_logs)
        {
            Boolean IsSuccess = false;
            try
            {
                DataTable objDatatable = MapRoute_vehicle_stops_fee_logsToDataTable(objRoute_vehicle_stops_fee_logs);
                SqlParameter objSqlParameter = new SqlParameter("@Model", SqlDbType.Structured);
                objSqlParameter.TypeName = DBTableTypes.route_vehicle_stops_fee_logs;
                objSqlParameter.Value = objDatatable;
                IsSuccess = DataAccess.ExecuteNonQuery(StoredProcedures.SyncRoute_vehicle_stops_fee_logs, objSqlParameter);

            }
            catch (Exception ex)
            {

            }
            finally
            {

            }
            return IsSuccess;
        }
        private static DataTable MapRoute_vehicle_stops_fee_logsToDataTable(route_vehicle_stops_fee_logsModel obj)
        {
            try
            {
                DataTable table = new DataTable();
                table.Columns.Add("id", typeof(string));
                table.Columns.Add("route_vehicle_stop_id", typeof(string));
                table.Columns.Add("fees_id", typeof(string));

                table.Rows.Add(
                                obj.id,
                                obj.route_vehicle_stop_id,
                                obj.fees_id
                              );
                return table;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {

            }
        }
        #endregion

        #region 6. Payments
        public static Boolean SyncStudent_paymentsFromOnline(student_paymentsModel objStudent_payments)
        {
            Boolean IsSuccess = false;
            try
            {
                if(objStudent_payments.offline_payment_id == null)
                    objStudent_payments.offline_payment_id = Guid.NewGuid().ToString();
                DataTable objDatatable = MapStudent_paymentsToDataTable(objStudent_payments);
                SqlParameter objSqlParameter = new SqlParameter("@Model", SqlDbType.Structured);
                objSqlParameter.TypeName = DBTableTypes.student_payments;
                objSqlParameter.Value = objDatatable;
                IsSuccess = DataAccess.ExecuteNonQuery(StoredProcedures.SyncStudent_payments, objSqlParameter);

            }
            catch (Exception ex)
            {

            }
            finally
            {

            }
            return IsSuccess;
        }
        public static Boolean SyncStudent_paymentsFromOffline(string APIUri, List<student_paymentsModel> lstStudent_payments)
        {
            Boolean IsSuccess = false;
            try
            {
                if (!APIUri.EndsWith("/"))
                    APIUri += "/";
                APIUri += "web-services/fees_payments_post";
                var postData = "data=";
                postData += JsonConvert.SerializeObject(lstStudent_payments);
                httpPostWebRequest(APIUri, postData);
                IsSuccess = true;
            }
            catch (Exception ex)
            {

            }
            finally
            {

            }
            return IsSuccess;
        }

        private static DataTable MapStudent_paymentsToDataTable(student_paymentsModel objPaymentHistoryModel)
        {
            try
            {
                DataTable table = new DataTable();
                table.Columns.Add("offline_payment_id", typeof(Guid));
                table.Columns.Add("id", typeof(string));
                table.Columns.Add("school_id", typeof(string));
                table.Columns.Add("student_fees_id", typeof(string));
                table.Columns.Add("amount", typeof(Double));
                table.Columns.Add("fine", typeof(Double));
                table.Columns.Add("comment", typeof(string));
                table.Columns.Add("recept_no", typeof(string));
                table.Columns.Add("payment_mode", typeof(string));
                table.Columns.Add("payment_date", typeof(DateTime));
                table.Columns.Add("ip", typeof(string));
                table.Columns.Add("created_by", typeof(string));
                table.Columns.Add("created_on", typeof(DateTime));
                table.Columns.Add("updated_by", typeof(string));
                table.Columns.Add("updated_on", typeof(DateTime));

                table.Rows.Add(
                                objPaymentHistoryModel.offline_payment_id,
                                objPaymentHistoryModel.id,
                                objPaymentHistoryModel.school_id,
                                objPaymentHistoryModel.student_fees_id,
                                objPaymentHistoryModel.amount,
                                objPaymentHistoryModel.fine,
                                objPaymentHistoryModel.comment,
                                objPaymentHistoryModel.recept_no,
                                objPaymentHistoryModel.payment_mode,
                                objPaymentHistoryModel.payment_date,
                                objPaymentHistoryModel.ip,
                                objPaymentHistoryModel.created_by,
                                objPaymentHistoryModel.created_on,
                                objPaymentHistoryModel.updated_by,
                                objPaymentHistoryModel.updated_on
                             );
                return table;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {

            }
        }
        #endregion

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
                foreach (SyncTableInfoModel objSyncTableInfo in objSyncTableInfoList)
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

        #region HttpGetRequet
        public static string httpGetWebRequest(string APIUri)
        {
            string returnedJSON;
            try
            {
                if (!APIUri.StartsWith("http"))
                    APIUri = "http://" + APIUri;
                var httpWebRequest = (HttpWebRequest)WebRequest.Create(APIUri);
                httpWebRequest.ContentType = "application/json; charset=utf-8";
                httpWebRequest.Method = "GET";

                var response = (HttpWebResponse)httpWebRequest.GetResponse();

                using (var sr = new StreamReader(response.GetResponseStream()))
                {
                    returnedJSON = sr.ReadToEnd();
                }
                return string.IsNullOrEmpty(returnedJSON) ? "[]" : returnedJSON;
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }
        #endregion

        #region HttpPostRequet
        public static string httpPostWebRequest(string APIUri,string postData)
        {
            string returnedJSON = "";
            try
            {
                if (!APIUri.StartsWith("http"))
                    APIUri = "http://" + APIUri;
                var httpWebRequest = (HttpWebRequest)WebRequest.Create(APIUri);
                var data = Encoding.ASCII.GetBytes(postData);

                //httpWebRequest.ContentType = "application/json; charset=utf-8";
                httpWebRequest.ContentType = "application/x-www-form-urlencoded";
                httpWebRequest.Method = "POST";
                httpWebRequest.ContentLength = data.Length;

                using (var stream = httpWebRequest.GetRequestStream())
                {
                    stream.Write(data, 0, data.Length);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return returnedJSON;

        }
        #endregion
    }

}