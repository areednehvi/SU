﻿using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace School_Universe.Models
{
    public class SettingsModel : INotifyPropertyChanged
    {     
        private ObservableCollection<NoOfRowsInGridsModel> _NoOfRowsInGrids;
        private Boolean _AlwaysShowMenuBar;
        public ObservableCollection<NoOfRowsInGridsModel> NoOfRowsInGrids
        {
            get
            {
                return _NoOfRowsInGrids;
            }
            set
            {
                _NoOfRowsInGrids = value;
                OnPropertyChanged("NoOfRowsInGrids");
            }
        }

        public Boolean AlwaysShowMenuBar
        {
            get
            {
                return _AlwaysShowMenuBar;
            }
            set
            {
                _AlwaysShowMenuBar = value;
                OnPropertyChanged("AlwaysShowMenuBar");
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
    public class NoOfRowsInGridsModel
    {
        public string name { get; set; }
        public string id { get; set; }
    }
}
