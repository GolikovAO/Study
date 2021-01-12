//Сортировка подсчетом и поразрядная сортировка для целых неотрицательных чисел

#include <iostream>
#include <cstdlib>
#include <vector>

using namespace std;

class Mas
{
public:
	vector <int> arr;
	int n;

	Mas(vector <int> arr1, int m) //конструктор массива
	{
		arr = arr1;
		n = m;
	}

	void vivod() // функция вывода массива на экран
	{
		for (int i = 0; i <= n - 1; i++)
		{
			cout << arr[i] << " ";
		}

	}

	int razryad(int value) //функция вычисления разрядности числа
	{
		int count = 0;
		while (value != 0)
		{
			value = value / 10;
			count++;
		}
		return count;
	}

	int maxrazryad() //функция вычисления максимальной разрядности чисел в массиве
	{
		int max = 0;
		for (int i = 0; i <= n - 1; i++)
		{
			if (razryad(arr[i]) >= max)
			{
				max = razryad(arr[i]);
			}
		}
		return max;
	}

	int powInt(int i, int j) // вспомогательная функция возведения числа в степень, т.к. метод pow библиотеки cmath не может возвращать значения типа int
	{
		int k = 1;
		while (j--)
		{
			k = k * i;
		}
		return k;
	}

	/*При сортировке подсчетом используется вспомогательный массив, в котором будут данные о кол-ве каждого элемента исходного массива
	temp - вспомогательный массив, где temp[i] кол-во чисел исходного массива равное i
	max - максимальное число в исходном массиве. 
	*/
	void count_sort() // сортировка подсчетом
	{
		int max = 0;
		vector <int> temp; //инциализируем вспомогательный массив
		for (int i = 0; i <= n - 1; i++) //находим максимальное число
		{
			if (arr[i] > max) max = arr[i];
		}
		for (int i = 0; i <= max + 1; i++) // заполняем вспомогательный массив нулями
		{
			temp.push_back(0);
		}
		for (int i = 0; i <= n - 1; i++) //заполняем вспомогательный массив
		{
			temp[arr[i]]++;
		}
		arr.clear(); // очищаем исходный массив
		for (int i = 0; i <= max + 1; i++)
		{
			if (temp[i] != 0)
			{
				int r = 0;
				while (r < temp[i])
				{
					arr.push_back(i); //заполняем исходный массив используя данные вспомогательного
					r++;
				}
			}
		}
	}

	/*Сортировка подсчетом. 
	Функция radix_sort будет вызывать функцию lsd некое число раз, равное максимальной разрядности чисел массива
	Функция lsd сортирует массив по конкретному разряду, который передает radix_sort*/

	void radix_sort()
	{
		int p = 1; // p - разряд
		for (int i = 1; i <= maxrazryad(); i++)
		{
			arr=lsd(arr, p); //переписываем массив на отсортированный по конкретному разряду
			p++;
		}
	}

	vector <int> lsd(vector <int> arr,int k)
	{
		vector <int> temp; //инциализируем вспомогательный массив
		vector <int> a[10]; //инциализируем массив из 10 векторов, где каждый вектор будет хранить числа, у которых цифра заданного разряда равна индексу элемента массива векторов
		for (int i = 0; i <= n - 1; i++)
		{
			int d = (arr[i] % powInt(10,k))/powInt(10,k-1); // d - цифра числа заданного разряда
			for (int j = 0; j <= 9; j++)
			{
				if (d == j)
				{
					a[j].push_back(arr[i]);  //записываем в вектор с индексом равный цифре заданного разряда число
				}
			}
		}
		for (int i = 0; i <= 9; i++)
		{
			if (a[i].empty() == false) //если вектор массива не пустой, то в массив temp упорядоченно записываем элементы элементы всех векторов
			{
				temp.insert(temp.end(), a[i].begin(), a[i].end());
			}
		}
		/*for (int i = 0; i <= temp.size() - 1; i++)  //вывод массива на экран после каждой итерации сортировки
		{
			cout << temp[i] << " ";
		}
		cout << endl;*/
		return temp;
	}
};

int main()
{
	setlocale(LC_CTYPE, "");

	int n;
	vector <int> arr1, arr2;
	cout << "Сортировка подсчетом" << endl;
	cout << "Введите размерность массива:" << endl;
	cin >> n;
	cout << "Введите массив:" << endl;
	for (int i = 0; i <= n - 1; i++)
	{
		int b;
		cin >> b;
		arr1.push_back(b);
	}
	Mas CS(arr1, n);
	CS.count_sort();
	cout << "Отсортированный массив:";
	CS.vivod();
	cout << endl << endl << endl;

	cout << "Поразрядная сортировка" << endl;
	cout << "Введите размерность массива:" << endl;
	cin >> n;
	cout << "Введите массив:" << endl;
	for (int i = 0; i <= n - 1; i++)
	{
		int b;
		cin >> b;
		arr2.push_back(b);
	}
	Mas RS(arr2, n);
	cout <<"Максимальная разрядность числа в массиве:"<< RS.maxrazryad() << endl;
	RS.radix_sort();
	cout <<"Отсортированный массив:";
	RS.vivod();
	cout << endl;
}

