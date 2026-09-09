# Library Management Database

A library database project for practicing books, authors, members, copies, loans, and overdue reporting.

## Learning goals

- Separate book titles from physical copies
- Model authorship with a junction table
- Track loans and return dates
- Find overdue items with date arithmetic
- Use views and conditional aggregation

## Run

```bash
psql -d learning_lab -f 01_schema.sql
psql -d learning_lab -f 02_queries.sql
```
