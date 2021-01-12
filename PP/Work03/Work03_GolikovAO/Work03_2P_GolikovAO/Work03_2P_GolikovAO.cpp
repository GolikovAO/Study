// Work03, метод трапеций, параллельная версия

#include <time.h>
#include <iostream>
#include <omp.h>


#define PI 3.1415926535897932384626433832795


using namespace std;

double f(double x, double y)
{
	return (exp(sin(PI * x) * cos(PI * y)) + 1) / (16.0 * 16.0);
}

void integral(double a1, double b1, double a2, double b2, double h, double* res)
{
	double sum = 0.0;
	int n = int((b2 - a2) / h);
	int m = int((b1 - a1) / h);
	double x = a1, y = a2;
	double q = 0;

	#pragma omp parallel for private(x, y) reduction(+: sum)
	for (int i = 0; i <= n; i++)
	{
		x = a1 + i * h;
		for (int j = 0; j <= m; j++)
		{
			if (i > 0 && i < n && j > 0 && j < m) q = 1;
			else if ((i == 0 || i == m) && (j == 0 || j == n))   q = 0.25;
			else  q = 0.5;
			y = a2 + j * h;
			sum += q * f(x, y);
		}
	}
	*res = h * h * sum;
}

double experiment(double* res)
{
	double stime, ftime; // время начала и конца расчета
	double a1 = 0.0, a2 = 0.0; // левая граница интегрирования
	double b1 = 16.0, b2 = 16.0; // правая граница интегрирования
	double h = 0.001; // шаг интегрирования
	stime = clock();
	integral(a1, b1, a2, b2, h, res); // вызов функции интегрирования
	ftime = clock();
	return (ftime - stime) / CLOCKS_PER_SEC;
}

int main()
{
	setlocale(LC_ALL, "Russian");
	int i; // переменная цикла
	double time; // время проведенного эксперимента
	double res; // значение вычисленного интеграла
	double min_time; // минимальное время работы
	// реализации алгоритма
	double max_time; // максимальное время работы
	// реализации алгоритма
	double avg_time; // среднее время работы
	// реализации алгоритма
	int numbExp = 10; // количество запусков программы

	min_time = max_time = avg_time = experiment(&res);
	// оставшиеся запуски
	for (i = 0; i < numbExp - 1; i++)
	{
		time = experiment(&res);
		avg_time += time;
		if (max_time < time) max_time = time;
		if (min_time > time) min_time = time;
	}
	// вывод результатов эксперимента
	cout << " Среднее время: " << avg_time / numbExp << "\n Минимальное время: " <<
		min_time << "\n Максимальное время:" << max_time << endl;
	cout.precision(8);
	cout << " Значение интеграла: " << res << endl;
	return 0;

}
