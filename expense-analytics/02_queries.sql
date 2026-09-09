-- Expense analytics query exercises. Run after 01_schema.sql.
-- 1. Monthly spend by category compared with budget.
SELECT s.month_start, s.category_name, s.spent, b.budget_amount,
       s.spent - b.budget_amount AS variance
FROM monthly_category_spend s
LEFT JOIN categories c ON c.category_name = s.category_name
LEFT JOIN budgets b ON b.category_id = c.category_id AND b.month_start = s.month_start
ORDER BY s.month_start, s.spent DESC;

-- 2. Income, expenses, and net cash flow by month.
SELECT DATE_TRUNC('month', transaction_date)::DATE AS month_start,
       SUM(amount) FILTER (WHERE transaction_type = 'income') AS income,
       SUM(amount) FILTER (WHERE transaction_type = 'expense') AS expenses,
       SUM(amount) FILTER (WHERE transaction_type = 'income')
         - SUM(amount) FILTER (WHERE transaction_type = 'expense') AS net_cash_flow
FROM transactions
GROUP BY 1
ORDER BY 1;

-- 3. Top expense categories.
SELECT c.category_name, SUM(t.amount) AS total_spent
FROM transactions t
JOIN categories c ON c.category_id = t.category_id
WHERE t.transaction_type = 'expense'
GROUP BY c.category_name
ORDER BY total_spent DESC;
