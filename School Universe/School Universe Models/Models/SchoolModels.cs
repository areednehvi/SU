using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace School_Universe.Models
{
    public class SchoolModel 
    {     
        public string id { get; set; }
        public string database_id { get; set; }
        public string subdomain { get; set; }
        public string domain { get; set; }
        public string name { get; set; }
        public string address { get; set; }
        public string phone { get; set; }
        public string theme { get; set; }
        public string pay_u_money_key { get; set; }
        public string pay_u_money_salt { get; set; }
        public string contact_person { get; set; }
        public string licence_key { get; set; }
        public DateTime created_on { get; set; }
    }
}
