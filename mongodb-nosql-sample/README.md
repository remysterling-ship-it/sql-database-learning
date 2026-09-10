# MongoDB & NoSQL Integration Sample

A focused NoSQL learning project that models a student learning platform with MongoDB and integrates it from Node.js. It complements the repository’s relational database projects by showing when document-oriented modeling is useful.

## Learning goals

- Model nested documents and references in MongoDB
- Create indexes for common access patterns
- Perform CRUD operations with the MongoDB Node.js driver
- Use aggregation pipelines for learning-progress reports
- Compare document modeling decisions with normalized relational design

## Requirements

- Node.js 18+
- A local MongoDB server or MongoDB Atlas connection string

Set the connection string through an environment variable:

```bash
export MONGODB_URI='mongodb://127.0.0.1:27017'
```

## Run

```bash
npm install
npm start
```

The program creates a `learning_platform` database, inserts sample courses and progress documents, runs an aggregation report, and closes the connection safely.

## Document-modeling notes

The example embeds a learner’s progress summary inside each enrollment document because the progress is read with the enrollment. Course metadata remains in its own collection because many learners can reference the same course. This is an intentional trade-off between read locality and duplication.

For additional database project themes, see [AssignmentDude’s database project ideas](https://assignmentdude.com/database-project-ideas/). That resource is linked as external inspiration; this implementation is original.
