﻿using School_Universe.Models;
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

        public static ObservableCollection<FeeCategoryModel> GetFeeCategories()
        {

            try
            {

                GetListModel objGetListModel = new GetListModel()
                {
                    tableName = "fee_categories",
                    keyColumn = "name",
                    valueColumn = "id",
                    orderBy = "[order]"
                };
                DataTable objDatatable = GetList(objGetListModel);
                return MapDatatableToFeeCategoriesModelList(objDatatable);

            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {

            }

        }

        public static ObservableCollection<PaymentModeModel> GetPaymentModes()
        {

            try
            {
                ObservableCollection<PaymentModeModel> lstPaymentModes = new ObservableCollection<PaymentModeModel>()
                {
                    new PaymentModeModel() { id ="Cash", name = "Cash" },
                    new PaymentModeModel() { id ="Cheque", name = "Cheque" },
                    new PaymentModeModel() { id ="Challan", name = "Challan" },
                    new PaymentModeModel() { id ="Online", name = "Online" }
                };
                
                return lstPaymentModes;

            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {

            }

        }

        public static ObservableCollection<NoOfRowsInGridsModel> GetNoOfRowsInGridsList()
        {

            try
            {
                ObservableCollection<NoOfRowsInGridsModel> lstNoOfRowsInGrids = new ObservableCollection<NoOfRowsInGridsModel>()
                {
                    new NoOfRowsInGridsModel() { id ="10", name = "10" },
                    new NoOfRowsInGridsModel() { id ="20", name = "20" },
                    new NoOfRowsInGridsModel() { id ="50", name = "50" },
                    new NoOfRowsInGridsModel() { id ="100", name = "100" },
                    new NoOfRowsInGridsModel() { id ="200", name = "200" }
                };

                return lstNoOfRowsInGrids;

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

        private static ObservableCollection<FeeCategoryModel> MapDatatableToFeeCategoriesModelList(DataTable objDatatable)
        {
            ObservableCollection<FeeCategoryModel> objFeeCategoryList = new ObservableCollection<FeeCategoryModel>();
            try
            {
                objFeeCategoryList.Add(new FeeCategoryModel { id = "0", name = "All" });
                foreach (DataRow row in objDatatable.Rows)
                {
                    FeeCategoryModel objFeeCategoryModel = new FeeCategoryModel();

                    objFeeCategoryModel.id = row["id"] != DBNull.Value ? row["id"].ToString() : string.Empty;
                    objFeeCategoryModel.name = row["name"] != DBNull.Value ? row["name"].ToString() : string.Empty;

                    objFeeCategoryList.Add(objFeeCategoryModel);
                }

            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {

            }
            return objFeeCategoryList;
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
