using School_Universe.Models;
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
    public class FeeCollectController :INotifyPropertyChanged
    {
        #region Fields
        private ObservableCollection<PaymentHistoryModel> _PaymentHistoryList;
        private FeeCollectionStudentList _FeeCollectionStudent;
        private PaymentHistoryModel _selectedItemInPaymentHistoryList;
        private PaymentHistoryOtherFileds _PaymentHistoryOtherFileds;
        private Window _window;
        private DataGrid _dataGrid;
        private int _SelectedTabItem;
        private int NoOfRecords = 50;
        private int fromRowNo,pageNo, NoOfRecordsPerPage, toRowNo;
        private string _NoRecordsFound;
        private ICommand _nextPageCommand;
        private ICommand _previousPageCommand;
        private ICommand _minimizeCommand;
        private ICommand _closeCommand;
        #endregion

        #region Constructor
        public FeeCollectController()
        {
            _PaymentHistoryList = new ObservableCollection<PaymentHistoryModel>();
            _FeeCollectionStudent = new FeeCollectionStudentList();
            _PaymentHistoryOtherFileds = new PaymentHistoryOtherFileds();
            // Set pagination
            this.ResetPagination();

            //Get Initial Payment History list
            //this.GetStudentPaymentHistoryList();
            //Initialize  Commands
            _nextPageCommand = new RelayCommand(MoveToNextPage, CanMoveToNextPage);
            _previousPageCommand = new RelayCommand(MoveToPreviousPage, CanMoveToPreviousPage);
            _closeCommand = new RelayCommand(CloseLogin, CanClose);
            _minimizeCommand = new RelayCommand(MinimizeLogin, CanMinimize);
        }
        
        #endregion

        #region Properties
        public ObservableCollection<PaymentHistoryModel> PaymentHistoryList
        {
            get
            {
                return _PaymentHistoryList;
            }

            set
            {
                _PaymentHistoryList = value;
            }

        }

        public PaymentHistoryOtherFileds PaymentHistoryOtherFileds
        {
            get
            {
                return _PaymentHistoryOtherFileds;
            }
            set
            {
                _PaymentHistoryOtherFileds = value;
            }
        }

        public PaymentHistoryModel SelectedItemInPaymentHistoryList
        {
            get
            {
                return _selectedItemInPaymentHistoryList;
            }

            set
            {
                _selectedItemInPaymentHistoryList = value;
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

        public int SelectedTabItem
        {
            get { return _SelectedTabItem; }
            set
            {
                _SelectedTabItem = value;
                OnPropertyChanged("SelectedTabItem");
                this.GetStudentPaymentHistoryList();
            }
        }
        public DataGrid PaymentHistorListDataGrid
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

        public FeeCollectionStudentList FeeCollectionStudentList
        {
            get
            {
                return _FeeCollectionStudent;
            }
            set
            {
                _FeeCollectionStudent = value;
                OnPropertyChanged("FeeCollectionStudentList");
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
                PaymentHistorListDataGrid.ItemsSource = null;
                pageNo++;
                PaymentHistoryOtherFileds.PageNo = "Page No : " + pageNo;
                fromRowNo = toRowNo + 1;
                toRowNo = pageNo * NoOfRecordsPerPage;
                this.GetStudentPaymentHistoryList();
                if (pageNo > 1 && PaymentHistoryList.Count == 0)
                    MoveToPreviousPage(obj);
                PaymentHistorListDataGrid.ItemsSource = PaymentHistoryList;
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
                    PaymentHistorListDataGrid.ItemsSource = null;
                    pageNo--;
                    PaymentHistoryOtherFileds.PageNo = "Page No : " + pageNo;
                    toRowNo = fromRowNo - 1;
                    fromRowNo = (toRowNo + 1) - NoOfRecordsPerPage;
                    this.GetStudentPaymentHistoryList();
                    PaymentHistorListDataGrid.ItemsSource = PaymentHistoryList;
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

        private void GetStudentPaymentHistoryList()
        {
            try
            {
                PaymentHistorListDataGrid.ItemsSource = null;
                PaymentHistoryList = FeeCollectManager.GetStudentPaymentHistory(fromRowNo, toRowNo, FeeCollectionStudentList.id.ToString());
                PaymentHistorListDataGrid.ItemsSource = PaymentHistoryList;
                NoRecordsFound = PaymentHistoryList.Count > 0 ? "Collapsed" : "Visible";
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
            PaymentHistoryOtherFileds.PageNo = "Page No : " + pageNo;
            NoOfRecordsPerPage = NoOfRecords;
            toRowNo = pageNo * NoOfRecordsPerPage;
        }

    }
}
