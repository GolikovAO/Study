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

namespace Lab2_GolikovAO
{

    public partial class Form1 : Form
    {
        OleDbConnection connection;

        public Form1()
        {
            InitializeComponent();           
        }

        private int CountNumbers(string s)
        {
            int n = 0;
            int[] mas = s.Split(' ').Select(Int32.Parse).ToArray();
            foreach (int item in mas)
            {
                if (item % 2 == 0) n++;
            }
            return n;
        }

        private void Button1_Click(object sender, EventArgs e)
        {
            string str = (string)listBox1.Items[0];
            label1.Text = "Кол-во четных чисел: " + CountNumbers(str).ToString();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            string str = "56 091 33 39274 2 7 8074 23 480 382661 65 99 13 20 51 86 11 80 841 54 70 96 1";
            listBox1.Items.Clear();
            listBox1.Items.Add(str);
        }

        private void button3_Click(object sender, EventArgs e)
        {
            connection = new OleDbConnection(@"Provider=Microsoft.Jet.OLEDB.4.0;Data Source=E:\учеба\SSU\Технологии программирования\2 семестр\Database_Lab2.mdb");
            connection.Open();
            OleDbCommand thisComand = connection.CreateCommand();
            thisComand.CommandText = @"SELECT Число FROM Числа";
            OleDbDataReader Reader = thisComand.ExecuteReader();
            string str = string.Empty;
            while (Reader.Read())
            {
                str += Reader["Число"] + " ";
            }
            Reader.Close();
            connection.Close();
            str = str.Remove(str.Length - 1, 1);
            listBox1.Items.Clear();
            listBox1.Items.Add(str);
        }
    }
}