// Work03, метод статистических испытаний (Монте-Карло), параллельная версия

#include <time.h>
#include <iostream>
#include <omp.h>

#define PI 3.1415926535897932384626433832795

using namespace std;

double f(double x, double y)
{
	return (exp(sin(PI * x) * cos(PI * y)) + 1) / (16.0 * 16.0);
}

double random(double min, double max)
{
	return (double)(rand()) / RAND_MAX * (max - min) + min;
}


void integral(double a1, double b1, double a2, double b2, double h, double* res)
{
	int n = 0;
	int N = 10000000;
	double sum = 0.0;
	double x, y;
	#pragma omp parallel for private(x,y) reduction (+: sum, n)
	for (int i = 0; i < N - 1; i++)
	{
		 x = random(a1, b1);
		 y = random(a1, b1);
		if ((x >= 0 && x <= 16.0) && (y >= 0 && y <= 16.0))
		{
			n++;
			sum += f(x, y);
		}
	}
	*res = b1 * b2 * sum / n;
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
