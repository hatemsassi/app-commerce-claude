package com.sassi.meditrack.repo;

import com.sassi.meditrack.model.Doctor;
import org.springframework.data.jpa.repository.JpaRepository;

public interface DoctorRepository extends JpaRepository<Doctor, Long> {
}
