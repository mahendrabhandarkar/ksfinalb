package com.ks.ksfinalb.model.sttandurlaccessrule;

import jakarta.persistence.*;
import lombok.Data;
import org.apache.arrow.flatbuf.Bool;

import java.io.Serializable;
import java.util.List;

@Data
@Entity
@Table(name="tbl_access_mvc_access_type")
public class AccessMvcAccessType implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="access_type_id", nullable=false)
    private Long accessTypeId;

    @Column(name = "name")
    private String name;

    @Column(name = "status")
    private Boolean status;

    @Column(name = "http_method")
    private String httpMethod;

    @OneToMany(mappedBy = "accessMvcAccessType")
    private List<AccessMvcActionRole> accessMvcActionRoleList;

}
