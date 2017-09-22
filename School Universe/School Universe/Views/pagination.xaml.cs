using School_Universe_Businness_Layer.Businness;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
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
    /// Interaction logic for pagination.xaml
    /// </summary>
    public partial class pagination : Window
    {
        int start = 1;
        int pageNo = 1;
        int NoOfRecordsPerPage = 500;
        int end;
        public pagination()
        {
            InitializeComponent();
            end = pageNo * NoOfRecordsPerPage;
            //DataTable dt = FeeCollection.GetStudentFeeCollectionList();
            //dataGrid.ItemsSource = dt;

            loadGrid();           

        }

        //int start = 1, pageNo = 1, NoOfRecordsPerPage = 50, end = pageNo * NoOfRecordsPerPage;
        private void button1_Click(object sender, RoutedEventArgs e) //next
        {
            pageNo++;
            start = end + 1;
            end = pageNo * NoOfRecordsPerPage;
            loadGrid();                       
        }

        private void button_Click(object sender, RoutedEventArgs e) //previous
        {
            if(pageNo > 1)
            {
                pageNo--;
                var temp = end;
                end = start - 1;
                start = (end + 1) - NoOfRecordsPerPage;
                loadGrid();
            }            
        }

        public  void loadGrid()
        {
            dataGrid.ItemsSource = null;
            SqlConnection objSqlConnection = new SqlConnection(@"Data Source=.;Initial Catalog=Pagination;Integrated Security=True;");
            DataTable objDatabale = new DataTable();
            string query = "";
            query = query + "WITH mytable AS " + "\n";
            query = query + "        ( " + "\n";
            query = query + "           SELECT *, " + "\n";
            query = query + "            ROW_NUMBER() OVER(order by ID) AS 'RowNumber' " + "\n";
            query = query + "            FROM students " + "\n";
            query = query + "        ) " + "\n";
            query = query + "        SELECT* " + "\n";
            query = query + "        FROM myTable " + "\n";
            query = query + "        WHERE RowNumber BETWEEN " + start + " AND " + end;
            SqlCommand objSqlCommand = new SqlCommand(query, objSqlConnection);
            try
            {
                objSqlConnection.Open();
                objSqlCommand.CommandType = CommandType.Text;
                objSqlCommand.CommandTimeout = 3000;
                SqlDataAdapter da = new SqlDataAdapter(objSqlCommand);
                da.Fill(objDatabale);
                if (pageNo > 1 && objDatabale.Rows.Count == 0)
                {
                    pageNo--;
                    end = start - 1;
                    start = (end + 1) - NoOfRecordsPerPage;
                    loadGrid();                                   
                    return;
                }
                List<object> genericList = new List<object>();
                Student studentObj;
                Random randomObj = new Random();
                foreach (DataRow row in objDatabale.Rows)
                {
                    studentObj = new Student();
                    studentObj.FirstName = row["FirstName"].ToString();
                    studentObj.MiddleName = row["MiddleName"].ToString();
                    studentObj.LastName = row["LastName"].ToString();
                    studentObj.Age = Convert.ToUInt32(row["ID"].ToString());

                    genericList.Add(studentObj);
                }
                dataGrid.ItemsSource = genericList;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                objSqlCommand.Dispose();
                objSqlConnection.Close();
            }

        }
    }
}
