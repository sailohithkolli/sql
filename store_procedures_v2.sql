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


alter procedure top_n @noofcust int,@range int
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

alter procedure emp_sales_perf @startDate date,@endDate date,@minSales DECIMAL(10, 2)
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
where o.OrderDate between @startDate  and @endDate,sum(p.price * od.quantity)>= @minSales
group by e.EmployeeID,e.LastName
order by total_sales desc;
end;

exec emp_sales_perf '01-01-1996','01-12-1997',1000;


--Implement a stored procedure that manages inventory levels.
--It should accept a product ID and a quantity as parameters, update the stock level,
--and automatically reorder products when they fall below a certain threshold. 
--The procedure should also log these activities in a separate table.

--Design a stored procedure that calculates the 
--shipping costs for an order based on the total weight of the products, the shipping destination, and the shipping method. 
--Use a combination of the Order, Order Details, and Products tables to gather the necessary information.

--create procedure sp_weight_of_products
--Create a stored procedure that generates
 --a comprehensive sales report for a specific time period. 
--The report should include total sales, 
--top-selling products, underperforming products, 
--sales by region, and a comparison with the previous period's performance.

CREATE PROCEDURE AnalyzeSales
    @CurrentYear INT,
    @PreviousYear INT
AS
BEGIN
    SET NOCOUNT ON;

    WITH cy AS (
        SELECT 
            p.ProductID,
            SUM(p.Price * od.Quantity) AS total_sales,
            DENSE_RANK() OVER (ORDER BY SUM(p.Price * od.Quantity) DESC) AS top_selling_products
        FROM 
            Products p
            JOIN OrderDetails od ON p.ProductID = od.ProductID
            JOIN Orders o ON o.OrderID = od.OrderID
        WHERE 
            YEAR(o.OrderDate) = @CurrentYear
        GROUP BY 
            p.ProductID
    ),
    py AS (
        SELECT 
            p.ProductID,
            SUM(p.Price * od.Quantity) AS prev_total_sales
        FROM 
            Products p
            JOIN OrderDetails od ON p.ProductID = od.ProductID
            JOIN Orders o ON o.OrderID = od.OrderID
        WHERE 
            YEAR(o.OrderDate) = @PreviousYear
        GROUP BY 
            p.ProductID
    ),
    avg_sales AS (
        SELECT AVG(total_sales) AS avg_sales_value FROM cy
    )
    SELECT
        cy.ProductID,
        cy.total_sales,
        py.prev_total_sales,
        cy.top_selling_products,
        CASE
            WHEN py.prev_total_sales IS NULL OR py.prev_total_sales = 0 THEN 'New Product'
            WHEN cy.total_sales >= (SELECT avg_sales_value * 1.5 FROM avg_sales) THEN
                CASE
                    WHEN (cy.total_sales - py.prev_total_sales) / py.prev_total_sales > 0.1 THEN 'Top Performer - Growing'
                    WHEN (cy.total_sales - py.prev_total_sales) / py.prev_total_sales < -0.1 THEN 'Top Performer - Declining'
                    ELSE 'Top Performer - Stable'
                END
            WHEN cy.total_sales < (SELECT avg_sales_value * 0.5 FROM avg_sales) THEN
                CASE
                    WHEN (cy.total_sales - py.prev_total_sales) / py.prev_total_sales > 0.1 THEN 'Low Sales - Improving'
                    WHEN (cy.total_sales - py.prev_total_sales) / py.prev_total_sales < -0.1 THEN 'Underperforming'
                    ELSE 'Low Sales - Stable'
                END
            ELSE
                CASE
                    WHEN (cy.total_sales - py.prev_total_sales) / py.prev_total_sales > 0.1 THEN 'Average - Growing'
                    WHEN (cy.total_sales - py.prev_total_sales) / py.prev_total_sales < -0.1 THEN 'Average - Declining'
                    ELSE 'Average - Stable'
                END
        END AS performance_status,
        COALESCE(CONCAT(ROUND((cy.total_sales - py.prev_total_sales) / py.prev_total_sales * 100, 2), '%'), 'N/A') AS sales_change_percentage
    FROM 
        cy
    LEFT JOIN
        py ON cy.ProductID = py.ProductID
    ORDER BY 
        cy.total_sales DESC;
END

EXEC AnalyzeSales @CurrentYear = 1997, @PreviousYear = 1996;


--Develop a stored procedure that handles the process of applying discounts to products. 
--The procedure should accept parameters for discount percentage, product category, and date range.
-- It should then apply the discount to eligible products and create a log of the changes made.

CREATE TABLE discountlog (
    logid INT PRIMARY KEY IDENTITY(1,1),
    productid INT,
    oldprice DECIMAL(10,2),
    newprice DECIMAL(10,2),
    discountpercentage DECIMAL(5,2),
    categoryid INT,
    applieddate DATETIME
);



create procedure applydiscount
    @discountpercentage decimal(5,2),
    @categoryid int,
    @startdate date,
    @enddate date
as
begin
    insert into discountlog (productid, oldprice, newprice, discountpercentage, categoryid, applieddate)
    select 
        p.productid,
        p.price as oldprice,
        p.price * (1 - @discountpercentage / 100) as newprice,
        @discountpercentage,
        @categoryid,
        getdate()
    from products p
    where p.categoryid = @categoryid
    and exists (
        select 1 
        from orders o 
        join orderdetails od on o.orderid = od.orderid
        where od.productid = p.productid
        and o.orderdate between @startdate and @enddate
    );
    update p
    set p.price = p.price * (1 - @discountpercentage / 100)
    from products p
    where p.categoryid = @categoryid
    and exists (
        select 1 
        from orders o 
        join orderdetails od on o.orderid = od.orderid
        where od.productid = p.productid
        and o.orderdate between @startdate and @enddate
    );
    select @@rowcount as productsupdated;
end;

exec applydiscount 
    @discountpercentage = 10, 
    @categoryid = 1, 
    @startdate = '1996-01-01', 
    @enddate = '1997-03-31';

	select * from discountlog;



--Create a stored procedure that generates a customer loyalty report.
--The procedure should categorize customers based on their purchase history, frequency of orders, and total spend. 
--Include parameters to adjust the criteria for each loyalty tier.