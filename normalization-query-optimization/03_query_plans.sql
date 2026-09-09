-- 03_query_plans.sql
-- Run after 02_normalized_schema.sql in PostgreSQL.

-- Query pattern: find a customer's orders in date order.
EXPLAIN (ANALYZE, BUFFERS)
SELECT order_id, order_date
FROM orders
WHERE customer_id = 1
ORDER BY order_date DESC;

-- The index follows the equality filter, then the sort column.
CREATE INDEX IF NOT EXISTS idx_orders_customer_date
    ON orders (customer_id, order_date DESC);

-- Compare the plan after indexing.
EXPLAIN (ANALYZE, BUFFERS)
SELECT order_id, order_date
FROM orders
WHERE customer_id = 1
ORDER BY order_date DESC;

-- Indexing questions:
-- 1. Does the planner choose the index with a small table?
-- 2. What changes after loading thousands of orders?
-- 3. What write and storage costs does this index introduce?
