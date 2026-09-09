-- Inventory query exercises. Run after 01_schema.sql.
-- 1. Current stock by product and warehouse.
SELECT p.sku, p.product_name, w.warehouse_name,
       COALESCE(SUM(sm.quantity), 0) AS current_stock
FROM products p
CROSS JOIN warehouses w
LEFT JOIN stock_movements sm ON sm.product_id = p.product_id AND sm.warehouse_id = w.warehouse_id
GROUP BY p.sku, p.product_name, w.warehouse_name
ORDER BY p.sku, w.warehouse_name;

-- 2. Products at or below their reorder point across all warehouses.
SELECT p.sku, p.product_name, p.reorder_point,
       COALESCE(SUM(sm.quantity), 0) AS total_stock
FROM products p
LEFT JOIN stock_movements sm ON sm.product_id = p.product_id
GROUP BY p.product_id, p.sku, p.product_name, p.reorder_point
HAVING COALESCE(SUM(sm.quantity), 0) <= p.reorder_point;

-- 3. Sales volume by supplier.
SELECT s.supplier_name,
       SUM(CASE WHEN sm.movement_type = 'sale' THEN -sm.quantity ELSE 0 END) AS units_sold
FROM suppliers s
JOIN products p ON p.supplier_id = s.supplier_id
JOIN stock_movements sm ON sm.product_id = p.product_id
GROUP BY s.supplier_name
ORDER BY units_sold DESC;
