package com.ks.ksfinalb.model.sttandurlaccessrule;

import jakarta.persistence.*;
import lombok.Data;

import java.io.Serializable;

@Data
@Entity
@Table(name="tbl_wf_queue_node_mst")
public class WfQueueNodeMst implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="node_id", nullable=false)
    private Long nodeId;

    @Column(name="node_name")
    private String nodeName;

    @Column(name="node_short_code")
    private String nodeShortCode;

    @Column(name="status")
    private Boolean status;
}
