package com.sassi.meditrack.repo;

import com.sassi.meditrack.model.Appointment;
import com.sassi.meditrack.model.Doctor;
import org.springframework.data.jpa.repository.JpaRepository;

import java.time.LocalDate;

public interface AppointmentRepository extends JpaRepository<Appointment, Long> {
    // Used by the (smelly) capacity check in the controller.
    long countByDoctorAndScheduledDate(Doctor doctor, LocalDate scheduledDate);
}
