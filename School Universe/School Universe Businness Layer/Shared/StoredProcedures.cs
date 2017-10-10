using System;
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
        public static string UpdatePayment = "UpdatePayment";
        public static string UpdateFeeDue = "UpdateFeeDue";
        public static string DeleteRecord = "DeleteRecord";
    }
}
