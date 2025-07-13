package com.ks.ksfinalb.model.sttandurlaccessrule;

import jakarta.persistence.*;
import lombok.Data;

import java.io.Serializable;

@Data
@Entity
@Table(name="tbl_wf_queue_role_mst")
public class WfQueueRoleMst implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="role_id", nullable=false)
    private Long roleId;

    @Column(name="role_name")
    private String roleName;

    @Column(name="role_short_code")
    private String roleShortCode;

    @Column(name="status")
    private Boolean status;

}
