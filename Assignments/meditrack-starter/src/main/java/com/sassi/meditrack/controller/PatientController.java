package com.sassi.meditrack.controller;

import com.sassi.meditrack.model.Patient;
import com.sassi.meditrack.repo.PatientRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.List;

@RestController
public class PatientController {

    @Autowired
    private PatientRepository patientRepo;

    @GetMapping("/patients")
    public List<Patient> all() {
        return patientRepo.findAll();
    }

    // SMELL: no duplicate-email check, no validation, returns the entity directly.
    @PostMapping("/patients")
    public Patient register(@RequestBody Patient p) {
        p.setCreatedAt(LocalDateTime.now());
        return patientRepo.save(p);
    }
}
