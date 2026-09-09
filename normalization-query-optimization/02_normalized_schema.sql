-- 02_normalized_schema.sql
-- Normalized design: customers, products, orders, and order_items.

DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
    customer_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    full_name TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE
);

CREATE TABLE products (
    product_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    product_name TEXT NOT NULL,
    category TEXT NOT NULL,
    current_price NUMERIC(10, 2) NOT NULL CHECK (current_price >= 0)
);

CREATE TABLE orders (
    order_id INTEGER PRIMARY KEY,
    order_date DATE NOT NULL,
    customer_id INTEGER NOT NULL REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    order_id INTEGER NOT NULL REFERENCES orders(order_id) ON DELETE CASCADE,
    product_id INTEGER NOT NULL REFERENCES products(product_id),
    quantity INTEGER NOT NULL CHECK (quantity > 0),
    unit_price NUMERIC(10, 2) NOT NULL CHECK (unit_price >= 0),
    PRIMARY KEY (order_id, product_id)
);

INSERT INTO customers (full_name, email) VALUES
    ('Aisha Khan', 'aisha@example.com'),
    ('Marco Silva', 'marco@example.com');

INSERT INTO products (product_name, category, current_price) VALUES
    ('SQL Fundamentals', 'Databases', 34.99),
    ('JDBC in Practice', 'Java', 29.95),
    ('Database Design', 'Databases', 42.50);

INSERT INTO orders (order_id, order_date, customer_id) VALUES
    (1001, '2026-09-01', 1),
    (1002, '2026-09-02', 2),
    (1003, '2026-09-03', 1);

INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
    (1001, 1, 1, 34.99),
    (1001, 2, 2, 29.95),
    (1002, 1, 1, 34.99),
    (1003, 3, 1, 42.50);

-- Recreate the business report with joins.
SELECT
    o.order_id,
    o.order_date,
    c.full_name AS customer,
    SUM(oi.quantity * oi.unit_price) AS order_total
FROM orders AS o
JOIN customers AS c ON c.customer_id = o.customer_id
JOIN order_items AS oi ON oi.order_id = o.order_id
GROUP BY o.order_id, o.order_date, c.full_name
ORDER BY o.order_date;
