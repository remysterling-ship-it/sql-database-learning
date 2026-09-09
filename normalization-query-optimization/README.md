# Database Normalization & Query Optimization

A practical lab for turning a deliberately flat order report into a normalized relational design, then measuring how indexes affect query plans.

## Learning goals

- Identify update, insertion, and deletion anomalies
- Decompose a flat relation into tables that satisfy 1NF, 2NF, and 3NF
- Use primary keys and foreign keys to preserve relationships
- Compare a query plan before and after adding a composite index
- Reason about indexing trade-offs instead of adding indexes blindly

## Run the lab

The scripts target PostgreSQL:

```bash
psql -d learning_lab -f 01_flat_orders.sql
psql -d learning_lab -f 02_normalized_schema.sql
psql -d learning_lab -f 03_query_plans.sql
```

For meaningful query-plan comparisons, load a larger dataset before running `EXPLAIN ANALYZE`. The sample is intentionally small so students can read every row and understand each relationship.

## Conceptual path

1. Start with the flat table and identify repeated customer, product, and order data.
2. Create separate `customers`, `products`, `orders`, and `order_items` relations.
3. Rebuild the report using joins and aggregation.
4. Add an index aligned with the filter and sort pattern, then compare plans.
