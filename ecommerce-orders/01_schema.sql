DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    full_name TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE
);

CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    sku TEXT NOT NULL UNIQUE,
    product_name TEXT NOT NULL,
    unit_price NUMERIC(10, 2) NOT NULL CHECK (unit_price >= 0),
    stock_quantity INTEGER NOT NULL CHECK (stock_quantity >= 0)
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INTEGER NOT NULL REFERENCES customers(customer_id),
    ordered_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    status TEXT NOT NULL CHECK (status IN ('placed', 'paid', 'shipped', 'cancelled'))
);

CREATE TABLE order_items (
    order_id INTEGER NOT NULL REFERENCES orders(order_id) ON DELETE CASCADE,
    product_id INTEGER NOT NULL REFERENCES products(product_id),
    quantity INTEGER NOT NULL CHECK (quantity > 0),
    sale_price NUMERIC(10, 2) NOT NULL CHECK (sale_price >= 0),
    PRIMARY KEY (order_id, product_id)
);

CREATE TABLE payments (
    payment_id SERIAL PRIMARY KEY,
    order_id INTEGER NOT NULL REFERENCES orders(order_id),
    amount NUMERIC(10, 2) NOT NULL CHECK (amount > 0),
    paid_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    status TEXT NOT NULL CHECK (status IN ('authorized', 'captured', 'refunded'))
);

INSERT INTO customers (full_name, email) VALUES
    ('Noah Williams', 'noah@example.test'),
    ('Sofia Garcia', 'sofia@example.test');

INSERT INTO products (sku, product_name, unit_price, stock_quantity) VALUES
    ('KB-100', 'Compact Keyboard', 45.00, 20),
    ('MS-200', 'Wireless Mouse', 28.50, 35),
    ('ST-300', 'Laptop Stand', 62.00, 10);

INSERT INTO orders (customer_id, status) VALUES (1, 'paid'), (2, 'shipped');
INSERT INTO order_items VALUES (1, 1, 1, 45.00), (1, 2, 2, 28.50), (2, 3, 1, 62.00);
INSERT INTO payments (order_id, amount, status) VALUES (1, 102.00, 'captured'), (2, 62.00, 'captured');
