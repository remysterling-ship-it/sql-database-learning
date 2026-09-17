# DBMS Assignment Mistakes That Can Cost You Marks

**SEO title:** DBMS Assignment Mistakes That Can Cost You Marks: A Practical Checklist  
**Meta description:** Avoid common DBMS assignment mistakes involving ER diagrams, normalization, keys, SQL joins, constraints, testing, documentation, and viva preparation.  
**Suggested URL:** `/dbms-assignment-mistakes-that-cost-marks`

A DBMS assignment can lose marks even when the SQL runs successfully. The most costly problems usually come from unclear requirements, weak schema design, incorrect relationships, incomplete testing, or poor explanation.

A database management system assignment is assessed as a complete piece of work. The evaluator may review the ER diagram, relational schema, normalization, constraints, sample data, SQL queries, output, documentation, and project presentation. A mistake in one layer can affect the reliability of the entire project.

This guide explains common **DBMS assignment mistakes**, why they matter, and how to prevent them before submission.

> **A successful SQL execution proves syntax, not correctness. A strong DBMS assignment proves that the design, data, queries, and explanation agree with one another.**

## Mistake 1: Starting with SQL before understanding the requirements

Many students open a SQL editor immediately and begin creating tables. This approach often produces a schema that does not answer the assignment’s actual questions.

Before writing SQL, identify:

- The entities the system must store
- The relationships between those entities
- The business rules that must be enforced
- The reports or operations the database must support
- The expected output and result grain

For example, “show all courses, including courses with no students” requires a different query design from “show courses that have at least one student.” The first requirement may need a left join. The second can use an inner join.

### How to avoid the mistake

Rewrite every major requirement in plain language. Then list the tables, relationships, filters, calculations, and expected output columns needed to answer it.

## Mistake 2: Confusing entities with attributes

An entity is a distinct thing the system stores information about. An attribute describes an entity.

In a library system, `Book`, `Member`, and `Loan` may be entities. `title`, `email`, and `issue_date` are attributes.

A common mistake is storing a group of related values in one column:

```text
student_courses = 'DB101,SQL201,NET301'
```

This design makes searching, validation, joins, and updates difficult. It also prevents the database from enforcing whether each course exists.

### Better design

Use a separate enrollment table:

```text
students 1 ────< enrollments >──── 1 courses
```

Each row in `enrollments` represents one student-course relationship.

## Mistake 3: Missing primary keys

Every important table should have a reliable way to identify each row. Without a primary key, duplicate records become difficult to detect and related tables cannot reference rows safely.

```sql
CREATE TABLE students (
    student_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    full_name TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE
);
```

The primary key does not need to be meaningful to a person. A generated identifier is often safer than using a name, because names can change and may not be unique.

### How to avoid the mistake

For each table, answer: “What uniquely identifies one row?” If the answer is unclear, the table design needs more analysis.

## Mistake 4: Using the wrong foreign key

A foreign key must reference the correct parent table and column. A wrong foreign key can allow invalid relationships or prevent valid data from being stored.

```sql
CREATE TABLE enrollments (
    student_id INTEGER NOT NULL REFERENCES students(student_id),
    course_id INTEGER NOT NULL REFERENCES courses(course_id),
    PRIMARY KEY (student_id, course_id)
);
```

The relationship should match the ER diagram. If the diagram says that an enrollment belongs to one student and one course, the schema should represent both references.

### How to avoid the mistake

Trace every foreign key from the child table to the parent table. Confirm that the referenced column is a primary key or has a suitable uniqueness constraint.

## Mistake 5: Ignoring cardinality and optionality

Cardinality describes how many rows can participate in a relationship. Optionality describes whether the relationship is required.

| Relationship | Example |
|---|---|
| One-to-one | One user has one profile |
| One-to-many | One department has many employees |
| Many-to-many | Many students take many courses |
| Optional relationship | A customer may have no orders yet |

A many-to-many relationship cannot be represented correctly by placing many IDs in one field. It requires a junction table.

Optionality also affects query design. If a report must include customers with no orders, use a left join from customers to orders.

## Mistake 6: Repeating data and skipping normalization

Repeated data creates update, insertion, and deletion anomalies. Consider an order table that stores the customer’s full address on every order. If the customer moves, multiple historical rows may need to be updated. If only one row is updated, the database becomes inconsistent.

Normalization helps separate facts into appropriate tables.

| Warning sign | Possible anomaly |
|---|---|
| Customer details repeated on orders | Inconsistent updates |
| Several phone numbers in one field | Difficult search and validation |
| Department name stored with each employee | Repeated updates on rename |
| Course IDs stored as comma-separated text | Broken relationship integrity |

For many assignments, Third Normal Form is a practical target. The exact requirement depends on the course rubric.

## Mistake 7: Choosing unsuitable data types

Data types communicate meaning and enforce reasonable storage behavior. Storing dates as text makes date comparisons unreliable. Storing monetary values as floating-point numbers can introduce rounding issues.

