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
        private ObservableCollection<FeeCollectionStudentList> _feeCollectionStudentList;
        private FeeCollectionStudentList _selectedItemInFeeCollectionStudentList;
        private FeeCollectionListFilters _FeeCollectionListFilters;
        private FeeCollectionListOtherFileds _FeeCollectionListOtherFileds;
        private Window _window;
        private DataGrid _dataGrid;
        private int NoOfRecords = 50;
        private int fromRowNo,pageNo, NoOfRecordsPerPage, toRowNo;
        private ICommand _nextPageCommand;
        private ICommand _previousPageCommand;
        private ICommand _minimizeCommand;
        private ICommand _closeCommand;
        #endregion

        #region Constructor
        public FeeCollectionListController()
        {
             _feeCollectionStudentList = new ObservableCollection<FeeCollectionStudentList>();
            _FeeCollectionListFilters = new FeeCollectionListFilters();
            _FeeCollectionListOtherFileds = new FeeCollectionListOtherFileds();

            //Subscribe to Model's Property changed event
            this.FeeCollectionListFilters.PropertyChanged += (s, e) => {
                ResetPagination();
                this.GetFeeCollectionStudentList();
                FeeCollectionListDataGrid.ItemsSource = null;
                FeeCollectionListDataGrid.ItemsSource = FeeCollectionStudentList;
            };
            // Set pagination
            ResetPagination();            
            this.GetFeeCollectionStudentList();
            _nextPageCommand = new RelayCommand(MoveToNextPage, CanMoveToNextPage);
            _previousPageCommand = new RelayCommand(MoveToPreviousPage, CanMoveToPreviousPage);
            _closeCommand = new RelayCommand(CloseLogin, CanClose);
            _minimizeCommand = new RelayCommand(MinimizeLogin, CanMinimize);
        }
        #endregion

        #region Properties
        public ObservableCollection<FeeCollectionStudentList> FeeCollectionStudentList
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

        public FeeCollectionStudentList SelectedItemInFeeCollectionStudentList
        {
            get
            {
                return _selectedItemInFeeCollectionStudentList;
            }

            set
            {
                _selectedItemInFeeCollectionStudentList = value;
            }

        }

        public FeeCollectionListFilters FeeCollectionListFilters
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

        public FeeCollectionListOtherFileds FeeCollectionListOtherFileds
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

        public Window Window
        {
            get
            {
                return _window;
            }
            set
            {
                _window = value;
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

        #region CloseCommand

        public ICommand CloseCommand
        {
            get { return _closeCommand; }
        }


        public bool CanClose(object obj)
        {
            return true;
        }


        public void CloseLogin(object obj)
        {
            Window.Close();
        }
        #endregion

        #region MinimizeCommand

        public ICommand MinimizeCommand
        {
            get { return _minimizeCommand; }
        }


        public bool CanMinimize(object obj)
        {
            return true;
        }


        public void MinimizeLogin(object obj)
        {
            Window.WindowState = WindowState.Minimized;
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

    }
}
