package com.ks.ksfinalb.model.stt;

import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
@Table(name = "tbl_stt_status")
public class STTStatus {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "status_id")
    private int statusId;

    @Column(name="status_name")
    private String statusName;

    @Column(name="process_id")
    private int processId;

    @Column(name="module_id")
    private int moduleId;

    @Column(name="start_sub_process")
    private Boolean startSubProcess;

    @Column(name="wait_sub_process")
    private Boolean waitSubProcess;

    @Column(name="next_user_notification_subject")
    private String nextUserNotificationSubject;

    @Column(name="return_back_to")
    private String returnBackTo;

    @Column(name="is_loop")
    private Boolean isLoop;

}
