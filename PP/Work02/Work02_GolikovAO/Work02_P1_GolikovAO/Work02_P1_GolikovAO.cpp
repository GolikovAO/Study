// Work02, параллельная версия 1-ый способ

#include <time.h>
#include <iostream>

#define PI 3.1415926535897932384626433832795

using namespace std;

void integral(const double a1, const double b1, const double a2, const double b2,
	const double h, double* res)
{
	int i, n, m;
	double sum; // локальная переменная для подсчета интеграла
	double x, y; // координата точки сетки
	n = (int)((b1 - a1) / h); // количество точек сетки интегрирования
	m = (int)((b2 - a2) / h);
	sum = 0.0;
	#pragma omp parallel for private(x) reduction (+: sum)
	for (i = 0; i < n; i++)
	{
		x = a1 + i * h + h / 2.0;
		for (int j = 0; j < m; j++)
		{
			y = a1 + j * h + h / 2.0;
			sum += (exp(sin(PI * x) * cos(PI * y)) + 1) * h * h / (b1 - a1) / (b2 - a2);
		}
	}
	*res = sum;
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

