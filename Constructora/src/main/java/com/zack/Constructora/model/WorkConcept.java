package com.zack.Constructora.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "work_concepts")
public class WorkConcept {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String description;

    private String unit;

    @OneToMany(mappedBy = "concept_id")
    private List<WorkProgress> workProgress;


    @ManyToOne
    @JoinColumn(name = "stage_id", nullable = false)
    private ConstructionStage constructionStage;


}
