#!/bin/bash

# MySQL credentials
MYSQL_USER="root"
MYSQL_PASS="11111111"
MYSQL_HOST="localhost"
DB_NAME="hospital_db"

# Create the SQL file
cat <<EOF > hospital_schema.sql
CREATE DATABASE IF NOT EXISTS \\\`$DB_NAME\\\`;
USE \\\`$DB_NAME\\\`;

-- Drop existing tables if needed
DROP TABLE IF EXISTS tbl_Billing, tbl_Prescription, tbl_Appointment, tbl_Doctor, tbl_Patient;

-- 1. Patient Table
CREATE TABLE tbl_Patient (
  col_PatientID INT PRIMARY KEY AUTO_INCREMENT,
  col_PatientName VARCHAR(100) NOT NULL,
  col_Gender ENUM('Male', 'Female', 'Other'),
  col_DOB DATE,
  col_ContactNumber VARCHAR(15),
  INDEX(col_PatientName)
);

-- 2. Doctor Table
CREATE TABLE tbl_Doctor (
  col_DoctorID INT PRIMARY KEY AUTO_INCREMENT,
  col_DoctorName VARCHAR(100) NOT NULL,
  col_Specialization VARCHAR(100),
  col_ContactNumber VARCHAR(15),
  col_ExperienceInYears INT,
  INDEX(col_Specialization)
);

-- 3. Appointment Table
CREATE TABLE tbl_Appointment (
  col_AppointmentID INT PRIMARY KEY AUTO_INCREMENT,
  col_PatientID INT,
  col_DoctorID INT,
  col_AppointmentDate DATETIME,
  col_Reason VARCHAR(255),
  FOREIGN KEY (col_PatientID) REFERENCES tbl_Patient(col_PatientID),
  FOREIGN KEY (col_DoctorID) REFERENCES tbl_Doctor(col_DoctorID),
  INDEX(col_AppointmentDate)
);

-- 4. Prescription Table
CREATE TABLE tbl_Prescription (
  col_PrescriptionID INT PRIMARY KEY AUTO_INCREMENT,
  col_AppointmentID INT,
  col_MedicationDetails TEXT,
  col_Dosage VARCHAR(100),
  col_Duration VARCHAR(100),
  FOREIGN KEY (col_AppointmentID) REFERENCES tbl_Appointment(col_AppointmentID)
);

-- 5. Billing Table
CREATE TABLE tbl_Billing (
  col_BillingID INT PRIMARY KEY AUTO_INCREMENT,
  col_AppointmentID INT,
  col_TotalAmount DECIMAL(10,2),
  col_BillingDate DATE,
  col_PaymentMethod ENUM('Cash', 'Card', 'Online'),
  FOREIGN KEY (col_AppointmentID) REFERENCES tbl_Appointment(col_AppointmentID)
);
EOF

# Execute SQL file
echo "Creating hospital database schema..."
mysql -u "$MYSQL_USER" -p"$MYSQL_PASS" -h "$MYSQL_HOST" < hospital_schema.sql

# Clean up
rm hospital_schema.sql

echo "Hospital schema created successfully in database '$DB_NAME'"
