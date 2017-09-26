﻿using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace School_Universe.Models
{
    public class FeeCollectionStudentList
    {
        public Int64 id { get; set; }
        public Int64 school_id { get; set; }
        public Int64 registration_id { get; set; }
        public string status { get; set; }
        public string file_id { get; set; }
        public Int64 session_id { get; set; }
        public Int64 fees_id { get; set; }
        public Int64 grade_fees_id { get; set; }
        public DateTime apply_from { get; set; }
        public DateTime apply_to { get; set; }
        public Double concession_amount { get; set; }
        public Double fine { get; set; }
        public Int64 grade_id { get; set; }
        public Int64 section_id { get; set; }
        public string full_name { get; set; }
        public string roll_number { get; set; }
        public string section_name { get; set; }
        public Int64 order { get; set; }
        public string grade_section { get; set; }
        public Int64 allocated_fee_cource_count { get; set; }
        public string parentage { get; set; }
    }
    public class FeeCollectionListFilters : INotifyPropertyChanged
    {        
        private string _class;
        private string _section;
        private string _rollNumber;
        private string _registrationID;
        private string _concessionAmount;

        public string Class
        {
            get
            {
                return _class;
            }
            set
            {
                _class = value;
                OnPropertyChanged("Class");
            }
        }
        

        public string Section
        {
            get
            {
                return _section;
            }
            set
            {
                _section = value;
                OnPropertyChanged("Section");
            }

        }

        public string RollNumber
        {
            get
            {
                return _rollNumber;
            }
            set
            {
                _rollNumber = value;
                OnPropertyChanged("RollNumber");
            }

        }

        public string RegistrationID
        {
            get
            {
                return _registrationID;
            }
            set
            {
                _registrationID = value;
                OnPropertyChanged("RegistrationID");
            }

        }

        public string ConcessionAmount
        {
            get
            {
                return _concessionAmount;
            }
            set
            {
                _concessionAmount = value;
                OnPropertyChanged("ConcessionAmount");
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

    public class FeeCollectionListOtherFileds : INotifyPropertyChanged
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
