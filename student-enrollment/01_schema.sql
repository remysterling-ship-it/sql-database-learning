-- Student enrollment schema and sample data.
DROP TABLE IF EXISTS enrollments;
DROP TABLE IF EXISTS sections;
DROP TABLE IF EXISTS courses;
DROP TABLE IF EXISTS instructors;
DROP TABLE IF EXISTS students;

CREATE TABLE students (
    student_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    full_name TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE
);
CREATE TABLE instructors (
    instructor_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    full_name TEXT NOT NULL
);
CREATE TABLE courses (
    course_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    code TEXT NOT NULL UNIQUE,
    title TEXT NOT NULL,
    credits INTEGER NOT NULL CHECK (credits BETWEEN 1 AND 6)
);
CREATE TABLE sections (
    section_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    course_id INTEGER NOT NULL REFERENCES courses(course_id),
    instructor_id INTEGER NOT NULL REFERENCES instructors(instructor_id),
    term TEXT NOT NULL,
    room TEXT NOT NULL
);
CREATE TABLE enrollments (
    student_id INTEGER NOT NULL REFERENCES students(student_id) ON DELETE CASCADE,
    section_id INTEGER NOT NULL REFERENCES sections(section_id) ON DELETE CASCADE,
    enrolled_on DATE NOT NULL DEFAULT CURRENT_DATE,
    grade NUMERIC(5,2) CHECK (grade BETWEEN 0 AND 100),
    PRIMARY KEY (student_id, section_id)
);

INSERT INTO students (full_name, email) VALUES
    ('Aisha Khan', 'aisha@student.example'),
    ('Marco Silva', 'marco@student.example'),
    ('Nora Chen', 'nora@student.example');
INSERT INTO instructors (full_name) VALUES ('Dr. Priya Shah'), ('Prof. Leo Martin');
INSERT INTO courses (code, title, credits) VALUES
    ('DB101', 'Database Systems', 4), ('NW110', 'Computer Networking', 3), ('JAVA120', 'Java Programming', 4);
INSERT INTO sections (course_id, instructor_id, term, room) VALUES
    (1, 1, 'Fall 2026', 'Lab 1'), (2, 2, 'Fall 2026', 'Room 204'), (3, 1, 'Fall 2026', 'Lab 2');
INSERT INTO enrollments (student_id, section_id, grade) VALUES
    (1, 1, 92), (1, 2, 87), (2, 1, 78), (2, 3, 84), (3, 1, 95), (3, 3, 90);
