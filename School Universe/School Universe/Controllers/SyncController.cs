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
            string SyncModuleName = (string)obj;

            if (SyncModules.Users == SyncModuleName)
                IsEnabled = true;
            else if (SyncModules.Students == SyncModuleName)
                IsEnabled = Sync.SyncModuleList[SyncModules.GetSyncModuleID(SyncModules.Users)].SyncModuleStatus == SyncNotifications.SyncCompleted ? true : false;
            else if (SyncModules.Grades == SyncModuleName)
                IsEnabled = Sync.SyncModuleList[SyncModules.GetSyncModuleID(SyncModules.Students)].SyncModuleStatus == SyncNotifications.SyncCompleted ? true : false;
            else if (SyncModules.Transportation == SyncModuleName)
                IsEnabled = Sync.SyncModuleList[SyncModules.GetSyncModuleID(SyncModules.Grades)].SyncModuleStatus == SyncNotifications.SyncCompleted ? true : false;
            else if (SyncModules.Fees == SyncModuleName)
                IsEnabled = Sync.SyncModuleList[SyncModules.GetSyncModuleID(SyncModules.Transportation)].SyncModuleStatus == SyncNotifications.SyncCompleted ? true : false;
            else if (SyncModules.Payments == SyncModuleName)
                IsEnabled = Sync.SyncModuleList[SyncModules.GetSyncModuleID(SyncModules.Fees)].SyncModuleStatus == SyncNotifications.SyncCompleted ? true : false;
            return IsEnabled;
        }


        public void StartSync(object obj)
        {
            try
            {
                Sync.CurrentSyncModule = (string)obj;

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

        #region 1. Users
        private Boolean SyncUsers()
        {
            Boolean IsSuccess = false;
            try
            {
                Sync.SyncStatus = SyncNotifications.SyncingModule + SyncModules.Users;

                GetUsersDataFromOnline();

                SyncUsersOnlineData();
                                                                
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

        private void GetUsersDataFromOnline()
        {
            Sync.SyncDBmodels.usersList = SyncManager.GetUsersFromOnline();
            Sync.SyncDBmodels.user_avatar_filesList = SyncManager.GetUserAvatarFilesFromOnline();
            Sync.SyncDBmodels.filesList = SyncManager.GetFilesFromOnline();

            Sync.SyncModuleList[SyncModules.GetSyncModuleID(SyncModules.Users)].SyncModuleProgress.Maximum = 
                Sync.SyncDBmodels.usersList.Count + 
                Sync.SyncDBmodels.user_avatar_filesList.Count + 
                Sync.SyncDBmodels.filesList.Count;
        }

        private void SyncUsersOnlineData()
        {
            //users
            for (int count = 0; count < Sync.SyncDBmodels.usersList.Count; count++)
            {
                Sync.SyncModuleList[SyncModules.GetSyncModuleID(SyncModules.Users)].SyncModuleStatus = SyncNotifications.GettingDataFromOnline + " Record " + count;
                string i = Sync.SyncDBmodels.usersList[count].id;
                Thread.Sleep(10);
                Sync.SyncModuleList[SyncModules.GetSyncModuleID(SyncModules.Users)].SyncModuleProgress.Progress++;
            }

            //user_avatar_files
            for (int count = 0; count < Sync.SyncDBmodels.user_avatar_filesList.Count; count++)
            {
                Sync.SyncModuleList[SyncModules.GetSyncModuleID(SyncModules.Users)].SyncModuleStatus = SyncNotifications.GettingDataFromOnline + " Record " + count;
                string i = Sync.SyncDBmodels.user_avatar_filesList[count].id;
                Thread.Sleep(10);
                Sync.SyncModuleList[SyncModules.GetSyncModuleID(SyncModules.Users)].SyncModuleProgress.Progress++;
            }
            
            //files
            for (int count = 0; count < Sync.SyncDBmodels.filesList.Count; count++)
            {
                Sync.SyncModuleList[SyncModules.GetSyncModuleID(SyncModules.Users)].SyncModuleStatus = SyncNotifications.GettingDataFromOnline + " Record " + count;
                string i = Sync.SyncDBmodels.filesList[count].id;
                Thread.Sleep(10);
                Sync.SyncModuleList[SyncModules.GetSyncModuleID(SyncModules.Users)].SyncModuleProgress.Progress++;
            }
        }        

        #endregion

        #region 2. Students

        private Boolean SyncStudents()
        {
            Boolean IsSuccess = false;
            try
            {
                Sync.SyncStatus = SyncNotifications.SyncingModule + SyncModules.Students;

                GetStudentsDataFromOnline();

                SyncStudentsOnlineData();
                                              
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

        private void GetStudentsDataFromOnline()
        {
            
            Sync.SyncDBmodels.studentsList = SyncManager.GetStudentsFromOnline();
            Sync.SyncDBmodels.parentsList = SyncManager.GetParentsFromOnline();

            Sync.SyncModuleList[SyncModules.GetSyncModuleID(SyncModules.Students)].SyncModuleProgress.Maximum = 
                Sync.SyncDBmodels.studentsList.Count + 
                Sync.SyncDBmodels.parentsList.Count;
        }

        private void  SyncStudentsOnlineData()
        {
            //students
            for (int count = 0; count < Sync.SyncDBmodels.studentsList.Count; count++)
            {
                Sync.SyncModuleList[SyncModules.GetSyncModuleID(SyncModules.Students)].SyncModuleStatus = SyncNotifications.GettingDataFromOnline + " Record " + count;
                string i = Sync.SyncDBmodels.studentsList[count].id;
                Thread.Sleep(10);
                Sync.SyncModuleList[SyncModules.GetSyncModuleID(SyncModules.Students)].SyncModuleProgress.Progress++;
            }
            //parents
            Sync.SyncDBmodels.parentsList = SyncManager.GetParentsFromOnline();
            for (int count = 0; count < Sync.SyncDBmodels.parentsList.Count; count++)
            {
                Sync.SyncModuleList[SyncModules.GetSyncModuleID(SyncModules.Students)].SyncModuleStatus = SyncNotifications.GettingDataFromOnline + " Record " + count;
                string i = Sync.SyncDBmodels.parentsList[count].id;
                Thread.Sleep(10);
                Sync.SyncModuleList[SyncModules.GetSyncModuleID(SyncModules.Students)].SyncModuleProgress.Progress++;
            }
        }

        #endregion

        #region 3. Grades

        private Boolean SyncGrades()
        {
            Boolean IsSuccess = false;
            try
            {
                Sync.SyncStatus = SyncNotifications.SyncingModule + SyncModules.Grades;

                GetGradesDataFromOnline();

                SyncGradesOnlineData();
                                               
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

        private void GetGradesDataFromOnline()
        {
            Sync.SyncDBmodels.gradesList = SyncManager.GetGradesFromOnline();
            Sync.SyncDBmodels.sectionsList = SyncManager.GetSectionsFromOnline();
            Sync.SyncDBmodels.sessionsList = SyncManager.GetSessionsFromOnline();
            Sync.SyncDBmodels.student_grade_session_logList = SyncManager.GetStudentGradeSessionLogFromOnline();

            Sync.SyncModuleList[SyncModules.GetSyncModuleID(SyncModules.Grades)].SyncModuleProgress.Maximum = 
                Sync.SyncDBmodels.gradesList.Count + 
                Sync.SyncDBmodels.sectionsList.Count + 
                Sync.SyncDBmodels.sessionsList.Count + 
                Sync.SyncDBmodels.student_grade_session_logList.Count;
        }

        private void SyncGradesOnlineData()
        {
            //grades
            for (int count = 0; count < Sync.SyncDBmodels.gradesList.Count; count++)
            {
                Sync.SyncModuleList[SyncModules.GetSyncModuleID(SyncModules.Grades)].SyncModuleStatus = SyncNotifications.GettingDataFromOnline + " Record " + count;
                string i = Sync.SyncDBmodels.gradesList[count].id;
                Thread.Sleep(10);
                Sync.SyncModuleList[SyncModules.GetSyncModuleID(SyncModules.Grades)].SyncModuleProgress.Progress++;
            }
            //sections                
            for (int count = 0; count < Sync.SyncDBmodels.sectionsList.Count; count++)
            {
                Sync.SyncModuleList[SyncModules.GetSyncModuleID(SyncModules.Grades)].SyncModuleStatus = SyncNotifications.GettingDataFromOnline + " Record " + count;
                string i = Sync.SyncDBmodels.sectionsList[count].id;
                Thread.Sleep(10);
                Sync.SyncModuleList[SyncModules.GetSyncModuleID(SyncModules.Grades)].SyncModuleProgress.Progress++;
            }
            //sessions                
            for (int count = 0; count < Sync.SyncDBmodels.sessionsList.Count; count++)
            {
                Sync.SyncModuleList[SyncModules.GetSyncModuleID(SyncModules.Grades)].SyncModuleStatus = SyncNotifications.GettingDataFromOnline + " Record " + count;
                string i = Sync.SyncDBmodels.sessionsList[count].id;
                Thread.Sleep(10);
                Sync.SyncModuleList[SyncModules.GetSyncModuleID(SyncModules.Grades)].SyncModuleProgress.Progress++;
            }
            //student_grade_session_log                
            for (int count = 0; count < Sync.SyncDBmodels.student_grade_session_logList.Count; count++)
            {
                Sync.SyncModuleList[SyncModules.GetSyncModuleID(SyncModules.Grades)].SyncModuleStatus = SyncNotifications.GettingDataFromOnline + " Record " + count;
                string i = Sync.SyncDBmodels.student_grade_session_logList[count].id;
                Thread.Sleep(10);
                Sync.SyncModuleList[SyncModules.GetSyncModuleID(SyncModules.Grades)].SyncModuleProgress.Progress++;
            }
        }

        #endregion

        #region 4. Transportation
        private Boolean SyncTransportation()
        {
            Boolean IsSuccess = false;
            try
            {
                Sync.SyncStatus = SyncNotifications.SyncingModule + SyncModules.Transportation;

                GetTransportationDataFromOnline();

                SyncTransportationOnlineData();                

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

        private void GetTransportationDataFromOnline()
        {
            Sync.SyncDBmodels.vehiclesList = SyncManager.GetVehiclesFromOnline();
            Sync.SyncDBmodels.routesList = SyncManager.GetRoutesFromOnline();
            Sync.SyncDBmodels.route_stopsList = SyncManager.GetRouteStopsFromOnline();
            Sync.SyncDBmodels.route_vehiclesList = SyncManager.GetRouteVehiclesFromOnline();
            Sync.SyncDBmodels.route_vehicle_stopsList = SyncManager.GetRouteVehicleStopsFromOnline();         
            Sync.SyncDBmodels.trip_stopsList = SyncManager.GetTripStopsFromOnline();

            Sync.SyncModuleList[SyncModules.GetSyncModuleID(SyncModules.Transportation)].SyncModuleProgress.Maximum =
                Sync.SyncDBmodels.vehiclesList.Count +
                Sync.SyncDBmodels.routesList.Count +
                Sync.SyncDBmodels.route_stopsList.Count +
                Sync.SyncDBmodels.route_vehiclesList.Count +
                Sync.SyncDBmodels.route_vehicle_stopsList.Count +
                Sync.SyncDBmodels.trip_stopsList.Count;
        }

        private void SyncTransportationOnlineData()
        {
            //vehicles
            for (int count = 0; count < Sync.SyncDBmodels.vehiclesList.Count; count++)
            {
                Sync.SyncModuleList[SyncModules.GetSyncModuleID(SyncModules.Transportation)].SyncModuleStatus = SyncNotifications.GettingDataFromOnline + " Record " + count;
                string i = Sync.SyncDBmodels.vehiclesList[count].id;
                Thread.Sleep(10);
                Sync.SyncModuleList[SyncModules.GetSyncModuleID(SyncModules.Transportation)].SyncModuleProgress.Progress++;
            }
            //routes
            for (int count = 0; count < Sync.SyncDBmodels.routesList.Count; count++)
            {
                Sync.SyncModuleList[SyncModules.GetSyncModuleID(SyncModules.Transportation)].SyncModuleStatus = SyncNotifications.GettingDataFromOnline + " Record " + count;
                string i = Sync.SyncDBmodels.routesList[count].id;
                Thread.Sleep(10);
                Sync.SyncModuleList[SyncModules.GetSyncModuleID(SyncModules.Transportation)].SyncModuleProgress.Progress++;
            }
            //route_stops
            for (int count = 0; count < Sync.SyncDBmodels.route_stopsList.Count; count++)
            {
                Sync.SyncModuleList[SyncModules.GetSyncModuleID(SyncModules.Transportation)].SyncModuleStatus = SyncNotifications.GettingDataFromOnline + " Record " + count;
                string i = Sync.SyncDBmodels.route_stopsList[count].id;
                Thread.Sleep(10);
                Sync.SyncModuleList[SyncModules.GetSyncModuleID(SyncModules.Transportation)].SyncModuleProgress.Progress++;
            }
            //route_vehicles
            for (int count = 0; count < Sync.SyncDBmodels.route_vehiclesList.Count; count++)
            {
                Sync.SyncModuleList[SyncModules.GetSyncModuleID(SyncModules.Transportation)].SyncModuleStatus = SyncNotifications.GettingDataFromOnline + " Record " + count;
                string i = Sync.SyncDBmodels.route_vehiclesList[count].id;
                Thread.Sleep(10);
                Sync.SyncModuleList[SyncModules.GetSyncModuleID(SyncModules.Transportation)].SyncModuleProgress.Progress++;
            }
            //route_vehicle_stops
            for (int count = 0; count < Sync.SyncDBmodels.route_vehicle_stopsList.Count; count++)
            {
                Sync.SyncModuleList[SyncModules.GetSyncModuleID(SyncModules.Transportation)].SyncModuleStatus = SyncNotifications.GettingDataFromOnline + " Record " + count;
                string i = Sync.SyncDBmodels.route_vehicle_stopsList[count].id;
                Thread.Sleep(10);
                Sync.SyncModuleList[SyncModules.GetSyncModuleID(SyncModules.Transportation)].SyncModuleProgress.Progress++;
            }
            //trip_stops
            for (int count = 0; count < Sync.SyncDBmodels.trip_stopsList.Count; count++)
            {
                Sync.SyncModuleList[SyncModules.GetSyncModuleID(SyncModules.Transportation)].SyncModuleStatus = SyncNotifications.GettingDataFromOnline + " Record " + count;
                string i = Sync.SyncDBmodels.trip_stopsList[count].id;
                Thread.Sleep(10);
                Sync.SyncModuleList[SyncModules.GetSyncModuleID(SyncModules.Transportation)].SyncModuleProgress.Progress++;
            }
        }
        #endregion

        #region 5. Fees
        private Boolean SyncFees()
        {
            Boolean IsSuccess = false;
            try
            {
                Sync.SyncStatus = SyncNotifications.SyncingModule + SyncModules.Fees;

                GetFeesDataFromOnline();

                SyncFeesOnlineData();

                GetFeesDataFromOffline();

                SyncFeesOfflineData();

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

        private void GetFeesDataFromOnline()
        {
            Sync.SyncDBmodels.fee_categoriesList = SyncManager.GetFeeCategoriesFromOnline();
            Sync.SyncDBmodels.feesList = SyncManager.GetFeesFromOnline();
            Sync.SyncDBmodels.grade_feesList = SyncManager.GetGradeFeesFromOnline();
            Sync.SyncDBmodels.student_feesList = SyncManager.GetStudentFeesFromOnline();
            Sync.SyncDBmodels.route_vehicle_stops_fee_logsList = SyncManager.GetRouteVehicleStopsFeeLogsFromOnline();

            Sync.SyncModuleList[SyncModules.GetSyncModuleID(SyncModules.Fees)].SyncModuleProgress.Maximum =
                Sync.SyncDBmodels.fee_categoriesList.Count +
                Sync.SyncDBmodels.feesList.Count +
                Sync.SyncDBmodels.grade_feesList.Count +
                Sync.SyncDBmodels.student_feesList.Count +
                Sync.SyncDBmodels.route_vehicle_stops_fee_logsList.Count;
        }

        private void SyncFeesOnlineData()
        {
            //fee_categories
            for (int count = 0; count < Sync.SyncDBmodels.fee_categoriesList.Count; count++)
            {
                Sync.SyncModuleList[SyncModules.GetSyncModuleID(SyncModules.Fees)].SyncModuleStatus = SyncNotifications.GettingDataFromOnline + " Record " + count;
                string i = Sync.SyncDBmodels.fee_categoriesList[count].id;
                Thread.Sleep(10);
                Sync.SyncModuleList[SyncModules.GetSyncModuleID(SyncModules.Fees)].SyncModuleProgress.Progress++;
            }
            //fees               
            for (int count = 0; count < Sync.SyncDBmodels.feesList.Count; count++)
            {
                Sync.SyncModuleList[SyncModules.GetSyncModuleID(SyncModules.Fees)].SyncModuleStatus = SyncNotifications.GettingDataFromOnline + " Record " + count;
                string i = Sync.SyncDBmodels.feesList[count].id;
                Thread.Sleep(10);
                Sync.SyncModuleList[SyncModules.GetSyncModuleID(SyncModules.Fees)].SyncModuleProgress.Progress++;
            }
            //grade_fees               
            for (int count = 0; count < Sync.SyncDBmodels.grade_feesList.Count; count++)
            {
                Sync.SyncModuleList[SyncModules.GetSyncModuleID(SyncModules.Fees)].SyncModuleStatus = SyncNotifications.GettingDataFromOnline + " Record " + count;
                string i = Sync.SyncDBmodels.grade_feesList[count].id;
                Thread.Sleep(10);
                Sync.SyncModuleList[SyncModules.GetSyncModuleID(SyncModules.Fees)].SyncModuleProgress.Progress++;
            }
            //student_fees               
            for (int count = 0; count < Sync.SyncDBmodels.student_feesList.Count; count++)
            {
                Sync.SyncModuleList[SyncModules.GetSyncModuleID(SyncModules.Fees)].SyncModuleStatus = SyncNotifications.GettingDataFromOnline + " Record " + count;
                string i = Sync.SyncDBmodels.student_feesList[count].id;
                Thread.Sleep(10);
                Sync.SyncModuleList[SyncModules.GetSyncModuleID(SyncModules.Fees)].SyncModuleProgress.Progress++;
            }
            //route_vehicle_stops_fee_logs               
            for (int count = 0; count < Sync.SyncDBmodels.route_vehicle_stops_fee_logsList.Count; count++)
            {
                Sync.SyncModuleList[SyncModules.GetSyncModuleID(SyncModules.Fees)].SyncModuleStatus = SyncNotifications.GettingDataFromOnline + " Record " + count;
                string i = Sync.SyncDBmodels.route_vehicle_stops_fee_logsList[count].id;
                Thread.Sleep(10);
                Sync.SyncModuleList[SyncModules.GetSyncModuleID(SyncModules.Fees)].SyncModuleProgress.Progress++;
            }
        }
        private void GetFeesDataFromOffline()
        {
            Sync.SyncDBmodels.student_feesList = SyncManager.GetStudentFeesFromOffline();

            Sync.SyncModuleList[SyncModules.GetSyncModuleID(SyncModules.Fees)].SyncModuleProgress.Maximum =
               Sync.SyncDBmodels.student_feesList.Count;
        }
        private void SyncFeesOfflineData()
        {
            //student_fees
            for (int count = 0; count < Sync.SyncDBmodels.student_feesList.Count; count++)
            {
                Sync.SyncModuleList[SyncModules.GetSyncModuleID(SyncModules.Fees)].SyncModuleStatus = SyncNotifications.SendingDataToOnline + " Record " + count;
                string i = Sync.SyncDBmodels.student_feesList[count].id;
                Thread.Sleep(10);
                Sync.SyncModuleList[SyncModules.GetSyncModuleID(SyncModules.Fees)].SyncModuleProgress.Progress++;
            }
        }

        
        #endregion

        #region 6. Payments
        private Boolean SyncPayments()
        {
            Boolean IsSuccess = false;
            try
            {
                Sync.SyncStatus = SyncNotifications.SyncingModule + SyncModules.Payments;

                GetPaymentsDataFromOnline();

                SyncPaymentsOnlineData();

                GetPaymentsDataFromOffline();

                SyncPaymentsOfflineData();

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

        private void GetPaymentsDataFromOnline()
        {
            Sync.SyncDBmodels.student_paymentsList = SyncManager.GetStudentPaymentsFromOnline();

            Sync.SyncModuleList[SyncModules.GetSyncModuleID(SyncModules.Payments)].SyncModuleProgress.Maximum =
                Sync.SyncDBmodels.student_paymentsList.Count;
        }

        private void SyncPaymentsOnlineData()
        {
            //student_payments
            for (int count = 0; count < Sync.SyncDBmodels.student_paymentsList.Count; count++)
            {
                Sync.SyncModuleList[SyncModules.GetSyncModuleID(SyncModules.Payments)].SyncModuleStatus = SyncNotifications.GettingDataFromOnline + " Record " + count;
                string i = Sync.SyncDBmodels.student_paymentsList[count].id;
                Thread.Sleep(10);
                Sync.SyncModuleList[SyncModules.GetSyncModuleID(SyncModules.Payments)].SyncModuleProgress.Progress++;
            }
        }
        private void GetPaymentsDataFromOffline()
        {
            Sync.SyncDBmodels.student_paymentsList = SyncManager.GetStudentPaymentsFromOnline();

            Sync.SyncModuleList[SyncModules.GetSyncModuleID(SyncModules.Payments)].SyncModuleProgress.Maximum =
                Sync.SyncDBmodels.student_paymentsList.Count;
        }

        private void SyncPaymentsOfflineData()
        {
            //student_payments
            for (int count = 0; count < Sync.SyncDBmodels.student_paymentsList.Count; count++)
            {
                Sync.SyncModuleList[SyncModules.GetSyncModuleID(SyncModules.Payments)].SyncModuleStatus = SyncNotifications.SendingDataToOnline + " Record " + count;
                string i = Sync.SyncDBmodels.student_paymentsList[count].id;
                Thread.Sleep(10);
                Sync.SyncModuleList[SyncModules.GetSyncModuleID(SyncModules.Payments)].SyncModuleProgress.Progress++;
            }
        }
        #endregion

        #endregion

    }
}
