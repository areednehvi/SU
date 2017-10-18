using School_Universe.Models;
using School_Universe.Shared;
using School_Universe.Views;
using School_Universe_Businness_Layer.Businness;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;

namespace School_Universe.Controllers
{
    public class SettingsController : INotifyPropertyChanged
    {
        #region Fields
        private SettingsModel _Settings;
        private NoOfRowsInGridsModel _SelectedNoOfRowsInGrids;
        #endregion

        #region Constructor
        public SettingsController()
        {
            _Settings = new SettingsModel();
            _SelectedNoOfRowsInGrids = new NoOfRowsInGridsModel();

            //Get Settings Drop down lists
            this.GetSettingsDropDownLists();
        }
        #endregion

        #region Properties
        public SettingsModel Settings
        {
            get
            {
                return _Settings;
            }
            set
            {
                _Settings = value;
            }
        }

        public NoOfRowsInGridsModel SelectedNoOfRowsInGrids
        {
            get
            {
                return _SelectedNoOfRowsInGrids;
            }
            set
            {
                _SelectedNoOfRowsInGrids = value;
                //Save to DB
                SettingsManager.SaveSetting(SelectedNoOfRowsInGrids);
            }
        }

        #endregion

        #region Private Functions
        private void SaveSettings()
        {

        }
        private void GetSettingsDropDownLists()
        {
            Settings.NoOfRowsInGrids = GetListManager.GetNoOfRowsInGridsList();
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
