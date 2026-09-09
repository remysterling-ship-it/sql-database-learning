-- Job portal schema and sample data.
DROP TABLE IF EXISTS applications;
DROP TABLE IF EXISTS job_postings;
DROP TABLE IF EXISTS candidates;
DROP TABLE IF EXISTS companies;

CREATE TABLE companies (
    company_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    company_name TEXT NOT NULL UNIQUE,
    industry TEXT NOT NULL
);
CREATE TABLE candidates (
    candidate_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    full_name TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    years_experience INTEGER NOT NULL CHECK (years_experience >= 0)
);
CREATE TABLE job_postings (
    job_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    company_id INTEGER NOT NULL REFERENCES companies(company_id),
    title TEXT NOT NULL,
    location TEXT NOT NULL,
    status TEXT NOT NULL CHECK (status IN ('open', 'closed')),
    posted_on DATE NOT NULL DEFAULT CURRENT_DATE
);
CREATE TABLE applications (
    application_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    job_id INTEGER NOT NULL REFERENCES job_postings(job_id) ON DELETE CASCADE,
    candidate_id INTEGER NOT NULL REFERENCES candidates(candidate_id) ON DELETE CASCADE,
    applied_on DATE NOT NULL DEFAULT CURRENT_DATE,
    status TEXT NOT NULL CHECK (status IN ('submitted', 'screening', 'interview', 'offer', 'rejected')),
    UNIQUE (job_id, candidate_id)
);

INSERT INTO companies (company_name, industry) VALUES ('DataWorks', 'Education Technology'), ('CloudRoute', 'Networking');
INSERT INTO candidates (full_name, email, years_experience) VALUES ('Aisha Khan', 'aisha@candidate.example', 1), ('Marco Silva', 'marco@candidate.example', 3), ('Nora Chen', 'nora@candidate.example', 2);
INSERT INTO job_postings (company_id, title, location, status) VALUES
    (1, 'Junior SQL Educator', 'Remote', 'open'), (2, 'Java Network Engineer', 'Bengaluru', 'open'), (1, 'Data Analyst Intern', 'Remote', 'closed');
INSERT INTO applications (job_id, candidate_id, status) VALUES
    (1, 1, 'interview'), (1, 3, 'screening'), (2, 2, 'submitted'), (3, 1, 'rejected');
