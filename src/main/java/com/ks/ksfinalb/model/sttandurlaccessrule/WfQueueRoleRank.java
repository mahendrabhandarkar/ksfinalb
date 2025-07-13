package com.ks.ksfinalb.model.sttandurlaccessrule;

import jakarta.persistence.*;
import lombok.Data;

import java.io.Serializable;
@Data
@Entity
@Table(name="tbl_wf_queue_role_rank")
public class WfQueueRoleRank implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="role_rank_id", nullable=false)
    private Long roleRankId;

    @Column(name="role_process_id")
    private Long roleProcessId;

    @Column(name="rank_id")
    private String rankId;

    @Column(name="status")
    private Boolean status;
/*
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name="rank_id", referencedColumnName = "rank_id", insertable = false, updatable = false)
    private UserRankMst userRankMst;
*/
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name="role_process_id", referencedColumnName = "role_process_id", insertable = false, updatable = false)
    private WfQueueRoleProcess wfQueueRoleProcess;
}
