using School_Universe.Models;
using School_Universe_Businness_Layer.Shared;
using School_Universe_Data_Layer.DataAccess;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;

namespace School_Universe_Businness_Layer.Businness
{
    public class FeeCollectManager
    {
        #region PaymentHistory
        public static ObservableCollection<PaymentHistoryModel> GetStudentPaymentHistory(Int64 fromRowNo, Int64 toRowNo, string studentID)
        {            
            try
            {
                List<SqlParameter> lstSqlParameters = new List<SqlParameter>()
                {                    
                    new SqlParameter() {ParameterName = "@FromRowNo",     SqlDbType = SqlDbType.NVarChar, Value = fromRowNo},
                    new SqlParameter() {ParameterName = "@ToRowNo",  SqlDbType = SqlDbType.NVarChar, Value = toRowNo},
                    new SqlParameter() {ParameterName = "@StudentID",  SqlDbType = SqlDbType.NVarChar, Value = studentID == "" ? null : studentID},                   
                };
                DataTable objDatable = DataAccess.GetDataTable(StoredProcedures.GetStudentPaymentHistory,lstSqlParameters);
                return MapDatatableToPaymentHistoryObject(objDatable);

            }
            catch(Exception ex)
            {
                throw ex;
            }
            finally
            {

            }            
            
        }

        private static ObservableCollection<PaymentHistoryModel> MapDatatableToPaymentHistoryObject(DataTable objDatatable)
        {
            ObservableCollection<PaymentHistoryModel> objPaymentHistoryList = new ObservableCollection<PaymentHistoryModel>();
            try
            {
                foreach (DataRow row in objDatatable.Rows)
                {
                    PaymentHistoryModel objPaymentHistory = new PaymentHistoryModel();
                    objPaymentHistory.id = row["id"] != DBNull.Value ? row["id"].ToString() : string.Empty;
                    objPaymentHistory.amount = row["amount"] != DBNull.Value ? Convert.ToDouble(row["amount"]) : 0;
                    objPaymentHistory.fine = row["fine"] != DBNull.Value ? Convert.ToDouble(row["fine"]) : 0;
                    objPaymentHistory.recept_no = row["recept_no"] != DBNull.Value ? row["recept_no"].ToString() : string.Empty;
                    objPaymentHistory.payment_date = row["payment_date"] != DBNull.Value ? Convert.ToDateTime(row["payment_date"]) : DateTime.MinValue;
                    objPaymentHistory.concession_amount = row["concession_amount"] != DBNull.Value ? Convert.ToDouble(row["concession_amount"]) : 0;
                    objPaymentHistory.month = row["month"] != DBNull.Value ? row["month"].ToString() : string.Empty;
                    objPaymentHistory.comment = row["comment"] != DBNull.Value ? row["comment"].ToString() : string.Empty;
                    objPaymentHistory.apply_from = row["apply_from"] != DBNull.Value ? Convert.ToDateTime(row["apply_from"]) : DateTime.MinValue;
                    objPaymentHistory.apply_to = row["apply_to"] != DBNull.Value ? Convert.ToDateTime(row["apply_to"]) : DateTime.MinValue;
                    objPaymentHistory.fee_amount = row["fee_amount"] != DBNull.Value ? Convert.ToDouble(row["fee_amount"]) : 0;
                    objPaymentHistory.concession_amount = row["concession_amount"] != DBNull.Value ? Convert.ToDouble(row["concession_amount"]) : 0;
                    objPaymentHistory.category_name = row["category_name"] != DBNull.Value ? row["category_name"].ToString() : string.Empty;
                    objPaymentHistoryList.Add(objPaymentHistory);
                }

            }
            catch(Exception ex)
            {
                throw ex;
            }
            finally
            {

            }
            return objPaymentHistoryList;
        }

        public static void UpdatePaymentHistory(PaymentHistoryModel objPaymentHistoryModel)
        {
            try
            {
                DataAccess.update();
            }
            catch(Exception ex)
            {
                throw ex;
            }
            finally
            {

            }
        }
        #endregion

        #region FeeDue
        public static ObservableCollection<FeeDueModel> GetStudentFeeDue(Int64 fromRowNo, Int64 toRowNo, string studentID, FeeDueListFiltersModel FeeDueListFilters)
        {
            try
            {
                List<SqlParameter> lstSqlParameters = new List<SqlParameter>()
                {
                    new SqlParameter() {ParameterName = "@FromRowNo",     SqlDbType = SqlDbType.NVarChar, Value = fromRowNo},
                    new SqlParameter() {ParameterName = "@ToRowNo",  SqlDbType = SqlDbType.NVarChar, Value = toRowNo},
                    new SqlParameter() {ParameterName = "@StudentID",  SqlDbType = SqlDbType.NVarChar, Value = studentID == "" ? null : studentID},
                    new SqlParameter() {ParameterName = "@FeeCategoryID",  SqlDbType = SqlDbType.NVarChar, Value = (FeeDueListFilters.FeeCategory != null && FeeDueListFilters.FeeCategory.name ==  "All") ? null : (FeeDueListFilters.FeeCategory != null ? FeeDueListFilters.FeeCategory.id : null)},
                };
                DataTable objDatable = DataAccess.GetDataTable(StoredProcedures.GetStudentFeeDue, lstSqlParameters);
                return MapDatatableToFeeDueObject(objDatable);

            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {

            }

        }

        private static ObservableCollection<FeeDueModel> MapDatatableToFeeDueObject(DataTable objDatatable)
        {
            ObservableCollection<FeeDueModel> objFeeDueList = new ObservableCollection<FeeDueModel>();
            try
            {
                foreach (DataRow row in objDatatable.Rows)
                {
                    FeeDueModel objFeeDue = new FeeDueModel();
                    objFeeDue.id = row["id"] != DBNull.Value ? row["id"].ToString() : string.Empty;
                    objFeeDue.student_balance = row["student_balance"] != DBNull.Value ? Convert.ToDouble(row["student_balance"]) : 0;
                    objFeeDue.student_id = row["student_id"] != DBNull.Value ? row["student_id"].ToString() : string.Empty;
                    objFeeDue.concession_amount = row["concession_amount"] != DBNull.Value ? Convert.ToDouble(row["concession_amount"]) : 0;
                    objFeeDue.apply_from = row["apply_from"] != DBNull.Value ? Convert.ToDateTime(row["apply_from"]) : DateTime.MinValue;
                    objFeeDue.apply_to = row["apply_to"] != DBNull.Value ? Convert.ToDateTime(row["apply_to"]) : DateTime.MinValue;
                    objFeeDue.fine = row["fine"] != DBNull.Value ? Convert.ToDouble(row["fine"]) : 0;
                    objFeeDue.category_name = row["category_name"] != DBNull.Value ? row["category_name"].ToString() : string.Empty;
                    objFeeDueList.Add(objFeeDue);
                }

            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {

            }
            return objFeeDueList;
        }
        #endregion
    }
}
