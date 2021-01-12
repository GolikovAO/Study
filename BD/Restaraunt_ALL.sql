USE Restaraunt

--Создание таблицы блюд (Cookings)

CREATE TABLE Cookings (
id int IDENTITY(1,1) PRIMARY KEY,
name_cooking varchar(128) NOT NULL,
price real NOT NULL,
discription text);

GO

--Заполнение таблицы блюд 

INSERT INTO Cookings(name_cooking,price,discription)
 VALUES ('Сок вишневый', 60, 'Сок вишневый'),
        ('Салат летний', 70, 'Огурец свежий, Помидор свежий, Зелень, Болгарский перец'),
		('Оливье', 90, 'Зеленый горошек, Колбаса вареная, Картофель, Яйцо, Огурец маринованный'),
		('Салат Крабовый', 95, 'Кукуруза, Крабовые палочки, Рис, Яйцо, Огурец свежий'),
		('Сельд под шубой', 95, 'Свекла, Морковь, Сельд, Яйцо, Картофель'),
		('Окрошка', 70, 'Квас, Колбаса вареная, Картофель, Яйцо, Огурец свежий'),
		('Борщ', 90, 'Говядица, Свекла, Капуста, Морковь, Картофель'),
		('Суп куриный', 75, 'Курица, Картофель, Морковь, Лук, Лапша'),
		('Картофель пюре', 40, 'Картофель'),
		('Картофель фри', 45, 'Картофель'),
		('Картофель по-деревенски', 50, 'Картофель'),
		('Свинина по-французски', 150, 'Свинина, Помидор свежий, Сыр, Майонез'),
		('Котлета по-киевски', 100, 'Курица, Зелень'),
		('Отбивная', 110, 'Свинина'),
		('Куриные крылышки', 90, 'Курица'),
		('Рис', 50, 'Рис'),
		('Плов', 75, 'Рис, Баранина, Морковь, Лук'),
		('Каша Гречневая', 65, 'Гречка'),
		('Чай черный',30, 'Чай черный'),
		('Чай зеленый', 30, 'Чай зеленый'),
		('Кофе', 40, 'Кофе'),
		('Сок яблочный', 60, 'Сок яблочный'),
		('Морс', 50, 'Клубника, Красная смородина, Черная смородина, Клюква'),
        ('Кока-Кола', 70, 'Кока-Кола');

GO


--Создание и заполнение таблицы скидок (Discount)

CREATE TABLE Discount (
id int PRIMARY KEY,
value real NOT NULL);
GO

INSERT INTO Discount(id,value)
VALUES (3, 0.97),
       (5, 0.95),
	   (7, 0.93),
	   (10, 0.9),
	   (15, 0.85),
       (0,1);

--Создание таблицы заказов (Orders)
CREATE TABLE Orders (
id int IDENTITY(1,1) PRIMARY KEY,
cooking_id int,
amount int,
cost real,
check_id int,
createdDate datetime  NOT NULL);
GO

--Создание и заполнение таблицы продуктов (Components)
CREATE TABLE Components(
name varchar(128) PRIMARY KEY,
amount int NOT NULL,
primecost real NOT NULL,
provider_id int);
GO

INSERT INTO Components(name,amount,primecost,provider_id)
 VALUES ('Картофель', 10, 11, 2),
        ('Свекла', 6, 9, 2),
		('Огурец свежий', 9, 13, 2),
		('Помидор свежий', 12, 13, 2),
		('Болгарский перец', 6, 10, 2),
		('Морковь', 8, 11, 2),
		('Капуста', 7, 8, 2),
		('Зелень', 10, 7, 2),
		('Курица', 10, 80, 1),
		('Свинина', 5, 185, 1),
		('Говядина', 5, 190, 1),
		('Сельдь', 8, 100, 1),
		('Зеленый горошек', 3, 70, 3),
		('Кукуруза', 3, 75, 3),
		('Колбаса вареная', 5, 85, 3),
		('Рис', 5, 54, 3),
		('Баранина', 3, 230, 1),
		('Крабовые палочки', 4, 65, 3),
		('Яйцо', 30, 9, 1),
		('Огурец маринованный', 3, 35, 3),
		('Квас', 3, 20, 4),
		('Лук', 6, 10, 2),
		('Лапша', 6, 15, 3),
		('Сыр', 4, 85, 3),
		('Майонез', 4, 20, 3),
		('Гречка', 3, 40, 3),
		('Чай черный', 15, 15, 4),
		('Чай зеленый', 15, 17, 4),
		('Кофе', 10, 20, 4),
		('Сок яблочный', 7, 15, 4),
		('Сок вишневый', 7, 15, 4),
		('Кока-Кола', 10, 25, 4),
		('Клубника', 3, 25, 2),
		('Красная смородина', 3, 20, 2),
		('Черная смородина', 3, 20, 2),
		('Клюква', 3, 27, 2);

