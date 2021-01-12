using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ChisMethod2
{
    class Program
    {
        static void Main(string[] args)
        {
            double h = Math.PI / 100;
            int n = 101;
            double a = -Math.PI;
            double b = 0;
            double[] masf = new double[n];
            double[] masf1 = new double[n];
            double[] masx = new double[n];
            masx[0] = a;
           
            for (int i = 1; i<100; i++)
            {
                masx[i] = masx[i - 1] + h;
                Console.WriteLine(masx[i]);
            }
            masx[100] = b;
            Console.WriteLine();
            for (int i = 0; i<100; i++)
            {
                masf[i] = 2 * Math.Pow((masx[i]), 3) * Math.Cos(Math.Pow(masx[i], 2));
                masf1[i] = 2 * Math.Pow((masx[i]+h/2), 3) * Math.Cos(Math.Pow((masx[i]+h/2), 2));
                Console.WriteLine(masf[i]);
            }
            //masf[0]= 2 * Math.Pow((a), 3) * Math.Cos(Math.Pow((a), 2));
            //masf[100] = 2 * Math.Pow((b), 3) * Math.Cos(Math.Pow((b), 2));
            double sum = 0;
            Console.WriteLine("Cумма правых:");
            for (int i = 1; i<=100; i++)
            {
                sum = sum + h*masf[i];
            }
            Console.WriteLine(sum);
            sum = 0;
            Console.WriteLine("Cумма левых:");
            for (int i = 0; i <= 99; i++)
            {
                sum = sum + h * masf[i];
            }
            Console.WriteLine(sum);
            sum = 0;
            Console.WriteLine("Cумма центр:");
            for (int i = 0; i < 99; i++)
            {
                sum = sum + h * masf1[i];
            }
            Console.WriteLine(sum);
            sum = 0;
            Console.WriteLine("Трапец.:");
            for (int i = 1; i < 100; i++)
            {
                sum = sum + masf[i];
            }
            Console.WriteLine((sum*h) + h/2*(masf[0]+masf[100]));
        }
    }
}
