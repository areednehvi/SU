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
        private SyncModel _SyncModel;
        
        #endregion

        #region Constructor
        public SyncController()
        {
            _SyncModel = new SyncModel() {
                SyncProgress = new SyncProgressModel(),                
                SyncTableInfoList = SyncManager.GetSyncTableInfo()
            };
            //Initialise Commands
            _SyncCommand = new RelayCommand(Sync, CanSync);
        }
        #endregion

        #region Properties
        
        public SyncModel SyncModel
        {
            get
            {
                return _SyncModel;
            }
            set
            {
                _SyncModel = value;
                OnPropertyChanged("SyncModel");
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
            if (SyncModel.IsSyncNotInProgress)
                return true;
            else
                return false;
        }


        public void Sync(object obj)
        {
            try
            {

                SyncModel.SyncModule = (string)obj;

                ResetProgress();
                SyncModel.IsSyncInProgress = true;
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
                if (Application.Current.Windows[intCounter].Name == WindowDefnitions.FeeCollectWindow)
                    Application.Current.Windows[intCounter].Close();
            }
        }

        private void ResetProgress()
        {
            SyncModel.SyncProgress.Progress = SyncModel.SyncProgress.Minimum;
        }

        void SyncRecords(object sender, DoWorkEventArgs e)
        {
            //BackgroundWorker worker = sender as BackgroundWorker;
            SyncModel.SyncStatus = SyncNotifications.CheckingInternetConnection;
            if (!GeneralMethods.IsInternetAvailable())
            {
                SyncModel.SyncStatus = SyncNotifications.InternetNotAvailable;
                return;
            }
            SyncModel.SyncStatus = SyncNotifications.SyncStarted;
            
            if (SyncModules.Users == SyncModel.SyncModule)
            {
                SyncModel.SyncProgress.Maximum = 1000;
                for (int i = SyncModel.SyncProgress.Minimum; i < SyncModel.SyncProgress.Maximum; i++)
                {
                    SyncModel.SyncProgress.Progress++;
                    Thread.Sleep(10);
                }
            }
            SyncModel.SyncStatus = SyncNotifications.SyncCompleted;


        }

        void worker_ProgressChanged(object sender, ProgressChangedEventArgs e)
        {
            // Does nothing yet
            throw new NotImplementedException();
        }

        void SyncCompleted(object sender, RunWorkerCompletedEventArgs e)
        {
            SyncModel.IsSyncInProgress = false;
            if(SyncModel.SyncStatus == SyncNotifications.InternetNotAvailable)
                GeneralMethods.ShowNotification("Internet Not Available!", "Please check your Internet Connection!", true);
            else if(SyncModel.SyncStatus == SyncNotifications.SyncCompleted)
                GeneralMethods.ShowNotification("Sync Completed!", "Sync finished Successfully!");

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
