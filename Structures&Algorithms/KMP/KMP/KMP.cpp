#include <vector>
#include <iostream>
#include <string>
#include <algorithm>
#include <cstdlib>

using namespace std;
class A
{
public:
	string slovo;
	int dl;
	A(string s)
	{
		slovo = s;
		dl = s.length();
	}
	vector<int> prefix()
	{
		vector<int> pi(dl); // значения префикс-функции
						  // индекс вектора соответствует номеру последнего символа аргумента
		pi[0] = 0; // для префикса из нуля и одного символа функция равна нулю

		int k = 0;
		for (int i = 1; i < dl; i++) {
			while ((k > 0) && (slovo[k] != slovo[i]))
				k = pi[k - 1];
			if (slovo[k] == slovo[i])
				k++;
			pi[i] = k;
		}
		return pi;
	}

	void KMP(string text)
	{
		int  i, j, textlen;

		textlen = text.length();
		vector <int> pi(dl);
		pi = prefix();
		int a = 0;

		// Поиск строки
		for (int i = 0; i < textlen; i++)
		{
			while (a > 0 && slovo[a] != text[i])
				a = pi[a - 1];								// a = pi[a - 1] часть алгоритма, которая предотвращает лишние проверки 												
			if (slovo[a] == text[i]) a++;
			if (a == dl)
			{

				cout << "Искомая подстрока найдена";
				a = pi[a - 1];
			}
		}
	}
	vector<int> z() // Z - функция — это вектор длин наибольшего общего префикса строки с ее суффиксом
	{
		vector<int> z(dl);//вектор на n элеметов, в который будут записыватья значения блоков функции
		int l = 0, r = 0; //левая и правая граница "отрезка совпадения"
		for (int i = 1; i < dl; i++)
		{
			if (i <= r)
				z[i] = min(r - i + 1, z[i - l]);
			while (i + z[i] < dl && slovo[z[i]] == slovo[i + z[i]])
				z[i]++;
			if (i + z[i] - 1 > r)
			{
				l = i;
				r = i + z[i] - 1;
			}
		}
		int max = z[0];
		for (int i = 1; i < z.size(); i++)
		{
			if (max < z[i])
			{
				max = z[i];
			}
		}
		return z;
	}
	//int max(int a, int b)
	//{
	//	return (a > b) ? a : b;
	//}

	//int min(int a, int b)
	//{
	//	return (a < b) ? a : b;
	//}



	//int* Slide()										 // Установка всего алфавит для slide
	//{
	//	int* slide = new int[256];
	//	for (int i = 0; i < 256; i++)												// установка всех символов максимально возможный сдвиг
	//		slide[i] = dl;
	//	for (int i = 1; i < dl; i++)										// устанвка удаленность от конца. последный символ если не повторяется равно длине образца
	//		slide[(int)slovo[i - 1] + '0'] = dl - i;
	//	return slide;
	//}


	//int* MasSlide()										// генерируем массив յump независимо от slide для того чтобы установить взаимоотношение между частей pattern
	//{
	//							
	//	int* Mas = new int[dl];											// создаем массив jump

	//	for (int i = 1; i <= dl; i++)									// иницилизируем массив с макс возможним сдвигам (надо учти что значение прибовляется к текушей позиции строки а не образца)
	//		Mas[i - 1] = 2 * dl - i;

	//	int temp = dl - 1;												// установка вспомогательных значении для сравнении символов образца (с конца)
	//	int target = dl;

	//	int* link = new int[target];												// создаем вспомогательный массив

	//	while (temp >= 0)															// сравниваем элементы с последнимы элементами образца
	//	{
	//		link[temp] = target;													// установливаем текуший target
	//		while (target < dl && slovo[temp] != slovo[target])		// если сивол с индексм test не ровно с элементом из конечной част под индексом target
	//		{
	//			Mas[target] = min(Mas[target], (dl - temp - 1));		// то выберам минмальное
	//			target = link[target];												// извлекаем target (target всегда больше temp)
	//		}
	//		temp--;																	// декрементируем
	//		target--;
	//	}

	//	for (int i = 0; i <= target; i++)											// иправляем начальные значения
	//		Mas[i] = min(Mas[i], dl + target - i);

	//	int tmp = link[target];													// сново извлекаем значение
	//	while (target < dl)												// исправляем значение от target до tmp (следующий цикл)
	//	{
	//		while (target < tmp)
	//		{
	//			Mas[target] = min(Mas[target], (tmp - target + dl));	// установка минимума
	//			target++;
	//		}
	//		if (tmp >= dl)
	//			break;
	//		temp = link[tmp];
	//	}
	//	delete[] link;

	//	return Mas;
	//}


	//int BM(string text, int k = 0)								// функция для поиска первого вхождения pattern в text с позиции k
	//{
	//	int textlen = text.length();												// установк длины текста
	//	int textLoc = k + dl - 1;											// установк место начала сравнние в тексте
	//	int slovoLoc = dl - 1;												// индескс для конца образца

	//	int* slide = Slide();													// получаем данные ростояние символв образц от конца. здесь не будем учитовать то что при совпадении несколько символов мы не будем увиличивать еще и уже пройденное количество символов, так как есть для этого jump
	//	int* mas = MasSlide();														// устанвока данные для прыжков, для боле усовершенствовании алгоритма	

