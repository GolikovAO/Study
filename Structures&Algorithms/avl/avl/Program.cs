using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace avl
{
   
    class AVL
    {
        class Node
        {
            public int data;
            public Node left;
            public Node right;
            public Node(int data)
            {
                this.data = data;
            }
        }
        Node root;
        public AVL()
        {
        }
        public void Add(int data) //добавление узла
        {
            Node newItem = new Node(data);
            if (root == null)
            {
                root = newItem;
            }
            else
            {
                root = Insert(root, newItem); //если узел не пустой то вызываем рекурсивую функцию, которая добавляет узлы, сохраняя балансировку
            }
        }
        private Node Insert(Node current, Node n)
        {
            if (current == null)
            {
                current = n;
                return current;
            }
            else if (n.data < current.data)
            {
                current.left = Insert(current.left, n);
                current = balance_tree(current);
            }
            else if (n.data > current.data)
            {
                current.right = Insert(current.right, n);
                current = balance_tree(current);
            }
            return current;
        }
        private Node balance_tree(Node current)
        {
            int raznost = check(current);
            if (raznost > 1)
            {
                if (check(current.left) > 0)
                {
                    current = RotateL(current);
                }
                else
                {
                    current = RotateLR(current);
                }
            }
            else if (raznost < -1)
            {
                if (check(current.right) > 0)
                {
                    current = RotateRL(current);
                }
                else
                {
                    current = RotateR(current);
                }
            }
            return current;
        }
        public void Delete(int key)
        {
            root = Delete(root, key);
        }
        private Node Delete(Node current, int key)
        {
            Node parent;
            if (current == null)
            { return null; }
            else
            {
                //левое поддерево
                if (key < current.data)
                {
                    current.left = Delete(current.left, key);
                    if (check(current) == -2)
                    {
                        if (check(current.right) <= 0)
                        {
                            current = RotateR(current);
                        }
                        else
                        {
                            current = RotateRL(current);
                        }
                    }
                }
                //правое поддерево
                else if (key > current.data)
                {
                    current.right = Delete(current.right, key);
                    if (check(current) == 2)
                    {
                        if (check(current.left) >= 0)
                        {
                            current = RotateL(current);
                        }
                        else
                        {
                            current = RotateLR(current);
                        }
                    }
                }
                //если значение найдено
                else
                {
                    if (current.right != null)
                    {
               
                        parent = current.right;
                        while (parent.left != null)
                        {
                            parent = parent.left;
                        }
                        current.data = parent.data;
                        current.right = Delete(current.right, parent.data);
                        if (check(current) == 2)// перебалансилуем
                        {
                            if (check(current.left) >= 0)
                            {
                                current = RotateL(current);
                            }
                            else { current = RotateLR(current); }
                        }
                    }
                    else
                    {   
                        return current.left;
                    }
                }
            }
            return current;
        }
       
        public void Vivod()
        {
            if (root == null)
            {
                Console.WriteLine("Derevo pustoe");
                return;
            }
            Preorder(root);
            Console.WriteLine();
        }
        private void Preorder(Node current)
        {
            if (current != null)
            {
                Console.Write("{0} ", current.data);
                Preorder(current.left);
                Preorder(current.right);
            }
        }
        private int max(int l, int r)
        {
            return l > r ? l : r;
        }
        private int getHeight(Node current)
        {
            int height = 0;
            if (current != null)
            {
                int l = getHeight(current.left);
                int r = getHeight(current.right);
                int m = max(l, r);
                height = m + 1;
            }
            return height;
        }
        private int check(Node current)
        {
            int l = getHeight(current.left);
            int r = getHeight(current.right);
            int raznost = l - r;
            return raznost;
        }
        private Node RotateR(Node parent) //поворот вправо
        {
            Node pivot = parent.right;
            parent.right = pivot.left;
            pivot.left = parent;
            return pivot;
        }
        private Node RotateL(Node parent) //поворот влево
        {
            Node pivot = parent.left;
            parent.left = pivot.right;
            pivot.right = parent;
            return pivot;
        }
        private Node RotateLR(Node parent) //поворот влево-вправо
        {
            Node pivot = parent.left;
            parent.left = RotateR(pivot);
            return RotateL(parent);
        }
        private Node RotateRL(Node parent) //поворот вправо-влево
        {
            Node pivot = parent.right;
            parent.right = RotateL(pivot);
            return RotateR(parent);
        }
    }
    class Program
    {
        static void Main(string[] args)
        {
            AVL tree = new AVL();
            int n;
            Console.WriteLine("VVedite razmernost' dereva:");
            n = int.Parse(Console.ReadLine());
            Console.WriteLine("VVedite elemeti dereva:");
            for (int i = 0; i <= n - 1; i++)
            {
                tree.Add(int.Parse(Console.ReadLine()));
            }
            tree.Delete(7);
            tree.Vivod();
        }
    }
}
