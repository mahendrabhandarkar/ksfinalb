package com.ks.ksfinalb.model.stt;

import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
@Table(name = "tbl_stt_state_transition")
public class STTStateTransition {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int id;

    @Column(name = "state_id")
    private int stateId;

    @Column(name = "status_id")
    private int statusId;

    @Column(name="next_state_id")
    private int nextStateId;

    @Column(name="has_next")
    private Boolean hasNext;

    @Column(name="remarks")
    private String remarks;

    @Column(name="sequence_id")
    private int sequenceId;

    @Column(name="module_id")
    private int moduleId;

    @Column(name="process_id")
    private int processId;

    @Column(name="next_role_id")
    private int nextRoleId;

}
