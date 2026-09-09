-- 01_flat_orders.sql
-- Deliberately denormalized starting point.

DROP TABLE IF EXISTS flat_orders;

CREATE TABLE flat_orders (
    order_id INTEGER,
    order_date DATE,
    customer_name TEXT,
    customer_email TEXT,
    product_name TEXT,
    product_category TEXT,
    quantity INTEGER,
    unit_price NUMERIC(10, 2)
);

INSERT INTO flat_orders VALUES
    (1001, '2026-09-01', 'Aisha Khan', 'aisha@example.com', 'SQL Fundamentals', 'Databases', 1, 34.99),
    (1001, '2026-09-01', 'Aisha Khan', 'aisha@example.com', 'JDBC in Practice', 'Java', 2, 29.95),
    (1002, '2026-09-02', 'Marco Silva', 'marco@example.com', 'SQL Fundamentals', 'Databases', 1, 34.99),
    (1003, '2026-09-03', 'Aisha Khan', 'aisha@example.com', 'Database Design', 'Databases', 1, 42.50);

-- Discussion prompts:
-- 1. What happens if Aisha changes her email address?
-- 2. How would you add a product before it appears in an order?
-- 3. Which values are repeated, and which depend on only part of the key?
