CREATE DATABASE hospital_management_system;
USE hospital_management_system;
--Domain-related name: Hospital Management System
CREATE SCHEMA hospital_management;
USE hospital_management;
--3nf model
CREATE TABLE patients (
  patient_id INT NOT NULL AUTO_INCREMENT,
  first_name VARCHAR(255) NOT NULL,
  last_name VARCHAR(255) NOT NULL,
  date_of_birth DATE NOT NULL,
  gender VARCHAR(255) NOT NULL CHECK (gender IN ('Male', 'Female')),
  PRIMARY KEY (patient_id)
);

CREATE TABLE doctors (
  doctor_id INT NOT NULL AUTO_INCREMENT,
  first_name VARCHAR(255) NOT NULL,
  last_name VARCHAR(255) NOT NULL,
  specialization VARCHAR(255) NOT NULL,
  PRIMARY KEY (doctor_id)
);

CREATE TABLE appointments (
  appointment_id INT NOT NULL AUTO_INCREMENT,
  patient_id INT NOT NULL,
  doctor_id INT NOT NULL,
  appointment_date DATE NOT NULL CHECK (appointment_date >= CURRENT_DATE),
  appointment_time TIME NOT NULL CHECK (appointment_time >= '08:00:00' AND appointment_time <= '17:00:00'),
  PRIMARY KEY (appointment_id),
  FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
  FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
);
-- NOT NULL constraints, DEFAULT values, and GENERATED ALWAYS AS
ALTER TABLE patients
  ADD COLUMN record_ts TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE doctors
  ADD COLUMN record_ts TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE appointments
  ADD COLUMN record_ts TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP;
--check constraints across the tables to restrict certain values
ALTER TABLE patients
  ADD CONSTRAINT ck_patients_date_of_birth CHECK (date_of_birth >= '2000-01-01');

ALTER TABLE appointments
  ADD CONSTRAINT ck_appointments_patient_id UNIQUE (patient_id);

ALTER TABLE appointments
  ADD CONSTRAINT ck_appointments_doctor_id UNIQUE (doctor_id);

ALTER TABLE appointments
  ADD CONSTRAINT ck_appointments_appointment_date CHECK (appointment_date >= CURRENT_DATE);

ALTER TABLE appointments
  ADD CONSTRAINT ck_appointments_appointment_time CHECK (appointment_time >= '08:00:00' AND appointment_time <= '17:00:00');

--20+ 
INSERT INTO patients (first_name, last_name, date_of_birth, gender)
VALUES ('John', 'Doe', '1980-01-01', 'Male'), ('Jane', 'Doe', '1985-02-02', 'Female'), ('Alice', 'Smith', '1990-03-03', 'Female'), ('Bob', 'Jones', '1995-04-04', 'Male'), ('Carol', 'Williams', '2000-05-05', 'Female');

INSERT INTO doctors (first_name, last_name, specialization)
VALUES ('Dr. Smith', 'Smith', 'General Medicine'), ('Dr. Jones', 'Jones', 'Pediatrics'), ('Dr. Williams', 'Williams', 'Cardiology'), ('Dr. Johnson', 'Johnson', 'Neurology'), ('Dr. Brown', 'Brown', 'Dermatology');

INSERT INTO appointments (patient_id, doctor_id, appointment_date
