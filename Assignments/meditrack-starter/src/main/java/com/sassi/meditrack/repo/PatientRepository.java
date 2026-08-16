package com.sassi.meditrack.repo;

import com.sassi.meditrack.model.Patient;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PatientRepository extends JpaRepository<Patient, Long> {
}
