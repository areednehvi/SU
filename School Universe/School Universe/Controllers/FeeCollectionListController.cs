using School_Universe.Models;
using School_Universe.Shared;
using School_Universe.Views;
using School_Universe_Businness_Layer.Businness;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;

namespace School_Universe.Controllers
{
    public class FeeCollectionListController
    {
        #region Fields
        private ObservableCollection<FeeCollectionStudentList> _feeCollectionStudentList;
        private FeeCollectionStudentList _selectedItemInFeeCollectionStudentList;
        private Window _window;
        private int fromRowNo = 1,pageNo = 1,NoOfRecordsPerPage = 100,toRowNo;
        private ICommand _nextPageCommand;
        private ICommand _previousPageCommand;
        private ICommand _minimizeCommand;
        #endregion

        #region Constructor
        public FeeCollectionListController()
        {
            _feeCollectionStudentList = new ObservableCollection<FeeCollectionStudentList>();
            toRowNo = pageNo * NoOfRecordsPerPage;
            //this.GetFeeCollectionStudentList();
            _nextPageCommand = new RelayCommand(MoveToNextPage, CanMoveToNextPage);
            _previousPageCommand = new RelayCommand(MoveToPreviousPage, CanMoveToPreviousPage);
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
                DataGrid dataGridFeeCollectionList = (DataGrid)obj;
                dataGridFeeCollectionList.ItemsSource = null;
                pageNo++;
                fromRowNo = toRowNo + 1;
                toRowNo = pageNo * NoOfRecordsPerPage;
                this.GetFeeCollectionStudentList();
                if (pageNo > 1 && FeeCollectionStudentList.Count == 0)
                    MoveToPreviousPage(obj);
                dataGridFeeCollectionList.ItemsSource = FeeCollectionStudentList;
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
                DataGrid dataGridFeeCollectionList = (DataGrid)obj;                
                if (pageNo > 1)
                {
                    dataGridFeeCollectionList.ItemsSource = null;
                    pageNo--;
                    toRowNo = fromRowNo - 1;
                    fromRowNo = (toRowNo + 1) - NoOfRecordsPerPage;
                    this.GetFeeCollectionStudentList();
                    dataGridFeeCollectionList.ItemsSource = FeeCollectionStudentList;
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


        private void GetFeeCollectionStudentList()
        {
            try
            {
                FeeCollectionStudentList = FeeCollectionListManager.GetFeeCollectionStudentList(fromRowNo, toRowNo);
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

    }
}
