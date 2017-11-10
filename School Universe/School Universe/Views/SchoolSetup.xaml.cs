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
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace School_Universe.Views
{
    /// <summary>
    /// </summary>
    public partial class SchoolSetup : Window
    {
        public SchoolSetup()
        {
            InitializeComponent();
            ((SchoolSetupController)grdSchoolSetup.DataContext).Window = this;
        }
    }
}