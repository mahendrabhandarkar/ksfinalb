package com.ks.ksfinalb.model.sttandurlaccessrule;

import jakarta.persistence.*;
import lombok.Data;

import java.io.Serializable;

@Data
@Entity
@Table(name="tbl_access_mvc_action_role")
public class AccessMvcActionRole implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="action_role_id", nullable=false)
    private Long actionRoleId;

    @ManyToOne(fetch = FetchType.LAZY, cascade = CascadeType.REFRESH)
    @JoinColumn(name = "access_id", referencedColumnName = "access_type_id")
    private AccessMvcAccessType accessMvcAccessType;

    @ManyToOne(fetch = FetchType.LAZY, cascade = CascadeType.REFRESH)
    @JoinColumn(name = "action_id", referencedColumnName = "action_id")
    private AccessMvcAction accessMvcAction;
/*
    @ManyToOne(fetch = FetchType.LAZY, cascade = CascadeType.REFRESH)
    @JoinColumn(name = "role_id", referencedColumnName = "role_id")
    private AccessRole
*/
}
