# Retail Database Project

## Overview
This project is a simple retail database created to manage customers, products, orders, and order items.  
It helps track customer purchases, product sales, and revenue over time.  
I made this project using MySQL to practice database creation, relationships, and queries.

## Database Name
`retail_db`

## Tables

### Customers
- `customer_id` (INT, primary key)  
- `name` (VARCHAR)  
- `city` (VARCHAR)  

Stores information about all customers.

### Products
- `product_id` (INT, primary key)  
- `name` (VARCHAR)  
- `category` (VARCHAR)  
- `price` (DECIMAL)  

Contains all products available in the store.

### Orders
- `order_id` (INT, primary key)  
- `customer_id` (INT, foreign key)  
- `order_date` (DATE)  

Stores all orders placed by customers.

### Order_Items
- `order_id` (INT, foreign key)  
- `product_id` (INT, foreign key)  
- `quantity` (INT)  

Keeps track of which products are in each order.

## Sample Data
- Added 5 customers from different cities.  
- Added 5 products in Electronics, Fashion, and Education categories.  
- Created 5 orders with multiple items to test the database functionality.

## Analysis Queries

Top Selling Products
Most Valuable Customers
Monthly Revenue
Category-wise Sales
Inactive Customers
