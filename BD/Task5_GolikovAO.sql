USE Restaraunt

SET STATISTICS IO ON
SET	STATISTICS TIME ON

CREATE NONCLUSTERED INDEX IX_OrdersCost ON Orders (cooking_id,cost) 

CREATE NONCLUSTERED INDEX IX_Ordersall ON dbo.Orders (check_id) INCLUDE (cooking_id,amount,cost)

CREATE NONCLUSTERED INDEX IX_Orders ON Orders (cooking_id)

CREATE NONCLUSTERED INDEX CI_Clients ON dbo.Clients(discount_id,fname,lname) 

SELECT fname, lname, discount_id AS 'Discount' FROM dbo.Clients
WHERE discount_id = 5

--Показыывает клиентов с одним именем и сортирует результат по фамилии
SELECT A.fname,A.lname FROM Clients as A, Clients as B
WHERE A.fname = B.fname AND  A.id <> B.id
ORDER BY A.lname

SELECT Clients.lname AS 'Фамилия', Clients.fname AS 'Имя', Cookings.name_cooking AS 'Блюдо', Cookings.price AS 'Цена', Orders.amount AS 'Кол-во', Orders.cost AS 'Стоимость', CashiersCheck.id AS 'Номер чека', Staff.lname AS 'Официант'
FROM Clients, Cookings, Orders, CashiersCheck, Staff
WHERE ((Cookings.id = Orders.cooking_id) AND (Staff.id = CashiersCheck.staff_id) AND (CashiersCheck.client_id = Clients.id)  AND (Orders.check_id = CashiersCheck.id))

--Выводит данные по скидкам у каждого клиента
SELECT lname AS 'Фамилия', fname AS 'Имя', Discount.id AS 'Discount,%' FROM Clients
JOIN Discount ON Clients.discount_id = Discount.id

SELECT * FROM Cookings
WHERE EXISTS (SELECT * FROM Orders WHERE Orders.cooking_id = Cookings.id)

--Показывает заказы по заданному условию цены
SELECT dbo.Cookings.name_cooking as Блюдо, dbo.Orders.cost as Цена FROM Cookings,dbo.Orders
WHERE Orders.cooking_id = dbo.Cookings.id AND (dbo.Cookings.price BETWEEN 50 AND 80) AND dbo.Orders.cost BETWEEN 100 AND 150 


SELECT DATENAME(DAY,dbo.Orders.createdDate) FROM dbo.Orders

CREATE INDEX IX_Orders_Date ON dbo.Orders (createdDate)



SELECT dbo.Transactions.description , SUBSTRING(description,2,3)
FROM dbo.Transactions;
CREATE INDEX IX_TRANSACTIONS ON dbo.Transactions (id) INCLUDE (timedata)

SELECT Components.name, Providers.provider_name FROM Components,Providers
WHERE Components.provider_id=Providers.provider_id
GROUP BY Components.name, Providers.provider_name
HAVING Providers.provider_name <> '"Гроздь"'


SELECT dbo.Orders.id, dbo.Cookings.name_cooking, dbo.Components.name, dbo.Providers.provider_name 
FROM dbo.Orders,dbo.Cookings,dbo.Providers,dbo.Components
WHERE (dbo.Orders.id = dbo.Cookings.id) AND 
(Components.name = ANY (SELECT value FROM Cookings CROSS APPLY STRING_SPLIT(Cookings.discription,',')))
GROUP BY dbo.Orders.id, Cookings.name_cooking,dbo.Components.name, dbo.Providers.provider_name
HAVING dbo.Providers.provider_name = '"Гроздь"'

CREATE INDEX IX_Orders_cookings ON dbo.Orders (cooking_id)
CREATE INDEX IX_Components ON dbo.Components(name) INCLUDE (provider_id)
CREATE INDEX IX_Prociders ON dbo.Providers(provider_id,provider_name)


(SELECT fname FROM dbo.Clients) INTERSECT (SELECT lname FROM dbo.Clients)

CREATE INDEX IX_Clientslname ON dbo.Clients (lname) 
DROP INDEX CI_Clients ON dbo.Clients 