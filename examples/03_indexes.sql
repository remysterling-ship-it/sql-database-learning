-- 03_indexes.sql
-- Run after 01_schema.sql. PostgreSQL syntax.

-- Inspect the plan before adding an index.
EXPLAIN ANALYZE
SELECT *
FROM books
WHERE category = 'Databases';

-- Add an index for repeated category filtering.
CREATE INDEX IF NOT EXISTS idx_books_category
    ON books(category);

-- Inspect the plan again and compare the result.
EXPLAIN ANALYZE
SELECT *
FROM books
WHERE category = 'Databases';

-- An index can improve reads, but it also adds storage and write overhead.
-- Always measure with realistic data before deciding to keep it.
