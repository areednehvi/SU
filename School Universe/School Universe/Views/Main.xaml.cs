﻿using School_Universe.Controllers;
using School_Universe.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;

namespace School_Universe.Views
{
    /// <summary>
    /// Interaction logic for main.xaml
    /// </summary>
    public partial class Main : Window
    {

        public Main() // remove this moethod once to production
        {
            InitializeComponent();
            ((MainController)grdMain.DataContext).Window = this;
            ((MainController)grdMain.DataContext).Menu = this.menu;

        }
        public Main(Login objLogin)
        {
            InitializeComponent();
            ((MainController)grdMain.DataContext).Window = this;
            ((MainController)grdMain.DataContext).Menu = this.menu;

            if (objLogin != null)
                lblUserName.Content = "User : " + objLogin.Username.ToUpper();
        }

    }
}
