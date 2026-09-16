-- Order totals at the correct line-item grain.
SELECT o.order_id, c.full_name,
       SUM(oi.quantity * oi.sale_price) AS order_total
FROM orders o
JOIN customers c ON c.customer_id = o.customer_id
JOIN order_items oi ON oi.order_id = o.order_id
GROUP BY o.order_id, c.full_name
ORDER BY o.order_id;

-- Top products by units sold.
SELECT p.product_name, SUM(oi.quantity) AS units_sold,
       SUM(oi.quantity * oi.sale_price) AS revenue
FROM order_items oi
JOIN products p ON p.product_id = oi.product_id
JOIN orders o ON o.order_id = oi.order_id
WHERE o.status <> 'cancelled'
GROUP BY p.product_id, p.product_name
ORDER BY revenue DESC;

-- Customers with no captured payment for a paid or shipped order.
SELECT o.order_id, c.full_name, o.status
FROM orders o
JOIN customers c ON c.customer_id = o.customer_id
LEFT JOIN payments p ON p.order_id = o.order_id AND p.status = 'captured'
WHERE o.status IN ('paid', 'shipped') AND p.payment_id IS NULL;
