package com.zack.Constructora.model;


import jakarta.persistence.*;
import lombok.*;

import java.math.BigDecimal;
import java.time.LocalDate;


@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "work_progress")
public class WorkProgress {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private LocalDate progressDate;


    @Column(nullable = false)
    private Integer estimateNumber;

    @Column(nullable = false)
    private BigDecimal executedQuantity;

    @Column(nullable = false)
    private BigDecimal progressPercentage;

    @ManyToOne
    @JoinColumn(name = "concept_id", nullable = false)
    private WorkConcept concept;

    @ManyToOne
    @JoinColumn(name = "updated_by")
    private User updatedBy;

}
