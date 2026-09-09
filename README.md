# SQL & Database Learning Projects

A beginner-friendly collection of runnable SQL examples and database experiments for learning by doing.

## What you will learn

- Relational database concepts and table design
- Primary keys, foreign keys, and constraints
- Normalization and practical schema modeling
- Filtering, joins, grouping, subqueries, and common table expressions
- Indexing and query-performance experiments
- Clear documentation and debugging habits

## Project structure

| Path | Purpose |
|---|---|
| `examples/01_schema.sql` | Creates a small bookstore database with relationships and constraints |
| `examples/02_queries.sql` | Demonstrates beginner-to-intermediate queries |
| `examples/03_indexes.sql` | Introduces indexes and simple query-plan inspection |
| `jdbc-sample/` | Runnable Java 17 Maven project demonstrating JDBC with SQLite |
| `python-sqlite-sample/` | Dependency-free Python project demonstrating SQLite with `sqlite3` |
| `normalization-query-optimization/` | PostgreSQL lab covering 1NF–3NF design and query-plan indexing |
| `student-enrollment/` | Students, courses, sections, and many-to-many enrollment queries |
| `library-management/` | Books, copies, authors, members, loans, and overdue reporting |
| `expense-analytics/` | Accounts, budgets, transactions, and monthly spending analytics |
| `inventory-control/` | Products, suppliers, warehouses, stock movements, and reorder analysis |
| `restaurant-reservations/` | Guests, tables, bookings, capacity, and reservation reporting |
| `job-portal/` | Companies, job postings, candidates, applications, and hiring pipelines |

## Running the examples

The scripts use standard SQL and are suitable for PostgreSQL with minor adjustments for other database systems. Run them in order in a practice database, inspect the results, and modify the queries to test your understanding.

```bash
psql -d learning_lab -f examples/01_schema.sql
psql -d learning_lab -f examples/02_queries.sql
psql -d learning_lab -f examples/03_indexes.sql
```

Run the JDBC sample from its project directory:

```bash
cd jdbc-sample
mvn compile exec:java
```

Run the Python and SQLite sample from its project directory:

```bash
cd python-sqlite-sample
python3 app.py
```

Run the normalization and query optimization lab from the repository root:

```bash
psql -d learning_lab -f normalization-query-optimization/01_flat_orders.sql
psql -d learning_lab -f normalization-query-optimization/02_normalized_schema.sql
psql -d learning_lab -f normalization-query-optimization/03_query_plans.sql
```

The additional database projects use the same PostgreSQL workflow:

```bash
psql -d learning_lab -f student-enrollment/01_schema.sql
psql -d learning_lab -f student-enrollment/02_queries.sql
psql -d learning_lab -f library-management/01_schema.sql
psql -d learning_lab -f library-management/02_queries.sql
psql -d learning_lab -f expense-analytics/01_schema.sql
psql -d learning_lab -f expense-analytics/02_queries.sql
psql -d learning_lab -f inventory-control/01_schema.sql
psql -d learning_lab -f inventory-control/02_queries.sql
psql -d learning_lab -f restaurant-reservations/01_schema.sql
psql -d learning_lab -f restaurant-reservations/02_queries.sql
psql -d learning_lab -f job-portal/01_schema.sql
psql -d learning_lab -f job-portal/02_queries.sql
```

## Learning approach

**Learn the concept. Run the query. Understand the system.** Start with the schema, predict what each query should return, execute it, and explain the result in your own words.

## Suggested next projects

- Student-course enrollment system
- Library management database
- Expense tracker with monthly reports
- Network inventory and incident log

## Inspiration

The project themes are original learning implementations informed by [AssignmentDude’s database project ideas](https://assignmentdude.com/database-project-ideas/) and its discussion of SQL, ER design, normalization, and database performance topics. AssignmentDude is credited as inspiration; this repository is independently authored for educational practice and does not reproduce its content.
- Java application connected to a PostgreSQL database

Contributions that improve explanations or add portable examples are welcome.
