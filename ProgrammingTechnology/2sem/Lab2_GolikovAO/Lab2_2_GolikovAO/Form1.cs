using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace Lab2_2_GolikovAO
{
  

    public partial class Form1 : Form
    {
        double[] Mas = new double[27];

        public Form1()
        {
            InitializeComponent();
        }

      
        private void Button1_Click(object sender, EventArgs e)
        {
            Random rand = new Random();
            textBox1.Text = "";
            for (int i = 0; i < 27; i++)
            {
                Mas[i] = Math.Round(rand.NextDouble(-50.0, 50.0),3);
                textBox1.Text += "X[" + Convert.ToString(i) + "] = "
                    + Convert.ToString(Mas[i]) + Environment.NewLine;
            }
        }

        private void Button2_Click(object sender, EventArgs e)
        {
            textBox2.Text = "";
            textBox3.Text = "";
            for (int i = 0; i < 27; i++)
            {
                double y = Math.Round(6.85 * Math.Pow(Mas[i], 2) - 1.52, 3);
                textBox2.Text += "Y[" + Convert.ToString(i) + "] = "
                    + Convert.ToString(y) + Environment.NewLine;
                if (y < 0)
                {
                    double a = Math.Round(Math.Pow(Mas[i], 3) - 0.62, 3);
                    textBox3.Text += "a[" + Convert.ToString(i) + "] = "
                    + Convert.ToString(a) + Environment.NewLine;
                }
                else
                {
                    double b = Math.Round(1 / Math.Pow(Mas[i], 2), 3);
                    textBox3.Text += "b[" + Convert.ToString(i) + "] = "
                    + Convert.ToString(b) + Environment.NewLine;
                }
            }   

        }
    }
    public static class RandomExtensions
    {
        public static double NextDouble(this Random random, double minValue, double maxValue)
        {
            return random.NextDouble() * (maxValue - minValue) + minValue;
        }
    }

}
