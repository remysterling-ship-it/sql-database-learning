# Python + SQLite Sample Project

A beginner-friendly Python project that uses the standard-library `sqlite3` module to create and query a small task database. No third-party packages or database server are required.

## What it demonstrates

- Opening a SQLite connection with Python
- Creating tables and constraints
- Inserting rows with parameterized SQL
- Updating and querying records
- Using `sqlite3.Row` for readable results
- Managing transactions and closing connections safely

## Run it

From this directory:

```bash
python3 app.py
```

The program creates `learning_tasks.db` in the project directory and prints the completed tasks. The generated database is ignored by Git.

## Suggested experiments

- Add a `priority` column and filter by it.
- Add a `due_date` column and sort upcoming tasks.
- Write a query that counts tasks by status.
- Split the database code into a reusable repository class.

The project uses only Python’s standard library, making it easy to run in a classroom, lab, or local practice environment.
