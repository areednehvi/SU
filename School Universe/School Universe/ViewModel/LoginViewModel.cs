using School_Universe.Models;
using School_Universe.Shared;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Input;

namespace School_Universe.ViewModel
{
    class LoginViewModel
    {
        private Login _login;
        private ICommand _chkLogin;
        public LoginViewModel()
        {
            _login = new Login
            {
                Username = "Areed"
                
            };
            _chkLogin = new RelayCommand(CheckLogin, CanAdd);
        }

        public ICommand LoginCommand
        {
            get { return _chkLogin; }        
        }

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

      
        public bool CanAdd(object obj)
        {
          
            //if (Login.Username != string.Empty)
                return true;
            //return false;
        }

       
        public void CheckLogin(object obj)
        {
            MessageBox.Show(Login.Username);
            Login.Username = "Arif";
        }
        #endregion

    }
}
