# JDBC Sample Project

A small Java Database Connectivity example using Java 17, Maven, and an embedded SQLite database. It demonstrates the core JDBC workflow without requiring a separate database server.

## What it demonstrates

- Opening a JDBC connection
- Creating a table with `Statement`
- Inserting data safely with `PreparedStatement`
- Reading rows with `ResultSet`
- Using try-with-resources to close JDBC resources
- Committing a transaction and rolling it back on failure

## Run it

From this directory:

```bash
mvn compile exec:java
```

The program creates `learning.db` in the project directory and prints the students whose grade is at least 80. The database file is ignored by Git because it is generated runtime state.

## Key JDBC flow

1. Load a JDBC URL through the SQLite driver.
2. Open a `Connection`.
3. Prepare SQL statements with placeholders.
4. Bind values with `PreparedStatement`.
5. Iterate through the `ResultSet`.
6. Close resources automatically with try-with-resources.

The example uses SQLite for portability. The same application structure can be adapted to PostgreSQL or MySQL by changing the JDBC dependency, URL, and SQL dialect where necessary.
