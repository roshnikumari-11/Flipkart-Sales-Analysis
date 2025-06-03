CREATE DATABASE flipcart_sample;
use flipcart_sample;



-- Customers Table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    city VARCHAR(50)
);

-- Products Table
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2),
    stock INT
);

-- Orders Table
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Order_Items Table
CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Customers
INSERT INTO customers VALUES
(1, 'Ravi Kumar', 'ravi@example.com', 'Delhi'),
(2, 'Priya Singh', 'priya@example.com', 'Mumbai'),
(3, 'Amit Shah', 'amit@example.com', 'Bangalore'),
(4, 'Neha Gupta', 'neha@example.com', 'Hyderabad'),
(5, 'Karan Mehta', 'karan@example.com', 'Ahmedabad'),
(6, 'Meera Joshi', 'meera@example.com', 'Pune'),
(7, 'Arjun Verma', 'arjun@example.com', 'Jaipur'),
(8, 'Simran Kaur', 'simran@example.com', 'Chandigarh'),
(9, 'Rahul Das', 'rahul@example.com', 'Kolkata'),
(10, 'Sneha Rao', 'sneha@example.com', 'Chennai');


-- Products
INSERT INTO products VALUES
(101, 'Samsung Galaxy M13', 'Mobiles', 11999.00, 25),
(102, 'HP Laptop 15s', 'Electronics', 45999.00, 10),
(103, 'Boat Headphones', 'Accessories', 999.00, 50),
(104, 'Apple iPhone 13', 'Mobiles', 63999.00, 5),
(105, 'Wildcraft Backpack', 'Bags', 1999.00, 20),
(106, 'Sony WH-1000XM4', 'Accessories', 19999.00, 15),
(107, 'Asus ROG Laptop', 'Electronics', 85999.00, 7),
(108, 'Nike Running Shoes', 'Footwear', 4999.00, 30),
(109, 'Lenovo Tab M10', 'Electronics', 14999.00, 12),
(110, 'Realme Narzo 50', 'Mobiles', 12999.00, 20);


-- Orders
INSERT INTO orders VALUES
(1001, 1, '2025-05-01', 12998.00),
(1002, 2, '2025-05-03', 47998.00),
(1003, 3, '2025-05-04', 63999.00),
(1004, 1, '2025-05-05', 1999.00),
(1005, 5, '2025-05-06', 14999.00),
(1006, 6, '2025-05-06', 14998.00),
(1007, 7, '2025-05-07', 4999.00),
(1008, 8, '2025-05-07', 19999.00),
(1009, 9, '2025-05-08', 85999.00),
(1010, 10, '2025-05-08', 12999.00),
(1011, 1, '2025-05-09', 19999.00),
(1012, 2, '2025-05-10', 14999.00),
(1013, 3, '2025-05-10', 62998.00),
(1014, 4, '2025-05-11', 4999.00);


-- Order_Items
INSERT INTO order_items VALUES
(1, 1001, 101, 1, 11999.00),
(2, 1001, 103, 1, 999.00),
(3, 1002, 102, 1, 45999.00),
(4, 1002, 103, 2, 1999.00),
(5, 1003, 104, 1, 63999.00),
(6, 1004, 105, 1, 1999.00),
(7, 1005, 109, 1, 14999.00),
(8, 1006, 110, 1, 12999.00),
(9, 1006, 103, 1, 999.00),
(10, 1007, 108, 1, 4999.00),
(11, 1008, 106, 1, 19999.00),
(12, 1009, 107, 1, 85999.00),
(13, 1010, 110, 1, 12999.00),
(14, 1011, 106, 1, 19999.00),
(15, 1012, 109, 1, 14999.00),
(16, 1013, 104, 1, 63999.00),
(17, 1013, 103, 1, 999.00),
(18, 1014, 108, 1, 4999.00),
(19, 1005, 103, 1, 999.00),
(20, 1006, 105, 1, 1999.00),
(21, 1007, 105, 2, 3998.00),
(22, 1008, 103, 2, 1998.00),
(23, 1009, 108, 1, 4999.00),
(24, 1010, 103, 1, 999.00),
(25, 1011, 103, 1, 999.00),
(26, 1012, 105, 1, 1999.00);


