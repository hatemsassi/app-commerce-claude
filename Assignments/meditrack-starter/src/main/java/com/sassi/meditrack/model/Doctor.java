package com.sassi.meditrack.model;

import jakarta.persistence.*;
import lombok.Data;
import java.time.LocalDateTime;

@Data
@Entity
@Table(name = "doctors")
public class Doctor {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String name;

    @Column(name = "license_no")
    private String licenseNo;

    // SMELL: money as double instead of BigDecimal.
    @Column(name = "consultation_fee")
    private double consultationFee;

    @Column(name = "daily_slot_capacity")
    private int dailySlotCapacity;

    private boolean active;

    // SMELL: EAGER fetch everywhere.
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "specialty_id")
    private Specialty specialty;

    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
}
