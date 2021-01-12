using System;
using Lab4Library;


namespace Lab4_2_GolikovAO
{
    class Program
    {
        static void Main(string[] args)
        {
            // Создаем четрые объекта (посылки)
            Package i1 = new Package(9123, "Запчасть", "Иванов А.С.", "Саратов", 3.54);         
            Package i2 = new Package(517, "Клавиатура", "Сидоров И.В.", "Челябинск", 0.921);
            Package i3 = new Package(1555, "Смартфон", "Афанасьев Д.А.", "Санкт-Петербург", 1.530);
            Package i4 = new Package(7712, "Книга", "Федоров К.С.", "Москва", 1.214);
            Move[] r = { i1, i2, i3, i4 };
            
            // Создаем массив посылок
            var tmp = new Package[] { i1, i2, i3, i4 };
            // Сортируем массив. Сортируется по коду посылки.
            Array.Sort(tmp);
            // Вывод информации по посылкам
            foreach (Move item in tmp)
                Console.WriteLine(item.Print);

            // Проверяем нужно ли перемещать посылку (True - нужно)
            Console.WriteLine(r[0].IsMove);
            // Теперь присвоим текущему положению конечный адрес
            r[0].CurrentLocation = i1.Address;
            // Снова проверяем нужно ли перемещать посылку (False - не нужно)
            Console.WriteLine(r[0].IsMove);

            Console.ReadLine();
        }
    }
}
