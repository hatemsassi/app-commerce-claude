package com.sassi.meditrack.controller;

import com.sassi.meditrack.model.Appointment;
import com.sassi.meditrack.model.Doctor;
import com.sassi.meditrack.model.Patient;
import com.sassi.meditrack.repo.AppointmentRepository;
import com.sassi.meditrack.repo.DoctorRepository;
import com.sassi.meditrack.repo.PatientRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

// SMELL: ALL the business logic lives in the controller. No service layer,
//        no DTOs, no exception handling, generic RuntimeExceptions (HTTP 500),
//        double arithmetic for money, status as free text with no transition rules,
//        cancel does not restore the slot or refund the payment.
@RestController
public class AppointmentController {

    @Autowired
    private AppointmentRepository appointmentRepo;
    @Autowired
    private DoctorRepository doctorRepo;
    @Autowired
    private PatientRepository patientRepo;

    @GetMapping("/appointments")
    public List<Appointment> all() {
        return appointmentRepo.findAll();
    }

    @GetMapping("/appointments/{id}")
    public Appointment get(@PathVariable Long id) {
        return appointmentRepo.findById(id).orElse(null);
    }

    @PostMapping("/appointments/book")
    public Appointment book(@RequestParam Long patientId,
                            @RequestParam Long doctorId,
                            @RequestParam String date) {
        Patient patient = patientRepo.findById(patientId).orElse(null);
        Doctor doctor = doctorRepo.findById(doctorId).orElse(null);
        if (patient == null || doctor == null) {
            throw new RuntimeException("Patient or doctor not found");
        }

        LocalDate scheduled = LocalDate.parse(date);
        long booked = appointmentRepo.countByDoctorAndScheduledDate(doctor, scheduled);
        if (booked >= doctor.getDailySlotCapacity()) {
            throw new RuntimeException("No slots available for this doctor on " + date);
        }

        Appointment a = new Appointment();
        a.setAppointmentNo("APT-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase());
        a.setPatient(patient);
        a.setDoctor(doctor);
        a.setStatus("REQUESTED");
        a.setScheduledDate(scheduled);
        a.setTotalAmount(doctor.getConsultationFee());
        a.setCreatedAt(LocalDateTime.now());
        a.setUpdatedAt(LocalDateTime.now());
        return appointmentRepo.save(a);
    }

    @PostMapping("/appointments/{id}/cancel")
    public Appointment cancel(@PathVariable Long id) {
        Appointment a = appointmentRepo.findById(id).orElse(null);
        a.setStatus("CANCELLED");
        a.setUpdatedAt(LocalDateTime.now());
        return appointmentRepo.save(a);
    }
}
