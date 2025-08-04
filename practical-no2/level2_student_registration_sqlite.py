# level2_student_registration_sqlite.py
# Purpose: Create a student registration system with relationships in SQLite

import sqlite3

# Connect to database
conn = sqlite3.connect("level2_database.db")
cursor = conn.cursor()

# Enable foreign keys
cursor.execute("PRAGMA foreign_keys = ON")

# Create students table
cursor.execute("""
CREATE TABLE IF NOT EXISTS students (
    student_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL
)
""")

# Create courses table
cursor.execute("""
CREATE TABLE IF NOT EXISTS courses (
    course_id INTEGER PRIMARY KEY AUTOINCREMENT,
    course_name TEXT NOT NULL,
    department TEXT NOT NULL
)
""")

# Create registrations table
cursor.execute("""
CREATE TABLE IF NOT EXISTS registrations (
    registration_id INTEGER PRIMARY KEY AUTOINCREMENT,
    student_id INTEGER,
    course_id INTEGER,
    registration_date TEXT NOT NULL,
    FOREIGN KEY(student_id) REFERENCES students(student_id),
    FOREIGN KEY(course_id) REFERENCES courses(course_id)
)
""")

# Commit and close
conn.commit()
conn.close()
print("✅ Level 2: Student registration schema created in SQLite.")
