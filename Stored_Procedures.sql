Create a stored procedure that returns all customers from a specific country:

create procedure cfsc @Country varchar(30)
as 
select CustomerName from dbo.Customers where Country = @country

exec cfsc @country = 'USA';

Create a stored procedure that inserts a new product:

create procedure insert_product  @ProductName varchar(30),@SupplierID int,@CategoryID int ,@Unit varchar(25),@Price numeric(18,0)
as 

insert into Products(ProductName,SupplierID,CategoryID,Unit,Price) values(@ProductName,@SupplierID,@CategoryID,@Unit,@Price)

exec insert_product @ProductName='Test_product',@SupplierID=28,@CategoryID=4,@Unit='test_weight5',@Price=20;


Create a stored procedure that updates the unit price of a product:

create procedure price_update @ProductID int,@price numeric(18,2)
as
update Products 
set Price = @Price
where ProductID = @ProductID

exec price_update @productID = 1,@price = 20;



Create a stored procedure that returns the top N most expensive products:

create procedure exp_n_items @count int
as
select top (@count) ProductName,Price from Products order by Price desc

exec exp_n_items @count = 10;



--CHECK

Create a stored procedure that calculates the total sales for a given year:

create procedure sales_in_a_year @year int
as
select * from Orders where OrderDate like '@year%'

exec sales_in_a_year @year = 1996;

Create a stored procedure that returns all orders for a specific customer:

create procedure customer_orders @CustomerID int
as
select c.CustomerID,c.CustomerName,count(o.OrderID) from Customers c join 
Orders o on c.CustomerID = o.CustomerID where c.CustomerID = @CustomerID
group by c.CustomerID, c.CustomerName

exec customer_orders @CustomerID = 8;

Create a stored procedure that returns the total number of products in each Category

create procedure products_in_category 
as 
select c.Categoryname,count(p.CategoryID) from Categories c 
left join Products p on c.CategoryID = p.CategoryID
group by c.CategoryName,p.CategoryID

exec products_in_category;