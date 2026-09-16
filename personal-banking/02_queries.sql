-- Current balance by account.
SELECT a.account_name,
       a.opening_balance + COALESCE(SUM(t.amount), 0) AS current_balance
FROM accounts a
LEFT JOIN transactions t ON t.account_id = a.account_id
GROUP BY a.account_id, a.account_name, a.opening_balance
ORDER BY a.account_name;

-- Monthly spending by category.
SELECT DATE_TRUNC('month', t.transaction_date)::date AS month,
       c.category_name,
       SUM(ABS(t.amount)) AS spending
FROM transactions t
JOIN categories c ON c.category_id = t.category_id
WHERE t.amount < 0
GROUP BY month, c.category_name
ORDER BY month, spending DESC;

-- Largest expenses.
SELECT transaction_date, description, amount
FROM transactions
WHERE amount < 0
ORDER BY amount ASC
LIMIT 5;
