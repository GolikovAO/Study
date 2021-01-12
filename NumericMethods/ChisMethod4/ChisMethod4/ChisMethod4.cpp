#include<iostream>
#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include <iomanip>

using namespace std;

//Создаем массив с значениями линейных уравнений (Вариант 4)
double arr[3][4] = { {3, 0.3, 0.2, 9.8 },
                    {0.3, 2, 0.1, 5.0},
					{0.2, 0.1, 1, 1.8 } };

float e = 0.001;


int main()
{
	setlocale(LC_ALL, "rus");
	double temp, res[4];


	//Прямой ход
	for (int i = 0; i < 3; i++)
	{
		temp = arr[i][i];
		for (int j = 3; j >= i; j--)
			arr[i][j] = arr[i][j] / temp;
		for (int j = i + 1; j < 3; j++)
		{
			temp = arr[j][i];
			for (int k = 3; k >= i; k--)
				arr[j][k] = arr[j][k] - temp * arr[i][k];
		}
	}
	//Обратный ход
	res[2] = arr[2][3];
	for (int i = 3 - 2; i >= 0; i--)
	{
		res[i] = arr[i][3];
		for (int j = i + 1; j < 3; j++) res[i] = res[i] - arr[i][j] * res[j];
	}
	cout << 3 * res[0] + 0.3 * res[1] + 0.2 * res[2] << endl;
	cout << 0.3 * res[0] + 2 * res[1] + 0.1 * res[2]  << endl;
	cout << 0.2 * res[0] + 0.1 * res[1] + res[2] << endl;
	cout << "0.9x1 + 0.8x2 + 8x3 = 80.2" << endl;
	cout << "Найденные корни:" << endl << "x1=" << res[0] << "  x2=" << res[1] << "  x3=" << res[2] << endl;
	//Проверка
	if (((3 * res[0] + 0.3 * res[1] + 0.2 * res[2]) == 9,8) && 
		((0.3 * res[0] + 2 * res[1] + 0.1 * res[2]) == 5,0) && 
		((0.2 * res[0] + 0.1 * res[1] + 1 * res[2]) == 1,8))
	{
		cout << "По результатам проверки корни верны" << endl;
	}
	else
	{
		cout << "По результатам проверки корни неверны" << endl;
	}
	system("pause");
	return 0;
}