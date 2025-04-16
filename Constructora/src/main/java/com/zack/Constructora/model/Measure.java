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
@Table(name = "measures")
public class Measure {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, length = 10, unique = true)
    private String name;

    @Column(nullable = false, length = 20)
    private String details;

    @OneToMany(mappedBy = "measure_id")
    private List<RequisitionDetail> requisitionDetail;

}
