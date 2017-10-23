using School_Universe.Models;
using School_Universe.Shared;
using School_Universe.Views;
using School_Universe_Businness_Layer.Businness;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;

namespace School_Universe.Controllers
{
    public class SyncController : INotifyPropertyChanged
    {
        #region Fields
        private ICommand _SyncCommand;
        private string _SyncDefnition;
        private string _SyncStatus;
        int _Progress;
        Double _ProgressPercentage;
        bool _IsSyncInProgress;
        int _Minimum = 0, _Maximum = 1;
        #endregion

        #region Constructor
        public SyncController()
        {
            //Initialise Commands
            _SyncCommand = new RelayCommand(Sync, CanSync);
        }
        #endregion

        #region Properties
        public bool IsSyncInProgress
        {
            get { return _IsSyncInProgress; }
            set
            {
                _IsSyncInProgress = value;
                OnPropertyChanged("IsSyncInProgress");
                OnPropertyChanged("IsSyncNotInProgress");
            }
        }
        public string SyncStatus
        {
            get
            {
                return _SyncStatus;
            }
            set
            {
                _SyncStatus = value;
                OnPropertyChanged("SyncStatus");
            }
        }

        public bool IsSyncNotInProgress
        {
            get
            {
                return !IsSyncInProgress;
            }
        }

        public int Maximum
        {
            get
            {
                return _Maximum;
            }
            set
            {
                _Maximum = value;
                OnPropertyChanged("Maximum");
            }
        }

        public int Minimum
        {
            get
            {
                return _Minimum;
            }
            set
            {
                _Minimum = value;
                OnPropertyChanged("Minimum");
            }
        }

        public Double ProgressPercentage
        {
            get
            {
                return _ProgressPercentage;
            }
            set
            {
                _ProgressPercentage = value;
                OnPropertyChanged("ProgressPercentage");
            }
        }

        public int Progress
        {
            get { return _Progress; }
            set
            {
                if (value <= _Maximum)
                {
                    if (value >= _Minimum)
                    {
                        _Progress = value;
                    }
                    else
                    {
                        _Progress = _Minimum;
                    }
                }
                else
                {
                    _Progress = _Maximum;
                }
                ProgressPercentage = ((Double)_Progress / (Double)Maximum) * 100;
                OnPropertyChanged("Progress");
            }
        }

        public string SyncDefnition
        {
            get { return _SyncDefnition; }
            set
            {
                _SyncDefnition = value;
            }
        }

        #endregion

        #region SyncCommand
        public ICommand SyncCommand
        {
            get { return _SyncCommand; }
        }


        public bool CanSync(object obj)
        {
            if (IsSyncNotInProgress)
                return true;
            else
                return false;
        }


        public void Sync(object obj)
        {
            try
            {
                
                SyncDefnition = (string)obj;

                ResetProgress();
                IsSyncInProgress = true;
                BackgroundWorker objBackgroundWorker = new BackgroundWorker();

                // Configure the function that will run when started
                objBackgroundWorker.DoWork += new DoWorkEventHandler(SyncRecords);

                /*The progress reporting is not needed with this implementation and is therefore
                commented out.  However, if our School App Grows into a more complex application, we may have a use for
                for this.

                //Enable progress and configure the progress function
                worker.WorkerReportsProgress = true;
                worker.ProgressChanged += new ProgressChangedEventHandler(worker_ProgressChanged);
                */

                // Configure the function to run when completed
                objBackgroundWorker.RunWorkerCompleted += new RunWorkerCompletedEventHandler(SyncCompleted);

                // Launch the sync               
                objBackgroundWorker.RunWorkerAsync();
                
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

        #region Private Functions
        private void CloseOtherWindows()
        {
            for (int intCounter = Application.Current.Windows.Count - 1; intCounter >= 0; intCounter--)
            {
                if (Application.Current.Windows[intCounter].Name == "FeeCollectWindow")
                    Application.Current.Windows[intCounter].Close();
            }
        }

        private void ResetProgress()
        {
            Progress = Minimum;
        }

        void SyncRecords(object sender, DoWorkEventArgs e)
        {
            //BackgroundWorker worker = sender as BackgroundWorker;
            SyncStatus = "Checking Internet Connection...";
            if (!GeneralMethods.IsInternetAvailable())
            {
                //GeneralMethods.ShowNotification("Internet Not Available!", "Please check your Internet Connection!", true);
                SyncStatus = "Internet Not Available...";
                return;
            }
            SyncStatus = "Syncing...";

            Maximum = 1000;
            if (SyncDefinitions.Users == SyncDefnition)
            {
                for (int i = _Minimum; i < _Maximum; i++)
                {
                    Progress++;
                    Thread.Sleep(10);
                }
            }
            
        }

        void worker_ProgressChanged(object sender, ProgressChangedEventArgs e)
        {
            // Does nothing yet
            throw new NotImplementedException();
        }

        void SyncCompleted(object sender, RunWorkerCompletedEventArgs e)
        {
            IsSyncInProgress = false;
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

    }
}
