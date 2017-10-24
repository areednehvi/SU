﻿using School_Universe.Models;
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
        private int _Maximum;
        #endregion

        #region Constructor
        public SettingsController()
        {
            _Settings = new SettingsModel();
            _SelectedNoOfRowsInGrids = new NoOfRowsInGridsModel();

            //Get Settings Drop down lists
            this.GetSettingsDropDownLists();
            //Get Settings
            this.GetSettings();

            //Subscribe to Model's Property changed event
            this.Settings.PropertyChanged += (s, e) => {
                if(e.PropertyName == SettingDefinitions.AlwaysShowMenuBar)
                {
                    //Save to DB
                    SettingsManager.SaveSetting(SettingDefinitions.AlwaysShowMenuBar, Settings.AlwaysShowMenuBar.ToString());
                }
            };
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
                OnPropertyChanged("Settings");
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
                OnPropertyChanged("SelectedNoOfRowsInGrids");
                //Save to DB
                SettingsManager.SaveSetting(SettingDefinitions.NoOfRowsInGrids,SelectedNoOfRowsInGrids.id);
                //Close Other Windows
                CloseOtherWindows();
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
        private void GetSettings()
        {
            //NoOfRecordsInGrids
            var noOfRecords = SettingsManager.GetSetting(SettingDefinitions.NoOfRowsInGrids);
            noOfRecords = noOfRecords != null ? noOfRecords : "50";
            SelectedNoOfRowsInGrids = new NoOfRowsInGridsModel() { id = noOfRecords, name = noOfRecords };
            //AlwaysShowMenuBar
            var alwaysShowMenuBar = SettingsManager.GetSetting(SettingDefinitions.AlwaysShowMenuBar);
            Settings.AlwaysShowMenuBar = alwaysShowMenuBar == null ? false : Convert.ToBoolean(alwaysShowMenuBar);
        }
        private void CloseOtherWindows()
        {
            for (int intCounter = Application.Current.Windows.Count - 1; intCounter >= 0; intCounter--)
            {
                if (Application.Current.Windows[intCounter].Name == WindowDefnitions.FeeCollectWindow)
                    Application.Current.Windows[intCounter].Close();
            }
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
