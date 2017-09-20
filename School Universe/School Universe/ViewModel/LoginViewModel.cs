using School_Universe.Models;
using School_Universe.Shared;
using School_Universe.Views;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;

namespace School_Universe.ViewModel
{
    class LoginViewModel
    {
        private Login _login;
        private ICommand _loginCommand;
        private ICommand _closeCommand;
        private ICommand _minimizeCommand;

        #region Constructor
        public LoginViewModel()
        {
            _login = new Login
            {
                Username = "",
                Password = "",
                
            };
            _loginCommand = new RelayCommand(CheckLogin, CanLogin);
            _closeCommand = new RelayCommand(CloseLogin, CanClose);
            _minimizeCommand = new RelayCommand(MinimizeLogin, CanMinimize);
        }
        #endregion

        public Login Login
        {
            get
            {
                return _login;
            }
            set
            {
                _login = value;
            }
        }


        #region LoginCommand
        public ICommand LoginCommand
        {
            get { return _loginCommand; }        
        }

      
        public bool CanLogin(object obj)
        {
          
            if (Login.Username != string.Empty)
                return true;
            return false;
        }

       
        public void CheckLogin(object obj)
        {
            PasswordBox pwBox = obj as PasswordBox;
            Login.Password = pwBox.Password;
            //MessageBox.Show(Login.Username + " " + Login.Password);
            main lw = new main();
            lw.Show();
            
            
            
            
            //Login.Username = "Arif";
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
            Window objWindow = (Window)obj;          
            objWindow.Close();            
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
            Window objWindow = (Window)obj;
            objWindow.WindowState = WindowState.Minimized;
        }
        #endregion

    }
}
