package com.ks.ksfinalb.model.sttandurlaccessrule;

import com.ks.ksfinalb.model.User;
import jakarta.persistence.*;
import lombok.Data;

import java.io.Serializable;

@Data
@Entity
@Table(name="tbl_wf_queue_role_rank_user")
public class WfQueueRoleRankUser implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="role_rank_user_id", nullable=false)
    private Long roleRankUserId;

    @Column(name="role_rank_id")
    private Long roleRankId;

    @Column(name="user_id")
    private Long userId;

    @Column(name="status")
    private Boolean status;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name="role_rank_id", referencedColumnName = "role_rank_id", insertable = false, updatable = false)
    private WfQueueRoleRank wfQueueRoleRank;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name="user_id", referencedColumnName = "id", insertable = false, updatable = false)
    private User user;

}
