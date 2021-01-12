#include <iostream>
#include <cmath>
#include <iomanip>
double temp = 1;
using namespace std;

static double f(double x, double y)
{
	return ((4*x*x) + y)/x;
}
double RungeKutta2(double x0, double y0, double h, double x)
{
	double xnew, ynew, k1, result = 0;
	if (x == x0)
		result = y0;
	else if (x > x0)
	{
		do
		{
			if (h > x - x0) 
			h = x - x0;
			k1 = h * f(temp, y0);
			ynew = y0 + h/2 * (f(temp,y0) + f(temp + h, y0 + k1));
			xnew = temp + h;
			x0 = xnew;
			temp = xnew;
			y0 = ynew;
		} while (x0 < x);
		result = ynew;
	}
	return result;
}
int main()
{
	setlocale(LC_ALL, "rus");
	double h = 0.1;
	double x0 = 1.0;
	double y0 = 1.0;
	double result = y0;
	double error[10];
	double max = 0;
	int j = 0;
	cout << "Приближенные решения, Точные значения, Погрешность" << endl << endl;
	for (double i = x0; i <= 2.1; i = i + h)
	{
		result = RungeKutta2(x0, result, h, i);
		double exact = ((4.0 * i - 3.0) * i);
		error[j] = fabs(result - exact);
		if (error[j] > max) max = error[j];
		cout << " x = " << i << " y = " << result << " exact = " << exact << " error = " << error[j] << endl << endl;
		j++;
	}
	cout << "Максимальная погрешность: " << max << endl;
	system("pause");
	return 0;
}