using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace School_Universe.Models
{
    public class SyncModel : INotifyPropertyChanged
    {
        private string _SyncModule;
        private string _SyncStatus;
        private bool _IsSyncInProgress;
        private SyncProgressModel _SyncProgress;
        private ObservableCollection<SyncTableInfoModel> _SyncTableInfoList;        

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
        public string SyncModule
        {
            get { return _SyncModule; }
            set
            {
                _SyncModule = value;
                OnPropertyChanged("SyncModule");
            }
        }

        public SyncProgressModel SyncProgress
        {
            get { return _SyncProgress; }
            set
            {
                _SyncProgress = value;
                OnPropertyChanged("SyncProgress");
            }
        }

        public ObservableCollection<SyncTableInfoModel> SyncTableInfoList
        {
            get { return _SyncTableInfoList; }
            set
            {
                _SyncTableInfoList = value;
            }
        }

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

    public class SyncProgressModel : INotifyPropertyChanged
    {
        int _Progress;
        Double _ProgressPercentage;
        int _Minimum = 0, _Maximum = 1;

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

    public class SyncTableInfoModel
    {
        public string id_offline { get; set;}
        public string TableName { get; set; }
        public DateTime LastSyncedOn { get; set; }
    }
}
