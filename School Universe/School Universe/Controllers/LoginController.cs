﻿using School_Universe.Models;
using School_Universe.Shared;
using School_Universe.Views;
using School_Universe_Businness_Layer.Businness;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;

namespace School_Universe.Controllers
{
    class LoginController
    {
        #region Fields
        private LoginModel _login;
        private Window _window;
        private ICommand _loginCommand;
        private ICommand _closeCommand;
        private ICommand _minimizeCommand;
        #endregion

        #region Constructor
        public LoginController()
        {
            _login = new LoginModel();
            _loginCommand = new RelayCommand(AuthenticateUser, CanLogin);
            _closeCommand = new RelayCommand(CloseLogin, CanClose);
            _minimizeCommand = new RelayCommand(MinimizeLogin, CanMinimize);
        }
        #endregion

        #region Properties
        public LoginModel Login
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
        #endregion

        #region LoginCommand
        public ICommand LoginCommand
        {
            get { return _loginCommand; }        
        }

      
        public bool CanLogin(object obj)
        {
          
            if (Login.Username != null)
                return true;
            return false;
        }

       
        public void AuthenticateUser(object obj)
        {
            try
            {
                PasswordBox pwBox = obj as PasswordBox;
                Login.Password = pwBox.Password;
                if (LoginManager.ValidateUser(Login))
                {
                    //Maintain state of Login
                    GeneralMethods.CreateGlobalObject(GlobalObjects.CurrentLogin, Login);                    
                    //open window after authentication
                    Main objMainWindow = new Main(Login);
                    objMainWindow.Show();
                    Window.Close();
                }
                else
                    Login.Message = "Username and password are incorrect";
                
            }
            catch (Exception ex)
            {
                var errorMessage = "Please notify about the error to Admin \n\nERROR : " + ex.Message + "\n\nSTACK TRACE : " + ex.StackTrace;
                MessageBox.Show(errorMessage);
            }
            finally
            {

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

    }
}
