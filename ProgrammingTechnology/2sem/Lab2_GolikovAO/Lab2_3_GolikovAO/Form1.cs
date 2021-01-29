using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.OleDb;

namespace Lab2_3_GolikovAO
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        string filebd;

        private void Button1_Click(object sender, EventArgs e)
        {
            OpenFileDialog openfiledialog1 = new OpenFileDialog();
            openfiledialog1.Filter = "Access 2003 (*.mdb)|*.mdb|Access 2007|*.accdb";
            if (openfiledialog1.ShowDialog() == DialogResult.OK)
            {
                filebd = openfiledialog1.FileName;
                using (OleDbConnection con = new OleDbConnection(@"Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + openfiledialog1.FileName))
                {
                    comboBox1.Items.Clear();
                    con.Open();
                    DataTable tbls = con.GetSchema("Tables", new string[] { null, null, null, "TABLE" }); //список всех таблиц
                    foreach (DataRow row in tbls.Rows)
                    {
                        string TableName = row["TABLE_NAME"].ToString();
                        comboBox1.Items.Add(TableName);
                    }
                }

            }
            label1.Visible = true;
            comboBox1.Visible = true;
        }


        private void Button3_Click(object sender, EventArgs e)
        {
            dataGridView1.DataSource = null;
            dataGridView1.Rows.Clear();
            dataGridView1.Columns.Clear();
            dataGridView1.RowCount = 4; //Указываем количество строк
            dataGridView1.ColumnCount = 3; //Указываем количество столбцов
            int[,] a = new int[4, 3]; //Инициализируем массив
            int i, j;
            //Заполняем матрицу случайными числами
            Random rand = new Random();
            for (i = 0; i < 4; i++)
                for (j = 0; j < 3; j++)
                    a[i, j] = rand.Next(-100, 100);
            //Выводим матрицу в dataGridView1
            for (i = 0; i < 4; i++)
                for (j = 0; j < 3; j++)
                    dataGridView1.Rows[i].Cells[j].Value = Convert.ToString(a[i, j]);
        }

        private void Button4_Click(object sender, EventArgs e)
        {
            //производим поиск минимального элемента
            int min = int.MaxValue;
            int n = dataGridView1.RowCount;
            int m = dataGridView1.ColumnCount;
            for (int i = 0; i < n; i++)
                for (int j = 0; j < m; j++)
                    if (Convert.ToInt32(dataGridView1.Rows[i].Cells[j].Value) < min) min = Convert.ToInt32(dataGridView1.Rows[i].Cells[j].Value);
            // выводим результат
            textBox1.Text = Convert.ToString(min);

        }

        private void ComboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
            dataGridView1.DataSource = null;
            dataGridView1.Rows.Clear();
            dataGridView1.RowCount = 1; //Указываем количество строк
            dataGridView1.ColumnCount = 0; //Указываем количество столбцов
            using (OleDbConnection con = new OleDbConnection(@"Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + filebd))
            {
                con.Open();
                OleDbDataAdapter dbAdapter1 = new OleDbDataAdapter(@"SELECT " + comboBox1.SelectedItem + @".* FROM " + comboBox1.SelectedItem, con);
                DataTable dataTable = new DataTable();
                dbAdapter1.Fill(dataTable);
                dataGridView1.DataSource = dataTable;
            }
        }
    }
}
