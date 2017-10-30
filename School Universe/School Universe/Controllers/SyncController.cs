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
        private ICommand _SyncAllCommand;
        private SyncModel _Sync;
        
        #endregion

        #region Constructor
        public SyncController()
        {
            _Sync = new SyncModel() {
                SyncModuleList = new List<SyncModule>() {
                    new SyncModule(){ Module = SyncModules.Users, SyncModuleProgress = new SyncProgressModel() },
                    new SyncModule(){ Module = SyncModules.Students, SyncModuleProgress = new SyncProgressModel() },
                    new SyncModule(){ Module = SyncModules.Grades, SyncModuleProgress = new SyncProgressModel() },
                    new SyncModule(){ Module = SyncModules.Transportation, SyncModuleProgress = new SyncProgressModel() },
                    new SyncModule(){ Module = SyncModules.Fees, SyncModuleProgress = new SyncProgressModel() },
                    new SyncModule(){ Module = SyncModules.Payments, SyncModuleProgress = new SyncProgressModel() }
                },
                SyncTableInfoList = SyncManager.GetSyncTableInfo(),
                SyncAllProgress = new SyncProgressModel()
            };
            //Initialise Commands
            _SyncCommand = new RelayCommand(StartSync, CanSync);
            _SyncAllCommand = new RelayCommand(StartSyncAll, CanSyncAll);
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
            bool IsEnabled = false;
            Sync.CurrentSyncModule = (string)obj;
            if (SyncModules.Users == Sync.CurrentSyncModule)
                IsEnabled = true;
            else if (SyncModules.Students == Sync.CurrentSyncModule)
                IsEnabled = Sync.SyncModuleList[SyncModules.GetSyncModuleID(SyncModules.Users)].SyncModuleStatus == SyncNotifications.SyncCompleted ? true : false;
            else if (SyncModules.Grades == Sync.CurrentSyncModule)
                IsEnabled = Sync.SyncModuleList[SyncModules.GetSyncModuleID(SyncModules.Students)].SyncModuleStatus == SyncNotifications.SyncCompleted ? true : false;
            else if (SyncModules.Transportation == Sync.CurrentSyncModule)
                IsEnabled = Sync.SyncModuleList[SyncModules.GetSyncModuleID(SyncModules.Grades)].SyncModuleStatus == SyncNotifications.SyncCompleted ? true : false;
            else if (SyncModules.Fees == Sync.CurrentSyncModule)
                IsEnabled = Sync.SyncModuleList[SyncModules.GetSyncModuleID(SyncModules.Transportation)].SyncModuleStatus == SyncNotifications.SyncCompleted ? true : false;
            else if (SyncModules.Payments == Sync.CurrentSyncModule)
                IsEnabled = Sync.SyncModuleList[SyncModules.GetSyncModuleID(SyncModules.Fees)].SyncModuleStatus == SyncNotifications.SyncCompleted ? true : false;
            return IsEnabled;
        }


        public void StartSync(object obj)
        {
            try
            {

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

        #region SyncAllCommand
        public ICommand SyncAllCommand
        {
            get { return _SyncAllCommand; }
        }


        public bool CanSyncAll(object obj)
        {
            if (Sync.IsSyncNotInProgress)
                return true;
            else
                return false;

        }


        public void StartSyncAll(object obj)
        {
            try
            {

                Sync.CurrentSyncModule = (string)obj;

                ResetAllProgress();
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
                objBackgroundWorker.RunWorkerCompleted += new RunWorkerCompletedEventHandler(SyncAllCompleted);

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
            Sync.SyncModuleList[SyncModules.GetSyncModuleID(Sync.CurrentSyncModule)].SyncModuleProgress.Progress = Sync.SyncModuleList[SyncModules.GetSyncModuleID(Sync.CurrentSyncModule)].SyncModuleProgress.Minimum;
        }
        private void ResetAllProgress()
        {
            for(int count = 0; count < Sync.SyncModuleList.Count; count++)
                Sync.SyncModuleList[count].SyncModuleProgress.Progress = Sync.SyncModuleList[count].SyncModuleProgress.Minimum;
            Sync.SyncAllProgress.Progress = Sync.SyncAllProgress.Minimum;
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

                Sync.SyncAllProgress.Maximum = Sync.SyncModuleList.Count;

                if (SyncModules.Users == Sync.CurrentSyncModule)
                    SyncUsers();
                else if (SyncModules.Students == Sync.CurrentSyncModule)
                    SyncStudents();
                else if (SyncModules.Grades == Sync.CurrentSyncModule)
                    SyncGrades();
                else if (SyncModules.Transportation == Sync.CurrentSyncModule)
                    SyncTransportation();
                else if (SyncModules.Fees == Sync.CurrentSyncModule)
                    SyncFees();
                else if (SyncModules.Payments == Sync.CurrentSyncModule)
                    SyncPayments();
                else if (SyncModules.All == Sync.CurrentSyncModule)
                {
                    SyncUsers();
                    SyncStudents();
                    SyncGrades();
                    SyncTransportation();
                    SyncFees();
                    SyncPayments();
                }


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
        void SyncAllCompleted(object sender, RunWorkerCompletedEventArgs e)
        {
            Sync.IsSyncInProgress = false;
            //if (Sync.SyncStatus == SyncNotifications.InternetNotAvailable)
            //    GeneralMethods.ShowNotification("Internet Not Available!", "Please check your Internet Connection!", true);
            //else if (Sync.SyncStatus == SyncNotifications.SyncCompleted)
                GeneralMethods.ShowNotification("Sync Completed!", "Syncing all Modules finished Successfully!");

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
                Sync.SyncStatus = SyncNotifications.SyncingModule + SyncModules.Users;
                Sync.SyncDBmodels.usersList = SyncManager.GetUsersFromOnline();
                Sync.SyncModuleList[SyncModules.GetSyncModuleID(SyncModules.Users)].SyncModuleProgress.Maximum = Sync.SyncDBmodels.usersList.Count + Sync.SyncDBmodels.usersList.Count;                
                //getting Data
                for (int count = 0; count < Sync.SyncDBmodels.usersList.Count; count++)
                {
                    Sync.SyncModuleList[SyncModules.GetSyncModuleID(SyncModules.Users)].SyncModuleStatus = SyncNotifications.GettingDataFromOnline + " Record " + count;
                    string i = Sync.SyncDBmodels.usersList[count].id;
                    Thread.Sleep(10);
                    Sync.SyncModuleList[SyncModules.GetSyncModuleID(SyncModules.Users)].SyncModuleProgress.Progress++;
                }
                //Sending Data               
                for (int count = 0; count < Sync.SyncDBmodels.usersList.Count; count++)
                {
                    Sync.SyncModuleList[SyncModules.GetSyncModuleID(SyncModules.Users)].SyncModuleStatus = SyncNotifications.SendingDataToOnline + " Record " + count;
                    string i = Sync.SyncDBmodels.usersList[count].id;
                    Thread.Sleep(10);
                    Sync.SyncModuleList[SyncModules.GetSyncModuleID(SyncModules.Users)].SyncModuleProgress.Progress++;
                }
                Sync.SyncModuleList[SyncModules.GetSyncModuleID(SyncModules.Users)].SyncModuleStatus = SyncNotifications.SyncCompleted;
                Sync.SyncAllProgress.Progress++;
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
                Sync.SyncStatus = SyncNotifications.SyncingModule + SyncModules.Students;
                Sync.SyncDBmodels.usersList = SyncManager.GetUsersFromOnline();
                Sync.SyncModuleList[SyncModules.GetSyncModuleID(SyncModules.Students)].SyncModuleProgress.Maximum = Sync.SyncDBmodels.usersList.Count + Sync.SyncDBmodels.usersList.Count;                
                //getting Data
                for (int count = 0; count < Sync.SyncDBmodels.usersList.Count; count++)
                {
                    Sync.SyncModuleList[SyncModules.GetSyncModuleID(SyncModules.Students)].SyncModuleStatus = SyncNotifications.GettingDataFromOnline + " Record " + count;
                    string i = Sync.SyncDBmodels.usersList[count].id;
                    Thread.Sleep(10);
                    Sync.SyncModuleList[SyncModules.GetSyncModuleID(SyncModules.Students)].SyncModuleProgress.Progress++;
                }
                //Sending Data                
                for (int count = 0; count < Sync.SyncDBmodels.usersList.Count; count++)
                {
                    Sync.SyncModuleList[SyncModules.GetSyncModuleID(SyncModules.Students)].SyncModuleStatus = SyncNotifications.SendingDataToOnline + " Record " + count;
                    string i = Sync.SyncDBmodels.usersList[count].id;
                    Thread.Sleep(10);
                    Sync.SyncModuleList[SyncModules.GetSyncModuleID(SyncModules.Students)].SyncModuleProgress.Progress++;
                }
                Sync.SyncModuleList[SyncModules.GetSyncModuleID(SyncModules.Students)].SyncModuleStatus = SyncNotifications.SyncCompleted;
                Sync.SyncAllProgress.Progress++;
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
                Sync.SyncStatus = SyncNotifications.SyncingModule + SyncModules.Grades;
                Sync.SyncDBmodels.usersList = SyncManager.GetUsersFromOnline();
                Sync.SyncModuleList[SyncModules.GetSyncModuleID(SyncModules.Grades)].SyncModuleProgress.Maximum = Sync.SyncDBmodels.usersList.Count + Sync.SyncDBmodels.usersList.Count;                
                //getting Data
                for (int count = 0; count < Sync.SyncDBmodels.usersList.Count; count++)
                {
                    Sync.SyncModuleList[SyncModules.GetSyncModuleID(SyncModules.Grades)].SyncModuleStatus = SyncNotifications.GettingDataFromOnline + " Record " + count;
                    string i = Sync.SyncDBmodels.usersList[count].id;
                    Thread.Sleep(10);
                    Sync.SyncModuleList[SyncModules.GetSyncModuleID(SyncModules.Grades)].SyncModuleProgress.Progress++;
                }
                //Sending Data                
                for (int count = 0; count < Sync.SyncDBmodels.usersList.Count; count++)
                {
                    Sync.SyncModuleList[SyncModules.GetSyncModuleID(SyncModules.Grades)].SyncModuleStatus = SyncNotifications.SendingDataToOnline + " Record " + count;
                    string i = Sync.SyncDBmodels.usersList[count].id;
                    Thread.Sleep(10);
                    Sync.SyncModuleList[SyncModules.GetSyncModuleID(SyncModules.Grades)].SyncModuleProgress.Progress++;
                }
                Sync.SyncModuleList[SyncModules.GetSyncModuleID(SyncModules.Grades)].SyncModuleStatus = SyncNotifications.SyncCompleted;
                Sync.SyncAllProgress.Progress++;
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
                Sync.SyncStatus = SyncNotifications.SyncingModule + SyncModules.Transportation;
                Sync.SyncDBmodels.usersList = SyncManager.GetUsersFromOnline();
                Sync.SyncModuleList[SyncModules.GetSyncModuleID(SyncModules.Transportation)].SyncModuleProgress.Maximum = Sync.SyncDBmodels.usersList.Count + Sync.SyncDBmodels.usersList.Count;                
                //getting Data
                for (int count = 0; count < Sync.SyncDBmodels.usersList.Count; count++)
                {
                    Sync.SyncModuleList[SyncModules.GetSyncModuleID(SyncModules.Transportation)].SyncModuleStatus = SyncNotifications.GettingDataFromOnline + " Record " + count;
                    string i = Sync.SyncDBmodels.usersList[count].id;
                    Thread.Sleep(10);
                    Sync.SyncModuleList[SyncModules.GetSyncModuleID(SyncModules.Transportation)].SyncModuleProgress.Progress++;
                }
                //Sending Data                
                for (int count = 0; count < Sync.SyncDBmodels.usersList.Count; count++)
                {
                    Sync.SyncModuleList[SyncModules.GetSyncModuleID(SyncModules.Transportation)].SyncModuleStatus = SyncNotifications.SendingDataToOnline + " Record " + count;
                    string i = Sync.SyncDBmodels.usersList[count].id;
                    Thread.Sleep(10);
                    Sync.SyncModuleList[SyncModules.GetSyncModuleID(SyncModules.Transportation)].SyncModuleProgress.Progress++;
                }
                Sync.SyncModuleList[SyncModules.GetSyncModuleID(SyncModules.Transportation)].SyncModuleStatus = SyncNotifications.SyncCompleted;
                Sync.SyncAllProgress.Progress++;
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
                Sync.SyncStatus = SyncNotifications.SyncingModule + SyncModules.Fees;
                Sync.SyncDBmodels.usersList = SyncManager.GetUsersFromOnline();
                Sync.SyncModuleList[SyncModules.GetSyncModuleID(SyncModules.Fees)].SyncModuleProgress.Maximum = Sync.SyncDBmodels.usersList.Count + Sync.SyncDBmodels.usersList.Count;                
                //getting Data
                for (int count = 0; count < Sync.SyncDBmodels.usersList.Count; count++)
                {
                    Sync.SyncModuleList[SyncModules.GetSyncModuleID(SyncModules.Fees)].SyncModuleStatus = SyncNotifications.GettingDataFromOnline + " Record " + count;
                    string i = Sync.SyncDBmodels.usersList[count].id;
                    Thread.Sleep(10);
                    Sync.SyncModuleList[SyncModules.GetSyncModuleID(SyncModules.Fees)].SyncModuleProgress.Progress++;
                }
                //Sending Data                
                for (int count = 0; count < Sync.SyncDBmodels.usersList.Count; count++)
                {
                    Sync.SyncModuleList[SyncModules.GetSyncModuleID(SyncModules.Fees)].SyncModuleStatus = SyncNotifications.SendingDataToOnline + " Record " + count;
                    string i = Sync.SyncDBmodels.usersList[count].id;
                    Thread.Sleep(10);
                    Sync.SyncModuleList[SyncModules.GetSyncModuleID(SyncModules.Fees)].SyncModuleProgress.Progress++;
                }
                Sync.SyncModuleList[SyncModules.GetSyncModuleID(SyncModules.Fees)].SyncModuleStatus = SyncNotifications.SyncCompleted;
                Sync.SyncAllProgress.Progress++;
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
                Sync.SyncStatus = SyncNotifications.SyncingModule + SyncModules.Payments;
                Sync.SyncDBmodels.usersList = SyncManager.GetUsersFromOnline();
                Sync.SyncModuleList[SyncModules.GetSyncModuleID(SyncModules.Payments)].SyncModuleProgress.Maximum = Sync.SyncDBmodels.usersList.Count + Sync.SyncDBmodels.usersList.Count;                
                //getting Data
                for (int count = 0; count < Sync.SyncDBmodels.usersList.Count; count++)
                {
                    Sync.SyncModuleList[SyncModules.GetSyncModuleID(SyncModules.Payments)].SyncModuleStatus = SyncNotifications.GettingDataFromOnline + " Record " + count;
                    string i = Sync.SyncDBmodels.usersList[count].id;
                    Thread.Sleep(10);
                    Sync.SyncModuleList[SyncModules.GetSyncModuleID(SyncModules.Payments)].SyncModuleProgress.Progress++;
                }
                //Sending Data                
                for (int count = 0; count < Sync.SyncDBmodels.usersList.Count; count++)
                {
                    Sync.SyncModuleList[SyncModules.GetSyncModuleID(SyncModules.Payments)].SyncModuleStatus = SyncNotifications.SendingDataToOnline + " Record " + count;
                    string i = Sync.SyncDBmodels.usersList[count].id;
                    Thread.Sleep(10);
                    Sync.SyncModuleList[SyncModules.GetSyncModuleID(SyncModules.Payments)].SyncModuleProgress.Progress++;
                }
                Sync.SyncModuleList[SyncModules.GetSyncModuleID(SyncModules.Payments)].SyncModuleStatus = SyncNotifications.SyncCompleted;
                Sync.SyncAllProgress.Progress++;
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