	//	while (textLoc < textlen && slovoLoc >= 0)											// цикл для сравнени текста с образцом
	//		if (text[textLoc] == slovo[slovoLoc])											// если текушие ровны, уменшаем чтобы сравнить предидущые
	//			textLoc--, slovoLoc--;
	//		else																				// иначе определяем с какого индекса начинать
	//		{
	//			textLoc = textLoc + max(slide[(int)text[textLoc] + '0'], mas[slovoLoc]);
	//			slovoLoc = dl - 1;											// для конца образца
	//		}
	//	delete[] slide, mas;
	//	if (slovoLoc < 0)																		// если нашли возвращаем
	//		return textLoc + 1;
	//	return -1;																				// иначе -1
	//}
	int max(int a, int b)
	{
		return (a > b) ? a : b;
	}

	int min(int a, int b)
	{
		return (a < b) ? a : b;
	}



	int* generateSlide(const string& pattern)										 // Установка всего алфавит для slide
	{
		int patternLength = pattern.length();
		int* slide = new int[256];
		for (int i = 0; i < 256; i++)												// установка всех символов максимально возможный сдвиг
			slide[i] = patternLength;
		for (int i = 1; i < patternLength; i++)										// устанвка удаленность от конца. последный символ если не повторяется равно длине образца
			slide[(int)pattern[i - 1] + '0'] = patternLength - i;
		return slide;
	}


	int* generateJump(const string & pattern)										// генерируем массив յump независимо от slide для того чтобы установить взаимоотношение между частей pattern
	{
		const int patternLength = (int)pattern.length();							// установка длины образца (pattern)
		int* jump = new int[patternLength];											// создаем массив jump

		for (int i = 1; i <= patternLength; i++)									// иницилизируем массив с макс возможним сдвигам (надо учти что значение прибовляется к текушей позиции строки а не образца)
			jump[i - 1] = 2 * patternLength - i;

		int test = patternLength - 1;												// установка вспомогательных значении для сравнении символов образца (с конца)
		int target = patternLength;

		int* link = new int[target];												// создаем вспомогательный массив

		while (test >= 0)															// сравниваем элементы с последнимы элементами образца
		{
			link[test] = target;													// установливаем текуший target
			while (target < patternLength && pattern[test] != pattern[target])		// если сивол с индексм test не ровно с элементом из конечной част под индексом target
			{
				jump[target] = min(jump[target], (patternLength - test - 1));		// то выберам минмальное
				target = link[target];												// извлекаем target (target всегда больше temp)
			}
			test--;																	// декрементируем
			target--;
		}

		for (int i = 0; i <= target; i++)											// иправляем начальные значения
			jump[i] = min(jump[i], patternLength + target - i);

		int temp = link[target];													// сново извлекаем значение
		while (target < patternLength)												// исправляем значение от target до tmp (следующий цикл)
		{
			while (target < temp)
			{
				jump[target] = min(jump[target], (temp - target + patternLength));	// установка минимума
				target++;
			}
			if (temp >= patternLength)
				break;
			temp = link[temp];
		}
		delete[] link;

		return jump;
	}


	int BM(const string & text, const string & pattern, int k = 0)								// функция для поиска первого вхождения pattern в text с позиции k
	{
		const int textLength = (int)text.length();												// установк длины текста
		int textLoc = k + (int)pattern.length() - 1;											// установк место начала сравнние в тексте
		int patternLoc = (int)pattern.length() - 1;												// индескс для конца образца

		int* slide = generateSlide(pattern);													// получаем данные ростояние символв образц от конца. здесь не будем учитовать то что при совпадении несколько символов мы не будем увиличивать еще и уже пройденное количество символов, так как есть для этого jump
		int* jump = generateJump(pattern);														// устанвока данные для прыжков, для боле усовершенствовании алгоритма	

		while (textLoc < textLength && patternLoc >= 0)											// цикл для сравнени текста с образцом
			if (text[textLoc] == pattern[patternLoc])											// если текушие ровны, уменшаем чтобы сравнить предидущые
				textLoc--, patternLoc--;
			else																				// иначе определяем с какого индекса начинать
			{
				textLoc = textLoc + max(slide[(int)text[textLoc] + '0'], jump[patternLoc]);
				patternLoc = (int)pattern.length() - 1;											// для конца образца
			}
		delete[] slide, jump;
		if (patternLoc < 0)																		// если нашли возвращаем
			return textLoc + 1;
		return -1;																				// иначе -1
	}
};

int main()
{
	setlocale(LC_CTYPE, "");
	string s = "abacaba";
	string text = "alkhsdkbabacabahwhad";
	string text1 = "jalshdasdkjahgskudhga";
	vector <int> prefunc(s.length()), z_func(s.length());
	A Slovo(s);
	prefunc = Slovo.prefix();
	z_func = Slovo.z();
	for (int i = 0; i <= Slovo.dl - 1; i++)
	{
		cout << prefunc[i] << " ";
	}
	cout << endl;
	for (int i = 0; i <= Slovo.dl - 1; i++)
	{
		cout << z_func[i] << " ";
	}
	cout << endl;
	Slovo.KMP(text);
	cout << endl;
	Slovo.BM(text,Slovo.slovo);
}

