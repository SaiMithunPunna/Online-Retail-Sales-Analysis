-- create new database

create database retail_db;
use retail_db;



-- creating required tables

create table Customers (
    customer_id int primary key,
    name varchar(100),
    city varchar(50)
);

create table Products (
    product_id int primary key,
    name varchar(100),
    category varchar(50),
    price decimal(10,2)
);

create table Orders (
    order_id int primary key,
    customer_id int,
    order_date date,
    foreign key (customer_id) references Customers(customer_id)
);

create table Order_Items (
    order_id int,
    product_id int,
    quantity int,
    foreign key (order_id) references Orders(order_id),
    foreign key (product_id) references Products(product_id)
);



-- inserting the data 

-- Customers table
insert into Customers values
(1, 'Sai', 'Mumbai'),
(2, 'Rahul', 'Delhi'),
(3, 'Priya', 'Bangalore'),
(4, 'Ankit', 'Pune'),
(5, 'Neha', 'Chennai');

-- Products table
insert into Products values
(101, 'Laptop', 'Electronics', 50000),
(102, 'Phone', 'Electronics', 20000),
(103, 'Shoes', 'Fashion', 3000),
(104, 'Watch', 'Fashion', 5000),
(105, 'Book', 'Education', 500);

-- Orders table
insert into Orders values
(1001, 1, '2025-03-01'),
(1002, 2, '2025-03-05'),
(1003, 1, '2025-03-10'),
(1004, 3, '2025-04-01'),
(1005, 4, '2025-04-03');

-- Order items table
insert into Order_Items values
(1001, 101, 1),
(1001, 105, 2),
(1002, 102, 1),
(1003, 103, 2),
(1004, 101, 1),
(1004, 104, 1),
(1005, 105, 5);

-- analysis queries

-- top selling products
select p.name, sum(oi.quantity) as total_sold
from Order_Items oi
join Products p on oi.product_id = p.product_id
group by p.name
order by total_sold desc;

-- most valuable customers
select c.name, sum(p.price * oi.quantity) as total_spent
from Customers c
join Orders o on c.customer_id = o.customer_id
join Order_Items oi on o.order_id = oi.order_id
join Products p on oi.product_id = p.product_id
group by c.name
order by total_spent desc;

-- monthly revenue
select 
    date_format(o.order_date, '%Y-%m') as month,
    sum(p.price * oi.quantity) as revenue
from Orders o
join Order_Items oi on o.order_id = oi.order_id
join Products p on oi.product_id = p.product_id
group by month
order by month;

-- category wise sales
select p.category, sum(oi.quantity) as total_sales
from Products p
join Order_Items oi on p.product_id = oi.product_id
group by p.category;

-- inactive customers (with no orders )
select c.name
from Customers c
left join Orders o on c.customer_id = o.customer_id
where o.order_id is null;