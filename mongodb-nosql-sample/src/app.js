import { MongoClient } from "mongodb";

const uri = process.env.MONGODB_URI ?? "mongodb://127.0.0.1:27017";
const client = new MongoClient(uri);

const courses = [
  { code: "DB101", title: "Database Systems", level: "beginner", topics: ["SQL", "normalization"] },
  { code: "NOSQL201", title: "Document Databases", level: "intermediate", topics: ["MongoDB", "aggregation"] }
];

async function run() {
  await client.connect();
  const database = client.db("learning_platform");
  const courseCollection = database.collection("courses");
  const enrollmentCollection = database.collection("enrollments");

  await courseCollection.deleteMany({});
  await enrollmentCollection.deleteMany({});
  await courseCollection.createIndex({ code: 1 }, { unique: true });
  await enrollmentCollection.createIndex({ learnerId: 1, status: 1 });

  const { insertedIds } = await courseCollection.insertMany(courses);
  await enrollmentCollection.insertMany([
    {
      learnerId: "learner-001",
      courseId: insertedIds[0],
      status: "completed",
      progress: { percent: 100, lastActivity: new Date("2026-09-01") }
    },
    {
      learnerId: "learner-001",
      courseId: insertedIds[1],
      status: "in_progress",
      progress: { percent: 60, lastActivity: new Date("2026-09-08") }
    },
    {
      learnerId: "learner-002",
      courseId: insertedIds[1],
      status: "in_progress",
      progress: { percent: 35, lastActivity: new Date("2026-09-07") }
    }
  ]);

  const report = await enrollmentCollection.aggregate([
    { $match: { status: "in_progress" } },
    { $group: { _id: "$courseId", learners: { $sum: 1 }, averageProgress: { $avg: "$progress.percent" } } },
    { $lookup: { from: "courses", localField: "_id", foreignField: "_id", as: "course" } },
    { $unwind: "$course" },
    { $project: { _id: 0, course: "$course.title", learners: 1, averageProgress: { $round: ["$averageProgress", 1] } } },
    { $sort: { averageProgress: -1 } }
  ]).toArray();

  console.log("In-progress course report:");
  for (const row of report) {
    console.log(`- ${row.course}: ${row.learners} learner(s), ${row.averageProgress}% average progress`);
  }
}

run()
  .catch((error) => {
    console.error("MongoDB operation failed:", error.message);
    process.exitCode = 1;
  })
  .finally(async () => {
    await client.close();
  });
