using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Windows.Forms.DataVisualization.Charting;

namespace Lab2_4_GolikovAO
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }


        private double XMin = 4.6;
        private double XMax = 5.8;
        private double Step = 0.1;

        private double[] x;
        private double[] y;

        Chart chart;

        

        private void CalcFunction()
        {
            // Количество точек графика
            int count = (int)Math.Ceiling((XMax - XMin) / Step);
            dataGridView1.RowCount = count + 1;
            dataGridView1.ColumnCount = 2;
            dataGridView1.Rows[0].Cells[0].Value = "X";
            dataGridView1.Rows[0].Cells[1].Value = "Y";
            // Создаём массивы нужных размеров
            x = new double[count];
            y = new double[count];
            // Расчитываем точки для графиков функции
            for (int i = 0; i < count; i++)
            {
                // Вычисляем значение X
                x[i] = XMin + Step * i;
                // Вычисляем значение функций в точке X
                y[i] = Math.Round(Math.Pow(x[i],4) + Math.Cos(2 + Math.Pow(x[i],3) - 1.3),2);
                dataGridView1.Rows[i + 1].Cells[0].Value = x[i];
                dataGridView1.Rows[i + 1].Cells[1].Value = y[i];
            }
        }

        private void CreateChart()
        {
            chart = new Chart();
            chart.Parent = this;
            chart.SetBounds(0, 0, ClientSize.Width - 40,
                            ClientSize.Height - 40);

            ChartArea area = new ChartArea();
            area.Name = "myGraph";
            area.AxisX.Minimum = XMin;
            area.AxisX.Maximum = XMax;
            area.AxisX.MajorGrid.Interval = Step;
            chart.ChartAreas.Add(area);
            Series series1 = new Series();
            series1.ChartArea = "myGraph";
            series1.ChartType = SeriesChartType.Spline;
            series1.BorderWidth = 3;
            series1.LegendText = "y = x^4 + cos(2 + x^3 - 1.3)";
            chart.Series.Add(series1);
            Legend legend = new Legend();
            chart.Legends.Add(legend);
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            BackColor = Color.White;
            CreateChart();
            CalcFunction();
            chart.Series[0].Points.DataBindXY(x, y);
        }
    }
}
