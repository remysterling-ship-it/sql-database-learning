"""A small, dependency-free Python and SQLite learning example."""

from __future__ import annotations

import sqlite3
from pathlib import Path

DATABASE_PATH = Path(__file__).with_name("learning_tasks.db")


SCHEMA = """
CREATE TABLE IF NOT EXISTS tasks (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    topic TEXT NOT NULL,
    status TEXT NOT NULL CHECK (status IN ('todo', 'in_progress', 'done'))
)
"""


def create_schema(connection: sqlite3.Connection) -> None:
    """Create the learning table if it does not already exist."""
    connection.execute(SCHEMA)


def seed_tasks(connection: sqlite3.Connection) -> None:
    """Reset and insert deterministic sample data for repeatable practice."""
    connection.execute("DELETE FROM tasks")
    tasks = [
        ("Design a normalized schema", "database design", "done"),
        ("Practice INNER JOIN queries", "SQL", "in_progress"),
        ("Compare two query plans", "indexing", "todo"),
    ]
    connection.executemany(
        "INSERT INTO tasks (title, topic, status) VALUES (?, ?, ?)", tasks
    )


def print_completed_tasks(connection: sqlite3.Connection) -> None:
    """Print completed tasks using named columns from sqlite3.Row."""
    query = """
        SELECT title, topic
        FROM tasks
        WHERE status = ?
        ORDER BY topic, title
    """
    for row in connection.execute(query, ("done",)):
        print(f"- {row['title']} ({row['topic']})")


def main() -> None:
    connection = sqlite3.connect(DATABASE_PATH)
    connection.row_factory = sqlite3.Row
    try:
        with connection:
            create_schema(connection)
            seed_tasks(connection)

        print("Completed learning tasks:")
        print_completed_tasks(connection)
    finally:
        connection.close()


if __name__ == "__main__":
    main()
