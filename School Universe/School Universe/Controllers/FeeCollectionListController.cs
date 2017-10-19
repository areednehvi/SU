﻿using School_Universe.Models;
using School_Universe.Shared;
using School_Universe.Views;
using School_Universe_Businness_Layer.Businness;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;

namespace School_Universe.Controllers
{
    public class FeeCollectionListController :INotifyPropertyChanged
    {
        #region Fields
        private ObservableCollection<FeeCollectionStudentListModel> _feeCollectionStudentList;
        private FeeCollectionStudentListModel _selectedItemInFeeCollectionStudentList;
        private FeeCollectionListFiltersModel _FeeCollectionListFilters;
        private FeeCollectionListOtherFiledsModel _FeeCollectionListOtherFileds;
        private GradesModel _selectedGradeModel;
        private SectionsModel _selectedSectionModel;
        private DataGrid _dataGrid;
        private int NoOfRecords;
        private int fromRowNo,pageNo, NoOfRecordsPerPage, toRowNo;
        private string _NoRecordsFound;
        private ICommand _nextPageCommand;
        private ICommand _previousPageCommand;
        #endregion

        #region Constructor
        public FeeCollectionListController()
        {
            _feeCollectionStudentList = new ObservableCollection<FeeCollectionStudentListModel>();
            _FeeCollectionListFilters = new FeeCollectionListFiltersModel();
            _FeeCollectionListOtherFileds = new FeeCollectionListOtherFiledsModel();
            // Get Lists
            this.GetDropDownLists();
            //Get Settings
            this.GetSettings();
            // Set pagination
            this.ResetPagination();

            //Subscribe to Model's Property changed event
            this.FeeCollectionListFilters.PropertyChanged += (s, e) => {
                this.LoadFeeCollectionAsFiltersHaveChanged();
            };
                        
            //Get Initial Student list
            this.GetFeeCollectionStudentList();
            //Initialize  Commands
            _nextPageCommand = new RelayCommand(MoveToNextPage, CanMoveToNextPage);
            _previousPageCommand = new RelayCommand(MoveToPreviousPage, CanMoveToPreviousPage);        

            NoRecordsFound = "Visible";
        }
        
        #endregion

        #region Properties
        public ObservableCollection<FeeCollectionStudentListModel> FeeCollectionStudentList
        {
            get
            {
                return _feeCollectionStudentList;
            }

            set
            {
                _feeCollectionStudentList = value;
            }

        }

        public FeeCollectionStudentListModel SelectedItemInFeeCollectionStudentList
        {
            get
            {
                return _selectedItemInFeeCollectionStudentList;
            }

            set
            {
                _selectedItemInFeeCollectionStudentList = value;
                loadCollectFeeWindow();
            }

        }

        public FeeCollectionListFiltersModel FeeCollectionListFilters
        {
            get
            {
                return _FeeCollectionListFilters;
            }
            set
            {
                _FeeCollectionListFilters = value;
            }
        }

        public FeeCollectionListOtherFiledsModel FeeCollectionListOtherFileds
        {
            get
            {
                return _FeeCollectionListOtherFileds;
            }
            set
            {
                _FeeCollectionListOtherFileds = value;
            }
        }

        public GradesModel SelectedGrade
        {
            get { return _selectedGradeModel; }
            set
            {
                if (_selectedGradeModel != value)
                {
                    _selectedGradeModel = value;
                    FeeCollectionListFilters.Grade = this.SelectedGrade;
                    this.LoadFeeCollectionAsFiltersHaveChanged();
                }
            }
        }

        public SectionsModel SelectedSection
        {
            get { return _selectedSectionModel; }
            set
            {
                if (_selectedSectionModel != value)
                {
                    _selectedSectionModel = value;
                    FeeCollectionListFilters.Section = this.SelectedSection;
                    this.LoadFeeCollectionAsFiltersHaveChanged();
                }
            }
        }

        public DataGrid FeeCollectionListDataGrid
        {
            get
            {
                return _dataGrid;
            }
            set
            {
                _dataGrid = value;
            }
        }
        public string NoRecordsFound
        {
            get
            {
                return _NoRecordsFound;
            }
            set
            {
                _NoRecordsFound = value;
                OnPropertyChanged("NoRecordsFound");
            }
        }
        #endregion

        #region NextPageCommand
        public ICommand NextPageCommand
        {
            get { return _nextPageCommand; }        
        }

      
        public bool CanMoveToNextPage(object obj)
        {          
            return true;
        }

