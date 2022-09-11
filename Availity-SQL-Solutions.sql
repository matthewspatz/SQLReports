-- 7a
-- Write a SQL query that will produce a reverse-sorted list (alphabetically by name) of customers (first and last names) whose last name begins with the letter ‘S.’ 
--------------------------
SELECT FirstName, LastName
FROM Customer
WHERE LastName LIKE 'S%'
ORDER BY LastName desc
--------------------------
-- 7b
-- Write a SQL query that will show the total value of all orders each customer has placed in the past six months. Any customer without any orders should show a $0 value. 
---------------------------------------------------
SELECT 
	CustomerID
	,FirstName
	,LastName
	,SUM(CASE WHEN OrderDate > DATEADD(m, -6, GetDate()) THEN Total ELSE 0 END) AS OrderTotal 
FROM (
	SELECT 
		c.CustID AS CustomerID
		,c.FirstName AS FirstName
		,c.LastName AS LastName
		,o.OrderDate AS OrderDate
		,ISNULL(SUM(ol.Cost * ol.Quantity), 0) AS Total
	FROM 
		Customer c
		LEFT JOIN [Order] o ON c.CustID = o.CustomerID
		LEFT JOIN [OrderLine] ol ON o.OrderID = ol.OrdID
	GROUP BY c.CustID, c.FirstName, c.LastName, o.OrderDate
) templist
GROUP BY CustomerID, FirstName, LastName
------------------------------------------------------------
-- 7c
-- Amend the query from the previous question to only show those customers who have a total order value of more than $100 and less than $500 in the past six months. 
---------------------------------------------------
SELECT 
	CustomerID
	,FirstName
	,LastName
	,SUM(CASE WHEN OrderDate > DATEADD(m, -6, GetDate()) THEN Total ELSE 0 END) AS OrderTotal 
FROM (
	SELECT 
		c.CustID AS CustomerID
		,c.FirstName AS FirstName
		,c.LastName AS LastName
		,o.OrderDate AS OrderDate
		,ISNULL(SUM(ol.Cost * ol.Quantity), 0) AS Total
	FROM 
		Customer c
		LEFT JOIN [Order] o ON c.CustID = o.CustomerID
		LEFT JOIN [OrderLine] ol ON o.OrderID = ol.OrdID
	GROUP BY c.CustID, c.FirstName, c.LastName, o.OrderDate
) templist
GROUP BY CustomerID, FirstName, LastName
HAVING SUM(CASE WHEN OrderDate > DATEADD(m, -6, GetDate()) THEN Total ELSE 0 END) BETWEEN 100.01 AND 499.99
------------------------------------------------------------
