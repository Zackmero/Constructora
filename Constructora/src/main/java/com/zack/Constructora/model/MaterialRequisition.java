package com.zack.Constructora.model;


import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDate;
import java.util.List;


@Entity
@Table(name = "material_requisitions")
@Data
@NoArgsConstructor @AllArgsConstructor
public class MaterialRequisition {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, length = 10)
    private String orderCode;

    @Column(nullable = false)
    private LocalDate requestDate;

    @Column(nullable = false)
    private LocalDate deliveryDate;

    @Column(nullable = false, length = 100)
    private LocalDate deliveryLocation;

    @Column(nullable = false, length = 100)
    private String receivedBy;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private String status;

    @ManyToOne
    @JoinColumn(name = "contract_id", nullable = false)
    private Contract contract;

    @ManyToOne
    @JoinColumn(name = "supplier_id", nullable = false)
    private Supplier supplier;

    @ManyToOne
    @JoinColumn(name = "requested_by", nullable = false)
    private User requestedBy;

    @OneToMany(mappedBy = "materialRequisitions")
    private List<RequisitionDetail> requisitionDetails;



}
