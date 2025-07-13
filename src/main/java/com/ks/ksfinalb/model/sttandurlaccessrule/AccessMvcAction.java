package com.ks.ksfinalb.model.sttandurlaccessrule;

import jakarta.persistence.*;
import lombok.Data;

import java.io.Serializable;

@Data
@Entity
@Table(name="tbl_access_mvc_action")
public class AccessMvcAction implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="action_id", nullable=false)
    private Long actionId;

    @Column(name="name")
    private String name;

    @Column(name="url")
    private String url;

    @Column(name="status")
    private Boolean Status;

}
