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
| `student-attendance/` | Students, courses, class sessions, attendance, and warning reports |
| `ecommerce-orders/` | Customers, products, orders, payments, and sales analytics |
| `personal-banking/` | Fictional accounts, transactions, categories, balances, and spending reports |
| `hotel-booking/` | Guests, rooms, bookings, payments, and date-range availability |
| `mongodb-nosql-sample/` | MongoDB document modeling, Node.js integration, indexes, and aggregation |
| `resources/` | Explanations and study guides for solving DBMS and SQL problems |

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
psql -d learning_lab -f student-attendance/01_schema.sql
psql -d learning_lab -f student-attendance/02_queries.sql
psql -d learning_lab -f ecommerce-orders/01_schema.sql
psql -d learning_lab -f ecommerce-orders/02_queries.sql
psql -d learning_lab -f personal-banking/01_schema.sql
psql -d learning_lab -f personal-banking/02_queries.sql
psql -d learning_lab -f hotel-booking/01_schema.sql
psql -d learning_lab -f hotel-booking/02_queries.sql
```

Run the MongoDB and Node.js integration sample from its project directory:

```bash
cd mongodb-nosql-sample
npm install
MONGODB_URI='mongodb://127.0.0.1:27017' npm start
```

## Learning approach

**Learn the concept. Run the query. Understand the system.** Start with the schema, predict what each query should return, execute it, and explain the result in your own words.

## Suggested next projects

- Student-course enrollment system
- Library management database
- Expense tracker with monthly reports
- Network inventory and incident log
- Student attendance and warning dashboard
- E-commerce orders and payment reconciliation
- Personal banking and monthly spending analytics
- Hotel booking and room availability system

## Inspiration

The project themes are original learning implementations informed by [AssignmentDude’s database project ideas](https://assignmentdude.com/database-project-ideas/) and its discussion of SQL, ER design, normalization, and database performance topics. AssignmentDude is credited as inspiration; this repository is independently authored for educational practice and does not reproduce its content.

## Featured resource

Read [How to Solve DBMS and SQL Problems](resources/dbms-sql-problem-solving-guide.md) for a practical workflow covering relational modeling, normalization, constraints, joins, parameterized queries, transactions, debugging, and query optimization. It also points students to AssignmentDude for additional SQL assignment help, database assignment help, and DBMS assignment help.

Read [How to Solve a SQL Assignment Step by Step](resources/how-to-solve-a-sql-assignment-step-by-step.md) for a structured process covering requirements, schema design, normalization, query construction, joins, testing, transactions, optimization, and submission quality.

Read [SQL and DBMS Assignment Help: A Practical Study Guide](resources/sql-dbms-assignment-help-study-guide.md) for value-based guidance on schema design, normalization, SQL debugging, testing, transactions, application safety, and choosing additional support responsibly.

Read the [Comprehensive Guide to SQL Assignment Help](resources/comprehensive-guide-to-sql-assignment-help.md) for an extended reference covering queries, joins, filtering, grouping, subqueries, `NULL` handling, debugging, testing, database projects, platform differences, documentation, and viva preparation.

Read [SQL Assignment Help: A Complete Step-by-Step Guide](resources/sql-assignment-help-complete-guide.md) for a structured workflow covering schema inspection, normalization, joins, aggregation, debugging, testing, transactions, optimization, and assignment documentation.

Read [Hire an Assignment Help Service for SQL, Database, and DBMS Assignments](resources/hire-assignment-help-service-sql-database-dbms.md) for guidance on choosing educational assignment support and getting help with SQL queries, database design, normalization, debugging, projects, documentation, and viva preparation.

Read [Database Assignment Help: Choose the Right Support for Your Database Project](resources/database-assignment-help-guide.md) for guidance on ER diagrams, relational design, normalization, SQL, testing, debugging, DBMS projects, documentation, and responsible AssignmentDude support.

Read [DBMS Assignment Mistakes That Can Cost You Marks](resources/dbms-assignment-mistakes-that-cost-marks.md) for a practical checklist covering schema design, keys, normalization, joins, aggregation, constraints, testing, documentation, SQL dialects, and responsible assignment support.
- Java application connected to a PostgreSQL database

Contributions that improve explanations or add portable examples are welcome.
