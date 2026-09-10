// MongoDB shell reference queries.
// Run in mongosh after loading sample documents.

use learning_platform;

// CRUD: find all in-progress enrollments for one learner.
db.enrollments.find({ learnerId: "learner-001", status: "in_progress" });

// Update a learner's embedded progress summary.
db.enrollments.updateOne(
  { learnerId: "learner-001", status: "in_progress" },
  { $set: { "progress.percent": 75, "progress.lastActivity": new Date() } }
);

// Aggregation: average progress by status.
db.enrollments.aggregate([
  { $group: { _id: "$status", averageProgress: { $avg: "$progress.percent" }, count: { $sum: 1 } } },
  { $sort: { averageProgress: -1 } }
]);