GO

--Создание и заполнение таблицы поставщиков (Providers)

CREATE TABLE Providers(
provider_id int IDENTITY(1,1) PRIMARY KEY NOT NULL,
provider_name varchar(128) NOT NULL);



INSERT INTO Providers (provider_name)
VALUES ('"Деревенский двор"'),
       ('ИП Иванов Н.В.'),
	   ('"Гроздь"'),
	   ('ИП Смирнов Д.А.'),
       ('ИП Дмитриев К.С');
GO

--Создание кассовый чек (CashiersCheck)
CREATE TABLE CashiersCheck (
id int IDENTITY(1,1) PRIMARY KEY NOT NULL,
client_id int NOT NULL,
staff_id int NOT NULL,
summ real);

--Создание и заполнение таблицы клиентов (Clients)
CREATE TABLE Clients (
id int IDENTITY(1,1) PRIMARY KEY NOT NULL,
fname varchar(128) NOT NULL,
mname varchar(128),
lname varchar(128) NOT NULL,
discount_id int);

INSERT INTO Clients (lname,fname,mname,discount_id)
VALUES ('Петров','Николай','Иванович',5),
       ('Федорчук','Дмитрий','Сергеерич',0),
	   ('Носова','Светлана','Игоревна',15),
	   ('Ростова','Алена','Викторовна',7),
	   ('Рогачев','Антон','Витальевич',3),
	   ('Калашников','Дмитрий','Сергеевич',0),
	   ('Мельникова','Ульяна','Константинова',10),
	   ('John','Simple',NULL,5);

GO

--Создание и заполнение таблицы персонала (Staff)
CREATE TABLE Staff (
id int IDENTITY(1,1) PRIMARY KEY NOT NULL,
fname varchar(128) NOT NULL,
mname varchar(128),
lname varchar(128) NOT NULL,
salary real);


INSERT INTO Staff (lname,fname,mname,salary)
VALUES ('Шаронова','Татьяна','Александровна',13700),
       ('Зайцева','Тамара','Валерьевна',15000),
	   ('Котов','Георгий','Алексеевич',17300),
	   ('Николаева','Виктория','Степановна',12000),
	   ('Black','Margo',NULL, 13500);

GO

--Создание таблицы поставок (Delivery)
CREATE TABLE Delivery (
id int IDENTITY(1,1) PRIMARY KEY NOT NULL,
provider_id int,
component varchar(128),
date datetime);


--Создание таблицы лога операций дохода/расхода (Transactions)
CREATE TABLE Transactions (
id int IDENTITY(1,1) PRIMARY KEY NOT NULL,
timedata datetime,
value real,
description text);

--Создание и заполнение таблицы бюджета ресторана (Budget)
CREATE TABLE Budget (
budget real,
last_date_salary date);

INSERT INTO Budget (budget,last_date_salary)
VALUES (100000, GETDATE());

--Заполнение таблицы Orders
INSERT INTO Orders (cooking_id, amount, createdDate, check_id)
VALUES (5,2,GETDATE(), 1),
       (3,1,GETDATE(), 1),
	   (24,1,GETDATE(), 1),
	   (7,3,GETDATE(), 2),
	   (8,2,GETDATE(), 2),
	   (18,1,GETDATE(), 3);

--Подсчет стоимости для уже добавленных заказов
UPDATE Orders
SET cost = amount * Cookings.price FROM Cookings
JOIN Orders ON Cookings.id = Orders.cooking_id

