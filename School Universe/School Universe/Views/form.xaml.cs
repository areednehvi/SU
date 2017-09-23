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
    /// Interaction logic for form.xaml
    /// </summary>
    public partial class form : Window
    {
        public form(ref Student s)
        {
            InitializeComponent();
            textBox.Text = s.FirstName + " : " + s.Age;
        }
    }
}
