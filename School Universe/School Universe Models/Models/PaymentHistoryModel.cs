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
        public string recept_no { get; set; }
        public DateTime payment_date { get; set; }
        public Double concession_amount { get; set; }
        public string month { get; set; }
        public DateTime apply_from { get; set; }
        public DateTime apply_to { get; set; }
        public Double fee_amount { get; set; }
        public string category_name { get; set; }
    }
    public class PaymentHistoryOtherFileds : INotifyPropertyChanged
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


}