--Заполнение таблицы кассового чека (CashiersCheck)
INSERT INTO CashiersCheck (client_id,staff_id)
VALUES (2,2),
       (1,3),
	   (3,4),
	   (2,1);
--Заполнение суммы чека по уже добавленных чеков
UPDATE CashiersCheck
SET summ = (SELECT SUM(ABC) FROM (
SELECT cost as ABC FROM Orders 
WHERE 
(Orders.check_id=CashiersCheck.id) 
)A) *  Discount.value FROM Discount 
JOIN Clients ON Discount.id = Clients.discount_id
JOIN CashiersCheck ON Clients.id = CashiersCheck.client_id

--Создание внешних ключей таблиц
ALTER TABLE Orders
WITH CHECK ADD CONSTRAINT FK_Orders_Cookings FOREIGN KEY(cooking_id) REFERENCES Cookings(id)
ALTER TABLE CashiersCheck
WITH CHECK ADD CONSTRAINT FK_Check_Client FOREIGN KEY (client_id) REFERENCES Clients(id)
ALTER TABLE CashiersCheck
WITH CHECK ADD CONSTRAINT FK_Check_Staff FOREIGN KEY (staff_id) REFERENCES Staff(id)
ALTER TABLE Clients
WITH CHECK ADD CONSTRAINT FK_Clients_Discount FOREIGN KEY (discount_id) REFERENCES Discount(id)
ALTER TABLE Components
WITH CHECK ADD CONSTRAINT FK_Components_Provider FOREIGN KEY(provider_id) REFERENCES Providers(provider_id)
ALTER TABLE Delivery
WITH CHECK ADD CONSTRAINT FK_Delivery_Provider FOREIGN KEY(provider_id) REFERENCES Providers(provider_id)
ALTER TABLE Delivery
WITH CHECK ADD CONSTRAINT FK_Delivery_Components FOREIGN KEY(component) REFERENCES Components(name)

----Добавление свойств полям таблицы: уникальное имя блюда и автозаполнение поля даты при добавлении записи в таблицу заказов
ALTER TABLE Cookings
ADD CONSTRAINT DF_Cookings_name_cooking_unique UNIQUE (name_cooking)
ALTER TABLE Orders
ADD CONSTRAINT DF_Orders_createdDate_Default DEFAULT (getdate()) FOR createdDate

----Очистка данных таблицы и ёё удаление на тестовой таблице
CREATE TABLE TestTable (
id int,
pole1 varchar(128),
pole2 datetime);

INSERT INTO TestTable (id,pole1,pole2)
VALUES (1,'fsfs', GETDATE()),
       (2,'tttttttttt', GETDATE()),
       (3,'7yd77777a8hn', GETDATE());

TRUNCATE TABLE TestTable
DROP TABLE TestTable

--Выводит список стоимости каждого блюда
SELECT name_cooking, price FROM Cookings

--Выводит данные по скидкам у каждого клиента
SELECT lname AS 'Фамилия', fname AS 'Имя', Discount.id AS 'Discount,%' FROM Clients
JOIN Discount ON Clients.discount_id = Discount.id

--Показывает незадействованных поставщиков
SELECT Providers.provider_name FROM Components 
RIGHT OUTER JOIN Providers ON Providers.provider_id = Components.provider_id
WHERE name IS NULL

--Выводит данные о том, кто сделал заказ, что заказал, цену блюда, кол-во порций, стоимость заказа без учета скидки, номер чека и кто был официантом
SELECT Clients.lname AS 'Фамилия', Clients.fname AS 'Имя', Cookings.name_cooking AS 'Блюдо', Cookings.price AS 'Цена', Orders.amount AS 'Кол-во', Orders.cost AS 'Стоимость', CashiersCheck.id AS 'Номер чека', Staff.lname AS 'Официант'
FROM Clients, Cookings, Orders, CashiersCheck, Staff
WHERE ((Cookings.id = Orders.cooking_id) AND (Staff.id = CashiersCheck.staff_id) AND (CashiersCheck.client_id = Clients.id)  AND (Orders.check_id = CashiersCheck.id))


--Показыывает клиентов с одним именем и сортирует результат по фамилии
SELECT A.fname,A.lname FROM Clients as A, Clients as B
WHERE A.fname = B.fname AND  A.id <> B.id
ORDER BY A.lname

