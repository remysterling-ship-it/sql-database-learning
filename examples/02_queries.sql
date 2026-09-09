-- 02_queries.sql
-- Run after 01_schema.sql.

-- 1. Filter and sort books.
SELECT title, author, price
FROM books
WHERE category = 'Databases'
ORDER BY price DESC;

-- 2. Join customers to their orders.
SELECT c.full_name, o.order_id, o.status, o.ordered_at
FROM customers AS c
JOIN orders AS o ON o.customer_id = c.customer_id
ORDER BY o.ordered_at;

-- 3. Calculate the value of each order.
SELECT
    o.order_id,
    c.full_name,
    SUM(oi.quantity * oi.unit_price) AS order_total
FROM orders AS o
JOIN customers AS c ON c.customer_id = o.customer_id
JOIN order_items AS oi ON oi.order_id = o.order_id
GROUP BY o.order_id, c.full_name
ORDER BY order_total DESC;

-- 4. Find customers who have placed at least one order.
SELECT full_name
FROM customers
WHERE customer_id IN (SELECT customer_id FROM orders);

-- 5. Use a common table expression to summarize sales by category.
WITH category_sales AS (
    SELECT b.category, SUM(oi.quantity * oi.unit_price) AS revenue
    FROM order_items AS oi
    JOIN books AS b ON b.book_id = oi.book_id
    GROUP BY b.category
)
SELECT category, revenue
FROM category_sales
ORDER BY revenue DESC;
