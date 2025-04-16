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
@Table(name = "suppliers")
public class Supplier {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, length = 100)
    private String trade_name;

    @Column(nullable = false, length = 255)
    private String company_name;

    @Column(nullable = false, length = 30)
    private String rfc;

    @Column(nullable = false, length = 70)
    private String name_contact;

    @Column(nullable = false, length = 70)
    private String phone_contact;

    @Column(unique = true, length = 100)
    private String email_contact;

    @Column(nullable = false, length = 150)
    private String address;

    @Column(length = 30)
    private String product;

    @OneToMany(mappedBy = "materialRequisitions")
    private List<MaterialRequisition> materialRequisitions;


}
