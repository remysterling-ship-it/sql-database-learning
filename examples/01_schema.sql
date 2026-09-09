-- 01_schema.sql
-- A small bookstore schema for SQL practice.

DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS books;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
    customer_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    joined_on DATE NOT NULL DEFAULT CURRENT_DATE
);

CREATE TABLE books (
    book_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    author VARCHAR(120) NOT NULL,
    category VARCHAR(80) NOT NULL,
    price NUMERIC(10, 2) NOT NULL CHECK (price >= 0),
    stock_quantity INTEGER NOT NULL DEFAULT 0 CHECK (stock_quantity >= 0)
);

CREATE TABLE orders (
    order_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    customer_id INTEGER NOT NULL REFERENCES customers(customer_id),
    ordered_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) NOT NULL DEFAULT 'placed'
        CHECK (status IN ('placed', 'shipped', 'completed', 'cancelled'))
);

CREATE TABLE order_items (
    order_id INTEGER NOT NULL REFERENCES orders(order_id) ON DELETE CASCADE,
    book_id INTEGER NOT NULL REFERENCES books(book_id),
    quantity INTEGER NOT NULL CHECK (quantity > 0),
    unit_price NUMERIC(10, 2) NOT NULL CHECK (unit_price >= 0),
    PRIMARY KEY (order_id, book_id)
);

INSERT INTO customers (full_name, email) VALUES
    ('Aisha Khan', 'aisha@example.com'),
    ('Marco Silva', 'marco@example.com'),
    ('Nora Chen', 'nora@example.com');

INSERT INTO books (title, author, category, price, stock_quantity) VALUES
    ('SQL Fundamentals', 'R. Patel', 'Databases', 34.99, 12),
    ('Designing Relational Schemas', 'M. Ortiz', 'Databases', 42.50, 7),
    ('Java Database Connectivity', 'L. Morgan', 'Java', 29.95, 9),
    ('Computer Networks in Practice', 'T. Ibrahim', 'Networking', 38.00, 5);

INSERT INTO orders (customer_id, status) VALUES
    (1, 'completed'),
    (2, 'shipped'),
    (1, 'placed');

INSERT INTO order_items (order_id, book_id, quantity, unit_price) VALUES
    (1, 1, 1, 34.99),
    (1, 3, 2, 29.95),
    (2, 2, 1, 42.50),
    (3, 4, 1, 38.00);
