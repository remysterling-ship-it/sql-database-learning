# Expense Analytics Database

A personal-finance analytics project for categorizing transactions, tracking accounts, and producing monthly summaries.

## Learning goals

- Model accounts, categories, and transactions
- Use constraints for valid transaction amounts and types
- Aggregate spending by month and category
- Compare actual spending with category budgets
- Build a reusable monthly reporting view

## Run

```bash
psql -d learning_lab -f 01_schema.sql
psql -d learning_lab -f 02_queries.sql
```
