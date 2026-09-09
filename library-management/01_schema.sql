-- Library management schema and sample data.
DROP TABLE IF EXISTS loans;
DROP TABLE IF EXISTS book_copies;
DROP TABLE IF EXISTS book_authors;
DROP TABLE IF EXISTS authors;
DROP TABLE IF EXISTS books;
DROP TABLE IF EXISTS members;

CREATE TABLE members (
    member_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    full_name TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    joined_on DATE NOT NULL DEFAULT CURRENT_DATE
);
CREATE TABLE books (
    book_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    isbn TEXT NOT NULL UNIQUE,
    title TEXT NOT NULL,
    published_year INTEGER CHECK (published_year > 0)
);
CREATE TABLE authors (
    author_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    full_name TEXT NOT NULL
);
CREATE TABLE book_authors (
    book_id INTEGER NOT NULL REFERENCES books(book_id) ON DELETE CASCADE,
    author_id INTEGER NOT NULL REFERENCES authors(author_id) ON DELETE CASCADE,
    PRIMARY KEY (book_id, author_id)
);
CREATE TABLE book_copies (
    copy_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    book_id INTEGER NOT NULL REFERENCES books(book_id),
    shelf_code TEXT NOT NULL UNIQUE
);
CREATE TABLE loans (
    loan_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    copy_id INTEGER NOT NULL REFERENCES book_copies(copy_id),
    member_id INTEGER NOT NULL REFERENCES members(member_id),
    borrowed_on DATE NOT NULL,
    due_on DATE NOT NULL,
    returned_on DATE,
    CHECK (due_on >= borrowed_on)
);

INSERT INTO members (full_name, email) VALUES ('Aisha Khan', 'aisha@library.example'), ('Marco Silva', 'marco@library.example');
INSERT INTO books (isbn, title, published_year) VALUES ('978-000000001', 'SQL Fundamentals', 2024), ('978-000000002', 'Networks in Practice', 2023);
INSERT INTO authors (full_name) VALUES ('R. Patel'), ('T. Ibrahim');
INSERT INTO book_authors VALUES (1, 1), (2, 2);
INSERT INTO book_copies (book_id, shelf_code) VALUES (1, 'DB-A1'), (1, 'DB-A2'), (2, 'NW-B1');
INSERT INTO loans (copy_id, member_id, borrowed_on, due_on, returned_on) VALUES
    (1, 1, CURRENT_DATE - 20, CURRENT_DATE - 6, NULL),
    (3, 2, CURRENT_DATE - 3, CURRENT_DATE + 11, NULL),
    (2, 1, CURRENT_DATE - 30, CURRENT_DATE - 16, CURRENT_DATE - 18);
