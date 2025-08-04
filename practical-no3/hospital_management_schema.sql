
-- Table: tbl_Patient
CREATE TABLE tbl_Patient (
  col_PatientID INT PRIMARY KEY,
  col_PatientName VARCHAR(100),
  col_DOB DATE,
  col_Gender VARCHAR(10),
  col_ContactNumber VARCHAR(15),
  col_Address TEXT
);

-- Table: tbl_Doctor
CREATE TABLE tbl_Doctor (
  col_DoctorID INT PRIMARY KEY,
  col_DoctorName VARCHAR(100),
  col_Specialization VARCHAR(50),
  col_ContactNumber VARCHAR(15),
  col_ExperienceInYears INT
);

-- Table: tbl_Appointment
CREATE TABLE tbl_Appointment (
  col_AppointmentID INT PRIMARY KEY,
  col_PatientID INT,
  col_DoctorID INT,
  col_AppointmentDate DATETIME,
  col_Reason TEXT,
  FOREIGN KEY (col_PatientID) REFERENCES tbl_Patient(col_PatientID),
  FOREIGN KEY (col_DoctorID) REFERENCES tbl_Doctor(col_DoctorID),
  INDEX idx_AppointmentDate (col_AppointmentDate)
);

-- Table: tbl_Prescription
CREATE TABLE tbl_Prescription (
  col_PrescriptionID INT PRIMARY KEY,
  col_AppointmentID INT,
  col_Medication TEXT,
  col_Dosage TEXT,
  col_Duration VARCHAR(50),
  FOREIGN KEY (col_AppointmentID) REFERENCES tbl_Appointment(col_AppointmentID)
);

-- Table: tbl_Billing
CREATE TABLE tbl_Billing (
  col_BillingID INT PRIMARY KEY,
  col_AppointmentID INT,
  col_TotalAmount DECIMAL(10,2),
  col_BillingDate DATE,
  col_PaymentMethod VARCHAR(50),
  FOREIGN KEY (col_AppointmentID) REFERENCES tbl_Appointment(col_AppointmentID),
  INDEX idx_BillingDate (col_BillingDate)
);
