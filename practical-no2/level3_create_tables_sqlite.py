# level3_create_tables_sqlite.py
# Purpose: Creates 'students' and 'courses' tables using raw SQL in SQLite

import sqlite3

# Connect to database (creates DB if not exists)
conn = sqlite3.connect("level3_database.db")
cursor = conn.cursor()

# Create students table
cursor.execute("""
CREATE TABLE IF NOT EXISTS students (
    student_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    age INTEGER NOT NULL
)
""")

# Create courses table
cursor.execute("""
CREATE TABLE IF NOT EXISTS courses (
    course_id INTEGER PRIMARY KEY AUTOINCREMENT,
    course_name TEXT NOT NULL,
    credits INTEGER NOT NULL
)
""")

# Commit and close
conn.commit()
conn.close()
print("✅ Level 3: Students and Courses tables created in SQLite.")
