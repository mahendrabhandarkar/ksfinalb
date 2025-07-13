package com.ks.ksfinalb.model.sttandurlaccessrule;

import jakarta.persistence.*;
import lombok.Data;

import java.io.Serializable;

@Data
@Entity
@Table(name="tbl_wf_queue_process_mst")
public class WfQueueProcessMst implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="process_id", nullable=false)
    private Long processId;

    @Column(name="process_name")
    private String processName;

    @Column(name="process_short_code")
    private String processShortCode;

    @Column(name="status")
    private Boolean status;

}
