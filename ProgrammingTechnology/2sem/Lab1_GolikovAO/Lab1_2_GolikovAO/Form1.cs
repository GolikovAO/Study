using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Lab1_2_GolikovAO
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }
        private void Form1_Load_1(object sender, EventArgs e)
        {
            textBox1.Text = "-15,246";  // Начальное значение X
            textBox2.Text = "0,04642"; // Начальное значение Y
            textBox3.Text = "2000,1";// Начальное значение Z
            richTextBox1.Text = "Голиков А.О. - Вариант 5";
        }



        private void button1_Click(object sender, EventArgs e)
        {
            errorProvider1.Clear();
            try
            {
                richTextBox1.Text = "Голиков А.О. - Вариант 5";
                // Считывание значения X
                double x = double.Parse(textBox1.Text);
                // Вывод значения X в окно
                richTextBox1.Text += Environment.NewLine +
                        "X = " + x.ToString();
                // Считывание значения Y
                double y = double.Parse(textBox2.Text);
                // Вывод значения Y в окно
                richTextBox1.Text += Environment.NewLine +
                    "Y = " + y.ToString();
                // Считывание значения Z
                double z = double.Parse(textBox3.Text);
                // Вывод значения Z в окно
                richTextBox1.Text += Environment.NewLine +
                    "Z = " + z.ToString();


                double first = Math.Log(Math.Pow(y, -Math.Sqrt(Math.Abs(x))));
                double second = x - y / 2;
                double third = Math.Pow(Math.Sin(Math.Atan(z)),2);
                double a = first * second + third;
                // Выводим результат в окно
                richTextBox1.Text += Environment.NewLine +
                    "Результат: a = " + a.ToString();

            }
            catch (FormatException)
            {
                errorProvider1.SetError(textBox1, "Некорректные входные данные");
            }
            catch (ArgumentException)
            {
                errorProvider1.SetError(richTextBox1, "Отрицательное подкоренное выражение");
            }
            catch (DivideByZeroException)
            {
                errorProvider1.SetError(richTextBox1, "Деление на ноль");
            }
        }
    }
}
