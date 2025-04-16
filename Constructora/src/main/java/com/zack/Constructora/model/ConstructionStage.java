package com.zack.Constructora.model;


import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Entity
@Data
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "construction_stages")
public class ConstructionStage {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, length = 255)
    private String stage_name;

    @ManyToOne
    @JoinColumn(name = "contract_id")
    private Contract contract_id;

    @ManyToOne
    @JoinColumn(name = "created_by")
    private User created_by;

    @OneToMany(mappedBy = "constructionStage")
    private List<WorkConcept> workConcepts;

}
