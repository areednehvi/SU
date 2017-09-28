using School_Universe.Controllers;
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
    /// Interaction logic for FeeCollectionList.xaml
    /// </summary>
    public partial class FeeCollectionList1 : Window
    {
        public FeeCollectionList1()
        {
            InitializeComponent();
            //this.WindowState = WindowState.Maximized;
            ((FeeCollectionListController)grdFeeCollectionList.DataContext).Window = this;
            ((FeeCollectionListController)grdFeeCollectionList.DataContext).FeeCollectionListDataGrid = this.dataGridFeeCollectionList;
        }
        private void Button_Click(object sender, RoutedEventArgs e)
        {
            if (rect.Visibility == System.Windows.Visibility.Collapsed)
            {
                rect.Visibility = System.Windows.Visibility.Visible;
  
            }
            else
            {
                rect.Visibility = System.Windows.Visibility.Collapsed;
    
            }
        }
    }
}
