package com.ks.ksfinalb.model.sttandurlaccessrule;

import jakarta.persistence.*;
import lombok.Data;

import java.io.Serializable;
@Data
@Entity
@Table(name="tbl_wf_queue_node_event")
public class WfQueueNodeEvent implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="node_event_id", nullable=false)
    private Long nodeEventId;

    @Column(name="queue_event_name")
    private String queueEventName;

    @Column(name="queue_event_desc")
    private String queueEventDesc;
}
