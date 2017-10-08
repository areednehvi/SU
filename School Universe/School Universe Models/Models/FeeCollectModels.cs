using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace School_Universe.Models
{
    public class PaymentHistoryModel
    {
        public string id { get; set; }
        public Double  amount { get; set; }
        public Double fine { get; set; }
        public string recept_no { get; set; }
        public DateTime payment_date { get; set; }
        public Double concession_amount { get; set; }
        public string month { get; set; }
        public DateTime apply_from { get; set; }
        public DateTime apply_to { get; set; }
        public Double fee_amount { get; set; }
        public string category_name { get; set; }
        public string comment { get; set; }
    }

    public class FeeDueModel : INotifyPropertyChanged
    {
        private Boolean _IsSelected;
        public string id { get; set; }
        public string student_id { get; set; }
        public Double student_balance { get; set; }
        public Double concession_amount { get; set; }
        public DateTime apply_from { get; set; }
        public DateTime apply_to { get; set; }
        public Double fine { get; set; }
        public string category_name { get; set; }        
        public Boolean IsSelected
        {
            get
            {
                return _IsSelected;
            }
            set
            {
                _IsSelected = value;
                OnPropertyChanged("IsSelected");
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
    public class FeeCollectOtherFieldsModel : INotifyPropertyChanged
    {
        private string _pageNo;

        public string PageNo
        {
            get
            {
                return _pageNo;
            }
            set
            {
                _pageNo = value;
                OnPropertyChanged("PageNo");
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

    public class FeeDueFormFieldsModel : INotifyPropertyChanged
    {
        private Double _fine;
        private Double _concession;
        private float _concessionPercentage;

        public Double Fine
        {
            get
            {
                return _fine;
            }
            set
            {
                _fine = value;
                OnPropertyChanged("Fine");
            }
        }

        public Double Concession
        {
            get
            {
                return _concession;
            }
            set
            {
                _concession = value;
                OnPropertyChanged("Concession");
            }
        }

        public float ConcessionPercentage
        {
            get
            {
                return _concessionPercentage;
            }
            set
            {
                _concessionPercentage = value;
                OnPropertyChanged("ConcessionPercentage");
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

    public class FeeDueListFiltersModel : INotifyPropertyChanged
    {
        private FeeCategoryModel _FeeCategory;
        private ObservableCollection<FeeCategoryModel> _FeeCategoryList;


        public FeeCategoryModel FeeCategory
        {
            get
            {
                return _FeeCategory;
            }
            set
            {
                _FeeCategory = value;
                OnPropertyChanged("FeeCategory");
            }
        }

        public ObservableCollection<FeeCategoryModel> FeeCategoryList
        {
            get
            {
                return _FeeCategoryList;
            }
            set
            {
                _FeeCategoryList = value;
                OnPropertyChanged("FeeCategoryList");
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

    public class FeeCategoryModel
    {
        public string id { get; set; }
        public string name { get; set; }
    }


}