-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------
                                                                        /* Intermediate */
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------

/*

🔸 Intermediate Queries
Get the total number of orders placed by each customer.

Find the total sales amount for each product.

List the top 3 most expensive products.

Get the details of customers who ordered more than one item in a single order.

Show the total quantity sold for each category.

List the top 3 customers who spent the most in total on orders.

Find all products that have never been ordered.

Get the average order value per customer.

Show the most frequently ordered product based on total quantity sold.


*/



-- Get the total number of orders placed by each customer.

SELECT 
    customers.customer_id,
    customers.name,
    customers.email,
    COUNT(orders.order_id) AS total_order
FROM
    customers
        JOIN
    orders ON customers.customer_id = orders.customer_id
GROUP BY customers.customer_id , customers.name , customers.email;

-- Find the total sales amount for each product.

SELECT 
    SUM(price) AS total_sales_amount
FROM
    products;
    
    
-- List the top 3 most expensive products.
SELECT 
    product_name, category, price
FROM
    products
ORDER BY price DESC
LIMIT 3;

-- Get the details of customers who ordered more than one item in a single order.
SELECT 
    c.name, c.email, COUNT(oi.quantity) AS no_of_items_ordered
FROM
    customers AS c
        JOIN
    orders AS o ON c.customer_id = o.customer_id
        JOIN
    order_items AS oi ON o.order_id = oi.order_id
GROUP BY c.name , c.email
HAVING no_of_items_ordered > 1;


-- Show the total quantity sold for each category.

SELECT 
    p.category, SUM(oi.quantity) AS total_quantity
FROM
    products AS p
        JOIN
    order_items AS oi ON p.product_id = oi.product_id
GROUP BY p.category;


use flipcart_sample;
select * from order_items;



-- List the top 3 customers who spent the most in total on orders.

SELECT 
    c.name, SUM(o.total_amount) AS total_amount_spent
FROM
    customers AS c
        JOIN
    orders AS o ON c.customer_id = o.customer_id
    group by c.name;


select * from customers;
select * from orders;
select * from products;
select * from order_items;

-- Find all products that have never been ordered.
SELECT 
    p.product_name, p.category
FROM
    products AS p
        LEFT JOIN
    order_items AS oi ON p.product_id = oi.product_id
WHERE
    oi.product_id IS NULL;


-- Get the average order value per customer.
SELECT 
    c.name, round(AVG(o.total_amount),2) AS Average_order_value
FROM
    customers AS c
        JOIN
    orders AS o ON c.customer_id = o.customer_id
GROUP BY c.name;



-- Show the most frequently ordered product based on total quantity sold.

SELECT 
    p.product_name, SUM(oi.quantity) AS total_quantity_sold
FROM
    products AS p
        JOIN
    order_items AS oi ON p.product_id = oi.product_id
GROUP BY p.product_name
ORDER BY total_quantity_sold DESC
LIMIT 1;
    
    

    select * from orders;
    select * from order_items;
    select * from customers;
    
    
 -- Find the number of orders placed in each city.   
SELECT 
    c.city, COUNT(o.order_id) AS total_orders_placed
FROM
    customers AS c
        JOIN
    orders AS o ON c.customer_id = o.customer_id
GROUP BY c.city;



-- List customers who placed orders on two or more different dates.

SELECT 
    c.name,
    c.email,
    c.city,
    COUNT(DISTINCT o.order_date) AS orders_placed_on_different_dates
FROM
    customers AS c
        JOIN
    orders AS o ON c.customer_id = o.customer_id
GROUP BY c.name , c.email , c.city
HAVING orders_placed_on_different_dates >= 2;

