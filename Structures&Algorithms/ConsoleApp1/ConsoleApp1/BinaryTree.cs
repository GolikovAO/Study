using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using System.Threading.Tasks;

namespace Tree

{
    public class BinaryTree //класс, реализующий АТД «дерево бинарного поиска»
    {

        public static double summa = 0;
        public static int c = 0;
        public static int poisk = 0;
        //вложенный класс, отвечающий за узлы и операции допустимы для дерева бинарного
        //поиска
        private class Node
        {

            public object inf; //информационное поле
            public Node left; //ссылка на левое поддерево
            public int counter;
            public Node rigth; //ссылка на правое поддерево
            //конструктор вложенного класса, создает узел дерева
            public Node(object nodeInf)
            {
                inf = nodeInf;
                left = null;
                rigth = null;
                counter = 0;
            }
            //добавляет узел в дерево так, чтобы дерево оставалось деревом бинарного поиска
            public static void Add(ref Node r, object nodeInf)
            {
                if (r == null)
                {
                    r = new Node(nodeInf);
                }
                else
                {
                    if (((IComparable)(r.inf)).CompareTo(nodeInf) > 0)
                    {
                        Add(ref r.left, nodeInf);
                    }
                    else
                    {
                        Add(ref r.rigth, nodeInf);
                    }
                }
                r.counter++;
            }


            public static void Preorder(Node r) //прямой обход дерева
            {

                if (r != null)
                {
                    Console.Write("{0} ", r.inf);
                    Preorder(r.left);
                    Preorder(r.rigth);
                }
            }
           
           
            public static void Inorder(Node r) //симметричный обход дерева
            {
                if (r != null)
                {
                    Inorder(r.left);
                    Console.Write("{0} ", r.inf);
                    Inorder(r.rigth);
                }
            }
            public static void Postorder(Node r) //обратный обход дерева
            {
                if (r != null)
                {
                    Postorder(r.left);
                    Postorder(r.rigth);
                    Console.Write("{0} ", r.inf);
                }
            }
            //поиск ключевого узла в дереве
            public static void Search(Node r, object key, out Node item)
            {
                if (r == null)
                {
                    item = null;
                }
                else
                {
                    if (((IComparable)(r.inf)).CompareTo(key) == 0)
                    {
                        item = r;
                        poisk++;
                    }
                        Search(r.rigth, key, out item);
                        Search(r.left, key, out item);
                    }
               
                
            }
            //методы Del и Delete позволяют удалить узел в дереве так, чтобы дерево при этом
            //оставалось деревом бинарного поиска
            private static void Del(Node t, ref Node tr)
            {
                if (tr.rigth != null)
                {
                    Del(t, ref tr.rigth);
                }
                else
                {

                    t.inf = tr.inf;
                    if (tr.left != null)
                        t.left = tr.left;
                    t = tr.rigth;
                    



                }
            }
            public static void Delete(ref Node t, object key)
            {
                    if (t == null)
                    {
                        throw new Exception("Данное значение в дереве отсутствует");
                    }
                    else
                    {
                        if (((IComparable)(t.inf)).CompareTo(key) > 0)
                        {
                            Delete(ref t.left, key);
                        }
                        else
                        {
                            if (((IComparable)(t.inf)).CompareTo(key) < 0)
                            {
                                Delete(ref t.rigth, key);
                            }
                            else
                            {
                                if (t.left == null)
                                {
                                    t = t.rigth;
                                }
                                else
                                {
                                    if (t.rigth == null)
                                    {
                                        t = t.left;
                                    }
                                    else
                                    {
                                        Node tr = t.left;
                                        Del(t, ref tr);
                                    }
                                }
                            }
                        }
                    }
            }
           
            public static void RotationLeft(ref Node t)
            {
                Node x = t.rigth;
                t.rigth = x.left;
                x.left = t;
                t = x;
            }
            public static void RotationRigth(ref Node t)
            {
                Node x = t.left;
                t.left = x.rigth;
                x.rigth = t;
                t = x;
            }





        } //конец вложенного класса
        Node tree; //ссылка на корень дерева
        //свойство позволяет получить доступ к значению информационного поля корня дерева
        public object Inf
        {
            set { tree.inf = value; }
            get { return tree.inf; }
        }
        public BinaryTree() //открытый конструктор
        {
            tree = null;
        }
        private BinaryTree(Node r) //закрытый конструктор
        {
            tree = r;
        }
        public void Add(object nodeInf) //добавление узла в дерево
        {
            Node.Add(ref tree, nodeInf);
        }
        //организация различных способов обхода дерева
        public void Preorder()
        {
            Node.Preorder(tree);
        }

        public void Inorder()
        {
            Node.Inorder(tree);
        }
        public void Postorder()
        {
            Node.Postorder(tree);
        }
        //поиск ключевого узла в дереве
        public void Search(object key)
        {
            Node r;
            poisk = 0;
            Node.Search(tree, key, out r);
            if (poisk>0)
            Console.WriteLine("Znachenie {0} vstrechaetsya",key);
            else
                Console.WriteLine("Znachenie {0} v dereve otsutstvuet",key);
        }
        //удаление ключевого узла в дереве
        public void Delete(object key)
        {
           // for (int i = 0; i <= poisk - 1; i++)
                Node.Delete(ref tree, key);
        }
        

    }
}
