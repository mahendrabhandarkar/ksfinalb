package com.ks.ksfinalb.model.sttandurlaccessrule;

import jakarta.persistence.*;
import lombok.Data;

import java.io.Serializable;

@Data
@Entity
@Table(name="tbl_wf_queue_stt_transition_mst")
public class WfQueueSttTransitionMst implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="stt_transition_id", nullable=false)
    private Long sttTransitionId;

    @Column(name="node_event_id")
    private Long nodeEventId;

    @Column(name="parent_node_process_id")
    private Long parentNodeProcessId;

    @Column(name="next_node_process_id")
    private Long nextNodeProcessId;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name="node_event_id", referencedColumnName = "node_event_id", insertable = false, updatable = false)
    private WfQueueNodeEvent wfQueueNodeEvent;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name="parent_node_process_id", referencedColumnName = "node_process_id", insertable = false, updatable = false)
    private WfQueueNodeProcessMst parentWfQueueNodeProcessMst;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name="next_node_process_id", referencedColumnName = "node_process_id", insertable = false, updatable = false)
    private WfQueueNodeProcessMst nextWfQueueNodeProcessMst;
}
