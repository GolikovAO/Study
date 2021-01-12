// Work01 - Вариант 4, последовательная версия, метод Симпсона

#include <time.h>
#include <iostream>


using namespace std;


void integral(const double a, const double b,
	const double h, const int N, double* res)
{
	int i;
	double sum1, sum2; // локальная переменная для подсчета интеграла
	double x; // координата точки сетки
	sum1 = 0.0;
	sum2 = 0.0;
	for (i = 0; i < N; i++)
	{
		x = a + (2 * double(i) - 1) * h;
		sum1 += (x / (x * x * x * x + 1));
	}
	for (i = 0; i < N-1; i++)
	{
		x = a + 2 * double(i) * h;
		sum2 += (x / (x * x * x * x + 1));
	}
	*res = (h / 3) * ((a / (a * a * a * a + 1)) + (b / (b * b * b * b + 1)) + (4 * sum1) + (2 * sum2));
}

double experiment(double* res)
{
	double stime, ftime; // время начала и конца расчета
	double a = 0.0; // левая граница интегрирования
	double b = 1000000.0; // правая граница интегрирования
	double h = 0.001; // шаг интегрирования
	int N = ((b - a) / h) / 2;
	stime = clock();
	integral(a, b, h, N, res); // вызов функции интегрирования
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


