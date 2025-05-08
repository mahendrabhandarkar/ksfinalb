package com.ks.ksfinalb.model.stt;

import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
@Table(name = "tbl_stt_states")
public class STTStates {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "state_id")
    private int stateId;

    @Column(name="state_name")
    private String stateName;

    @Column(name="state_description")
    private String stateDescription;

    @Column(name="is_start_state")
    private Boolean isStartState;

    @Column(name="state_url")
    private String stateUrl;

    @Column(name="process_id")
    private int processId;

    @Column(name="module_id")
    private int moduleId;

    @Column(name="original_state_id")
    private int originalStateId;

    @Column(name="remarks")
    private String remarks;
}
