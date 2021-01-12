#include <iostream>
#include <cstdlib>
#include <ctime>

using namespace std;

class Mas
{
public:
	int a1[500], a2[1000], a3[5000], a4[10000], a5[15000], test[15];

	Mas()
	{
		for (int i = 0; i <= 14; i++)
		{
			test[i] = rand();
		}
		for (int i = 0; i <= 499; i++)
		{
			a1[i] = rand();
		}
		for (int i = 0; i <= 999; i++)
		{
			a2[i] = rand();
		}
		for (int i = 0; i <= 4999; i++)
		{
			a3[i] = rand();
		}
		for (int i = 0; i <= 9999; i++)
		{
			a4[i] = rand();
		}
		for (int i = 0; i <= 14999; i++)
		{
			a5[i] = rand();
		}
	}

	void vivod()
	{
		for (int i = 0; i <= 14; i++)
		{
			cout << test[i] << " ";
		}
		cout << endl;
	}

	void quick_sort(int* arr, int size) //быстрая сортировка
	{
		int i = 0;  //Указатели в начало и в конец массива
		int j = size - 1;
		int mid = arr[size / 2];  //Центральный элемент массива - опорный элемент

		do   //Делим массив и ищем те, которые нужно переместить на другую сторону.
		{
			while (arr[i] < mid)  //В левой части массива пропускаем элементы, которые меньше опорного
			{
				i++;
			}
			while (arr[j] > mid) //В правой части пропускаем элементы, которые больше опорного
			{
				j--;
			}
			if (i <= j)   //Меняем элементы местами
			{
				int temp = arr[i];
				arr[i] = arr[j];
				arr[j] = temp;

				i++;
				j--;
			}
		} while (i <= j);


		//Рекурсия, если осталось, что сортировать 
		if (j > 0) 
		{
			quick_sort(arr, j + 1);  	//Для левой части
		}
		if (i < size) 
		{
			quick_sort(&arr[i], size - i);  //Для правой части
		}
	}
	
	void merge_sort(int* arr, int first, int last) //сортировка слиянием
	{
		{
			if (first < last)
			{
				merge_sort(arr, first, (first + last) / 2); //рекурсия по левой части
				merge_sort(arr, (first + last) / 2 + 1, last); //рекурсия по части
				int middle, start, final, j;
				int* mas = new int[15000]; //инциализируем вспомогательный массив
				middle = (first + last) / 2; //вычисление среднего элемента
				start = first; //начало левой части
				final = middle + 1; //начало правой части
				for (j = first; j <= last; j++) //выполнять от начала до конца
					if ((start <= middle) && ((final > last) || (arr[start] < arr[final])))
					{
						mas[j] = arr[start];
						start++;
					}
					else
					{
						mas[j] = arr[final];
						final++;
					}
				for (j = first; j <= last; j++) arr[j] = mas[j]; //возвращение результата в исходный массив
				delete[]mas; 
			}
		}
	}
	void heap_sort(int* arr, int size) // Пирамидальная сортировка
	{
		for (int i = (size / 2) - 1; i >= 0; i--) // Формируем нижний уровень пирамиды
		{
			down(arr, i, size - 1);
		}
		for (int i = size - 1; i >= 1; i--) // Проходим остальными элементами через пирамиду
		{
			int temp = arr[0];
			arr[0] = arr[i];
			arr[i] = temp;
			down(arr, 0, i - 1);
		}
	}
	private:

	void down(int* arr, int root, int end)
	{
		int max; // индекс максимального потомка
		bool complete = false; // индикатор формирования пирамиды
		while ((root * 2 <= end) && (complete == false)) // Пока не дошли до последнего уровня
		{
			if (root * 2 == end)    // если мы в последнем ряду, 
				max = root * 2;    // запоминаем левый потомок
			else                   // иначе запоминаем больший потомок из двух
				if (arr[root * 2] > arr[root * 2 + 1])
				max = root * 2;
			    else
				max = root * 2 + 1;
			if (arr[root] < arr[max]) // Если элемент вершины меньше максимального потомка меняем их местами
			{
				int temp = arr[root]; 
				arr[root] = arr[max];
				arr[max] = temp;
				root = max;
			}
			else // иначе пирамида сформирована
				complete = true;
		}
	}
};

int main()
{
	setlocale(LC_CTYPE, "");
	srand(time(NULL)); // позволяет получать разные рандомные числа с каждым запуском программы

	clock_t time_start = clock();
	Mas A;
	A.vivod();
	A.quick_sort(A.test, 15);
	A.quick_sort(A.a1, 500);
	A.quick_sort(A.a2, 1000);
	A.quick_sort(A.a3, 5000);
	A.quick_sort(A.a4, 10000);
	A.quick_sort(A.a5, 15000);
	A.vivod();
	cout << endl << endl;

	Mas B;
	B.vivod();
	B.merge_sort(B.test, 0, 14);
	B.merge_sort(B.a1, 0, 499);
	B.merge_sort(B.a2, 0, 999);
	B.merge_sort(B.a3, 0, 4999);
	B.merge_sort(B.a4, 0, 9999);
	B.merge_sort(B.a5, 0, 14999);
	B.vivod();
	cout << endl << endl;

	Mas C;
	C.vivod();
	C.heap_sort(C.test, 15);
	C.heap_sort(C.a1, 500);
	C.heap_sort(C.a2, 1000);
	C.heap_sort(C.a3, 5000);
	C.heap_sort(C.a4, 10000);
	C.heap_sort(C.a5, 15000);
	C.vivod();


	clock_t time_end = clock();
	double elapsed = (double)(time_end - time_start) / CLOCKS_PER_SEC;
	cout << "Время в секундах:" << elapsed << endl;
}

	
	
