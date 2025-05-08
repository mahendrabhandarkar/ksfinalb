package com.ks.ksfinalb.model.stt;

import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
@Table(name = "tbl_stt_state_activity")
public class STTStateActivityMappingCode {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int Id;

    @Column(name="module_code")
    private String moduleCode;

    @Column(name="process_code")
    private String processCode;

    @Column(name="state_id")
    private int stateId;

    @Column(name="activity_code")
    private String activityCode;

    @Column(name="status_id")
    private int status_id;

    @Column(name="status_code")
    private String statusCode;

}
