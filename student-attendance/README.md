# Student Attendance Database

A practical project for tracking students, courses, class sessions, attendance, and attendance percentages. It helps students practice keys, many-to-many relationships, date filtering, conditional aggregation, and reporting.

## Run

```bash
psql -d learning_lab -f 01_schema.sql
psql -d learning_lab -f 02_queries.sql
```

## Practice ideas

Add an attendance warning report, enforce one record per student and session, and compare attendance by course.
