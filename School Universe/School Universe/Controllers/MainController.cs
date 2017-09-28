using School_Universe.Shared;
using School_Universe_Models.Models;
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
    public class MainController : INotifyPropertyChanged
    {
        #region Fields
        private Window _window;
        private Menu _menu;
        private View _View;
        private ICommand _minimizeCommand;
        private ICommand _closeCommand;
        private ICommand _menuCommand;
        private ICommand _loadViewCommand;
        #endregion

        #region Constructor
        public MainController()
        {
            SelectedView = ViewDefinitions.FeeCollectionListView; // startup View
            //Initialize Commands
            _closeCommand = new RelayCommand(CloseLogin, CanClose);
            _minimizeCommand = new RelayCommand(MinimizeLogin, CanMinimize);
            _menuCommand = new RelayCommand(OpenMenu, CanOpenMenu);
            _loadViewCommand = new RelayCommand(LoadView, CanLoadView);
        }
        #endregion

        #region Properties     

        public View SelectedView
        {
            get
            {
                return _View;
            }
            set
            {
                _View = value;
                OnPropertyChanged("SelectedView");
            }
        }
        public Window Window
        {
            get
            {
                return _window;
            }
            set
            {
                _window = value;
            }
        }
        public Menu Menu
        {
            get
            {
                return _menu;
            }
            set
            {
                _menu = value;
            }
        }
        #endregion

        #region CloseCommand

        public ICommand CloseCommand
        {
            get { return _closeCommand; }
        }


        public bool CanClose(object obj)
        {
            return true;
        }


        public void CloseLogin(object obj)
        {
            Window.Close();
        }
        #endregion

        #region MinimizeCommand

        public ICommand MinimizeCommand
        {
            get { return _minimizeCommand; }
        }


        public bool CanMinimize(object obj)
        {
            return true;
        }


        public void MinimizeLogin(object obj)
        {
            Window.WindowState = WindowState.Minimized;
        }
        #endregion

        #region MenuCommand

        public ICommand MenuCommand
        {
            get { return _menuCommand; }
        }


        public bool CanOpenMenu(object obj)
        {
            return true;
        }


        public void OpenMenu(object obj)
        {
            Menu objMenu = (Menu)obj;
            if (objMenu.Visibility == System.Windows.Visibility.Collapsed)
                objMenu.Visibility = System.Windows.Visibility.Visible;
            else
                objMenu.Visibility = System.Windows.Visibility.Collapsed;            
        }
        #endregion

        #region LoadViewCommand

        public ICommand LoadViewCommand
        {
            get { return _loadViewCommand; }
        }


        public bool CanLoadView(object obj)
        {
            return true;
        }


        public void LoadView(object obj)
        {
            View objView = (View)obj;
            SelectedView = objView;
            Menu.Visibility = Visibility.Collapsed;
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
