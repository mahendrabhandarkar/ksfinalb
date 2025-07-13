package com.ks.ksfinalb.model.sttandurlaccessrule;

import jakarta.persistence.*;
import lombok.Data;

import java.io.Serializable;

@Data
@Entity
@Table(name="tbl_wf_queue_node_process_mst")
public class WfQueueNodeProcessMst implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="node_process_id", nullable=false)
    private Long nodeProcessId;

    @Column(name="node_id")
    private Long nodeId;

    @Column(name="role_process_id")
    private Long roleProcessId;

    @Column(name="start_flag")
    private Boolean startFlag;

    @Column(name="end_flag")
    private Boolean endFlag;

    @Column(name="status")
    private Boolean status;

    @ManyToOne
    @JoinColumn(name="node_id", referencedColumnName = "node_id", insertable = false, updatable = false)
    private WfQueueNodeMst wfQueueNodeMst;

    @ManyToOne
    @JoinColumn(name="role_process_id", referencedColumnName = "role_process_id", insertable = false, updatable = false)
    private WfQueueRoleProcess wfQueueRoleProcess;
}
