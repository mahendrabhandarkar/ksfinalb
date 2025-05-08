package com.ks.ksfinalb.model.stt;

import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
@Table(name = "tbl_stt_process")
public class STTProcess {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "process_id")
    private int processId;

    @Column(name="process_code")
    private String processCode;

    @Column(name="module_id")
    private int moduleId;

    @Column(name="process_name")
    private String processName;

}
