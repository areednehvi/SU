using School_Universe.Controllers;
using School_Universe.Models;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
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

            try
            {
                //var httpWebRequest = (HttpWebRequest)WebRequest.Create("http://volcanix.schooluniverse.in/web-services/student_payments");
                //httpWebRequest.ContentType = "application/json; charset=utf-8";
                //httpWebRequest.Method = "GET";

                //var response = (HttpWebResponse)httpWebRequest.GetResponse();
                //string returnedJSON;
                //using (var sr = new StreamReader(response.GetResponseStream()))
                //{
                //    returnedJSON = sr.ReadToEnd();
                //}


                //var request = (HttpWebRequest)WebRequest.Create("http://volcanix.schooluniverse.in/web-services/fees_payments_post");

                ////var postData = "data=hello";
                //var postData = "data=";
                ////postData += "[{\"id\" : \"2344\"}]";
                //postData += returnedJSON;
                //var data = Encoding.ASCII.GetBytes(postData);

                //request.Method = "POST";
                //request.ContentType = "application/x-www-form-urlencoded";
                //request.ContentLength = data.Length;

                //using (var stream = request.GetRequestStream())
                //{
                //    stream.Write(data, 0, data.Length);
                //}

                //response = (HttpWebResponse)request.GetResponse();

                //var responseString = new StreamReader(response.GetResponseStream()).ReadToEnd();


            }
            catch (Exception ex)
            {
                throw ex;
            }

        }
        public Main(LoginModel objLogin)
        {
            InitializeComponent();
            ((MainController)grdMain.DataContext).Window = this;
            ((MainController)grdMain.DataContext).Menu = this.menu;

            if (objLogin != null)
                ((MainController)grdMain.DataContext).Login = objLogin;
        }

    }
}
