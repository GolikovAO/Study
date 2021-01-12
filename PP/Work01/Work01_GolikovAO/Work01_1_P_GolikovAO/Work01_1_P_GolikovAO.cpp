﻿// Work01 - Вариант 4, параллельная версия, метод прямоугольников

#include <time.h>
#include <iostream>
#include <omp.h>


using namespace std;


void integral(const double a, const double b,
	const double h, double* res)
{
	int i, n;
	double sum; // локальная переменная для подсчета интеграла
	double x; // координата точки сетки
	n = (int)((b - a) / h); // количество точек сетки интегрирования
	sum = 0.0;
#pragma omp parallel for private(x) reduction(+: sum)
	for (i = 0; i < n; i++)
		{
			x = a + i * h + h / 2.0;
			sum += (x / (x * x * x * x + 1)) * h;
		}
	*res = sum;
}

double experiment(double* res)
{
	double stime, ftime; // время начала и конца расчета
	double a = 0.0; // левая граница интегрирования
	double b = 1000000.0; // правая граница интегрирования
	double h = 0.001; // шаг интегрирования
	stime = clock();
	integral(a, b, h, res); // вызов функции интегрирования
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




