package com.zack.Constructora.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;

@Entity
@Data
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "requisitions_details")
public class RequisitionDetail {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, length = 10)
    private String material_code;

    @Column(nullable = false, length = 100)
    private String material_name;

    @Column(nullable = false, length = 255)
    private String material_description;

    @Column(nullable = false)
    private BigDecimal quantity;

    @Column(nullable = false)
    private BigDecimal unit_price;

    @Column(nullable = false)
    private BigDecimal subtotal;

    @Column(nullable = false)
    private BigDecimal iva;

    private BigDecimal total_amount;

    @Column(nullable = false)
    private BigDecimal discount;

    @ManyToOne
    @JoinColumn(name = "requisition_id")
    private MaterialRequisition requisition_id;

    @ManyToOne
    @JoinColumn(name = "measure_id")
    private Measure measure_id;




}
