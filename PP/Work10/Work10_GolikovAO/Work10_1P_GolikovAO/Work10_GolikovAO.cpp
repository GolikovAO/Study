// Work10 - Вариант 4

#include <time.h>
#include <iostream>
#include <mpi.h>

using namespace std;

int NProc = 0, ProcId = 0;

double f(double x)
{
	return (x / (x * x * x * x + 1));
}

//// Метод прямоугольников 
//void integral(const double a, const double b,
//	const double h, double* res)
//{
//	int n;
//	double sum = 0.0;
//	double x; 
//	n = (int)((b - a) / h);
//	for (int i = 0; i < n; i += NProc) 
//	{
//		x = a + i * h + h / 2.0;
//		sum += f(x) * h;
//	}
//	MPI_Reduce(&sum, res, 1, MPI_DOUBLE, MPI_SUM, 0, MPI_COMM_WORLD);
//}

//// Метод Симпсона
void integral(const double a, const double b,
	const double h, double* res)
{
	int n;
	double sum1 = 0.0, sum2 = 0.0, s1 = 0.0, s2 = 0.0;
	double x;
	n = (int)((b - a) / (2 * h));
	for (int i = 1; i <= n; i += NProc)
	{
		x = (a + (2 * i - 1) * h);
		sum1 += 4 * f(x);
	}
	MPI_Reduce(&sum1, &s1, 1, MPI_DOUBLE, MPI_SUM, 0, MPI_COMM_WORLD);
	for (int i = 1; i < n; i += NProc)
	{
		x = a + 2 * i * h;
		sum2 += 2.0 * f(x);
	}
	MPI_Reduce(&sum2, &s2, 1, MPI_DOUBLE, MPI_SUM, 0, MPI_COMM_WORLD);
	if (ProcId == 0)
	{
		*res = (h / 3) * (s1 + s2 + ((a / (a * a * a * a + 1)) + (b / (b * b * b * b + 1))));
	}
}

double experiment(double* res)
{
	double stime; // время начала и конца расчета
	double a = 0.0; // левая граница интегрирования
	double b = 1000000.0; // правая граница интегрирования
	double h = 0.001; // шаг интегрирования
	if (ProcId == 0)
	{
		stime = MPI_Wtime();
	}
	integral(a, b, h, res); // вызов функции интегрирования
	if (ProcId == 0)
	{
		return (MPI_Wtime() - stime);
	}
	
}


int main()
{
	setlocale(LC_ALL, "RUS");
	MPI_Init(NULL, NULL);
	MPI_Comm_size(MPI_COMM_WORLD, &NProc);
	MPI_Comm_rank(MPI_COMM_WORLD, &ProcId);
	int i; // переменная цикла
	double time; // время проведенного эксперимента
	double res; // значение вычисленного интеграла
	double min_time; // минимальное время работы
	double max_time; // максимальное время работы
	double avg_time; // среднее время работы
	int numbExp = 10; // количество запусков программы

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

	if (ProcId == 0)
	{
		// вывод результатов эксперимента
		cout << " Среднее время: " << avg_time / numbExp << "\n Минимальное время: " <<
			min_time << "\n Максимальное время:" << max_time << endl;
		cout.precision(8);
		cout << " Значение интеграла: " << res << endl;
	}
	
	MPI_Finalize();
	return 0;

}
