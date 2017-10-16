using School_Universe.Views;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;

namespace School_Universe.Shared
{
    public class GeneralMethods
    {
        public static void ShowNotification(string Title, string Message)
        {
            Notification winNotification = new Notification(Title, Message);
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
    }
}
