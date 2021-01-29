using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Lab1_4_GolikovAO
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            errorProvider1.Clear();
            richTextBox1.Text = "";
            try
            {
                double x0 = Convert.ToDouble(textBox1.Text);
                double xk = Convert.ToDouble(textBox2.Text);
                double dx = Convert.ToDouble(textBox3.Text);
                double d = Convert.ToDouble(textBox4.Text);
                richTextBox1.Text = "Голиков А.О. - Вариант 5" + Environment.NewLine;
                richTextBox1.Text += "Результат работы:" + Environment.NewLine;
                // Цикл для табулирования функции
                double x = x0;
                while (x <= (xk + dx / 2))
                {
                    double y = Math.Pow(x, 4) + Math.Cos(2 + Math.Pow(x, 3) - d);
                    richTextBox1.Text += "x=" + Convert.ToString(x) +
                                     "  y=" + Convert.ToString(y) + Environment.NewLine + Environment.NewLine;
                    x = x + dx;
                }
            }
            catch (FormatException)
            {
                errorProvider1.SetError(textBox1, "Некорректные входные данные");
            }


        }

        private void button2_Click(object sender, EventArgs e)
        {
            textBox3.Text = (Convert.ToDouble(textBox3.Text) / 2).ToString();
            button1_Click(sender, e);
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            textBox1.Text = "4,6";
            textBox2.Text = "5,8";
            textBox3.Text = "0,2";
            textBox4.Text = "1,3";
        }
    }
}
