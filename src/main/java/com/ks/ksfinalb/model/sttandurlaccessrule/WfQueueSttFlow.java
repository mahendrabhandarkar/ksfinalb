package com.ks.ksfinalb.model.sttandurlaccessrule;

import jakarta.persistence.*;
import lombok.Data;

import java.io.Serializable;
import java.sql.Timestamp;

@Data
@Entity
@Table(name="tbl_wf_queue_stt_flow_definition")
public class WfQueueSttFlow implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="stt_definition_id", nullable=false)
    private Long sttDefinitionId;

    @Column(name="stt_transition_id")
    private Long sttTransitionId;

    @Column(name="role_rank_user_id")
    private Long roleRankUserId;

    @Column(name="record_id")
    private Long record_Id;

    @Column(name="record_type")
    private String recordType;

    @Column(name="created_at")
    private Timestamp createdAt;

    @Column(name="created_by")
    private Long createdById;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name="stt_transition_id", referencedColumnName = "stt_transition_id", insertable = false, updatable = false)
    private WfQueueSttTransitionMst wfQueueSttTransitionMst;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name="role_rank_user_id", referencedColumnName = "role_rank_user_id", insertable = false, updatable = false)
    private WfQueueRoleRankUser wfQueueRoleRankUser;
}
