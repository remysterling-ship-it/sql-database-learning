-- Inventory control schema and sample data.
DROP TABLE IF EXISTS stock_movements;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS suppliers;
DROP TABLE IF EXISTS warehouses;

CREATE TABLE warehouses (
    warehouse_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    warehouse_name TEXT NOT NULL UNIQUE,
    city TEXT NOT NULL
);
CREATE TABLE suppliers (
    supplier_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    supplier_name TEXT NOT NULL UNIQUE,
    contact_email TEXT NOT NULL
);
CREATE TABLE products (
    product_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    sku TEXT NOT NULL UNIQUE,
    product_name TEXT NOT NULL,
    supplier_id INTEGER NOT NULL REFERENCES suppliers(supplier_id),
    reorder_point INTEGER NOT NULL CHECK (reorder_point >= 0)
);
CREATE TABLE stock_movements (
    movement_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    product_id INTEGER NOT NULL REFERENCES products(product_id),
    warehouse_id INTEGER NOT NULL REFERENCES warehouses(warehouse_id),
    movement_type TEXT NOT NULL CHECK (movement_type IN ('purchase', 'sale', 'adjustment')),
    quantity INTEGER NOT NULL CHECK (quantity <> 0),
    moved_on DATE NOT NULL DEFAULT CURRENT_DATE
);

INSERT INTO warehouses (warehouse_name, city) VALUES ('Central Depot', 'Pune'), ('North Depot', 'Delhi');
INSERT INTO suppliers (supplier_name, contact_email) VALUES ('Campus Tech Supply', 'orders@campus.example'), ('Network Parts Co', 'sales@network.example');
INSERT INTO products (sku, product_name, supplier_id, reorder_point) VALUES
    ('KB-001', 'Mechanical Keyboard', 1, 10), ('SW-010', 'Network Switch', 2, 5), ('CB-100', 'Ethernet Cable', 2, 25);
INSERT INTO stock_movements (product_id, warehouse_id, movement_type, quantity, moved_on) VALUES
    (1, 1, 'purchase', 40, CURRENT_DATE - 10), (1, 1, 'sale', -32, CURRENT_DATE - 2),
    (2, 2, 'purchase', 12, CURRENT_DATE - 8), (2, 2, 'sale', -9, CURRENT_DATE - 1),
    (3, 1, 'purchase', 100, CURRENT_DATE - 7), (3, 1, 'sale', -60, CURRENT_DATE - 3);
