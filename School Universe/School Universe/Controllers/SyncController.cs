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
        private SyncModel _Sync;
        
        #endregion

        #region Constructor
        public SyncController()
        {
            _Sync = new SyncModel() {
                SyncModuleList = new List<SyncModule>() {
                    new SyncModule(){ Module = SyncModules.Users, SyncModuleProgress = new SyncModuleProgressModel() },
                    new SyncModule(){ Module = SyncModules.Students, SyncModuleProgress = new SyncModuleProgressModel() },
                    new SyncModule(){ Module = SyncModules.Grades, SyncModuleProgress = new SyncModuleProgressModel() },
                    new SyncModule(){ Module = SyncModules.Transportation, SyncModuleProgress = new SyncModuleProgressModel() },
                    new SyncModule(){ Module = SyncModules.Fees, SyncModuleProgress = new SyncModuleProgressModel() },
                    new SyncModule(){ Module = SyncModules.Payments, SyncModuleProgress = new SyncModuleProgressModel() }
                },
                SyncTableInfoList = SyncManager.GetSyncTableInfo()
            };
            //Initialise Commands
            _SyncCommand = new RelayCommand(StartSync, CanSync);
        }
        #endregion

        #region Properties
        
        public SyncModel Sync
        {
            get
            {
                return _Sync;
            }
            set
            {
                _Sync = value;
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
            if (Sync.IsSyncNotInProgress)
                return true;
            else
                return false;
        }


        public void StartSync(object obj)
        {
            try
            {

                Sync.SyncModuleList[0].Module = (string)obj;

                ResetProgress();
                Sync.IsSyncInProgress = true;
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
            Sync.SyncModuleList[0].SyncModuleProgress.Progress = Sync.SyncModuleList[0].SyncModuleProgress.Minimum;
        }

        private void SyncRecords(object sender, DoWorkEventArgs e)
        {
            try
            {
                //BackgroundWorker worker = sender as BackgroundWorker;
                Sync.SyncStatus = SyncNotifications.CheckingInternetConnection;
                if (!GeneralMethods.IsInternetAvailable())
                {
                    Sync.SyncStatus = SyncNotifications.InternetNotAvailable;
                    return;
                }
                Sync.SyncStatus = SyncNotifications.SyncStarted;
                Sync.SyncDBmodels = new SyncDBmodels();

                if (SyncModules.Users == Sync.SyncModuleList[0].Module)
                    SyncUsers();
                else if (SyncModules.Students == Sync.SyncModuleList[0].Module)
                    SyncStudents();
                else if (SyncModules.Grades == Sync.SyncModuleList[0].Module)
                    SyncGrades();
                else if (SyncModules.Transportation == Sync.SyncModuleList[0].Module)
                    SyncTransportation();
                else if (SyncModules.Fees == Sync.SyncModuleList[0].Module)
                    SyncFees();
                else if (SyncModules.Payments == Sync.SyncModuleList[0].Module)
                    SyncPayments();

                Sync.SyncStatus = SyncNotifications.SyncCompleted;
            }
            catch(Exception ex)
            {
                throw ex;
            }
            finally
            {

            }


        }

        void worker_ProgressChanged(object sender, ProgressChangedEventArgs e)
        {
            // Does nothing yet
            throw new NotImplementedException();
        }

        void SyncCompleted(object sender, RunWorkerCompletedEventArgs e)
        {
            Sync.IsSyncInProgress = false;
            if(Sync.SyncStatus == SyncNotifications.InternetNotAvailable)
                GeneralMethods.ShowNotification("Internet Not Available!", "Please check your Internet Connection!", true);
            else if(Sync.SyncStatus == SyncNotifications.SyncCompleted)
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

        #region Sync Functions
        private Boolean SyncUsers()
        {
            Boolean IsSuccess = false;
            try
            {
                Sync.SyncStatus = SyncNotifications.GettingDataFromOnline;
                Sync.SyncDBmodels.usersList = SyncManager.GetUsersFromOnline();
                Sync.SyncModuleList[0].SyncModuleProgress.Maximum = Sync.SyncDBmodels.usersList.Count + Sync.SyncDBmodels.usersList.Count;
                //getting Data
                for (int count = 0; count < Sync.SyncDBmodels.usersList.Count; count++)
                {
                    string i = Sync.SyncDBmodels.usersList[count].id;
                    Thread.Sleep(10);
                    Sync.SyncModuleList[0].SyncModuleProgress.Progress++;
                }
                //Sending Data
                Sync.SyncStatus = SyncNotifications.SendingDataToOnline;
                for (int count = 0; count < Sync.SyncDBmodels.usersList.Count; count++)
                {
                    string i = Sync.SyncDBmodels.usersList[count].id;
                    Thread.Sleep(10);
                    Sync.SyncModuleList[0].SyncModuleProgress.Progress++;
                }
                IsSuccess = true;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {

            }
            return IsSuccess;         
        }
        private Boolean SyncStudents()
        {
            Boolean IsSuccess = false;
            try
            {
                Sync.SyncStatus = SyncNotifications.GettingDataFromOnline;
                Sync.SyncDBmodels.usersList = SyncManager.GetUsersFromOnline();
                Sync.SyncModuleList[0].SyncModuleProgress.Maximum = Sync.SyncDBmodels.usersList.Count + Sync.SyncDBmodels.usersList.Count;
                //getting Data
                for (int count = 0; count < Sync.SyncDBmodels.usersList.Count; count++)
                {
                    string i = Sync.SyncDBmodels.usersList[count].id;
                    Thread.Sleep(10);
                    Sync.SyncModuleList[0].SyncModuleProgress.Progress++;
                }
                //Sending Data
                Sync.SyncStatus = SyncNotifications.SendingDataToOnline;
                for (int count = 0; count < Sync.SyncDBmodels.usersList.Count; count++)
                {
                    string i = Sync.SyncDBmodels.usersList[count].id;
                    Thread.Sleep(10);
                    Sync.SyncModuleList[0].SyncModuleProgress.Progress++;
                }
                IsSuccess = true;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {

            }
            return IsSuccess;
        }
        private Boolean SyncGrades()
        {
            Boolean IsSuccess = false;
            try
            {
                Sync.SyncStatus = SyncNotifications.GettingDataFromOnline;
                Sync.SyncDBmodels.usersList = SyncManager.GetUsersFromOnline();
                Sync.SyncModuleList[0].SyncModuleProgress.Maximum = Sync.SyncDBmodels.usersList.Count + Sync.SyncDBmodels.usersList.Count;
                //getting Data
                for (int count = 0; count < Sync.SyncDBmodels.usersList.Count; count++)
                {
                    string i = Sync.SyncDBmodels.usersList[count].id;
                    Thread.Sleep(10);
                    Sync.SyncModuleList[0].SyncModuleProgress.Progress++;
                }
                //Sending Data
                Sync.SyncStatus = SyncNotifications.SendingDataToOnline;
                for (int count = 0; count < Sync.SyncDBmodels.usersList.Count; count++)
                {
                    string i = Sync.SyncDBmodels.usersList[count].id;
                    Thread.Sleep(10);
                    Sync.SyncModuleList[0].SyncModuleProgress.Progress++;
                }
                IsSuccess = true;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {

            }
            return IsSuccess;
        }
        private Boolean SyncTransportation()
        {
            Boolean IsSuccess = false;
            try
            {
                Sync.SyncStatus = SyncNotifications.GettingDataFromOnline;
                Sync.SyncDBmodels.usersList = SyncManager.GetUsersFromOnline();
                Sync.SyncModuleList[0].SyncModuleProgress.Maximum = Sync.SyncDBmodels.usersList.Count + Sync.SyncDBmodels.usersList.Count;
                //getting Data
                for (int count = 0; count < Sync.SyncDBmodels.usersList.Count; count++)
                {
                    string i = Sync.SyncDBmodels.usersList[count].id;
                    Thread.Sleep(10);
                    Sync.SyncModuleList[0].SyncModuleProgress.Progress++;
                }
                //Sending Data
                Sync.SyncStatus = SyncNotifications.SendingDataToOnline;
                for (int count = 0; count < Sync.SyncDBmodels.usersList.Count; count++)
                {
                    string i = Sync.SyncDBmodels.usersList[count].id;
                    Thread.Sleep(10);
                    Sync.SyncModuleList[0].SyncModuleProgress.Progress++;
                }
                IsSuccess = true;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {

            }
            return IsSuccess;
        }
        private Boolean SyncFees()
        {
            Boolean IsSuccess = false;
            try
            {
                Sync.SyncStatus = SyncNotifications.GettingDataFromOnline;
                Sync.SyncDBmodels.usersList = SyncManager.GetUsersFromOnline();
                Sync.SyncModuleList[0].SyncModuleProgress.Maximum = Sync.SyncDBmodels.usersList.Count + Sync.SyncDBmodels.usersList.Count;
                //getting Data
                for (int count = 0; count < Sync.SyncDBmodels.usersList.Count; count++)
                {
                    string i = Sync.SyncDBmodels.usersList[count].id;
                    Thread.Sleep(10);
                    Sync.SyncModuleList[0].SyncModuleProgress.Progress++;
                }
                //Sending Data
                Sync.SyncStatus = SyncNotifications.SendingDataToOnline;
                for (int count = 0; count < Sync.SyncDBmodels.usersList.Count; count++)
                {
                    string i = Sync.SyncDBmodels.usersList[count].id;
                    Thread.Sleep(10);
                    Sync.SyncModuleList[0].SyncModuleProgress.Progress++;
                }
                IsSuccess = true;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {

            }
            return IsSuccess;
        }
        private Boolean SyncPayments()
        {
            Boolean IsSuccess = false;
            try
            {
                Sync.SyncStatus = SyncNotifications.GettingDataFromOnline;
                Sync.SyncDBmodels.usersList = SyncManager.GetUsersFromOnline();
                Sync.SyncModuleList[0].SyncModuleProgress.Maximum = Sync.SyncDBmodels.usersList.Count + Sync.SyncDBmodels.usersList.Count;
                //getting Data
                for (int count = 0; count < Sync.SyncDBmodels.usersList.Count; count++)
                {
                    string i = Sync.SyncDBmodels.usersList[count].id;
                    Thread.Sleep(10);
                    Sync.SyncModuleList[0].SyncModuleProgress.Progress++;
                }
                //Sending Data
                Sync.SyncStatus = SyncNotifications.SendingDataToOnline;
                for (int count = 0; count < Sync.SyncDBmodels.usersList.Count; count++)
                {
                    string i = Sync.SyncDBmodels.usersList[count].id;
                    Thread.Sleep(10);
                    Sync.SyncModuleList[0].SyncModuleProgress.Progress++;
                }
                IsSuccess = true;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {

            }
            return IsSuccess;
        }
        #endregion

    }
}
