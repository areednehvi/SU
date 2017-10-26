using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace School_Universe_Models.Models
{
    public class DBModels
    {
        #region DB Models
        public class fee_categoriesModel
        {
            public string id { get; set; }
            public string school_id { get; set; }
            public string name { get; set; }
            public string recur { get; set; }
            public string is_transport { get; set; }
            public string order { get; set; }
            public string created_by { get; set; }
            public DateTime created_on { get; set; }
            public string updated_by { get; set; }
            public DateTime updated_on { get; set; }
        }
        public class feesModel
        {
            public string id { get; set; }
            public string school_id { get; set; }
            public string fee_category { get; set; }
            public string session_id { get; set; }
            public Double amount { get; set; }
            public string fee_cources { get; set; }
            public string last_date { get; set; }
            public string last_day { get; set; }
            public Double fine_per_day { get; set; }
            public string is_allocated { get; set; }
            public string remarks { get; set; }
            public string created_by { get; set; }
            public DateTime created_on { get; set; }
            public string updated_by { get; set; }
            public DateTime updated_on { get; set; }

        }
        public class filesModel
        {
            public string id { get; set; }
            public string name { get; set; }
            public string extension { get; set; }
            public string size { get; set; }
            public string school_id { get; set; }
            public string owner_user_id { get; set; }
            public DateTime created { get; set; }

        }
        public class SyncTableInfoModel
        {
            public string id_offline { get; set; }
            public string TableName { get; set; }
            public DateTime LastSyncedOn { get; set; }
        }
        #endregion
    }
}
