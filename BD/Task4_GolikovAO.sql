USE Restaraunt
GO

--Триггер на подсчет стоимости заказа при его добавлении
CREATE TRIGGER Orders_insert_cost
ON Orders
AFTER INSERT
AS 
UPDATE Orders
SET cost = amount * Cookings.price FROM Cookings
JOIN Orders ON Cookings.id = Orders.cooking_id
GO

--Триггер на перерасчет стоимости заказов при изменении таблицы
CREATE TRIGGER Orders_Update
ON Orders
AFTER UPDATE
AS
UPDATE Orders
SET cost = amount * Cookings.price FROM Cookings
JOIN Orders ON Cookings.id = Orders.cooking_id
GO

--Тригер на перерасчет кассового чека при добавлении заказа
CREATE TRIGGER Orders_insert_CashiersCheck_insert
ON Orders
AFTER INSERT
AS
BEGIN
UPDATE CashiersCheck
SET summ = (SELECT SUM(ABC) FROM (
SELECT cost as ABC FROM Orders 
WHERE 
(Orders.check_id=CashiersCheck.id) 
)A) *  Discount.value FROM Discount 
JOIN Clients ON Discount.id = Clients.discount_id
JOIN CashiersCheck ON Clients.id = CashiersCheck.client_id
INSERT INTO dbo.Transactions
(
    value,
    description)
SELECT dbo.CashiersCheck.summ,'Чек' FROM dbo.CashiersCheck 
END
GO



--Триггер на перерасчет кассового чека при изменении заказа
CREATE TRIGGER Orders_insert_CashiersCheck_update
ON Orders
AFTER UPDATE
AS
BEGIN
UPDATE CashiersCheck
SET summ = (SELECT SUM(ABC) FROM (
SELECT cost as ABC FROM Orders 
WHERE 
(Orders.check_id=CashiersCheck.id) 
)A) *  Discount.value FROM Discount 
JOIN Clients ON Discount.id = Clients.discount_id
JOIN CashiersCheck ON Clients.id = CashiersCheck.client_id
END
GO

--Тригер на перерасчет кассового чека при удалении заказа
CREATE TRIGGER Orders_insert_CashiersCheck_delete
ON Orders
AFTER DELETE
AS
BEGIN
UPDATE CashiersCheck
SET summ = (SELECT SUM(ABC) FROM (
SELECT cost as ABC FROM Orders 
WHERE 
(Orders.check_id=CashiersCheck.id) 
)A) *  Discount.value FROM Discount 
JOIN Clients ON Discount.id = Clients.discount_id
JOIN CashiersCheck ON Clients.id = CashiersCheck.client_id
END
GO


--Триггер на списание продуктов со склада при добавлении нового заказа
CREATE TRIGGER Orders_amount_component
ON Orders
AFTER INSERT
AS
UPDATE Components
SET Components.amount = Components.amount - (SELECT Inserted.amount FROM Inserted)
WHERE Components.name = ANY (SELECT value FROM Cookings CROSS APPLY STRING_SPLIT(Cookings.discription,',')
JOIN Inserted ON Inserted.cooking_id = Cookings.id)
GO



--Триггер на добавление продуктов на склад при удалении заказа
CREATE TRIGGER Orders_amount_component_delete
ON Orders
AFTER DELETE
AS
UPDATE Components
SET Components.amount = Components.amount + (SELECT Deleted.amount FROM Deleted)
WHERE Components.name = ANY (SELECT value FROM Cookings CROSS APPLY STRING_SPLIT(Cookings.discription,',')
JOIN Deleted ON Deleted.cooking_id = Cookings.id)
GO

--Тригер на доставку недостающих продуктов
CREATE TRIGGER Components_Delivery
ON Components
AFTER UPDATE
AS
BEGIN
IF (EXISTS(SELECT Components.amount FROM Components WHERE amount < 3))
BEGIN
INSERT INTO dbo.Delivery
(
    provider_id,
    component
)
SELECT Components.provider_id, dbo.Components.name FROM dbo.Components WHERE dbo.Components.amount < 3
INSERT INTO Transactions (value, description)
 SELECT Components.primecost * -10, abc = 'Заказ продукта'  FROM Components WHERE Components.amount < 3
UPDATE Components
SET  amount = amount + 10 
WHERE Components.amount < 3
END
END
GO

--Триггер на обновление бюджета Ресторана при добавлении транзакции
CREATE TRIGGER Budget_update
ON Transactions
AFTER INSERT
AS
UPDATE Budget
SET budget = budget + (SELECT SUM(ABC) FROM (
SELECT value as ABC FROM inserted)A)  
GO

--Триггер на обновление бюджета Ресторана при удалении
CREATE TRIGGER Budget_delete
ON Transactions
AFTER DELETE
AS
UPDATE Budget
SET budget = budget + (SELECT SUM(ABC) FROM (
SELECT value as ABC FROM deleted)A)  
GO

--Триггер на добавление новой скидки, с учетом, того, что она не может превышать 20 процентов
CREATE TRIGGER Discount_insert
ON Discount
INSTEAD OF INSERT
AS
BEGIN
DECLARE @id int
SELECT @id = id FROM inserted
IF (@id < 21)
BEGIN
INSERT INTO Discount (id,value)
SELECT id, 1-id*0.01 FROM inserted
END
ELSE 
BEGIN
RAISERROR ('Скидка не может превышать 20%',16,1)
ROLLBACK;
END
END
GO
