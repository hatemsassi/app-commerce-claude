-- MediTrack — Clinic Appointment & Billing schema (assignment project)
-- Run this in MySQL Workbench before starting. Recreates the database each time.

DROP DATABASE IF EXISTS meditrack_db;
CREATE DATABASE meditrack_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE meditrack_db;

-- specialties  (parallels: categories)
CREATE TABLE specialties (
    id          BIGINT        NOT NULL AUTO_INCREMENT,
    name        VARCHAR(100)  NOT NULL,
    slug        VARCHAR(100)  NOT NULL,
    description TEXT,
    created_at  DATETIME,
    updated_at  DATETIME,
    PRIMARY KEY (id),
    UNIQUE KEY uk_specialties_name (name),
    UNIQUE KEY uk_specialties_slug (slug)
);

-- doctors  (parallels: products; daily_slot_capacity is the "stock")
CREATE TABLE doctors (
    id                  BIGINT        NOT NULL AUTO_INCREMENT,
    name                VARCHAR(200)  NOT NULL,
    license_no          VARCHAR(100)  NOT NULL,
    consultation_fee    DECIMAL(10,2) NOT NULL,
    daily_slot_capacity INT           NOT NULL DEFAULT 0,
    active              BOOLEAN       NOT NULL DEFAULT TRUE,
    specialty_id        BIGINT        NOT NULL,
    created_at          DATETIME,
    updated_at          DATETIME,
    PRIMARY KEY (id),
    UNIQUE KEY uk_doctors_license (license_no),
    CONSTRAINT fk_doctors_specialty FOREIGN KEY (specialty_id) REFERENCES specialties (id)
);

-- patients  (parallels: customers)
CREATE TABLE patients (
    id            BIGINT        NOT NULL AUTO_INCREMENT,
    first_name    VARCHAR(100)  NOT NULL,
    last_name     VARCHAR(100)  NOT NULL,
    email         VARCHAR(255)  NOT NULL,
    phone         VARCHAR(20),
    date_of_birth DATE,
    created_at    DATETIME,
    PRIMARY KEY (id),
    UNIQUE KEY uk_patients_email (email)
);

-- appointments  (parallels: orders; one-way status machine)
CREATE TABLE appointments (
    appointment_id   BIGINT        NOT NULL AUTO_INCREMENT,
    appointment_no   VARCHAR(20)   NOT NULL,
    patient_id       BIGINT        NOT NULL,
    doctor_id        BIGINT        NOT NULL,
    status           VARCHAR(20)   NOT NULL DEFAULT 'REQUESTED',
    scheduled_date   DATE          NOT NULL,
    total_amount     DECIMAL(12,2) NOT NULL DEFAULT 0.00,
    notes            TEXT,
    created_at       DATETIME,
    updated_at       DATETIME,
    PRIMARY KEY (appointment_id),
    UNIQUE KEY uk_appointments_no (appointment_no),
    CONSTRAINT fk_appointments_patient FOREIGN KEY (patient_id) REFERENCES patients (id),
    CONSTRAINT fk_appointments_doctor  FOREIGN KEY (doctor_id)  REFERENCES doctors  (id)
);

-- appointment_services  (parallels: order_items)
CREATE TABLE appointment_services (
    id             BIGINT        NOT NULL AUTO_INCREMENT,
    appointment_id BIGINT        NOT NULL,
    service_name   VARCHAR(200)  NOT NULL,
    quantity       INT           NOT NULL,
    unit_price     DECIMAL(10,2) NOT NULL,
    subtotal       DECIMAL(12,2) NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT fk_appt_services_appt FOREIGN KEY (appointment_id) REFERENCES appointments (appointment_id)
);

-- payments  (parallels: payments)
CREATE TABLE payments (
    id             BIGINT        NOT NULL AUTO_INCREMENT,
    appointment_id BIGINT        NOT NULL,
    payment_method VARCHAR(30)   NOT NULL,
    payment_status VARCHAR(20)   NOT NULL DEFAULT 'PENDING',
    amount         DECIMAL(12,2) NOT NULL,
    created_at     DATETIME,
    PRIMARY KEY (id),
    UNIQUE KEY uk_payments_appointment (appointment_id),
    CONSTRAINT fk_payments_appointment FOREIGN KEY (appointment_id) REFERENCES appointments (appointment_id)
);

-- indexes
CREATE INDEX idx_doctors_specialty     ON doctors             (specialty_id);
CREATE INDEX idx_doctors_active        ON doctors             (active);
CREATE INDEX idx_appointments_patient  ON appointments        (patient_id);
CREATE INDEX idx_appointments_doctor   ON appointments        (doctor_id);
CREATE INDEX idx_appointments_date     ON appointments        (scheduled_date);
CREATE INDEX idx_appointments_status   ON appointments        (status);
CREATE INDEX idx_appt_services_appt    ON appointment_services(appointment_id);

-- ---------------------------------------------------------------------------
-- Seed data (reference data + patients only).
-- Appointments, appointment_services and payments are created through the API.
-- ---------------------------------------------------------------------------
INSERT INTO specialties (name, slug, description, created_at, updated_at) VALUES
('Cardiology',  'cardiology',  'Heart and cardiovascular care',  NOW(), NOW()),
('Dermatology', 'dermatology', 'Skin, hair and nails',           NOW(), NOW()),
('Pediatrics',  'pediatrics',  'Care for infants and children',  NOW(), NOW()),
('Orthopedics', 'orthopedics', 'Bones, joints and muscles',      NOW(), NOW());

INSERT INTO doctors (name, license_no, consultation_fee, daily_slot_capacity, active, specialty_id, created_at, updated_at) VALUES
('Dr. Asha Rao',     'LIC-CARD-001', 600.00, 8,  TRUE, 1, NOW(), NOW()),
('Dr. Vivek Menon',  'LIC-CARD-002', 750.00, 6,  TRUE, 1, NOW(), NOW()),
('Dr. Neha Gupta',   'LIC-DERM-001', 500.00, 10, TRUE, 2, NOW(), NOW()),
('Dr. Sam Patel',    'LIC-PEDI-001', 450.00, 12, TRUE, 3, NOW(), NOW()),
('Dr. Liu Wei',      'LIC-ORTH-001', 800.00, 5,  TRUE, 4, NOW(), NOW());

INSERT INTO patients (first_name, last_name, email, phone, date_of_birth, created_at) VALUES
('John',  'Doe',   'john.doe@example.com',   '+1-202-555-0101', '1990-05-14', NOW()),
('Jane',  'Smith', 'jane.smith@example.com', '+1-202-555-0142', '1985-11-02', NOW()),
('Ravi',  'Kumar', 'ravi.kumar@example.com', '+91-90000-12345', '2001-03-23', NOW());

-- Verification
SELECT * FROM specialties;
SELECT * FROM doctors;
SELECT * FROM patients;
