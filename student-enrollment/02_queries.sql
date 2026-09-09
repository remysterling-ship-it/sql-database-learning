-- Enrollment query exercises. Run after 01_schema.sql.
-- 1. Show each student's schedule.
SELECT s.full_name, c.code, c.title, sec.term, sec.room
FROM students s
JOIN enrollments e ON e.student_id = s.student_id
JOIN sections sec ON sec.section_id = e.section_id
JOIN courses c ON c.course_id = sec.course_id
ORDER BY s.full_name, c.code;

-- 2. Count students in each section.
SELECT c.code, c.title, COUNT(e.student_id) AS enrolled_students
FROM courses c
JOIN sections sec ON sec.course_id = c.course_id
LEFT JOIN enrollments e ON e.section_id = sec.section_id
GROUP BY c.code, c.title
ORDER BY enrolled_students DESC;

-- 3. Find students with an average grade above 85.
SELECT s.full_name, ROUND(AVG(e.grade), 2) AS average_grade
FROM students s
JOIN enrollments e ON e.student_id = s.student_id
GROUP BY s.student_id, s.full_name
HAVING AVG(e.grade) > 85;
