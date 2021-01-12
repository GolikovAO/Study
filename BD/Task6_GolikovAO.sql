USE Restaraunt
GO
SET NUMERIC_ROUNDABORT OFF;

SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT,
   QUOTED_IDENTIFIER, ANSI_NULLS ON;

GO
--Представление, которое содержит информацию по кассовым чекам
CREATE VIEW [dbo].[CashCheck]
WITH SCHEMABINDING
AS
SELECT        TOP (100) PERCENT dbo.Orders.check_id AS [Номер чека], dbo.Staff.lname AS Официант, dbo.Cookings.name_cooking AS Блюдо, dbo.Cookings.price AS Цена, dbo.Orders.amount AS [Кол-во], dbo.Orders.cost AS Стоимость, 
                         dbo.Clients.lname AS Посетитель, dbo.Clients.discount_id AS [Скидка.%], dbo.CashiersCheck.summ AS Итого
FROM            dbo.CashiersCheck INNER JOIN
                         dbo.Orders ON dbo.Orders.check_id = dbo.CashiersCheck.id INNER JOIN
                         dbo.Clients ON dbo.CashiersCheck.client_id = dbo.Clients.id INNER JOIN
                         dbo.Staff ON dbo.CashiersCheck.staff_id = dbo.Staff.id INNER JOIN
                         dbo.Cookings ON dbo.Orders.cooking_id = dbo.Cookings.id
ORDER BY [Номер чека]
GO

--Представление, которое содержит меню ресторана
CREATE VIEW [dbo].[Menu]
AS
SELECT        name_cooking AS Блюдо, price AS Цена, discription AS Состав
FROM            dbo.Cookings
WITH CHECK OPTION 
GO

--Представление, которое содержит себестоимость каждого блюда
CREATE VIEW [dbo].[PrimeCosts]
AS
SELECT        name AS Блюдо, primecost * 0.5 AS Себестоимость
FROM            dbo.PRIME
GO

--Представление, которое содержит информацию о кол-ве продуктов на складе
CREATE VIEW [dbo].[Склад]
WITH ENCRYPTION
AS
SELECT        name AS Наименование, amount AS [Кол-во]
FROM            dbo.Components
GO

USE [Restaraunt]
GO

/****** Object:  View [dbo].[Доход от клиентов]    Script Date: 15.06.2020 12:18:38 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[Доход от клиентов]
WITH SCHEMABINDING
AS
SELECT        dbo.Clients.id, dbo.Clients.fname AS Имя, dbo.Clients.lname AS Фамилия, dbo.CashiersCheck.summ AS [Чек на сумму]
FROM            dbo.Clients INNER JOIN
                         dbo.CashiersCheck ON dbo.Clients.id = dbo.CashiersCheck.client_id
GO



EXEC sys.sp_helptext @objname = 'Склад' -- nvarchar(776)



USE [Restaraunt]
GO

SET ARITHABORT ON
SET CONCAT_NULL_YIELDS_NULL ON
SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
SET NUMERIC_ROUNDABORT OFF
GO

/****** Object:  Index [ClusteredIndex-20200615-122822]    Script Date: 15.06.2020 12:28:50 ******/
CREATE UNIQUE CLUSTERED INDEX [ClusteredIndex-20200615-122822] ON [dbo].[Доход от клиентов]
([id] ASC)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, 
 DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON,
 ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

SET STATISTICS IO ON
SET STATISTICS TIME ON

SELECT * FROM dbo.[Доход от клиентов]

SELECT  dbo.Clients.id, dbo.Clients.fname AS Имя, dbo.Clients.lname AS Фамилия, dbo.CashiersCheck.summ AS [Чек на сумму]
FROM  dbo.Clients INNER JOIN
dbo.CashiersCheck ON dbo.Clients.id = dbo.CashiersCheck.client_id
