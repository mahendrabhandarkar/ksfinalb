package com.ks.ksfinalb.model.stt;

import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
@Table(name = "tbl_stt_module")
public class STTModule {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int id;

    @Column(name="module_code")
    private String moduleCode;

    @Column(name="module_name")
    private String moduleName;

}
