-- Library query exercises. Run after 01_schema.sql.
-- 1. Find currently overdue loans.
SELECT m.full_name, b.title, l.due_on,
       CURRENT_DATE - l.due_on AS days_overdue
FROM loans l
JOIN members m ON m.member_id = l.member_id
JOIN book_copies bc ON bc.copy_id = l.copy_id
JOIN books b ON b.book_id = bc.book_id
WHERE l.returned_on IS NULL AND l.due_on < CURRENT_DATE
ORDER BY days_overdue DESC;

-- 2. Count copies and active loans per title.
SELECT b.title,
       COUNT(DISTINCT bc.copy_id) AS total_copies,
       COUNT(l.loan_id) FILTER (WHERE l.returned_on IS NULL) AS active_loans
FROM books b
LEFT JOIN book_copies bc ON bc.book_id = b.book_id
LEFT JOIN loans l ON l.copy_id = bc.copy_id
GROUP BY b.book_id, b.title;

-- 3. Find members with no active loans.
SELECT m.full_name
FROM members m
LEFT JOIN loans l ON l.member_id = m.member_id AND l.returned_on IS NULL
WHERE l.loan_id IS NULL;
