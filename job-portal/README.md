# Job Portal Database

An original recruiting-platform project inspired by job-board systems. Practice companies, job postings, candidates, applications, and application-status reporting.

## Learning goals

- Separate companies, postings, candidates, and applications
- Enforce one application per candidate per job
- Query open roles and applicant pipelines
- Use conditional aggregation to summarize statuses

## Run

```bash
psql -d learning_lab -f 01_schema.sql
psql -d learning_lab -f 02_queries.sql
```
