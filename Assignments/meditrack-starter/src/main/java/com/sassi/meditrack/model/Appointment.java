package com.sassi.meditrack.model;

import jakarta.persistence.*;
import lombok.Data;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Data
@Entity
@Table(name = "appointments")
public class Appointment {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "appointment_id")
    private Long appointmentId;

    @Column(name = "appointment_no")
    private String appointmentNo;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "patient_id")
    private Patient patient;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "doctor_id")
    private Doctor doctor;

    // SMELL: status is a free-text String, no enum, no validation of transitions.
    private String status;

    @Column(name = "scheduled_date")
    private LocalDate scheduledDate;

    // SMELL: money as double.
    @Column(name = "total_amount")
    private double totalAmount;

    private String notes;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    @OneToMany(mappedBy = "appointment", cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    private List<AppointmentService> services = new ArrayList<>();
}