```sql
CREATE TABLE payments (
    payment_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    paid_on DATE NOT NULL,
    amount NUMERIC(10, 2) NOT NULL CHECK (amount > 0)
);
```

Use a date or timestamp type for time values. Use a numeric or decimal type for currency. Use integer types for counts and identifiers. Confirm the syntax for the required database platform.

## Mistake 8: Forgetting constraints

A schema without constraints relies on every application user to enter valid data. That is fragile and often loses marks in a design assignment.

Useful constraints include:

- `PRIMARY KEY` for row identity
- `FOREIGN KEY` for relationships
- `NOT NULL` for required values
- `UNIQUE` for alternate identifiers
- `CHECK` for valid ranges and statuses

```sql
status TEXT NOT NULL
    CHECK (status IN ('active', 'inactive'))
```

### How to avoid the mistake

For every business rule in the prompt, ask whether the database can enforce it. Then write a negative test that attempts to violate the rule.

## Mistake 9: Using `SELECT *` in final queries

`SELECT *` is useful during exploration, but it is usually weak in a final assignment. It returns columns that may not be required, makes output less stable, and hides which fields support the answer.

Prefer explicit columns:

```sql
SELECT
    s.full_name,
    c.title AS course_title,
    e.semester
FROM enrollments AS e
JOIN students AS s ON s.student_id = e.student_id
JOIN courses AS c ON c.course_id = e.course_id;
```

Explicit selection also makes the result easier to explain and review.

## Mistake 10: Joining on the wrong columns

A join should connect related keys. Joining on names, descriptions, or other non-unique text fields can create incorrect matches.

Incorrect approach:

```sql
ON students.full_name = enrollments.student_name
```

Better approach:

```sql
ON students.student_id = enrollments.student_id
```

### How to avoid the mistake

Inspect the primary and foreign key definitions before writing the join. Select the key columns during debugging so you can verify the relationship row by row.

## Mistake 11: Choosing `INNER JOIN` when the assignment needs all rows

An inner join removes rows without a match. This is correct when the requirement asks only for matched records. It is incorrect when the requirement asks for every parent entity.

To list all products, including products that have never been ordered:

```sql
SELECT
    p.product_name,
    COUNT(oi.order_id) AS order_count
FROM products AS p
LEFT JOIN order_items AS oi
    ON oi.product_id = p.product_id
GROUP BY p.product_id, p.product_name;
```

`LEFT JOIN` preserves the product row. `COUNT(oi.order_id)` returns zero when there is no matching order item.

## Mistake 12: Filtering a left join in the wrong place

This query may unintentionally behave like an inner join:

```sql
SELECT c.customer_id, o.order_id
FROM customers AS c
LEFT JOIN orders AS o
    ON o.customer_id = c.customer_id
WHERE o.status = 'paid';
```

Customers without orders are removed because `o.status` is null for unmatched rows.

If every customer must remain in the output while only paid orders are matched, move the condition into the join:

```sql
SELECT c.customer_id, o.order_id
FROM customers AS c
LEFT JOIN orders AS o
    ON o.customer_id = c.customer_id
   AND o.status = 'paid';
```

The correct location depends on the intended result.

## Mistake 13: Misusing `GROUP BY` and `HAVING`

`WHERE` filters rows before grouping. `HAVING` filters groups after aggregation.

```sql
SELECT
    department_id,
    COUNT(*) AS employee_count
FROM employees
WHERE active = TRUE
GROUP BY department_id
HAVING COUNT(*) >= 5;
```

This query first removes inactive employees. It then forms department groups and keeps groups containing at least five active employees.

A frequent error is using `WHERE COUNT(*) >= 5`. Aggregate filters belong in `HAVING`.

## Mistake 14: Hiding duplicate rows with `DISTINCT`

`DISTINCT` removes duplicate output combinations. It does not repair an incorrect join.

Suppose an order has several items and several payments. Joining both child tables directly can create every item-payment combination. The order total may then be overstated.

Inspect the relationship first:

```sql
SELECT o.order_id, oi.order_item_id, p.payment_id
FROM orders AS o
JOIN order_items AS oi ON oi.order_id = o.order_id
LEFT JOIN payments AS p ON p.order_id = o.order_id
WHERE o.order_id = 1001;
```

If the row multiplication is real, aggregate each one-to-many source before combining it. Use `DISTINCT` only when duplicate output values are logically irrelevant and the reason is understood.

## Mistake 15: Mishandling `NULL`

`NULL` represents missing or unknown information. It is not equal to zero, an empty string, or another null.

Incorrect:

```sql
WHERE email = NULL
```

Correct:

```sql
WHERE email IS NULL
```

Use `COALESCE` when a fallback display value is needed:

```sql
SELECT
    full_name,
    COALESCE(email, 'No email provided') AS email_display
FROM students;
```

Test null behavior in filters, joins, calculations, sorting, and concatenation.

## Mistake 16: Failing to test empty and edge cases

A query that works with ordinary sample rows may fail when no record matches. A left join may be tested only with matched rows. A constraint may be tested only with valid values.

Include test cases for:

