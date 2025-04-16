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
@Table(name = "contracts")
public class Contract {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, length = 100)
    private String name;

    @Column(nullable = false, length = 30)
    private String rfc;

    @Column(nullable = false, length = 255)
    private String address;

    @Column(nullable = false, length = 100)
    private String contractCode;

    @Column(nullable = false, length = 100)
    private String suburb;

    @Column(nullable = false, length = 100)
    private String location;

    @Column(nullable = false)
    private Double progress;

    @ManyToOne
    @JoinColumn(name = "resident_id")
    private Resident resident;

    @ManyToOne
    @JoinColumn(name = "grocer_id")
    private Grocer grocer;

    @ManyToOne
    @JoinColumn(name = "created_by")
    private User user;

    @OneToMany(mappedBy = "contract")
    private List<MaterialRequisition> materialRequisitions;

}
