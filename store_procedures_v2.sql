use Northwind;

select * from dbo.Categories;

--Create a stored procedure that calculates the total revenue for a given time period, grouped by product category. 
--The procedure should accept start and end dates as parameters and return the results sorted by revenue in descending order.

alter procedure total_rev_period @startdate date, @enddate date
as
begin
select p.categoryid,sum(try_cast(p.unit AS DECIMAL(10,2)) * try_cast(p.price AS DECIMAL(10,2)) * try_cast(od.quantity AS INT)) as total_revenue from orders o 
join OrderDetails od on o.OrderID = od.OrderID
join Products p on od.ProductID = p.ProductID where o.OrderDate between @startdate and @enddate
group by p.CategoryID
order by total_revenue desc
end;


EXEC total_rev_period 
    @startdate = '1996-01-01', 
    @enddate = '1997-01-01';


-- Develop a stored procedure that identifies the top N customers based on their total order value. 
-- The procedure should accept the number of customers (N) and a date range as parameters. 
--It should return the customer details, total order value, 
--and the number of orders placed within the specified period.


create procedure top_n @noofcust int,@range int
as
begin
select top (@noofcust) c.*,p.unit,p.price,od.Quantity,p.price * od.quantity as order_value,o.OrderDate from Products p 
join OrderDetails od on p.ProductID = od.ProductID 
join Orders o on o.OrderID = od.OrderID
join Customers c on c.CustomerID = o.CustomerID
where YEAR(o.OrderDate ) = @range
order by p.price * od.quantity desc;
end;

exec top_n 25,1997;

--Create a stored procedure that generates a report of employees and their sales performance. 
--The procedure should calculate the total sales, average order value, 
--and number of orders for each employee within a given date range.
--Include a parameter to filter results based on a minimum sales threshold.

create procedure emp_sales_perf @startDate date,@endDate date,@minSales DECIMAL(10, 2)
as
begin
select e.employeeid,e.lastname,count(o.orderid) as total_order_count,sum(p.price*od.Quantity) as total_sales,
avg(p.price*od.quantity) as average_order_value
from Employees e
join
Orders o on e.EmployeeID = o.EmployeeID
join
OrderDetails od on od.OrderID = o.OrderID
join
Products p on p.ProductID = od.ProductID
where o.OrderDate between @startDate  and @endDate
group by e.EmployeeID,e.LastName
having
sum(p.price * od.quantity)>= @minSales
order by total_sales desc;
end;

exec emp_sales_perf '01-01-1996','01-12-1997',1000;


--Implement a stored procedure that manages inventory levels.
--It should accept a product ID and a quantity as parameters, update the stock level,
--and automatically reorder products when they fall below a certain threshold. 
--The procedure should also log these activities in a separate table.