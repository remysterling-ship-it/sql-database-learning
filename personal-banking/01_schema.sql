DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS accounts;

CREATE TABLE accounts (
    account_id SERIAL PRIMARY KEY,
    account_name TEXT NOT NULL,
    account_type TEXT NOT NULL CHECK (account_type IN ('checking', 'savings', 'credit')),
    opening_balance NUMERIC(12, 2) NOT NULL DEFAULT 0
);

CREATE TABLE categories (
    category_id SERIAL PRIMARY KEY,
    category_name TEXT NOT NULL UNIQUE
);

CREATE TABLE transactions (
    transaction_id SERIAL PRIMARY KEY,
    account_id INTEGER NOT NULL REFERENCES accounts(account_id),
    category_id INTEGER REFERENCES categories(category_id),
    transaction_date DATE NOT NULL,
    description TEXT NOT NULL,
    amount NUMERIC(12, 2) NOT NULL CHECK (amount <> 0),
    transfer_group UUID
);

INSERT INTO accounts (account_name, account_type, opening_balance) VALUES
    ('Everyday Checking', 'checking', 1200.00),
    ('Emergency Savings', 'savings', 5000.00);

INSERT INTO categories (category_name) VALUES
    ('Groceries'), ('Transport'), ('Salary'), ('Utilities');

INSERT INTO transactions (account_id, category_id, transaction_date, description, amount) VALUES
    (1, 3, '2026-09-01', 'Monthly salary', 3200.00),
    (1, 1, '2026-09-03', 'Weekly groceries', -86.40),
    (1, 2, '2026-09-05', 'Transit pass', -45.00),
    (1, 4, '2026-09-08', 'Electricity bill', -72.25),
    (2, 1, '2026-09-04', 'Savings deposit', 200.00);
