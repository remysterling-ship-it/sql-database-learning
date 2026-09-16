-- Attendance percentage by student and course.
SELECT s.full_name, c.course_code,
       ROUND(100.0 * COUNT(*) FILTER (WHERE a.status IN ('present', 'late')) / COUNT(*), 2) AS attendance_percent
FROM attendance a
JOIN students s ON s.student_id = a.student_id
JOIN class_sessions cs ON cs.session_id = a.session_id
JOIN courses c ON c.course_id = cs.course_id
GROUP BY s.student_id, s.full_name, c.course_id, c.course_code
ORDER BY attendance_percent DESC;

-- Students below the 75% attendance threshold.
SELECT s.full_name, COUNT(*) AS sessions,
       COUNT(*) FILTER (WHERE a.status = 'absent') AS absences
FROM attendance a
JOIN students s ON s.student_id = a.student_id
GROUP BY s.student_id, s.full_name
HAVING 100.0 * COUNT(*) FILTER (WHERE a.status IN ('present', 'late')) / COUNT(*) < 75;

-- Sessions with the highest absence count.
SELECT cs.session_date, c.course_code,
       COUNT(*) FILTER (WHERE a.status = 'absent') AS absences
FROM class_sessions cs
JOIN courses c ON c.course_id = cs.course_id
JOIN attendance a ON a.session_id = cs.session_id
GROUP BY cs.session_id, cs.session_date, c.course_code
ORDER BY absences DESC;
