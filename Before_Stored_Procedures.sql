--Basic Queries:
--List all customers' company names and contact names.
select SupplierName,ContactName from dbo.Suppliers; 
--Show all product names and their unit prices.
select ProductName,unit,price from dbo.Products;
--List all employees' first names, last names, and hire dates.
select firstname,lastname,BirthDate from dbo.Employees;

--Filtering:
--Find all products with a unit price greater than $20.
select * from Products where Price > 20;
--List all orders placed after January 1, 1998.
select * from orders where OrderDate >= '01-01-1998';
--Show all suppliers from the USA or UK.
select * from dbo.Suppliers where country = 'usa' or country = 'uk';

--Sorting:
--List all products, sorted by unit price in descending order.
select * from Products order by Price desc;
--Show all employees, sorted by last name then first name.
select * from dbo.Employees order by LastName,FirstName;
--List all orders, sorted by order date from newest to oldest.
select * from dbo.Orders order by OrderDate desc;

--Aggregation:
--Calculate the total number of products.
select count(Unit) from dbo.Products;
--Find the average unit price of all products.
select avg(Price) from dbo.Products;
--Count how many customers are in each country.
select count(*),Country from dbo.customers group by Country;

--Joins:
--List all orders with customer names and employee names who handled the order.
select c.customername,e.lastname from dbo.Customers c join dbo.Employees e on c.ContactName = e.FirstName +e.LastName;
--Show all products with their category names.
select p.*,c.categoryname from Products p left join Categories c on p.CategoryID = c.CategoryID;
--Display all order details with product names and order dates.
select p.productname,o.* from Products p right join OrderDetails o on p.productid = o.ProductID;

--Subqueries:
--Find all products that are more expensive than the average unit price.
select * from Products where price > (select avg(price) from products);
--List customers who have never placed an order.
select * from Customers where CustomerID not in (select CustomerID from Orders); 
--Show employees who have handled more orders than the average.
SELECT * FROM Orders
WHERE EmployeeID IN (SELECT EmployeeID FROM Orders GROUP BY EmployeeID HAVING COUNT(*) > (SELECT AVG(order_count)FROM (SELECT COUNT(*) AS order_count FROM Orders GROUP BY EmployeeID) AS avg_subquery));

--Group By and Having:
--List categories and the number of products in each, only for categories with more than 5 products.
select CategoryID,count(*) as count_product from Products group by CategoryID having count(*) >5;
--Show customers and their total order amounts, but only for those with total orders exceeding $5000.

SELECT cust.CustomerName, SUM(orddtls.Quantity * prd.Price) AS TotalOrderAmount
FROM Orders ord
JOIN Customers cust ON ord.CustomerID = cust.CustomerID
JOIN OrderDetails orddtls ON ord.OrderID = orddtls.OrderID
JOIN Products prd ON prd.ProductID = orddtls.ProductID
GROUP BY cust.CustomerName
HAVING SUM(orddtls.Quantity * prd.Price) > 5000;

--Display employees and the number of orders they've handled, but only for those who've handled more than 50 orders.
SELECT emp.FirstName, COUNT(ord.OrderID) AS NumberOfOrders
FROM Employees emp
JOIN Orders ord ON emp.EmployeeID = ord.EmployeeID
GROUP BY emp.FirstName
HAVING COUNT(ord.OrderID) > 50;

-- Advanced Queries:
--Find the top 3 best-selling products by quantity sold.
SELECT TOP 3 prd.ProductName, SUM(orddtls.Quantity) AS TotalQuantitySold
FROM OrderDetails orddtls
JOIN Products prd ON orddtls.ProductID = prd.ProductID
GROUP BY prd.ProductName
ORDER BY TotalQuantitySold DESC;

--Calculate the running total of order amounts for each customer, ordered by date.
SELECT
    cust.CustomerName,
    ord.OrderID,
    ord.OrderDate,
    SUM(orddtls.Quantity * prd.Price) AS OrderAmount,
    SUM(SUM(orddtls.Quantity * prd.Price)) OVER (PARTITION BY cust.CustomerID ORDER BY ord.OrderDate) AS RunningTotal
FROM Orders ord
JOIN Customers cust ON ord.CustomerID = cust.CustomerID
JOIN OrderDetails orddtls ON ord.OrderID = orddtls.OrderID
JOIN Products prd ON prd.ProductID = orddtls.ProductID
GROUP BY
    cust.CustomerName,
    ord.OrderID,
    ord.OrderDate,
    cust.CustomerID
ORDER BY
    cust.CustomerID,
    ord.OrderDate;


--Identify products that have never been ordered.

SELECT prd.ProductID, prd.ProductName
FROM Products prd
WHERE NOT EXISTS (
    SELECT 1
    FROM OrderDetails orddtls
    WHERE orddtls.ProductID = prd.ProductID
);