--Показывает информацию блюд, которые заказывали и которые не заказывали
SELECT * FROM Cookings
WHERE EXISTS (SELECT * FROM Orders WHERE Orders.cooking_id = Cookings.id)
SELECT * FROM Cookings
WHERE NOT EXISTS (SELECT * FROM Orders WHERE Orders.cooking_id = Cookings.id)

--Показывает кто поставщик у заданного набора продуктов
SELECT Components.name AS Продукт, Providers.provider_name AS Поставщик FROM Providers,Components
WHERE Components.name IN('Картофель','Курица','Клубника','Яйцо') AND Providers.provider_id = Components.provider_id

--Показывает блюда по заданному условию цены
SELECT Cookings.name_cooking as Блюдо, Cookings.price as Цена FROM Cookings
WHERE price BETWEEN 50 AND 80;

SELECT Cookings.name_cooking as Блюдо, Cookings.price as Цена FROM Cookings
WHERE price NOT BETWEEN 50 AND 80

--Выводит поставщика, если он один, у кого цены закупки больше 100
SELECT provider_name FROM Providers
WHERE provider_id = ALL (SELECT provider_id FROM Components WHERE primecost > 100)

--Выводит поставщиков, у кого существуют цены больше 70
SELECT provider_name FROM Providers
WHERE provider_id = ANY (SELECT provider_id FROM Components WHERE primecost > 70)

--Показывает клиентов, у которых имя начинается с буквы "A"
SELECT fname, lname FROM Clients
WHERE fname LIKE 'А%';

----Показывает стоимость блюд с расчетом всех скидок
SELECT
   Cookings.name_cooking,Cookings.price as Цена, Discount.value  as Множитель,
  CASE
    WHEN Discount.id = 0 THEN Cookings.price*Discount.value
    WHEN Discount.id = 3 THEN Cookings.price*Discount.value
	WHEN Discount.id = 5 THEN Cookings.price*Discount.value
	WHEN Discount.id = 7 THEN Cookings.price*Discount.value
	WHEN Discount.id = 10 THEN Cookings.price*Discount.value
	WHEN Discount.id = 15 THEN Cookings.price*Discount.value
  END Итого 
FROM Cookings, Discount
ORDER BY Cookings.name_cooking

---Запросы с преобразованием типов
SELECT Cookings.name_cooking, CAST(Cookings.price AS nvarchar) + ' руб.' as   Цена
FROM Cookings
SELECT CONVERT(nvarchar, Orders.createdDate, 3)
FROM Orders

--Выводит наличие скидки у клиента, если есть, то выводит величину
SELECT fname, lname,
IIF(discount_id = 0, 'Скидки нет', CAST(discount_id as nvarchar) + '%') as 'Наличие Скидки'
FROM Clients 

--Пример функции replace, без изменения данных
SELECT fname as 'До замены', REPLACE(fname, 'Дмитрий', 'Дима') as 'После замены'
FROM Clients;

--Пример перевода в верхний регистр
SELECT fname, UPPER(fname) FROM Clients

--Пример использования unicode и ascii. Выводит номера по таблицам первого символа.
SELECT fname, ASCII(fname), UNICODE(fname) FROM Clients

--Пример использования nchar. Выводит символ по таблице юникод.
SELECT price, NCHAR(price) FROM Cookings

---Пример использования datepart
SELECT createdDate, DATEPART(YY, createdDate) FROM Orders

--Пример использования dateadd
SELECT createdDate, DATEADD(YY, 10, createdDate) FROM Orders

--Пример получения времени компьютера и преобразования типа
SELECT SYSDATETIMEOFFSET(), CONVERT(datetime,SYSDATETIMEOFFSET()), CONVERT(date,SYSDATETIMEOFFSET())

--Пример использования Group by, выводит те продукты и их поставщиков, отсортировав по названию продукта, которые не поставляет "Гроздь"
SELECT Components.name, Providers.provider_name FROM Components,Providers
WHERE Components.provider_id=Providers.provider_id
GROUP BY Components.name, Providers.provider_name
HAVING Providers.provider_name <> '"Гроздь"'

