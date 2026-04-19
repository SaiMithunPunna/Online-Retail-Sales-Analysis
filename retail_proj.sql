-- Create Database
CREATE DATABASE retail_db;
USE retail_db;


-- TABLE CREATION


CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    city VARCHAR(50)
);

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE Order_Items (
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- =========================
-- INSERT SAMPLE DATA
-- =========================

-- Customers
INSERT INTO Customers VALUES
(1, 'Sai', 'Mumbai'),
(2, 'Rahul', 'Delhi'),
(3, 'Priya', 'Bangalore'),
(4, 'Ankit', 'Pune'),
(5, 'Neha', 'Chennai');

-- Products
INSERT INTO Products VALUES
(101, 'Laptop', 'Electronics', 50000),
(102, 'Phone', 'Electronics', 20000),
(103, 'Shoes', 'Fashion', 3000),
(104, 'Watch', 'Fashion', 5000),
(105, 'Book', 'Education', 500);

-- Orders
INSERT INTO Orders VALUES
(1001, 1, '2025-03-01'),
(1002, 2, '2025-03-05'),
(1003, 1, '2025-03-10'),
(1004, 3, '2025-04-01'),
(1005, 4, '2025-04-03');

-- Order Items
INSERT INTO Order_Items VALUES
(1001, 101, 1),
(1001, 105, 2),
(1002, 102, 1),
(1003, 103, 2),
(1004, 101, 1),
(1004, 104, 1),
(1005, 105, 5);

-- =========================
-- ANALYSIS QUERIES
-- =========================

-- Top-Selling Products
SELECT p.name, SUM(oi.quantity) AS total_sold
FROM Order_Items oi
JOIN Products p ON oi.product_id = p.product_id
GROUP BY p.name
ORDER BY total_sold DESC;

-- Most Valuable Customers
SELECT c.name, SUM(p.price * oi.quantity) AS total_spent
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN Order_Items oi ON o.order_id = oi.order_id
JOIN Products p ON oi.product_id = p.product_id
GROUP BY c.name
ORDER BY total_spent DESC;

--  Monthly Revenue
SELECT 
    DATE_FORMAT(o.date, '%Y-%m') AS month,
    SUM(p.price * oi.quantity) AS revenue
FROM Orders o
JOIN Order_Items oi ON o.order_id = oi.order_id
JOIN Products p ON oi.product_id = p.product_id
GROUP BY month
ORDER BY month;

-- Category-wise Sales
SELECT p.category, SUM(oi.quantity) AS total_sales
FROM Products p
JOIN Order_Items oi ON p.product_id = oi.product_id
GROUP BY p.category;

--  Inactive Customers (no orders)
SELECT c.name
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;