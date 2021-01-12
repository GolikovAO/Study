
#include <cstdlib>
#include <locale>
#include <string>

using namespace std;

int BMSearch(string text, string substring) {
	int  sl = 0;
	int ssl = 0;
	int res = -1;
	while (text[sl] != NULL) {
		sl++;
	}
	while (substring[ssl] != NULL) {
		ssl++;
	}
	if (sl == 0)
		printf("Некорректная строка\n");
	else if (ssl == 0)
		printf("Некорректная подстрока\n");
	else {
		int  i, Pos;
		int  BMT[256];
		for (i = 0; i < 256; i++)
			BMT[i] = ssl;
		for (i = ssl - 1; i >= 0; i--)
			if (BMT[(short)(substring[i])] == ssl)
				BMT[(short)(substring[i])] = ssl - i - 1;
		Pos = ssl - 1;
		while (Pos < sl)
			if (substring[ssl - 1] != text[Pos])
				Pos = Pos + BMT[(short)(text[Pos])];
			else
				for (i = ssl - 2; i >= 0; i--) {
					if (substring[i] != text[Pos - ssl + i + 1]) {
						Pos += BMT[(short)(text[Pos - ssl + i + 1])] - 1;
						break;
					}
					else
						if (i == 0)
							return Pos - ssl + 1;
				}
	}
	printf("\n");
	return res;
}

int main(int argc, char* argv[]) {
	setlocale(LC_ALL, "Rus");
	string str;
	string substr;
	str = "abacabaagsjvasi";
	substr = "abacaba";

	int pos = BMSearch(str, substr);
	printf("Смещение = %d", pos);

	return 0;
}