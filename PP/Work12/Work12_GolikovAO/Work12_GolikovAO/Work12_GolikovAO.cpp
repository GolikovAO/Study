﻿// Work12

#include <time.h>
#include <iostream>
#include <mpi.h>

#define PI 3.1415926535897932384626433832795
int NProc, ProcId;


using namespace std;

double f(double x, double y)
{
	return (exp(sin(PI * x) * cos(PI * y)) + 1) / (16.0 * 16.0);
}

////Метод ячеек
//void integral(double a1, double b1, double a2, double b2, double h, double* res)
//{
//	double sum = 0.0;
//	double x0, y0, x1, y1;
//
//	for (x1 = a1 + h; x1 < b1; x1 += h)
//	{
//		x0 = x1 - h;
//		for (y1 = a2 + (ProcId + 1) * h; y1 < b2; y1 += NProc * h)
//		{
//			y0 = y1 - h;
//			sum += f((x0 + x1) / 2.0, (y0 + y1) / 2.0);
//		}
//	}
//
//	sum *= h * h;
//	MPI_Reduce(&sum, res, 1, MPI_DOUBLE, MPI_SUM, 0, MPI_COMM_WORLD);
//}

////// Метод трапеций
//void integral(double a1, double b1, double a2, double b2, double h, double* res)
//{
//	double sum = 0.0;
//	int n = int((b2 - a2) / h);
//	int m = int((b1 - a1) / h);
//	double x = a1, y = a2;
//	double q = 0;
//
//	for (int i = 0; i <= n; i++)
//	{
//		x = a1 + i * h;
//		for (int j = ProcId; j <= m; j+=NProc)
//		{
//			if (i > 0 && i < n && j > 0 && j < m) q = 1;
//			else if ((i == 0 || i == m) && (j == 0 || j == n))   q = 0.25;
//			else  q = 0.5;
//			y = a2 + j * h;
//			sum += q * f(x, y);
//		}
//	}
//	MPI_Reduce(&sum, res, 1, MPI_DOUBLE, MPI_SUM, 0, MPI_COMM_WORLD);
//	*res *= h * h;
//}

//Метод Монте-Карло
double random(double min, double max)
{
	return (double)(rand()) / RAND_MAX * (max - min) + min;
}

int N = 100000000;

void integral(double a1, double b1, double a2, double b2, double h, double* res)
{
	int n = 0;
	double sum = 0.0;
	for (int i = ProcId; i < N; i += NProc)
	{
		double x = random(a1, b1);
		double y = random(a1, b1);
		if ((x >= 0 && x <= 16.0) && (y >= 0 && y <= 16.0))
		{
			n++;
			sum += f(x, y);
		}
	}
	MPI_Reduce(&sum, res, 1, MPI_DOUBLE, MPI_SUM, 0, MPI_COMM_WORLD);
	int nn = 0;
	MPI_Reduce(&n, &nn, 1, MPI_INT, MPI_SUM, 0, MPI_COMM_WORLD);
	*res *= b1 * b2 / nn;
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
