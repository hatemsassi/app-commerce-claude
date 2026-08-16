package com.sassi.meditrack.model;

import jakarta.persistence.*;
import lombok.Data;
import java.time.LocalDateTime;

// SMELL: @Data on a JPA entity; everything public via getters/setters.
@Data
@Entity
@Table(name = "specialties")
public class Specialty {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String name;
    private String slug;
    private String description;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
}
