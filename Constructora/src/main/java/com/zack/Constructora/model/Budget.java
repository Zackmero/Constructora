package com.zack.Constructora.model;


import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.math.BigDecimal;
import java.time.LocalDate;

@Entity @Setter @Getter @NoArgsConstructor @AllArgsConstructor
@Table(name = "budgets")
public class Budget {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private Integer total_houses;

    @Column(nullable = false)
    private BigDecimal unit_price;

    private BigDecimal total_amount;


    private BigDecimal advance_payment;

    @Column(nullable = false)
    private LocalDate invoice_date;


    @ManyToOne
    @JoinColumn(name = "contract_id", nullable = false)
    private Contract contract;



}
