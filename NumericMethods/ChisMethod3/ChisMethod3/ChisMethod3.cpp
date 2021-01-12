#include <iostream>;
#include <iomanip>;
using namespace std;
const int n = 5;
const int V = 4; // Номер варианта

//Функция интерполяционного многочлена методом Лагранжа
double Lang(double X[n], double Y[n], double x) {
	double sum, a, b;
	sum = 0;
	for (int j = 0; j < n; j++) {
		a = 1; b = 1;
		for (int i = 0; i < n; i++) {
			if (i == j) {
				a = a * 1; 
				b = b * 1;
			}
			else {
				a = a * (x - X[i]);
				b = b * (X[j] - X[i]);
			}
		}
		sum = sum + Y[j] * a / b;
	}
	return sum;
}

// Функция интерполяционного многочлена Ньютона
double Newton(double X[n], double Y[n], double x)
{
	double sum = Y[0], Fx, Dx;
	for (int i = 1; i < n; i++)
	{
		Fx = 0;
		for (int j = 0; j <= i; j++)
		{
			Dx = 1;
			for (int k = 0; k <= i; k++) {
				if (k != j) Dx = Dx * (X[j] - X[k]);
			}
			Fx = Fx + Y[j] / Dx;
		}
		for (int j = 0; j < i; j++)
			Fx = Fx * (x - X[j]);
		sum = sum + Fx;
	}
	return sum;
}

int main() {
 setlocale(LC_ALL, "rus");
 double X[n] = { 0,1,2,3,4 };
 double Y[n] = { 4,5,12,31,68 };
 double x[n - 1] = { 0.5, 1.5, 2.5, 3.5 };
 cout << "Данные из первой таблицы:" << endl;
 for (int i = 0; i <= 4; i++)
 {
	 cout << "X[" << i+1 << "] = " << Y[i] << " ";
 }
 cout << endl << endl << "Точные значения функции:" << endl;
 for (int i = 0; i <= 3; i++)
 {
	 cout << "x[" << i + 1 << "] = " << x[i] * x[i] * x[i] + V << " ";
 }
 cout << endl << "Значения интерполяционного многочлена Лагранжа:" << endl;
 for (int i = 0; i <= 3; i++)
 {
	 cout << "x[" << i + 1 << "] = " << Lang(X,Y,x[i]) << " ";
 }
 cout << endl << endl;
 cout << endl << "Значения интерполяционного многочлена Ньютона:" << endl;
 for (int i = 0; i <= 3; i++)
 {
	 cout << "x[" << i + 1 << "] = " << Newton(X, Y, x[i]) << " ";
 }
 cout << endl << endl;
 system("pause");
 return 0;
}

