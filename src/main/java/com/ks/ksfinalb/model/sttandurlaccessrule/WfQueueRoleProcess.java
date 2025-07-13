package com.ks.ksfinalb.model.sttandurlaccessrule;

import jakarta.persistence.*;
import lombok.Data;
import java.io.Serializable;

@Data
@Entity
@Table(name="tbl_wf_queue_role_process")
public class WfQueueRoleProcess implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="role_process_id", nullable=false)
    private Long roleProcessId;

    @Column(name="role_id")
    private Long roleId;

    @Column(name="process_id")
    private Long processId;

    @Column(name="status")
    private Boolean status;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name="role_id", referencedColumnName = "role_id", insertable = false, updatable = false)
    private WfQueueRoleMst wfQueueRoleMst;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name="process_id", referencedColumnName = "process_id", insertable = false, updatable = false)
    private WfQueueProcessMst wfQueueProcessMst;
}
