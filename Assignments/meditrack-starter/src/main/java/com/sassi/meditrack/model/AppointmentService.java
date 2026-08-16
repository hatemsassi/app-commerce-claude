package com.sassi.meditrack.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
@Table(name = "appointment_services")
public class AppointmentService {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "appointment_id")
    @JsonIgnore
    private Appointment appointment;

    @Column(name = "service_name")
    private String serviceName;

    private int quantity;

    // SMELL: money as double.
    @Column(name = "unit_price")
    private double unitPrice;

    private double subtotal;
}
