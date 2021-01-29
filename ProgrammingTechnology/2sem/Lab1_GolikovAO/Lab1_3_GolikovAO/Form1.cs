using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Lab1_3_GolikovAO
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }
        private static double F1(object sender, EventArgs e, Func<double, double> funk, double x, double i)
        {
            double l = 0;
            if ((i % 2 == 1) && (x > 0)) l = i * Math.Sqrt(funk(x));
            else if ((i % 2 == 0) && (x < 0)) l = i / (2 * Math.Sqrt(Math.Abs(funk(x))));
            else l = Math.Sqrt(Math.Abs(i * funk(x)));
            return l;
        }
        private void button1_Click(object sender, EventArgs e)
        {
            errorProvider1.Clear();
            richTextBox1.Text = "";
            try
            {
                // Получение исходных данных из TextBox
                double x = Convert.ToDouble(textBox1.Text);
                double p = Convert.ToDouble(textBox2.Text);
                // Ввод исходных данных в окно результатов
                richTextBox1.Text = "Голиков А.О. - Вариант 5"  + Environment.NewLine;
                richTextBox1.Text += "Результаты работы программы: " + Environment.NewLine;
                richTextBox1.Text += "При x = " + textBox1.Text + Environment.NewLine;
                richTextBox1.Text += "При i = " + textBox2.Text + Environment.NewLine;

                // Определение номера выбранной функции
                int n = 0;
                if (radioButton2.Checked) n = 1;
                else if (radioButton3.Checked) n = 2;
                double l = 0;
                switch (n)
                {
                    case 0:
                        l = F1(sender, e, T => ((Math.Exp(T) + Math.Exp(-T)) / 2), x, p);
                        richTextBox1.Text += "Решение найдено " + l.ToString() + Environment.NewLine;
                        break;
                    case 1:
                        l = F1(sender, e, T => (Math.Pow(T, 2)), x, p);
                        richTextBox1.Text += "Решение найдено " + l.ToString() + Environment.NewLine;
                        break;
                    case 2:
                        l = F1(sender, e, T => (Math.Exp(T)), x, p);
                        richTextBox1.Text += "Решение найдено " + l.ToString() + Environment.NewLine;
                        break;


                    default:
                        richTextBox1.Text += "Решение не найдено" + Environment.NewLine;
                        break;
                }
            }
            catch (FormatException)
            {
                errorProvider1.SetError(textBox1, "Некорректные входные данные");
            }

        }

        private void button2_Click(object sender, EventArgs e)
        {
            errorProvider1.Clear();
            richTextBox1.Text = "";
            textBox1.Text = "";
            textBox2.Text = "";
        }

        private void Label1_Click(object sender, EventArgs e)
        {

        }
    }
}
