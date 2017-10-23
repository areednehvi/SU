using School_Universe.Views;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Text;
using System.Threading.Tasks;
using System.Windows;

namespace School_Universe.Shared
{
    public class GeneralMethods
    {
        public static void ShowNotification(string Title, string Message, Boolean IsError = false)
        {
            Notification winNotification = new Notification(Title, Message, IsError);
            winNotification.Show();
        }

        public static void CreateGlobalObject(string globalObjectName,object objObject)
        {
            Application.Current.Properties[globalObjectName] = objObject;
        }
        public static object GetGlobalObject(string globalObjectName)
        {
            return Application.Current.Properties[globalObjectName];
        }

        public static bool IsInternetAvailable()
        {
            try
            {
                IPHostEntry ipHe = Dns.GetHostEntry("www.google.com");
                return true;
            }
            catch
            {
                return false;
            }
        }
    }
}
