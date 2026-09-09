-- Job portal query exercises. Run after 01_schema.sql.
-- 1. List open jobs and their companies.
SELECT j.title, c.company_name, j.location, j.posted_on
FROM job_postings j
JOIN companies c ON c.company_id = j.company_id
WHERE j.status = 'open'
ORDER BY j.posted_on DESC;

-- 2. Applicant pipeline per job.
SELECT j.title,
       COUNT(a.application_id) AS total_applicants,
       COUNT(*) FILTER (WHERE a.status = 'interview') AS interviews,
       COUNT(*) FILTER (WHERE a.status = 'offer') AS offers
FROM job_postings j
LEFT JOIN applications a ON a.job_id = j.job_id
GROUP BY j.job_id, j.title
ORDER BY total_applicants DESC;

-- 3. Candidates who applied to more than one job.
SELECT c.full_name, COUNT(a.application_id) AS applications
FROM candidates c
JOIN applications a ON a.candidate_id = c.candidate_id
GROUP BY c.candidate_id, c.full_name
HAVING COUNT(a.application_id) > 1;
