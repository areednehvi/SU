using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace School_Universe.Shared
{
    public class SyncModules
    {
        public static string Users = "Users";
        public static string Students = "Students";
        public static string Grades = "Grades";
        public static string Transportation = "Transportation";
        public static string Fees = "Fees";        
        public static string Payments = "Payments";

    }
    public class SyncNotifications
    {
        public static string SyncStarted = "Syncing...";
        public static string SyncCompleted = "Sync Completed";
        public static string InternetNotAvailable = "Internet Not Available";
        public static string CheckingInternetConnection = " Checking Internet Connection...";
       
    }
    public class Tables
    {
        public static string fee_categories = "fee_categories";
        public static string fees = "fees";
        public static string files = "files";
        public static string grade_fees = "grade_fees";
        public static string grades = "grades";
        public static string parents = "parents";
        public static string route_stops = "route_stops";
        public static string route_vehicle_stops = "route_vehicle_stops";
        public static string route_vehicle_stops_fee_logs = "route_vehicle_stops_fee_logs";
        public static string route_vehicles = "route_vehicles";
        public static string routes = "routes";
        public static string sections = "sections";
        public static string sessions = "sessions";
        public static string student_fees = "student_fees";
        public static string student_grade_session_log = "student_grade_session_log";
        public static string student_payments = "student_payments";
        public static string students = "students";
        public static string trip_stops = "trip_stops";
        public static string user_avatar_files = "user_avatar_files";
        public static string users = "users";
        public static string vehicles = "vehicles";
    }
}