        public void MoveToNextPage(object obj)
        {
            try
            {
                FeeCollectionListDataGrid.ItemsSource = null;
                pageNo++;
                FeeCollectionListOtherFileds.PageNo = "Page No : " + pageNo;
                fromRowNo = toRowNo + 1;
                toRowNo = pageNo * NoOfRecordsPerPage;
                this.GetFeeCollectionStudentList();
                if (pageNo > 1 && FeeCollectionStudentList.Count == 0)
                    MoveToPreviousPage(obj);
                FeeCollectionListDataGrid.ItemsSource = FeeCollectionStudentList;
                CloseOtherWindows();
            }
            catch (Exception ex)
            {
                var errorMessage = "Please notify about the error to Admin \n\nERROR : " + ex.Message + "\n\nSTACK TRACE : " + ex.StackTrace;
                MessageBox.Show(errorMessage);
            }
            finally
            {

            }
            
        }

        #endregion

        #region PreviousPageCommand

        public ICommand PreviousPageCommand
        {
            get { return _previousPageCommand; }
        }


        public bool CanMoveToPreviousPage(object obj)
        {
            return true;
        }


        public void MoveToPreviousPage(object obj)
        {
            try
            {             
                if (pageNo > 1)
                {
                    FeeCollectionListDataGrid.ItemsSource = null;
                    pageNo--;
                    FeeCollectionListOtherFileds.PageNo = "Page No : " + pageNo;
                    toRowNo = fromRowNo - 1;
                    fromRowNo = (toRowNo + 1) - NoOfRecordsPerPage;
                    this.GetFeeCollectionStudentList();
                    FeeCollectionListDataGrid.ItemsSource = FeeCollectionStudentList;
                }
                CloseOtherWindows();

            }
            catch (Exception ex)
            {
                var errorMessage = "Please notify about the error to Admin \n\nERROR : " + ex.Message + "\n\nSTACK TRACE : " + ex.StackTrace;
                MessageBox.Show(errorMessage);
            }
            finally
            {

            }
        }
        #endregion


        #region INotifyPropertyChanged Members

        public event PropertyChangedEventHandler PropertyChanged;
        private void OnPropertyChanged(string propertyName)
        {
            if (PropertyChanged != null)
            {
                PropertyChanged(this, new PropertyChangedEventArgs(propertyName));
            }
        }
        #endregion

        private void GetFeeCollectionStudentList()
        {
            try
            {
                FeeCollectionStudentList = FeeCollectionListManager.GetFeeCollectionStudentList(fromRowNo, toRowNo, FeeCollectionListFilters);
                NoRecordsFound = FeeCollectionStudentList.Count > 0 ? "Collapsed" : "Visible";
            }
            catch (Exception ex)
            {
                var errorMessage = "Please notify about the error to Admin \n\nERROR : " + ex.Message + "\n\nSTACK TRACE : " + ex.StackTrace;
                MessageBox.Show(errorMessage);
            }
            finally
            {

            }

        }

        private void ResetPagination()
        {
            fromRowNo = 1;
            pageNo = 1;
            FeeCollectionListOtherFileds.PageNo = "Page No : " + pageNo;
            NoOfRecordsPerPage = NoOfRecords;
            toRowNo = pageNo * NoOfRecordsPerPage;
        }

        private void GetDropDownLists()
        {

            FeeCollectionListFilters.GradesList = GetListManager.GetGrades();
            FeeCollectionListFilters.SectionsList = GetListManager.GetSections();
        }

        private void GetSettings()
        {
            string noOfRecords = SettingsManager.GetSetting(SettingDefinitions.NoOfRowsInGrids);
            NoOfRecords = noOfRecords != null ? Convert.ToInt32(noOfRecords) : 50;
        }

        private void LoadFeeCollectionAsFiltersHaveChanged()
        {
            ResetPagination();
            this.GetFeeCollectionStudentList();
            if (FeeCollectionListDataGrid != null)
            {
                FeeCollectionListDataGrid.ItemsSource = null;
                FeeCollectionListDataGrid.ItemsSource = FeeCollectionStudentList;
            }
        }

        private void loadCollectFeeWindow()
        {
            FeeCollect objFeeCollectWindow = new FeeCollect(SelectedItemInFeeCollectionStudentList);
            objFeeCollectWindow.Show();
        }

        private void CloseOtherWindows()
        {
            for (int intCounter = Application.Current.Windows.Count - 1; intCounter >= 0; intCounter--)
            {
                if (Application.Current.Windows[intCounter].Name == "FeeCollectWindow")
                {
                    Application.Current.Windows[intCounter].Close();
                    break;
                }
            }
        }

    }
}
