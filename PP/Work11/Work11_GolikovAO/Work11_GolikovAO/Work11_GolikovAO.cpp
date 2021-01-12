// Work11

#include <time.h>
#include <iostream>
#include <mpi.h>

#define PI 3.1415926535897932384626433832795
int NProc, ProcId;

using namespace std;

double f(double x, double y)
{
	return (exp(sin(PI * x) * cos(PI * y)) + 1);
}

void integral(const double a1, const double b1, const double a2, const double b2,
	const double h, double* res)
{
	double sum; // локальная переменная для подсчета интеграла
	sum = 0.0;
	for (double x = a1 + h / 2.0; x < b1; x+= h)
	{
		for (double y = a2 + (ProcId + 1) * h / 2.0; y < b2; y += NProc * h)
		{
			sum += f(x,y) / ((b1 - a1) * (b2 - a2));
		}
	}
	MPI_Reduce(&sum, res, 1, MPI_DOUBLE, MPI_SUM, 0, MPI_COMM_WORLD);
	if (ProcId == 0)
	{
		*res *= h * h;
	}
}

double experiment(double* res)
{
	double stime; // время начала и конца расчета
	double a1 = 0.0, a2 = 0.0; // левая граница интегрирования
	double b1 = 16.0, b2 = 16.0; // правая граница интегрирования
	double h = 0.001; // шаг интегрирования
	if (ProcId == 0)
	{
		stime = MPI_Wtime();
	}
	integral(a1, b1, a2, b2, h, res); // вызов функции интегрирования
	if (ProcId == 0)
	{
		return MPI_Wtime() - stime;
	}
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
	MPI_Init(NULL, NULL);
	MPI_Comm_size(MPI_COMM_WORLD, &NProc);
	MPI_Comm_rank(MPI_COMM_WORLD, &ProcId);
	min_time = max_time = avg_time = experiment(&res);
	// оставшиеся запуски	
	for (i = 0; i < numbExp - 1; i++)
	{
		time = experiment(&res);
		if (ProcId == 0)
		{
			avg_time += time;
			if (max_time < time) max_time = time;
			if (min_time > time) min_time = time;
		}
	}
	// вывод результатов эксперимента
	if (ProcId == 0)
	{
		cout << " Среднее время: " << avg_time / numbExp << "\n Минимальное время: " <<
			min_time << "\n Максимальное время:" << max_time << endl;
		cout.precision(8);
		cout << " Значение интеграла: " << res << endl;
	}
	MPI_Finalize();
	return 0;
}