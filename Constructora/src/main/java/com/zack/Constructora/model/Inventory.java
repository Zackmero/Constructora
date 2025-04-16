package com.zack.Constructora.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.sql.Timestamp;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "inventories")
public class Inventory {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, unique = true, length = 10)
    private String material_code;

    @Column(nullable = false, length = 50)
    private String name;

    @Column(nullable = false)
    private String details;

    @Column(nullable = false)
    private BigDecimal stock;


    private Timestamp lastUpdate;

    @ManyToOne
    @JoinColumn(name = "category_id", nullable = false)
    private MaterialCategory category;

    @ManyToOne
    @JoinColumn(name = "measure_id", nullable = false)
    private Measure measure;



}
