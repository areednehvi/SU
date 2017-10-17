using School_Universe.Models;
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
        private StackPanel _menu;
        private LoginModel _Login;
        private View _View;
        private ICommand _minimizeCommand;
        private ICommand _closeCommand;
        private ICommand _menuCommand;
        private ICommand _loadViewCommand;
        private ICommand _logOutCommand;
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
            _logOutCommand = new RelayCommand(LogOut, CanLogOut);
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
        public StackPanel Menu
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

        public LoginModel Login
        {
            get
            {
                return _Login;
            }
            set
            {
                _Login = value;
                OnPropertyChanged("Login");
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
            if (Menu.Visibility == Visibility.Collapsed)
                Menu.Visibility = Visibility.Visible;
            else
                Menu.Visibility = Visibility.Collapsed;            
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

        #region LogOutCommand

        public ICommand LogOutCommand
        {
            get { return _logOutCommand; }
        }


        public bool CanLogOut(object obj)
        {
            return true;
        }


        public void LogOut(object obj)
        {                        
            for (int intCounter = Application.Current.Windows.Count - 1; intCounter >= 0; intCounter--)
            {
                if(Application.Current.Windows[intCounter] != Window)
                    Application.Current.Windows[intCounter].Close();
            }
            LoginWindow winLogin = new LoginWindow();
            winLogin.Show();
            Window.Close();
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
