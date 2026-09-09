-- Expense analytics schema and sample data.
DROP VIEW IF EXISTS monthly_category_spend;
DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS budgets;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS accounts;

CREATE TABLE accounts (
    account_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    account_name TEXT NOT NULL UNIQUE,
    account_type TEXT NOT NULL CHECK (account_type IN ('bank', 'cash', 'card'))
);
CREATE TABLE categories (
    category_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    category_name TEXT NOT NULL UNIQUE
);
CREATE TABLE budgets (
    category_id INTEGER NOT NULL REFERENCES categories(category_id),
    month_start DATE NOT NULL,
    budget_amount NUMERIC(12,2) NOT NULL CHECK (budget_amount >= 0),
    PRIMARY KEY (category_id, month_start)
);
CREATE TABLE transactions (
    transaction_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    account_id INTEGER NOT NULL REFERENCES accounts(account_id),
    category_id INTEGER NOT NULL REFERENCES categories(category_id),
    transaction_date DATE NOT NULL,
    description TEXT NOT NULL,
    amount NUMERIC(12,2) NOT NULL CHECK (amount > 0),
    transaction_type TEXT NOT NULL CHECK (transaction_type IN ('income', 'expense'))
);

INSERT INTO accounts (account_name, account_type) VALUES ('Everyday Bank', 'bank'), ('Travel Card', 'card');
INSERT INTO categories (category_name) VALUES ('Food'), ('Transport'), ('Learning'), ('Salary');
INSERT INTO budgets VALUES (1, DATE '2026-09-01', 300), (2, DATE '2026-09-01', 150), (3, DATE '2026-09-01', 200);
INSERT INTO transactions (account_id, category_id, transaction_date, description, amount, transaction_type) VALUES
    (1, 4, DATE '2026-09-01', 'Monthly salary', 2400, 'income'),
    (1, 1, DATE '2026-09-03', 'Groceries', 84.50, 'expense'),
    (2, 2, DATE '2026-09-05', 'Train pass', 48.00, 'expense'),
    (1, 3, DATE '2026-09-07', 'Database course', 120.00, 'expense'),
    (1, 1, DATE '2026-09-10', 'Lunch', 18.75, 'expense');

CREATE VIEW monthly_category_spend AS
SELECT DATE_TRUNC('month', t.transaction_date)::DATE AS month_start,
       c.category_name,
       SUM(t.amount) AS spent
FROM transactions t
JOIN categories c ON c.category_id = t.category_id
WHERE t.transaction_type = 'expense'
GROUP BY 1, 2;
