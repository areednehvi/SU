using School_Universe.Views;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace School_Universe.Shared
{
    public class GeneralMethods
    {
        public static void ShowNotification(string Title, string Message)
        {
            Notification winNotification = new Notification("Notification", "Payment Saved Successfully!");
            winNotification.Show();
        }
    }
}
