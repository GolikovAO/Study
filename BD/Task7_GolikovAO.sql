USE Restaraunt
GO

CREATE PROCEDURE PrimeCost
AS
BEGIN
DECLARE @i INT = 0
DECLARE @prime INT = 0
DECLARE @result TABLE (namecook VARCHAR(128),primecost INT)
DECLARE @TEMP TABLE (id int,prime INT)
SET @i = @i + (SELECT COUNT(*) FROM Cookings)
WHILE (@i > 0)
  BEGIN
  SET @prime = (SELECT SUM(AB.primecost) FROM (SELECT dbo.Components.primecost FROM dbo.Components
  JOIN (SELECT value FROM Cookings CROSS APPLY STRING_SPLIT(Cookings.discription,',') WHERE dbo.Cookings.id = @i)ABC ON dbo.Components.name = ABC.value)AB)
  INSERT INTO @TEMP (id,prime)
  VALUES (@i,@prime)
  SET @i = @i - 1
  END
TRUNCATE TABLE PRIME
INSERT INTO PRIME(name,primecost)
SELECT dbo.Cookings.name_cooking,[@TEMP].prime  FROM @TEMP,dbo.Cookings
WHERE Cookings.id = [@TEMP].id
ORDER BY dbo.Cookings.id
END

EXEC PrimeCost
SELECT * FROM PRIME
GO

CREATE PROCEDURE OrdersPerDate 
@time_start date = NULL, 
@time_finish date = NULL
AS
BEGIN
IF @time_start IS NOT NULL
IF @time_finish IS NOT NULL
SELECT dbo.Orders.id, dbo.Cookings.name_cooking, dbo.Orders.amount,dbo.Orders.cost, createdDate FROM dbo.Orders,dbo.Cookings
WHERE (dbo.Orders.cooking_id = dbo.Cookings.id) AND (createdDate BETWEEN @time_start AND @time_finish)
END

EXEC dbo.OrdersPerDate @time_start = '20200120',
                       @time_finish = '20200220'


GO
CREATE PROCEDURE SalaryDay
AS
BEGIN
DECLARE @salary REAL 
SET @salary = (SELECT SUM(ABC) FROM (SELECT salary AS ABC FROM dbo.Staff)A)
INSERT INTO dbo.Transactions (value,description)
VALUES
(@salary * (-1),'Выдача зарплаты сотрудникам')
UPDATE dbo.Budget
SET last_date_salary = GETDATE();
END
   

GO
 CREATE FUNCTION [dbo].[Components_find](@cook int)
 RETURNS TABLE
 AS
 RETURN (SELECT value FROM Cookings CROSS APPLY STRING_SPLIT(Cookings.discription,',')
WHERE Cookings.id = @cook);

