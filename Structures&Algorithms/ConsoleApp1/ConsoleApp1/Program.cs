//бинарное дерево
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;

namespace Tree
{
    class Program
    {
        static void Main(string[] args)
        {
            BinaryTree Tree = new BinaryTree();
            using (StreamReader file = new StreamReader("f:/c++/text.txt"))
            {
                string line = file.ReadToEnd();
                string[] data = line.Split(' ');
                foreach (string item in data)
                {
                    Tree.Add(int.Parse(item));
                }
            }
            Tree.Preorder();
            //Console.WriteLine();
            //Tree.Postorder();
            //Console.WriteLine();
            //Tree.Inorder();
            Console.WriteLine();
            Tree.Search(7);
            Console.WriteLine();
            Tree.Delete(15);
            Console.WriteLine();
            Tree.Preorder();
        }
    }
}
