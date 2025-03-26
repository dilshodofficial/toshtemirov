--create database hwork_20
use hwork_20
drop table Employees
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(100),
    DepartmentID INT,
    Salary DECIMAL(10,2)
);

INSERT INTO Employees (EmployeeID, Name, DepartmentID, Salary) VALUES
(1, 'Alice', 1, 5000),
(2, 'Bob', 2, 7000),
(3, 'Charlie', 1, 6000),
(4, 'David', 2, 8000),
(5, 'Eve', 1, 5500);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    Name VARCHAR(100),
    Price DECIMAL(10,2)
);

INSERT INTO Products (ProductID, Name, Price) VALUES
(1, 'Laptop', 1200),
(2, 'Phone', 800),
(3, 'Tablet', 600),
(4, 'Monitor', 300),
(5, 'Headphones', 150);


INSERT INTO Products (ProductID, Name, Price) VALUES
(6, 'Laptop', 200),
(7, 'Phone', 800),
(88, 'Tablet', 6040),
(9, 'Monitor', 3020),
(8, 'Headphones', 1550);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE
);

INSERT INTO Orders (OrderID, CustomerID, OrderDate) VALUES
(1, 101, '2024-01-01'),
(2, 102, '2024-01-02'),
(3, 101, '2024-01-03'),
(4, 103, '2024-01-04'),
(5, 104, '2024-01-05');

CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    ProductID INT,
    SalesAmount DECIMAL(10,2)
);

INSERT INTO Sales (SaleID, ProductID, SalesAmount) VALUES
(1, 1, 5000),
(2, 2, 3000),
(3, 3, 4000),
(4, 4, 2000),
(5, 5, 1000);

select * from Employees
select * from Products
select * from Orders
select * from sales


-----1 exercise---
select *,
ROW_NUMBER() over(order by salary desc) as sal_rank
from Employee


--- 2 exercise---
select *,
rank() over(order by price desc) as pr_price
from Products

-----3 exercise---
select *,
DENSE_RANK() over(order by salary desc) as sal_dense
from Employees

---4 exercise--
select *,
lead(Salary, 1, 0) over(partition by departmentid order by salary desc)
from Employees

----5 exercise---
select *,
ROW_NUMBER() over(order by orderid desc) as order_rank
from Orders


---- 6 exercise--
with cte as(
select *,
rank() over (order by salary desc) as rank_sal
from Employees
)
select * from cte
where rank_sal <= 2;

----7 exercise---
select *,
lag(salary) over(order by salary desc) as lag_sal
from Employees

---8 exercise---
select *,
ntile(4) over(order by salary desc) as sal_group
from Employees

--- 9 exercise--
select *,
ROW_NUMBER() over(partition by departmentid order by salary) as rw_depar
from Employees


---10 exercise--
select *,
DENSE_RANK() over(order by price desc) as dr_price
from Products


---11 exercise--
select *,
avg(price) over(order by productid rows between 2 preceding and current row)
from  Products


---12 exercise---
select 
*,
lead(salary) over(order by employeeid desc)
from Employees


---13 exercise---
select *,
sum(SalesAmount) over(order by saleid)
from sales


---14 execise---
with cte as(select *,
ROW_NUMBER() over(order by price) as rankin
from Products)
select * from cte
where rankin <= 5;


---15 exercise---
select *,
sum(orderamount) over(partition by customerid) as sum_cust
from orders

----16 exercise--
select *,
rank() over(order by orderamount desc) as rank_amount
from orders


----17 exercise--

SELECT 
    ProductCategory,
    SUM(SalesAmount) AS TotalSales,
    ceiling((SUM(SalesAmount) * 100.0 / (SELECT SUM(SalesAmount) FROM Sales))) AS PercentageContribution
FROM Sales
GROUP BY ProductCategory
ORDER BY PercentageContribution DESC;


----18 exercise---
select *,
lead(OrderDate) over(order by orderdate) as ld_or_dt
from orders

----19 exercise---
select *,
ntile(3) over(order by age desc) as age_grouping
from employees


----20 execise---
select *,
ROW_NUMBER() over(order by hire_date) as hiring_num
from Employees