- An entity without a child record
- Several child records
- An empty result
- A null optional value
- A duplicate identifier
- An invalid foreign key
- A minimum and maximum boundary
- A date exactly at the range boundary
- A failed multi-step transaction

Document the expected and actual results. Testing is evidence that the design works beyond the demonstration data.

## Mistake 17: Ignoring SQL dialect differences

PostgreSQL, MySQL, SQLite, SQL Server, and Oracle Database do not implement every feature identically. Date functions, pagination, auto-generated keys, string matching, and procedural syntax can differ.

For example, PostgreSQL supports `ILIKE` for case-insensitive matching. Another platform may require a different expression.

### How to avoid the mistake

Confirm the required database platform and version before writing the final script. Do not assume that SQL from a different tutorial will run unchanged.

## Mistake 18: Omitting transactions

Related changes should be grouped when partial completion would create an invalid state. For example, returning a library book may require updating both the loan and the copy availability.

```sql
BEGIN;

UPDATE loans
SET return_date = CURRENT_DATE
WHERE loan_id = 1001
  AND return_date IS NULL;

UPDATE book_copies
SET availability = 'available'
WHERE copy_id = (
    SELECT copy_id FROM loans WHERE loan_id = 1001
);

COMMIT;
```

Test the failure path. A rollback should remove all changes from the incomplete operation.

## Mistake 19: Adding indexes without explanation

Indexes can improve reads, but they also consume storage and may increase insert and update costs. Adding indexes to every column does not demonstrate good database design.

Explain which query the index supports:

```sql
CREATE INDEX idx_orders_customer_date
    ON orders (customer_id, order_date DESC);
```

Use `EXPLAIN` or `EXPLAIN ANALYZE` when the assignment requires performance analysis. Compare plans and measurements on representative data.

## Mistake 20: Submitting weak documentation

A technically correct script can still lose marks if the report does not explain the choices behind it. The documentation should connect the requirements to the schema and the schema to the queries.

A strong DBMS assignment report usually includes:

1. Problem statement and objectives
2. Assumptions and scope
3. ER diagram
4. Entity and attribute descriptions
5. Normalization analysis
6. Relational schema
7. Constraints and indexes
8. Sample data
9. SQL queries and output
10. Test cases
11. Limitations and future improvements

Do not insert screenshots without explaining what the screenshot proves. Describe the result grain and why the output is correct.

## Mistake 21: Using real sensitive information

Hospital, payroll, banking, and student projects often contain sensitive information in real life. Classroom assignments should use fictional names, addresses, account numbers, and medical details.

Never include passwords, private database credentials, or real personal records in a shared assignment. A production system would require stronger authentication, authorization, encryption, auditing, privacy controls, and legal review.

## Mistake 22: Accepting unexplained outside work

External support can help clarify a schema, debug a query, or review a design. It should not leave you with a submission you cannot explain.

If you seek **DBMS assignment help**, share the assignment prompt, schema or ER diagram, attempted work, error message, database platform, and expected result. Ask for reasoning and feedback. Follow your institution’s academic-integrity rules.

[AssignmentDude](https://assignmentdude.com/) is an additional educational resource for SQL queries, database design, normalization, ER diagrams, debugging, project documentation, and DBMS viva preparation. Use any external guidance to improve your understanding and produce work you can defend.

## Final DBMS assignment checklist

Before submission, confirm that:

- The requirements are reflected in the schema.
- Every important table has a primary key.
- Foreign keys match the intended relationships.
- Many-to-many relationships use junction tables.
- Repeated data and normalization issues have been considered.
- Important business rules are enforced with constraints.
- The result grain is clear for every major query.
- Joins use keys rather than descriptive text.
- Aggregates have been checked for row multiplication.
- `NULL` and empty-result behavior has been tested.
- The syntax matches the required database platform.
- Transactions are used where related changes must succeed together.
- Indexes are justified with a query or plan.
- The report explains assumptions and limitations.
- You can explain the project in your own words.

## Conclusion

The mistakes that cost marks in a DBMS assignment are usually preventable. Start with the requirements. Model the relationships carefully. Normalize where appropriate. Add constraints. Build queries in stages. Test edge cases. Document the reasoning.

If you need additional educational guidance, visit [AssignmentDude](https://assignmentdude.com/) for support with SQL assignment help, database assignment help, DBMS assignment help, database design, normalization, debugging, project documentation, and viva preparation.

**Design carefully. Query deliberately. Test completely. Explain confidently.**

## References

[1]: https://www.postgresql.org/docs/current/ddl-constraints.html "PostgreSQL Documentation: Constraints"
[2]: https://www.postgresql.org/docs/current/queries-table-expressions.html "PostgreSQL Documentation: Table Expressions"
[3]: https://www.postgresql.org/docs/current/tutorial-join.html "PostgreSQL Tutorial: Joins Between Tables"
[4]: https://www.postgresql.org/docs/current/transaction-iso.html "PostgreSQL Documentation: Transaction Isolation"
[5]: https://assignmentdude.com/database-project-ideas/ "AssignmentDude: Database Project Ideas"
