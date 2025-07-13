package com.ks.ksfinalb.model.sttandurlaccessrule;

import jakarta.persistence.*;
import lombok.Data;

import java.io.Serializable;
import java.sql.Timestamp;

@Data
@Entity
@Table(name="tbl_wf_queue_stt_transition_hst")
public class WfQueueSttTransitionHistory implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="queue_stt_hst_id", nullable=false)
    private Long queueSttHstId;

    @Column(name="stt_transition_id")
    private Long queueStateTransitionId;

    @Column(name = "node_event_id")
    private Long nodeEventId;

    @Column(name="record_id")
    private Long recordId;

    @Column(name="record_type")
    private Long recordType;

    @Column(name="action_event")
    private String actionEvent;

    @Column(name = "assignee_id")
    private Long assigneeId;

    @Column(name = "comments")
    private Long comments;

    @Column(name="created_at")
    private Timestamp createdAt;

    @Column(name="created_by")
    private String createdBy;

    @Column(name="updated_by")
    private String updatedBy;

    @Column(name = "updatedAt")
    private Timestamp updatedAt;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "stt_transition_id", referencedColumnName = "stt_transition_id", insertable = false, updatable = false)
    private WfQueueSttTransitionMst wfQueueSttTransitionMst;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "node_event_id", referencedColumnName = "node_event_id", insertable = false, updatable = false)
    private WfQueueNodeEvent wfQueueNodeEvent;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "assignee_id", referencedColumnName = "role_rank_user_id", insertable = false, updatable = false)
    private WfQueueRoleRankUser wfQueueRoleRankUser;
    /*
    @OneToMany(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    @JoinColumn(name = "queue_state_history_id", referencedColumnName = "queue_state_history_id")
    private List<Wf>
     */
}
