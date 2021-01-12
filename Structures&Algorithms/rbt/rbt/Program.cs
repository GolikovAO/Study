using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace rbt
{
    class Program
    {
        static void Main(string[] args)
        {
            RBT tree = new RBT();
            tree.Insert(5);
            tree.Insert(3);
            tree.Insert(7);
            tree.Insert(2);
            tree.Insert(1);
            tree.Insert(9);
            tree.Insert(11);
            tree.Insert(6);
            tree.vivod();
            tree.Delete(6);
            Console.WriteLine();
            tree.vivod();
            Console.ReadLine();
        }
    }
    enum Color
    {
        Red,
        Black
    }
    class RBT
    {
        public class Node
        {
            public Color colour;
            public Node left;
            public Node right;
            public Node parent;
            public int data;

            public Node(int data) { this.data = data; }
            public Node(Color colour) { this.colour = colour; }
            public Node(int data, Color colour) { this.data = data; this.colour = colour; }
        }

        private Node root;

        public RBT() { }
   
        private void RotateL(Node X)
        {
            Node Y = X.right;
            X.right = Y.left;
            if (Y.left != null)
            {
                Y.left.parent = X;
            }
            if (Y != null)
            {
                Y.parent = X.parent;
            }
            if (X.parent == null)
            {
                root = Y;
            }
            if (X == X.parent.left)
            {
                X.parent.left = Y;
            }
            else
            {
                X.parent.right = Y;
            }
            Y.left = X; 
            if (X != null)
            {
                X.parent = Y;
            }

        }

        private void RotateR(Node Y)
        {
            Node X = Y.left;
            Y.left = X.right;
            if (X.right != null)
            {
                X.right.parent = Y;
            }
            if (X != null)
            {
                X.parent = Y.parent;
            }
            if (Y.parent == null)
            {
                root = X;
            }
            if (Y == Y.parent.right)
            {
                Y.parent.right = X;
            }
            if (Y == Y.parent.left)
            {
                Y.parent.left = X;
            }

            X.right = Y;
            if (Y != null)
            {
                Y.parent = X;
            }
        }
      
        public void vivod()
        {
            if (root == null)
            {
                Console.WriteLine("derevo pustoe");
                return;
            }
            if (root != null)
            {
                Preorder(root);
            }
        }
        public Node Find(int key)
        {
            bool isFound = false;
            Node temp = root;
            Node item = null;
            while (!isFound)
            {
                if (temp == null)
                {
                    break;
                }
                if (key < temp.data)
                {
                    temp = temp.left;
                }
                if (key > temp.data)
                {
                    temp = temp.right;
                }
                if (key == temp.data)
                {
                    isFound = true;
                    item = temp;
                }
            }
            if (isFound)
            {
                return temp;
            }
            else
            {
                Console.WriteLine();
                Console.WriteLine("{0} net v dereve", key);
                return null;
            }
        }
        public void Insert(int item)
        {
            Node newItem = new Node(item);
            if (root == null)
            {
                root = newItem;
                root.colour = Color.Black;
                return;
            }
            Node Y = null;
            Node X = root;
            while (X != null)
            {
                Y = X;
                if (newItem.data < X.data)
                {
                    X = X.left;
                }
                else
                {
                    X = X.right;
                }
            }
            newItem.parent = Y;
            if (Y == null)
            {
                root = newItem;
            }
            else if (newItem.data < Y.data)
            {
                Y.left = newItem;
            }
            else
            {
                Y.right = newItem;
            }
            newItem.left = null;
            newItem.right = null;
            newItem.colour = Color.Red;
            Check(newItem);// проверяем и исправляем дерево
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
        private void Check(Node item)
        {
            //Проверка на цвета
            while (item != root && item.parent.colour == Color.Red)
            {
                //Если имеется несоответствие
                if (item.parent == item.parent.parent.left)
                {
                    Node Y = item.parent.parent.right;
                    if (Y != null && Y.colour == Color.Red)
                    {
                        item.parent.colour = Color.Black;
                        Y.colour = Color.Black;
                        item.parent.parent.colour = Color.Red;
                        item = item.parent.parent;
                    }
                    else 
                    {
                        if (item == item.parent.right)
                        {
                            item = item.parent;
                            RotateL(item);
                        }
                        
                        item.parent.colour = Color.Black;
                        item.parent.parent.colour = Color.Red;
                        RotateR(item.parent.parent);
                    }

                }
                else
                {
                    Node X = null;

                    X = item.parent.parent.left;
                    if (X != null && X.colour == Color.Black)
                    {
                        item.parent.colour = Color.Red;
                        X.colour = Color.Red;
                        item.parent.parent.colour = Color.Black;
                        item = item.parent.parent;
                    }
                    else 
                    {
                        if (item == item.parent.left)
                        {
                            item = item.parent;
                            RotateR(item);
                        }                       
                        item.parent.colour = Color.Black;
                        item.parent.parent.colour = Color.Red;
                        RotateL(item.parent.parent);

                    }

                }
                root.colour = Color.Black;
            }
        }
        public void Delete(int key)
        {
            
            Node item = Find(key);
            Node X = null;
            Node Y = null;

            if (item == null)
            {
                Console.WriteLine("Takovo znacheniya net v dereve");
                return;
            }
            if (item.left == null || item.right == null)
            {
                Y = item;
            }
            else
            {
                Y = TreeSuccessor(item);
            }
            if (Y.left != null)
            {
                X = Y.left;
            }
            else
            {
                X = Y.right;
            }
            if (X != null)
            {
                X.parent = Y;
            }
            if (Y.parent == null)
            {
                root = X;
            }
            else if (Y == Y.parent.left)
            {
                Y.parent.left = X;
            }
            else
            {
                Y.parent.left = X;
            }
            if (Y != item)
            {
                item.data = Y.data;
            }
            if (Y.colour == Color.Black)
            {
                DeleteCheck(X);
            }

        }
  
        private void DeleteCheck(Node X) //проверка на соответствие после удаления
        {

            while (X != null && X != root && X.colour == Color.Black)
            {
                if (X == X.parent.left)
                {
                    Node W = X.parent.right;
                    if (W.colour == Color.Red)
                    {
                        W.colour = Color.Black; 
                        X.parent.colour = Color.Red; 
                        RotateL(X.parent); 
                        W = X.parent.right; 
                    }
                    if (W.left.colour == Color.Black && W.right.colour == Color.Black)
                    {
                        W.colour = Color.Red; 
                        X = X.parent; 
                    }
                    else if (W.right.colour == Color.Black)
                    {
                        W.left.colour = Color.Black; 
                        W.colour = Color.Red; 
                        RotateR(W); 
                        W = X.parent.right; 
                    }
                    W.colour = X.parent.colour; 
                    X.parent.colour = Color.Black; 
                    W.right.colour = Color.Black; 
                    RotateL(X.parent); 
                    X = root; 
                }
                else 
                {
                    Node W = X.parent.left;
                    if (W.colour == Color.Red)
                    {
                        W.colour = Color.Black;
                        X.parent.colour = Color.Red;
                        RotateR(X.parent);
                        W = X.parent.left;
                    }
                    if (W.right.colour == Color.Black && W.left.colour == Color.Black)
                    {
                        W.colour = Color.Black;
                        X = X.parent;
                    }
                    else if (W.left.colour == Color.Black)
                    {
                        W.right.colour = Color.Black;
                        W.colour = Color.Red;
                        RotateL(W);
                        W = X.parent.left;
                    }
                    W.colour = X.parent.colour;
                    X.parent.colour = Color.Black;
                    W.left.colour = Color.Black;
                    RotateR(X.parent);
                    X = root;
                }
            }
            if (X != null)
                X.colour = Color.Black;
        }
        private Node Minimum(Node X)
        {
            while (X.left.left != null)
            {
                X = X.left;
            }
            if (X.left.right != null)
            {
                X = X.left.right;
            }
            return X;
        }
        private Node TreeSuccessor(Node X)
        {
            if (X.left != null)
            {
                return Minimum(X);
            }
            else
            {
                Node Y = X.parent;
                while (Y != null && X == Y.right)
                {
                    X = Y;
                    Y = Y.parent;
                }
                return Y;
            }
        }
    }
}