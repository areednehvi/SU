﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace School_Universe_Businness_Layer.Shared
{
    static class StoredProcedures
    {
        public static string AuthenticateUser = "AuthenticateUser";
        public static string GetStudentFeeAllocatedList = "GetStudentFeeAllocatedList";
        public static string GetList = "GetList";
        public static string GetStudentPaymentHistory = "GetStudentPaymentHistory";
        public static string GetStudentFeeDue = "GetStudentFeeDue";
        public static string GetStudentBalances = "GetStudentBalances"; 
        public static string GetStudentPaymentsForSync = "GetStudentPaymentsForSync";
        public static string GetStudentFeesForSync = "GetStudentFeesForSync";
        public static string UpdatePayment = "UpdatePayment";
        public static string MakePayment = "MakePayment";
        public static string UpdateFeeDue = "UpdateFeeDue";
        public static string DeleteRecord = "DeleteRecord";
        public static string GetSchoolInfo = "GetSchoolInfo";
        public static string SetSchoolInfo = "SetSchoolInfo";
        public static string SaveSettings = "SaveSettings";
        public static string GetSettings = "GetSettings";
        public static string GetSyncTableInfo = "GetSyncTableInfo";
        public static string UpdateSyncTableInfo = "UpdateSyncTableInfo";
        public static string SyncFee_categories = "SyncFee_categories";
        public static string SyncFees = "SyncFees";
        public static string SyncFiles = "SyncFiles";
        public static string SyncGrade_fees = "SyncGrade_fees";
        public static string SyncGrades = "SyncGrades";
        public static string SyncParents = "SyncParents";
        public static string SyncRoute_stops = "SyncRoute_stops";
        public static string SyncRoute_vehicle_stops = "SyncRoute_vehicle_stops";
        public static string SyncRoute_vehicle_stops_fee_logs = "SyncRoute_vehicle_stops_fee_logs";
        public static string SyncRoute_vehicles = "SyncRoute_vehicles";
        public static string SyncRoutes = "SyncRoutes";
        public static string SyncSections = "SyncSections";
        public static string SyncSessions = "SyncSessions";
        public static string SyncStudent_fees = "SyncStudent_fees";
        public static string SyncStudent_grade_session_log = "SyncStudent_grade_session_log";
        public static string SyncStudent_payments = "SyncStudent_payments";
        public static string SyncStudents = "SyncStudents";
        public static string SyncTrip_stops = "SyncTrip_stops";
        public static string SyncUser_avatar_files = "SyncUser_avatar_files";
        public static string SyncUsers = "SyncUsers";
        public static string SyncVehicles = "SyncVehicles";
        public static string IsSchoolSetup = "IsSchoolSetup";
        public static string CheckIfStudentFeesCanBeDeleted = "CheckIfStudentFeesCanBeDeleted";
    }
}
