using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ChisMethod1
{
    class Program
    {

        static void fminus(double[] masf)
        {
            Console.WriteLine("f-");
            for (int i=1; i<18; i++)
            {
                Console.WriteLine((masf[i] - masf[i-1]) / 0.1);
                
            }
            Console.WriteLine();
            
        }

        static void fplus(double[] masf)
        {
            Console.WriteLine("f+");
            for (int i = 0; i < 17; i++)
            {
               Console.WriteLine((masf[i + 1] - masf[i]) / 0.1);
            }
            Console.WriteLine();
            
        }

        static void frazn(double[] masf)
        {
            Console.WriteLine("f+-");
            for (int i = 1; i < 17; i++)
            {
                Console.WriteLine((masf[i + 1] - masf[i - 1]) / 0.2);
            }
            Console.WriteLine();
        }

        static void Main(string[] args)
        {
            double[] masx = new double[18] { 0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.1, 1.1, 1.2, 1.3, 1.4, 1.5, 1.6, 1.7 }, masf = new double[18];
            double e = 0.0001;
            for (int i=0; i<18; i++)
            {
                double f = masx[i] / 2, sum = 0;
                int k = 0;
                while (Math.Abs(f) > e)
                {
                    double q = -(masx[i] * masx[i]) / (16 * k * k + 40 * k + 24);
                    sum = sum + f;
                    f = f * q;
                    k++;
                }
                Console.WriteLine("x={0} sum={1} {2}", masx[i],sum, Math.Sin(masx[i]/2));
                masf[i] = sum;
            }
            Console.WriteLine();
            fminus(masf);
            fplus(masf);
            frazn(masf);
        }
    }
}
