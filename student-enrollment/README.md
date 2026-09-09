# Student Enrollment Database

A relational database project for practicing students, courses, instructors, sections, and many-to-many enrollment relationships.

## Learning goals

- Model many-to-many relationships with a junction table
- Enforce uniqueness and foreign-key constraints
- Query enrollment totals and student schedules
- Use aggregates, joins, and `HAVING`

## Run

```bash
psql -d learning_lab -f 01_schema.sql
psql -d learning_lab -f 02_queries.sql
```
