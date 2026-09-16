DROP TABLE IF EXISTS attendance;
DROP TABLE IF EXISTS class_sessions;
DROP TABLE IF EXISTS course_enrollments;
DROP TABLE IF EXISTS courses;
DROP TABLE IF EXISTS students;

CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    full_name TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE
);

CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,
    course_code TEXT NOT NULL UNIQUE,
    title TEXT NOT NULL
);

CREATE TABLE course_enrollments (
    student_id INTEGER NOT NULL REFERENCES students(student_id),
    course_id INTEGER NOT NULL REFERENCES courses(course_id),
    enrolled_on DATE NOT NULL DEFAULT CURRENT_DATE,
    PRIMARY KEY (student_id, course_id)
);

CREATE TABLE class_sessions (
    session_id SERIAL PRIMARY KEY,
    course_id INTEGER NOT NULL REFERENCES courses(course_id),
    session_date DATE NOT NULL,
    UNIQUE (course_id, session_date)
);

CREATE TABLE attendance (
    session_id INTEGER NOT NULL REFERENCES class_sessions(session_id),
    student_id INTEGER NOT NULL REFERENCES students(student_id),
    status TEXT NOT NULL CHECK (status IN ('present', 'absent', 'late')),
    PRIMARY KEY (session_id, student_id)
);

INSERT INTO students (full_name, email) VALUES
    ('Aisha Khan', 'aisha@example.edu'),
    ('Daniel Lee', 'daniel@example.edu'),
    ('Maya Patel', 'maya@example.edu');

INSERT INTO courses (course_code, title) VALUES
    ('DB101', 'Database Systems'),
    ('SQL201', 'Practical SQL');

INSERT INTO course_enrollments VALUES
    (1, 1, '2026-09-01'), (2, 1, '2026-09-01'), (3, 1, '2026-09-01'),
    (1, 2, '2026-09-01'), (2, 2, '2026-09-01');

INSERT INTO class_sessions (course_id, session_date) VALUES
    (1, '2026-09-08'), (1, '2026-09-15'), (2, '2026-09-10');

INSERT INTO attendance VALUES
    (1, 1, 'present'), (1, 2, 'late'), (1, 3, 'absent'),
    (2, 1, 'present'), (2, 2, 'present'), (2, 3, 'present'),
    (3, 1, 'present'), (3, 2, 'absent');
