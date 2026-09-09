# Inventory Control Database

An original learning project inspired by real-world inventory and sales systems. Practice products, suppliers, warehouses, stock movements, and reorder analysis.

## Learning goals

- Model stock across multiple warehouses
- Track purchases, sales, and adjustments as movements
- Use aggregates and conditional logic for inventory reports
- Identify products below their reorder point

## Run

```bash
psql -d learning_lab -f 01_schema.sql
psql -d learning_lab -f 02_queries.sql
```
